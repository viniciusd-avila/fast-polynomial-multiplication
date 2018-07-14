;;TODO: correct small numeric errors, remove imaginary parts of the answer which tend towards zero

(defun split-poly-even-odd (A fun)
	(let ((res))
	(loop for k from 0 to (- (length A) 1)
		do (if (funcall fun k) (push (aref A k) res)))
	(make-array (length res) :initial-contents (reverse res))))

(defun fft (A &optional (c 1) (n (length A)))
  (if (equal n 1) A
    (let*
        ((omega 1)
         (omega-n (expt (exp 1) (* c (/ 2 n) pi (complex 0 1) )))
         (even (fft (split-poly-even-odd A #'evenp) c))
         (odd (fft (split-poly-even-odd A #'oddp) c))
         (y (make-array n)))
      (loop for k from 0 to (- (/ n 2) 1)
            do (setf (aref y k) (+ (aref even k) (* omega (aref odd k)))
                     (aref y (+ k (/ n 2))) (- (aref even k) (* omega (aref odd k)))
                     omega (* omega omega-n)))
      y)))

(defun inverse-fft (C)
  (let ((ans (fft C -1))
        (n (length C)))
    (loop for i from 0 to (- n 1)
          do (progn
               (setf (aref ans i) (/ (aref ans i) n))))
    ans))
	
(defun round-power-of-two (n)
  (expt 2 (ceiling (log n 2))))
 
(defun resize-array (A new-size &optional res)
  (loop for i from 0 to (- new-size 1)
        do (if (>= i (length A)) (push 0 res)
          (push (aref A i) res)))
  (make-array new-size :initial-contents (reverse res)))
  
(defun fast-poly-multiplication (A B)
	(let* ((n  (if (> (length A) (length B)) (round-power-of-two (* 2 (length A))) (round-power-of-two (* 2 (length B)))))
		(dft-A (fft (resize-array A n)))
		(dft-B (fft (resize-array B n)))
		(ans (make-array n)))
	(loop for i from 0 to (- n 1)
		do (setf (aref ans i) (* (aref dft-A i) (aref dft-B i))))
	(inverse-fft ans)))
