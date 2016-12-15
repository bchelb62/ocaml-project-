CAML=ocamlc
EXC=run
LIBS=graphics.cma
 
all:$(EXC)
 
$(EXC) : sat_solver.cmo voronoi.cmo affichage.cmo examples.cmo fonction.cmo run.cmo 
	$(CAML) $(LIBS) -o $@ $^ 

fonction.cmo : fonction.ml
	$(CAML) -c $^

examples.cmo : examples.ml
	$(CAML) -c $^

run.cmo : run.ml 	
	$(CAML) -c $^  

sat_solver.cmo: sat_solver.ml sat_solver.cmi
	$(CAML) -c $<
	
sat_solver.cmi: sat_solver.mli
	$(CAML) -c $^

voronoi.cmo: voronoi.ml voronoi.cmi
	$(CAML) -c $<

voronoi.cmi: voronoi.mli
	$(CAML) -c $^

affichage.cmo : affichage.ml
	$(CAML) -c $^



.PHONY : clean mrproper cleanexc

clean : 
	rm  -rf *~
mrproper: 	
	rm -rf	*.cmo *.cmi
cleanexc : 
	rm -rf $(EXC) 	
