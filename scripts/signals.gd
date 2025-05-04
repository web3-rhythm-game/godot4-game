extends Node2D

var score:int= 0
signal IncrementScore(amount: int)
#called by KL, updates ScoreText in GameUI

signal IncrementCombo()
signal ResetCombo()

signal CreateFallingKey(button_name: String)
signal KeyListenerPress(button_name: String, array_num: int)
