"XXX find an implement any empty methods in the following"
!GraphReader class methods !
new 
    ^super new init  
!!
! GraphReader  methods !
init
	line := 0.
	self handler: Tag;
   	     commentChar: $#.
!
cantDo: this
	^self error: ('line ',line s,') cannot handle [',this,']')
!
commentChar: aChar
	commentChar := aChar
!
handler: aRootClass
	 handler := aRootClass
!
handlerOf: aString 
    ^(handler handlerOf: aString) ifNil: [^self cantDo: aString]
!
line: string for: graph
    |words thing  klass|
    words := string asWords.
    thing := words removeFirst. 
    klass := self handlerOf: thing.
    ^klass new  line: words for: graph at: line
!
lines: aFileName for: graph
      "XXX delete all commentChars and anything to their right.
       XXX After that, skip any blank or empty lines"
	line := 0.
	aFileName fileLinesDo: [:words|
		line := line + 1.
		words size > 1 ifTrue: [ 
			self line: words for: graph]] !
!!
