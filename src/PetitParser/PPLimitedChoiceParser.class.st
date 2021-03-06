"
A PPLimitedChoiceParser is similar to the choice parser except for the fact, that limit must pass if one of the choices passes. This is similar strategy as with the PPLimitedRepeatingParsers.

This way, one can implement choices that successfully parse this (if limit is filled with 'a'):

('aa' // 'a') 'a' parse: 'aa'

The limit can be automatically filled using elements from either follow or next set (see methods  PPParser>>followSets or PPParser>>nextSets).

Limit is by default epsilon and therefore it behaves as an ordinary ordered choice.

Instance Variables
	limit:		<Object>

limit
	- xxxxx

"
Class {
	#name : #PPLimitedChoiceParser,
	#superclass : #PPChoiceParser,
	#instVars : [
		'limit'
	],
	#category : #'PetitParser-Parsers'
}

{ #category : #operators }
PPLimitedChoiceParser >> // aRule [ 
	^ self copyWith: aRule
]

{ #category : #initialization }
PPLimitedChoiceParser >> initialize [
	limit := nil asParser
]

{ #category : #accessing }
PPLimitedChoiceParser >> limit [
	
	^ limit
]

{ #category : #accessing }
PPLimitedChoiceParser >> limit: anObject [
	
	limit := anObject
]

{ #category : #parsing }
PPLimitedChoiceParser >> parseOn: aPPContext [
	"This is optimized code that avoids unnecessary block activations, do not change. When all choices fail, the last failure is answered."

	| element limitResult memento |
	1 to: parsers size do: [ :index |
		memento := aPPContext remember.
		
		element := (parsers at: index)
			parseOn: aPPContext.
		
		(element isPetitFailure not) ifTrue: [ 
			"check limit"
			limitResult := limit parseOn: aPPContext.
			limitResult isPetitFailure ifTrue: [ 
				element := PPFailure message: 'limit failed' at: aPPContext position .
				aPPContext restore: memento.
			] ifFalse: [ ^ element ].
		].
	].	
	^ element
]
