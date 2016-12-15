open Voronoi 
open Graphics
open Affichage
open Fonction
open Examples 

let v = random_voronoi list_voro ;; 
print_int (dim_fenetre_h v) ;

(*
let caculate_matrix_chose voronoi = 
  let x = chose() in 
  if x = 1 then regions_voronoi dist_min_pixel_seed dist_euclide voronoi
  else regions_voronoi dist_min_pixel_seed dist_taxicab voronoi 


let matrix = caculate_matrix_chose Examples.v4 ;;

let matrix_cout = adjacences_voronoi_count Examples.v4 matrix ;; 

(*print_matrix matrix ;; *) 

open_graph (" "^(string_of_int (dim_fenetre_h Examples.v4))^"x"^(string_of_int (dim_fenetre_h Examples.v4)));

auto_synchronize false ;draw_voronoi matrix Examples.v4 ;synchronize();;

while true do () done 
*)




