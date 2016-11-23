module  Voronoi  :  
sig  
  type seed = {c : Graphics.color option ; x : int ; y : int }  
  type voronoi = {dim : int*int ; seeds : seed array }
  type pixel_info = {seed_apt : seed option ; color_with : Graphics.color option  }  
  val dist_euclide : float * float -> float * float -> float
  val dist_taxicab : int*int -> int*int -> int 
  val creat_matrix_pixel : int -> int -> pixel_info array array 

end  

