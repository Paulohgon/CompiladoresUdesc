.source corrigido.txt
.class public test
.super java/lang/Object

.method public <init>()V 
aload_0
invokenonvirtual java/lang/Object/<init>()V
return
.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 100
ldc 2
istore 0
ldc 3
istore 0
ldc 4
istore 0
ldc 5
istore 0
ldc 6
istore 0
ldc 21
ldc 3
idiv
istore 1
getstatic java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V

return
.end method
