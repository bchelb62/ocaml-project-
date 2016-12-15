#load "graphics.cma";; 
open  Graphics;;
 (*exemple de voronoi*)     

type seed = {c : color option ; x : int ; y : int }  ;;
type voronoi = {dim : int*int  ; seeds : seed array } ;;


let v2 =  {
    dim = 800,800;
    seeds = [|
              {c = None; x=100; y=75};
              {c = None; x=125; y=225};
              {c = Some red; x=25; y=255};
              {c = None; x=60; y=305};
              {c = Some blue; x=50; y=400};
              {c = Some green; x=100; y=550};
              {c = Some green; x=150; y=25};
              {c = Some red; x=200; y=55};
              {c = None; x=200; y=200};
              {c = None; x=250; y=300};
              {c = None; x=300; y=450};
              {c = None; x=350; y=10};
              {c = None; x=357; y=75};
              {c = Some yellow; x=450; y=80};
              {c = Some blue; x=400; y=150};
              {c = None; x=550; y=350};
              {c = None; x=400; y=450};
              {c = None; x=400; y=500};
              {c = Some red; x=500; y=75};
              {c = Some green; x=600; y=100};
              {c = Some red; x=700; y=75};
              {c = None; x=578; y=175};
              {c = None; x=750; y=205};
              {c = None; x=520; y=345};
              {c = None; x=678; y=420};
              {c = None; x=600; y=480};
              {c = Some blue; x=650; y=480};
              {c = None; x=750; y=500};
              {c = None; x=600; y=550};
              {c = Some red; x=700; y=550};
            |]
    } ;;

let dim_fenetre_h voronoi = 
   fst (voronoi.dim )	 ;;  

  let dim_fenetre_l voronoi = 
    snd (voronoi.dim) ;;

let x_seed seed = 
  match seed with 
  |{c=_; x=x ; y=_ }-> x ;; 


let y_seed seed = 
  match seed with 
  |{c=_; x=_ ; y= y}-> y ;; 



let color_seed seed = 
  match seed with 
  |{c=c; x=_ ; y=_}-> c ;;
  


let dist_euclide (x1, y1) (x2,y2) =
  let x = (x1 - x2) * (x1 - x2) in
  let y = (y1 - y2) * (y1 - y2) in
  int_of_float (sqrt (float_of_int (x + y))) ;;




let dist_taxicab (x1,y1) (x2,y2) = 
  abs(x1 - x2) +   abs(y1 - y2) ;;
    

    
let dim_fenetre_h voronoi = 
  fst (voronoi.dim ) ;;
	   
let dim_fenetre_l voronoi = 
  snd (voronoi.dim)  ;;


let dist_min_pixel_seed  dist_taxicab (x,y) array_seeds  = 
  let length_array = Array.length array_seeds in 
  let min = ref (dist_taxicab (x,y) (array_seeds.(0).x,array_seeds.(0).y)) in
  let x_y = ref 0 in
  (*let count = ref 0 in *)
  for i = 1 to length_array -1 do
    let bis = dist_taxicab (x,y) (array_seeds.(i).x , array_seeds.(i).y) in 
    if !min >= bis then
      begin
	(*count := !count + 1  ;*)
	x_y := i ;
	min := (bis)
      end
  done ;
  (*if !count >= 4 then  x_y := -1 ;*)  
  !x_y   ;;

let regions_voronoi dist_min_pixel_seed dist_taxicab voronoi = 
  let dimx = fst voronoi.dim in
  let dimy = snd voronoi.dim in
  let matrix = Array.make_matrix dimx dimy 0 in 
  for i = 0 to dimx-1 do 
    for j = 0 to dimy-1 do
      matrix.(i).(j) <- dist_min_pixel_seed dist_taxicab (i,j) voronoi.seeds
    done
  done ;
  matrix ;; 

let get_color c = match c with 
  |None -> white
  |Some s -> s ;;
  
let color_seed seed = match seed with 
	  |{c=c; x=_ ; y=_}-> c ;;

let frontier matrix i j = 
  let length_i = Array.length matrix in 
  let length_j = Array.length matrix.(0) in 
  if (i>0 && i < length_i-1 &&  j>0 && j < length_j-1) then 
    let value = matrix.(i).(j) in 
    matrix.(i).(j+1)<> value || matrix.(i).(j-1)<> value
    ||matrix.(i+1).(j)<> value || matrix.(i-1).(j)<> value
  else
    false ;;



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
   matrix_bool  ;;
 

let draw_voronoi matrix voronoi = 
  let s_i = Array.length matrix in 
  let s_j = Array.length matrix.(0) in 
  for i = 0 to s_i -1 do 
    for j = 0 to s_j -1 do 
      if frontier matrix i j then
	begin 
	  set_color black ;
	  plot i j ; 
	end
      else
	begin
	  set_color (get_color voronoi.seeds.(matrix.(i).(j)).c);
	  plot i j ;
	end
    done
  done;;

let draw_voronoi matrix voronoi = 
  let s_i = Array.length matrix in 
  let s_j = Array.length matrix.(0) in 
  for i = 0 to s_i -1 do 
    for j = 0 to s_j -1 do 
      if frontier matrix i j then
	begin 
	  set_color black ;
	  plot i j ; 
	end
      else
	begin
	  set_color (get_color voronoi.seeds.(matrix.(i).(j)).c) ;
	  plot i j ;
	end
    done
  done;;

let chose () =
print_endline " choisir un mode  " ;
print_endline " 1 : euclide    " ;
print_endline " 2 : taxicable  " ;
let n = read_int () in
n ;;

let after__carte voronoi = 
  let x = chose() in 
  if x = 1 then regions_voronoi dist_min_pixel_seed dist_euclide voronoi
  else regions_voronoi dist_min_pixel_seed dist_taxicab voronoi 
;;

let 
open_graph " 600x600" ;auto_synchronize false ;draw_voronoi matrix v2 ;synchronize();;
close_graph();;

