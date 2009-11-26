
	 
! Factory class methods !
new
	^super new init
!
parser
	"right now, incomplete. Needs more keywords mapped to classes"
	^self new
	       at: 'line' put: #LineTag
!!

! Factory class methods !
process: aFileName using: whatFactory
       |f|
       f := self perform: whatFactory.
       (File name: aFileName) readStream 
           linesDo: [:line| 
	       line size > 1 ifTrue: [
	       	   f do: line]].
      ^f wme
!!       
!Factory methods !
at: key put: classSymbol
    	string2Class at: key put: classSymbol
!
cantDo: first
    ('ERROR: unknown tag [' , first , ']') oo
!
do: string
    |first words thing klass instance|
    words    := string asWords.
    thing    := words removeFirst. 
    1 oo.
    klass    := string2Class at: thing ifAbsent: [^self cantDo: thing].
    2 oo.
    instance := klass new: [^self cantDo: first].
    33 oo.
    ^instance  do: words. 
!
init
	string2Class := Dictionary new.
	wme := OrderedCollection new.
!
wme
	^wme
!
add: w
     wme addLast:  w
!!
! LineTag methods !
do: words
    words oo
!!
