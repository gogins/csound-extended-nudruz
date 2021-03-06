;;; **********************************************************************
;;; $Name$
;;; $Revision$
;;; $Date$
(require :asdf)
(require :fomus)
(require :nudruz)
(load "example-csd.lisp")
(in-package :cm)


;;;
;;; Examples of "change ringing".  I was made aware of this compositional
;;; technique by Nicky Hind.  Change ringing is an algorithmic procedure
;;; for church bell ringing invented by those clever British, who also gave
;;; these algorithms great names like Plain Bob Minimus, Grandsire Doubles etc. 
;;; The algorithms all involve rotating diferent pairs of bells in the peal, 
;;; but "...the composer's job is to be sure that he has selected as far as
;;; possible the most musical sequences from the many thousands available."
;;; We implement change ringing by passsing the appropriate changes to the
;;; rotation pattern. These rotation changes affect just the first two
;;; change value numbers, ie. the start index and the stepping increment of
;;; the rotation.  Change ringing rotates (almost always) by pairs, so the
;;; step increment between rotations is generally 2.  The start index is
;;; (almost always) the mod 2 cycle. The basic changes for even bell hunting
;;; is therefore a cycle of two changes: (items (0 2) (1 2)).  This pattern
;;; is called the Plain Hunt. Plain Hunting causes a set of n elements to
;;; repeat after 2n changes, or n times through our cycle. Here is Plain Hunt
;;;  Minumus (4 elements A B C D); X marks the rotations.
;;;
;;; Plain Hunt Minimus
;;;	A B C D
;;;	 X   X
;;;	B A D C
;;;	   X
;;;	B D A C
;;;	 X   X
;;;	D B C A
;;;	   X
;;;	D C B A
;;;	 X   X
;;;	C D A B
;;;	   X
;;;	C A D B
;;;	 X   X
;;;	A C B D
;;;	   X
;;;	A B C D
;;;

;;; utility function to return pattern results.

(defun peals (p)
  ;; return periods of one full cyle and num changes.
  (let* ((a (next p t))
         (r (list a))
         (i 1))
    (loop for l = (next p t)
          until (equal l a)
          do 
          (nconc r (list l))
          (incf i))
    (values r i)))

;;;
;;; Plain Hunt changes: start=cycle(0,1) and step=2.
;;; For n elements, this process brings a pattern back to its original
;;; form after 2*n changes, which we look at as n repetitions of
;;; cycle(0,1)
;;;

(defun plain-hunt () (new cycle of '((0 2) (1 2))))

;(peals (new rotation of  '(a b c d) rotations (plain-hunt)))

;;;
;;; Plain Bob builds on the Plain Hunt and is n-1 repetions of cycle(0,1)
;;; followed by a "dodge" on the nth: cycle(0,2), wich causes the rotation
;;; to start at the 2nd index instead of the first, this stops the return 
;;; of the pattern, which finally repeats after 2n*(n-1) changes.
;;;

(defun dodge (start &optional (step 2))
  ;; returns a "dodged" cycle, ie instead of 0,1 its 0,x
  (new cycle of `((0 2) (,start ,step))))

(defun plain-bob (n)
  (new cycle
       of (list (new cycle of (plain-hunt) for (1- n))
                (dodge 2))))

;(peals (new rotation of  '(a b c d) rotations (plain-bob 4)))

;;;
;;; Call Bob builds on Plain Bob. It's n-2 repitions of Plain Bob
;;; followed by a plain bob whose dodge is different: cycle(1,3). The
;;; total number of changes become 3*(2n*(n-1)). So for 6 bells 
;;; (Call Bob Minumus), the pattern repeats after 3*60 or 180 changes.
;;;


(defun call-bob (n)
  (new cycle
    of
    (list (new cycle of (plain-bob n) for (- n 2))
          (new cycle of (list (new cycle of (plain-hunt) for (1- n)) 
                               (dodge 1 3))))))

;(peals (new rotation of '(a b c d e f) rotations (call-bob 6)))


;;;
;;; Call Single builds on Call Bob, but the very last dodge of 1,3 is
;;; replaced by a rotation of just the last two elements, which causes
;;; the process to double (360 changes for 6 bells). 
;;;



(defun call-single (n)
  (new cycle of
       (list
        (new cycle of (call-bob n) for 2)
        (new cycle
          of
          (list
           (new cycle of (plain-bob n) for (- n 2))
           ;; the third call-bob is the single
           (new cycle of (list (new cycle of (plain-hunt) for (1- n)) 
                               (dodge (- n 2)))))))))

; (peals (new rotation of  '(a b c d e f) rotations (call-single 6)))

;;;
;;; Grandsire rotates an odd number of Bells
;;;

(defun grandsire (n)
  (new cycle of
       (list 
        '(0 3)
        (new cycle of (new cycle of '((1 2) (0 2))) for (1- n))
        '(1 2))))

(peals (new rotation of '(a b c d) rotations (plain-hunt)))
(peals (new rotation of '(a b c d e) rotations (grandsire 5)))

(defprocess chrds (n p r d k a z)
  (process with j 
               repeat n
           do
           (setf j k)
           (loop for i in (next p t)
                 unless (eql i 0)
                 do
                 (output 
                  (new midi time (now)
                       duration d amplitude a
                       keynum j))
                 (incf j i))
           (setf k (+ k z))
           (wait r)))
; (events
 ; (list
  ; (chrds 60 (new rotation of '(0 3 4 7 8 11) rotations (plain-bob 6))
         ; .5 .5 48 .3 0)
  (chrds 60 (new rotation of '(0 3 4 7 8 11) rotations (plain-bob 6))
        .7 2 20 .3 1)
  ; )
 "midi.port"
 ; "brad2.midi"
 ; )

; (events
 ; (list
  ; (chrds 60 (new rotation of '(0 3 4 7 8 11) rotations (plain-bob 6))
         ; .7 2 80 .3 -1)
  ; (chrds 60 (new rotation of '(0 3 4 7 8 11) rotations (plain-bob 6))
         ; .7 2 20 .3 1)
  ; )
 ; "brad3.midi")
               
(defprocess dograndshire (r n tr am)
  (let ((pat (new rotation of '(cs4 ds fs gs as g a d)
                  rotations (grandsire 5) parser #'note)))
    (process repeat n
             for k = (next pat)
             do
             (output
              (new midi keynum (transpose k tr)
                   time (now)
                   amplitude am
                   duration (* r 1.5)))
             (wait r))))

(defparameter csound-seq (new seq :name "csound-test"))
(events (list (dograndshire (rhythm 's  100) 100  12 .4)
              (dograndshire (rhythm 'e  100) 50  -12 .5)
              (dograndshire (rhythm 'qq 100) 32  -36 .7)
              )
        csound-seq)
(list-objects csound-seq)
(defparameter *piano-part* 
    (new fomus:part
        :name "Bells"
        :partid 0 
        :instr '(:piano :staves 2)
    )
)
(defparameter partids (make-hash-table))
(setf (gethash 0 partids) 0)
(defparameter voices (make-hash-table))
(defparameter voicelist '(1 2 3))
(setf (gethash 0 voices) voicelist)
;(seq-to-lilypond csound-seq "cring-cm.ly" *piano-part* partids voices :title "Change Ringing" :composer "Rick Taube?")        
(render-with-csd csound-seq csd-text :channel-offset 14 :velocity-scale 100 :csd-filename "cring-cm.csd" :output "test.wav")
(quit)
