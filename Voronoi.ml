
open Graphics;;


module Voronoi  = 
struct  
  type seed = {c : color option ; x : int ; y : int }  
  type voronoi = {dim : (int*int) ; seeds : seed array } 
  type pixel_info = {seed_apt : seed option ; color_with : color option  }
       
  let dist_euclide  (x1,y1) (x2,y2) = 
    sqrt((x1-.x2) **  2.0 +. (y1-.y2)** 2.0 ) 
      
  let dist_taxicab (x1,y1) (x2,y2) = 
    abs(x1 - x2) +   abs(y1 - y2) 
      
  let creat_matrix_pixel n m = 
    Array.make_matrix n m {seed_apt = None ; color_with = None}
	
  let dim_fenetre_h voronoi = 
    voronoi.dim	   
  let dim_fenetre_l voronoi = 
    snd (voronoi.dim)  
      
      
  let v2 = {
    dim = 600,600 ;
    seeds = [|
      {c = None; x=100; y=100};
      {c = Some red; x=125; y=550};
      {c = None; x=250; y=50};
      {c = Some blue; x=150; y=250};
      {c = None; x=250; y=300};
      {c = None; x=300; y=500};
      {c = Some red; x=400; y=100};
      {c = None; x=450; y=450};
      {c = None; x=500; y=250};
      {c = Some yellow; x=575; y=350};
      {c = Some green; x=300; y=300};
      {c = None; x=75; y=470};
	    |]} ;; 
  
end ;;

open Voronoi

let x = dist_euclide (1.,3.) (3.,5.);;
print_float x ; 
