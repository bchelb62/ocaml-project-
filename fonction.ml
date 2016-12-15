



let chose () =
  print_endline " choisir un mode  " ;
  print_endline " 1 : euclide    " ;
  print_endline " 2 : taxicable  " ;
  let n = read_int () in
  n 

(* for debug *)
let print_matrix matrix = 
  let size_i = Array.length matrix in
  let size_j = Array.length matrix in
  for i = 0 to size_i-1 do 
    for j = 0 to size_j-1 do
      print_string " " ;print_int matrix.(i).(j) ; 
    done ;
      print_newline() ;
  done ;;


