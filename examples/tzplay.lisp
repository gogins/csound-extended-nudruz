;;;; N U D R U Z   C S O U N D   F F I   E X A M P L E S
;;;; Michael Gogins
;;;; August 2018

#|
Contrary to CM documentation, the events function does not return a usable seq 
object. The generated score is placed into the seq that is passed to events.
|#
(require :asdf)
(require :quicklisp)
(ql:quickload "fomus")
(ql:quickload "nudruz")
(load "example-orc.lisp")
(in-package :cm)

(defparameter csound-seq (new seq :name "csound-test"))
(events (tzplay) csound-seq)
(defparameter *piano-part* 
  (new fomus:part
   :name "B3"
   :partid 0 
   :instr '(:piano :staves 2)))
(defparameter partids (make-hash-table))
(setf (gethash 0 partids) 0)
(defparameter voices (make-hash-table))
(setf (gethash 0 voices) (list 1 2))
(seq-to-lilypond csound-seq "tzplay.ly" *piano-part* partids voices :title "tzplay" :composer "Drew Krause")
(render-with-orc csound-seq orc-text :channel-offset 32 :velocity-scale 120 :csd-filename "tzplay.csd" :output "test.wav")
