
open Graphics 


  
type seed ={c:color option; x: int; y : int} 
type voronoi={dim : int*int; seeds: seed array} 


let dist_euclide (x1, y1) (x2,y2) =
  let x = (x1 - x2) * (x1 - x2) in
  let y = (y1 - y2) * (y1 - y2) in
  int_of_float (sqrt (float_of_int (x + y))) 
    
let dist_taxicab (x1,y1) (x2,y2) = 
  abs(x1 - x2) +   abs(y1 - y2) 
    
let dim_fenetre_h voronoi = 
  snd (voronoi.dim )	
    
let dim_fenetre_l voronoi = 
  fst (voronoi.dim)  

let dim_array_seeds voronoi = 
  Array.length voronoi.seeds


let x_seed seed = match seed with 
  |{c=_; x=x ; y=_ }-> x 


let y_seed seed =  match seed with 
  |{c=_; x=_ ; y= y}-> y 

    

let get_color c = match c with 
  |None -> white
  |Some s -> s 


let frontier matrix i j s_i s_j = 
  if (i = 0 || j = 0 || i = s_i - 1 || j = s_j - 1) then
    true      
  else 
    let value = matrix.(i).(j) in 
    matrix.(i).(j+1)<> value || matrix.(i).(j-1)<> value || matrix.(i+1).(j)<> value || matrix.(i-1).(j)<> value
      

let regions_voronoi dist_min_pixel_seed dist_taxicab voronoi = 
  let dimx = fst voronoi.dim in
  let dimy = snd voronoi.dim in
  let matrix = Array.make_matrix dimx dimy 0 in 
  Array.iteri(fun i line -> Array.iteri(fun j _ -> line.(j) <- dist_min_pixel_seed dist_taxicab (i,j) voronoi.seeds)line)matrix ;
  matrix  


    
(*let dist_min_pixel_seed  dist_function (x,y) array_seeds  = 
  let length_array = Array.length array_seeds in 
  let min = ref (dist_function (x,y) (array_seeds.(0).x,array_seeds.(0).y)) in
  let x_y = ref 0 in
  for i = 1 to length_array -1 do
  let bis = dist_function (x,y) (array_seeds.(i).x , array_seeds.(i).y) in 
  if !min >= bis then
  begin
  x_y := i ;
  min := (bis)
  end
  done ;  
  !x_y *)  

    
let dist_min_pixel_seed dist_function (x,y) array_seeds = 
  let length_array = Array.length array_seeds in
  let min = dist_taxicab (x,y) (array_seeds.(0).x,array_seeds.(0).y) in
  let indice = 0 in 
  let rec aux min n indice = 
    match n with
    | 0 -> indice
    | n -> 
      let min_bis = dist_taxicab (x,y) (array_seeds.(n).x , array_seeds.(n).y)
      in  if min_bis < min then aux (min_bis) (n-1) n 
	else aux min (n-1) indice
  in aux min (length_array-1) indice ;;




(*
let adjacences_voronoi_count voronoi matrix = 
  let l = dim_fenetre_l voronoi in
  let h = dim_fenetre_h voronoi in 
  let n = Array.length voronoi.seeds in  
  let matrix_bool = Array.make_matrix n n 0 in 
  for i = 1 to l-2 do 
    for j = i+1 to h-2 do (* j = i + 1*)
      if matrix.(i).(j) <> matrix.(i).(j-1)then
    	begin
      	  matrix_bool.(matrix.(i).(j)).(matrix.(i).(j-1)) <- matrix_bool.(matrix.(i).(j)).(matrix.(i).(j-1)) + 1 ;
	  matrix_bool.(matrix.(i).(j-1)).(matrix.(i).(j)) <- matrix_bool.(matrix.(i).(j-1)).(matrix.(i).(j)) + 1 ;
    	end;
      if matrix.(i).(j) <> matrix.(i).(j+1)then
    	begin
      	  matrix_bool.(matrix.(i).(j)).(matrix.(i).(j+1)) <- matrix_bool.(matrix.(i).(j)).(matrix.(i).(j+1)) + 1 ;	
	  matrix_bool.(matrix.(i).(j+1)).(matrix.(i).(j)) <- matrix_bool.(matrix.(i).(j+1)).(matrix.(i).(j)) + 1 ;
  	end;					
      if matrix.(i).(j) <> matrix.(i-1).(j)then
    	begin
      	  matrix_bool.(matrix.(i).(j)).(matrix.(i-1).(j)) <- matrix_bool.(matrix.(i).(j)).(matrix.(i-1).(j)) + 1 ;
	  matrix_bool.(matrix.(i-1).(j)).(matrix.(i).(j)) <- matrix_bool.(matrix.(i-1).(j)).(matrix.(i).(j)) + 1 ;
    	end;
      if matrix.(i).(j) <> matrix.(i+1).(j)then
    	begin
      	  matrix_bool.(matrix.(i).(j)).(matrix.(i+1).(j)) <- matrix_bool.(matrix.(i).(j)).(matrix.(i+1).(j)) + 1 ;
	  matrix_bool.(matrix.(i+1).(j)).(matrix.(i).(j)) <- matrix_bool.(matrix.(i+1).(j)).(matrix.(i).(j)) + 1 ;
    	end;					
    done
  done ; 
  matrix_bool 
*)

let adjacences_voronoi_count voronoi matrix = 
  let l = dim_fenetre_l voronoi in
  let h = dim_fenetre_h voronoi in 
  let n = Array.length voronoi.seeds in  
  let matrix_bool = Array.make_matrix n n 0 in 
  for i = 1 to l-2 do 
    for j = i+1 to h-2 do (* j = i + 1*)
      if matrix.(i).(j) <> matrix.(i).(j-1)then
    	begin
      	  matrix_bool.(matrix.(i).(j)).(matrix.(i).(j-1)) <- matrix_bool.(matrix.(i).(j)).(matrix.(i).(j-1)) + 1 ;
	  matrix_bool.(matrix.(i).(j-1)).(matrix.(i).(j)) <- matrix_bool.(matrix.(i).(j-1)).(matrix.(i).(j)) + 1 ;
    	end;
      if matrix.(i).(j) <> matrix.(i).(j+1)then
    	begin
      	  matrix_bool.(matrix.(i).(j)).(matrix.(i).(j+1)) <- matrix_bool.(matrix.(i).(j)).(matrix.(i).(j+1)) + 1 ;	
	  matrix_bool.(matrix.(i).(j+1)).(matrix.(i).(j)) <- matrix_bool.(matrix.(i).(j+1)).(matrix.(i).(j)) + 1 ;
  	end;					
      if matrix.(i).(j) <> matrix.(i-1).(j)then
    	begin
      	  matrix_bool.(matrix.(i).(j)).(matrix.(i-1).(j)) <- matrix_bool.(matrix.(i).(j)).(matrix.(i-1).(j)) + 1 ;
	  matrix_bool.(matrix.(i-1).(j)).(matrix.(i).(j)) <- matrix_bool.(matrix.(i-1).(j)).(matrix.(i).(j)) + 1 ;
    	end;
      if matrix.(i).(j) <> matrix.(i+1).(j)then
    	begin
      	  matrix_bool.(matrix.(i).(j)).(matrix.(i+1).(j)) <- matrix_bool.(matrix.(i).(j)).(matrix.(i+1).(j)) + 1 ;
	  matrix_bool.(matrix.(i+1).(j)).(matrix.(i).(j)) <- matrix_bool.(matrix.(i+1).(j)).(matrix.(i).(j)) + 1 ;
    	end;					
    done
  done ; 
  matrix_bool 
    
    
    
    



