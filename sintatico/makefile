all: 
	flex main.lex
	bison -g --report=states -y -d main.y
	gcc lde.c lex.yy.c y.tab.c -o main.out
	./main.out< corrigido.txt

exec: all
	./trabalhoFinal.out

java:
	javac test.java
	javap -c test.class

error: 
	bison --verbose syntax.y

custom_run:
	./main.out < corrigido.txt
	java -jar ./jasmin-1.1/jasmin.jar output.j
	java test

jasmine_temp:
	java -jar ./jasmin-1.1/jasmin.jar output.j

run:
	java test

exec_jasm: exec jasmine_temp run