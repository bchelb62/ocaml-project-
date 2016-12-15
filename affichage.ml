open Graphics
open Voronoi 

(* draw voronoi *)
let draw_voronoi matrix voronoi = 
  let s_i = Array.length matrix in 
  let s_j = Array.length matrix.(0) in 
  for i = 0 to s_i -1 do 
    for j = 0 to s_j -1 do 
      if frontier matrix i j s_i s_j then
	begin 
	  set_color black ;
	  plot i j ; 
	end
      else
	begin
	  set_color (get_color voronoi.seeds.(matrix.(i).(j)).c ) ;
	  plot i j ;
	end
    done
  done;;










