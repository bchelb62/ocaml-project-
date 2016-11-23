CAML=ocamlc
EXC=RUN
LIBS=graphics.cma
 
all:$(EXC)
 
$(EXC) : sat_solver.cmo Voronoi.cmo 
	$(CAML) $(LIBS) -o $@ $^ 
	
sat_solver.cmo : sat_solver.mli sat_solver.ml 
	$(CAML)  -c $^

Voronoi.cmo : Voronoi.mli Voronoi.ml
	$(CAML)  -c $^

.PHONY : clean mrproper

clean : 
	rm  -rf *~

mrproper: 
	rm -rf $(EXEC)
	rm -rf	*.cmo *.cmi 	
