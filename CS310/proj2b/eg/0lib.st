#Fred isa: Object with: 'name' !

!Fred methods ! 
name: x      name := x ! 
name         ^name  ! 
!

|f|
f := Fred new name: 'flintsone'.
f name o.
f name oo.
!

#(11 22 33) oo.
'to be or not to be' asWords oo. 
!

|i|
i := 0.
'eg/0lib.st' fileLinesDo: [:line| 
   i := i + 1.
	(i s, ':', Character tab s, line ) oo].
!
