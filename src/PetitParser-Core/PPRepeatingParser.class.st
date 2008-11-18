"
A parser that eagerly parses min to max instances of my delegate. The default instance parses eagerly an infinite number of elements, as min is set to 0 and max to infinity (SmallInteger maxVal).
"
Class {
	#name : #PPRepeatingParser,
	#superclass : #PPDelegateParser,
	#instVars : [
		'min',
		'max'
	],
	#category : #'PetitParser-Core'
}

{ #category : #'as yet unclassified' }
PPRepeatingParser class >> on: aParser [
	^ (super on: aParser) setMin: 0 max: SmallInteger maxVal
]

{ #category : #'as yet unclassified' }
PPRepeatingParser class >> on: aParser max: aMaxInteger [
	^ (super on: aParser) setMin: 0 max: aMaxInteger
]

{ #category : #'as yet unclassified' }
PPRepeatingParser class >> on: aParser min: aMinInteger [
	^ (super on: aParser) setMin: aMinInteger max: SmallInteger maxVal 
]

{ #category : #'as yet unclassified' }
PPRepeatingParser class >> on: aParser min: aMinInteger max: aMaxInteger [
	^ (super on: aParser) setMin: aMinInteger max: aMaxInteger
]

{ #category : #parsing }
PPRepeatingParser >> basicParse: aStream [
	| start element elements |
	start := aStream position.
	elements := OrderedCollection new.
	[ elements size < min ] whileTrue: [
		element := super basicParse: aStream.
		element isFailure
			ifFalse: [ elements addLast: element ]
			ifTrue: [
				aStream position: start.
				^ element ] ].
	[ elements size < max ] whileTrue: [
		element := super basicParse: aStream.
	 	element isFailure
			ifTrue: [ ^ elements asArray ].
		elements addLast: element ].
	^ elements asArray
]

{ #category : #printing }
PPRepeatingParser >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' ['; print: min; nextPutAll: ', '; print: max; nextPut: $]
]

{ #category : #initialization }
PPRepeatingParser >> setMin: aMinInteger max: aMaxInteger [
	min := aMinInteger.
	max := aMaxInteger
]