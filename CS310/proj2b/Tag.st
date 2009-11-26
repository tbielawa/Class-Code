"XXX find an implement any empty methods in the following"
!Tag class methods!
handles
	 ^'someImpossibBle STRing'
!
handlerOf: tag
	   "XXX if not class handles tag, then instiate  TagError
           and get it to handle it by printing an error message"
	   self allSubclasses do: [:class|	
	   	class handles = tag ifTrue: [^class]].
           ^nil "XXX once TagError is running, get rid of this return" !
!!
! TagWidth class methods !
handles
	^'width'
!!
! TagWidth methods !
line: words for: this at: line
	words first asInteger oo.
	words size > 1
		ifTrue: [^self error: (line,')  expected 1 argument ')].
	this width: words first asInteger.
	"XXX need to complain when the first item is not an integer"
! !
