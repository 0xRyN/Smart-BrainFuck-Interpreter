all:
	ocamlfind ocamlopt -package Unix -linkpkg bf.ml -o bf

clean:
	rm *.cmx *.cmi *.o bf