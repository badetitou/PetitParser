"
A PPInfo represent the informations around a parsing result and also contain this result. It is usefull to get parsing evaluation and stream position.

Instance Variables
	element:		<Object>
	start:		<Object>
	stop:		<Object>

element
	- xxxxx

start
	- xxxxx

stop
	- xxxxx

"
Class {
	#name : #PPInfo,
	#superclass : #Object,
	#instVars : [
		'element',
		'start',
		'stop'
	],
	#category : #'PetitPreprocessor-Core'
}

{ #category : #'instance creation' }
PPInfo class >> new [
	self error: 'Info can only be created using a dedicated constructor.'
]

{ #category : #'instance creation' }
PPInfo class >> on: anElement start: aStartInteger stop: aStopInteger [
	^ self basicNew 
		initializeOn: anElement
		start: aStartInteger stop: aStopInteger
]

{ #category : #accessing }
PPInfo >> element [
	^ element
]

{ #category : #accessing }
PPInfo >> initializeOn: anElement start: aStartInteger stop: aStopInteger [
	element := anElement.
	start := aStartInteger.
	stop := aStopInteger
]

{ #category : #accessing }
PPInfo >> start [
	^ start
]

{ #category : #accessing }
PPInfo >> stop [
	^ stop
]
