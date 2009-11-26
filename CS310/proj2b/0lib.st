";;;;set global flags !"
ObjectMemory gcMessage: false 
!
";;;; convenient sub-classing"
! Symbol methods !
isa:  dad
     ^dad subclass: self       instanceVariableNames: ''
          classVariableNames: '' poolDictionaries: ''
          category: nil !
isa: dad with: vars
     ^dad subclass: self       instanceVariableNames: vars
          classVariableNames: '' poolDictionaries: ''
          category: nil !
isa: dad with: vars shares: classVars
     ^dad subclass: self
          instanceVariableNames: vars classVariableNames: classVars
          poolDictionaries: ''        category: nil !!

";;;; convenient printing"
! Object methods ! 
o       ^self s display   !
oo      ^self s displayNl !
s       ^self displayString !!
 
";;;; collection tricks"
! SequenceableCollection methods !
first: first then: then
         | atFirst |
         atFirst := true .
         self do: [:elm |
               atFirst ifFalse: [then  value: elm]
                       ifTrue:  [first value: elm].
               atFirst := false] !!
 
! Array methods !
printOn: aStream
	 aStream nextPut: $(.
         self first: [:elm| elm printOn: aStream]
              then:  [:elm| aStream space.
                            elm printOn: aStream].
         aStream nextPut: $) !!

";;;; string ticks"
! String methods ! 
asWords  
      ^(self tokenize: '\s+') asOrderedCollection !
fileLinesDo: aBlock
    |f last|         
    f := File name: self.
    f readStream linesDo: [:line|
        last := aBlock value: line].
	f readStream close.
    ^last !!
