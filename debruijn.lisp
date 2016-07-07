
; De Bruijn sequences
; like Eulerian paths, contain all subwords 

; K = 2, N = 4; length 16
(define debrn2n4
'(0 0 0 0 1 0 0 1 1 0 1 0 1 1 1 1))

; K = 2, N = 5; length 32
(define debrn2n5
  '(0 0 0 0 0 1 0 0 0 1 1 0 0 1 0 1 0 0 
    1 1 1 0 1 0 1 1 0 1 1 1 1 1))

; K = 2, N = 6; length 64
(define debrn2n6
  '(0 0 0 0 0 0 1 0 0 0 0 1 1 0 0 0 1 0 1 0 0 0 1 1 1
    0 0 1 0 0 1 0 1 1 0 0 1 1 0 1 0 0 1 1 1 1 0 1
    0 1 0 1 1 1 0 1 1 0 1 1 1 1 1 1))

; K = 2, N = 7; length 128
(define debrn2n7
  '(0 0 0 0 0 0 0 1 0 0 0 0 0 1 1 0 0 0 0 1 0 1 0 0 0 0 1 1 1
    0 0 0 1 0 0 1 0 0 0 1 0 1 1 0 0 0 1 1 0 1 0 0 0 1 1 1 1
    0 0 1 0 0 1 1 0 0 1 0 1 0 1 0 0 1 0 1 1 1 0 0 1 1 0 1 1
    0 0 1 1 1 0 1 0 0 1 1 1 1 1 0 1 0 1 0 1 1 0 1 0 1 1 1 1
    0 1 1 0 1 1 1 0 1 1 1 1 1 1 1))

; K = 2, N = 8; length 256
(define debrn2n8
  '(0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 1 0 1
    0 0 0 0 0 1 1 1 0 0 0 0 1 0 0 1 0 0 0 0 1 0 1 1
    0 0 0 0 1 1 0 1 0 0 0 0 1 1 1 1 0 0 0 1
    0 0 0 1 0 0 1 1 0 0 0 1 0 1 0 1 0 0 0 1 0 1 1 1
    0 0 0 1 1 0 0 1 0 0 0 1 1 0 1 1 0 0 0 1 1 1 0 1
    0 0 0 1 1 1 1 1 0 0 1 0 0 1 0 1 0 0 1 0 0 1 1 1
    0 0 1 0 1 0 1 1 0 0 1 0 1 1 0 1 0 0 1 0 1 1 1 1
    0 0 1 1 0 0 1 1 0 1 0 1 0 0 1 1 0 1 1 1 0 0 1 1 1 0 1 1
    0 0 1 1 1 1 0 1 0 0 1 1 1 1 1 1 0 1 0 1 0 1 0 1 1 1 0 1 0 1 1 0 1 1
    0 1 0 1 1 1 1 1 0 1 1 0 1 1 1 1 0 1 1 1 0 1 1 1 1 1 1 1 1))

; K = 3; N = 3; length 27
(define debrn3n3
  '(0 0 0 1 0 0 2 0 1 1 0 1 2 0 2 1 0 2 2 1 1 1 2 1 2 2 2))

; K = 3, N = 4; length 81
(define debrn3n4
  '(0 0 0 0 1 0 0 0 2 0 0 1 1 0 0 1 2 0 0 2 1 0 0 2 2 0 1
    0 1 0 2 0 1 1 1 0 1 1 2 0 1 2 1 0 1 2 2 0 2 0 2 1 1
    0 2 1 2 0 2 2 1 0 2 2 2 1 1 1 1 2 1 1 2 2 1 2 1 2 2 2 2))

; K = 3, N = 5; length 243
(define debrn3n5
  '(0 0 0 0 0 1 0 0 0 0 2 0 0 0 1 1 0 0 0 1 2 0 0 0 2 1
    0 0 0 2 2 0 0 1 0 1 0 0 1 0 2 0 0 1 1 1 0 0 1 1 2 0 0 1 2 1
    0 0 1 2 2 0 0 2 0 1 0 0 2 0 2 0 0 2 1 1 0 0 2 1 2 0 0 2 2 1
    0 0 2 2 2 0 1 0 1 1 0 1 0 1 2 0 1 0 2 1 0 1 0 2 2 0 1 1 0 2
    0 1 1 1 1 0 1 1 1 2 0 1 1 2 1 0 1 1 2 2 0 1 2 0 2 0 1 2 1 1
    0 1 2 1 2 0 1 2 2 1 0 1 2 2 2 0 2 0 2 1 0 2 0 2 2 0 2 1 1 1
    0 2 1 1 2 0 2 1 2 1 0 2 1 2 2 0 2 2 1 1 0 2 2 1 2 0 2 2 2 1
    0 2 2 2 2 1 1 1 1 1 2 1 1 1 2 2 1 1 2 1 2 1 1 2 2 2 1 2 1 2 2
    1 2 2 2 2 2))

; K= 4, N = 4; length 256
(define debrn4n4
  '(0 0 0 0 1 0 0 0 2 0 0 0 3 0 0 1 1 0 0 1 2 0 0 1 3 0 0 2 1
    0 0 2 2 0 0 2 3 0 0 3 1 0 0 3 2 0 0 3 3 0 1 0 1 0 2 0 1 0 3
    0 1 1 1 0 1 1 2 0 1 1 3 0 1 2 1 0 1 2 2 0 1 2 3 0 1 3 1 0 1 3 2
    0 1 3 3 0 2 0 2 0 3 0 2 1 1 0 2 1 2 0 2 1 3 0 2 2 1 0 2 2 2
    0 2 2 3 0 2 3 1 0 2 3 2 0 2 3 3 0 3 0 3 1 1 0 3 1 2 0 3 1 3
    0 3 2 1 0 3 2 2 0 3 2 3 0 3 3 1 0 3 3 2 0 3 3 3 1 1 1 1 2
    1 1 1 3 1 1 2 2 1 1 2 3 1 1 3 2 1 1 3 3 1 2 1 2 1 3
    1 2 2 2 1 2 2 3 1 2 3 2 1 2 3 3 1 3 1 3 2 2 1 3 2 3 1 3 3 2
    1 3 3 3 2 2 2 2 3 2 2 3 3 2 3 2 3 3 3 3))
