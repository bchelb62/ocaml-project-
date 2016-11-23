#load "graphics.cma";;
open Graphics;;     



type seed ={c:color option; x: int; y : int};;
type voronoi={dim : int*int; seeds: seed array};;

let v2 = {
  dim = 600,600;
  seeds = [|
    {c = None; x=100; y=100};
    {c = Some red; x=125; y=550};
	  |]};;

let taxicab (x1,y1) (x2,y2)= abs(x1-x2)+abs(y1-y2);;

let compare_min_tab tab=
  let min=ref tab.(0) and u=ref 0 in
  for i=0 to (Array.length tab) -1 do
    if !min > tab.(i) then
      begin
        min:=tab.(i);
        u:=i
      end 
  done;!u;;

compare_min_tab [|4;3;1;7;9|];;

let compare_dis tab idc=
  let u=ref 1 in
  for i=0 to (Array.length tab)-2 do
   for j=1 to (Array.length tab)-1 do
     if i!=idc then
       begin 
	 if tab.(i)=tab.(idc) then u:=0
       end
   done
  done;!u;;

let data = Array.make_matrix 600 600 {c=None;x=0;y=0} ;; 

let affiche v=
  let  data=Array.make_matrix 600 600 {c=None;x=0;y=0}
  and liste=ref [] and l=Array.length (v.seeds) and tab = Array.make (Array.length (v.seeds)) 0 in
  for i= 0 to 599 do
    for j=0 to 599 do
      for k=0 to l-1 do
      tab.(k)<-taxicab (i,j)(v.seeds.(k).x,v.seeds.(k).y)
      done;
      let indice=compare_min_tab(tab) in
      data.(i).(j)<-v.seeds.(indice);
      if compare_dis tab indice=0 then liste:=((i,j)::!liste)
    done
  done;(data,!liste);;



let coloring v=
  open_graph(" 600x600");
  let (ha,l)=affiche v and lr =ref [] and lg =ref [] and ly =ref [] and lb =ref [] and ln =ref [] in
  for i= 0 to 599 do
    for j=0 to 599 do 
      if ha.(i).(j).c=Some Red    then lr:=((i,j)::!lr) 
      else  if ha.(i).(j).c=Some Green  then lg:=((i,j)::!lg)
      else  if ha.(i).(j).c=Some Yellow then ly:=((i,j)::!ly)         
      else  if ha.(i).(j).c=Some Blue   then lb:=((i,j)::!lb)
      else  if ha.(i).(j).c=None        then ln:=((i,j)::!ln)
      else ()
    done
  done;
  let tabr=Array.of_list !lr and tabg=Array.of_list !lg and taby=Array.of_list !ly and tabb=Array.of_list !lb and tabn=Array.of_list !ln 
  and tabl=Array.of_list l  in
  
  set_color red;
  plots tabr;
  
  set_color green;
  plots tabg;
  
  set_color yellow;
  plots taby;
  
  set_color blue;
  plots tabb;
  
  set_color white;
  plots tabn;
  
  set_color black;
  plots tabl;; 

coloring v2;;
    
