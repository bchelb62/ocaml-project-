open Graphics 

	type seed = { c : color option; x : int; y : int; }
	type voronoi = { dim : int * int; seeds : seed array; }
      
	val dist_euclide : int * int -> int * int -> int
	val dist_taxicab : int * int -> int * int -> int
	val dim_fenetre_h : voronoi -> int 
	val dim_fenetre_l : voronoi -> int
	val x_seed : seed -> int
	val y_seed : seed -> int
	val get_color : Graphics.color option -> Graphics.color	
	(*val dist_min_pixel_seed : ('a * 'b -> int * int -> 'c) -> 'a * 'b -> seed array -> int  *)
	val dist_min_pixel_seed : 'a -> int * int -> seed array -> int
	val adjacences_voronoi_count : voronoi -> int array array -> int array array   
	val frontier :  'a array array -> int -> int -> int -> int -> bool   
	val regions_voronoi : ('a -> int * int -> seed array -> int) -> 'a -> voronoi -> int array array
	val dim_array_seeds : voronoi -> int
	(*val	adjacences_voronoi : voronoi -> int array array -> bool array array*)
  
