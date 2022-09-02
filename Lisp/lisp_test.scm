;1.3
(define (sumX a b c)
	(if (> a b)
		(if (> b c)
			(+ b a)
			(+ c a))
		(if (> a c)
			(+ a b)
			(+ c b))))
			
;1.3 easy func
(define (bigger a b) (if (> a b) a b))
(define (smaller a b) (if (< a b) a b))
(define (sum-two-bigger a b c)
	(+ (bigger (smaller a b) c) (bigger a b)))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2)) tolerance))
	(define (try guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
				(try next))))
	(try first-guess))
			
(define (repeated f n)
    (if (= n 1)
        f
        (lambda (x)
            (f ((repeated f (- n 1)) x)))))
			
(define (iterative-improve close-enough? improve)
    (lambda (first-guess)
        (define (try guess)
            (let ((next (improve guess)))
                (if (close-enough? guess next)
                    next
                    (try next))))
        (try first-guess)))
		
		
(define (average a b) (/ 2 (+ a b)))
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-seg sp ep) (cons sp ep))
(define (start-seg seg) (car seg))
(define (end-seg seg) (cdr seg))

(define (midpoint-seg seg)
	(let ((start (start-seg seg))
		 (end (end-seg seg)))
	(make-point (average (x-point start) (x-point end))
				(average (y-point start) (y-point end)))))

(define (rectangle wid-len1 wid-len2 hei-len1 hei-len2)
	(cons (cons wid-len1 hei-len1)
		  (cons wid-len2 hei-len2)))
(define (S r) (* (height r)(width r)))
(define (C r) (* 2 (+ (height r) (width r))))
(define (get-wid-len1 r) (car (car r)))
(define (get-hei-len1 r) (cdr (car r)))
(define (get-wid-len2 r) (car (cdr r)))
(define (get-hei-len2 r) (cdr (cdr r)))

(define (wid-of-rectangle r)
    (let (wid (get-wid-len1 r))
        (let ((start (start-seg wid))
              (end (end-seg wid)))
            (- (x-point end)
               (x-point start)))))
(define (hei-of-rectangle r)
    (let ((hei (get-hig-len1 r)))
        (let ((start (start-segment hei))
              (end (end-segment hei)))
            (- (y-point end)
               (y-point start)))))
			   
			   
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(add-1 zero)

(add-1 (lambda (f)
           (lambda (x)
               x)))

((lambda (n)                    ; add-1
     (lambda (f)
         (lambda (x)
             (f ((n f) x)))))
 (lambda (f)                    ; zero
     (lambda (x)
         x)))

(lambda (f)
    (lambda (x)
        (f (
            ((lambda (f)        ; zero
                 (lambda (x)
                     x))
             f)
            x))))

(lambda (f)
    (lambda (x)
        (f ((lambda (x) x)
            x))))

(lambda (f)
    (lambda (x)
        (f x)))
        (f x)))
		
(define zero (lambda (f) (lambda (x) x)))  
(define (add-1 n) (lambda (f) (lambda(x) (f ((n f) x)))))


(define (last-pair lst)
    (cond ((null? lst)
            (error "list empty -- LAST-PAIR"))
          ((null? (cdr lst))
            lst)
          (else
            (last-pair (cdr lst)))))
			
(define (reverse lists)
	(define (res lists result)
		(if (null? lists)
			result
			(res (cdr lists) 
				(cons (car lists) result))))
	(res lists '()))
	

; 可成功运行，最复杂版本，重改
; 判断了next为空的情况所以let中的内容不会为空
(define (filter judge lists)
	(define (get-cons lists)
		(let ((w (car lists))
			(next (cdr lists)))
		(cond ((null? lists) nil)
			  ((null? next)
					(if (judge w)
						(cons w '())
						'()))
			  ((judge w)
					(cons w (get-cons next)))
			  (else (get-cons next)))
			))
	(get-cons lists))
	
; 错误示范 car null会出错
(define (filter judge listes)
	(define (get-cons lists)
		(let ((w (car lists))
				 (next (cdr lists)))
		(cond ((null? lists) nil)
			  ((judge w)
					(cons w (get-cons next)))
			  (else (get-cons next)))
			))
	(get-cons listes))

; 正确示范，let放在中间
(define (filter judge listes)
	(define (get-cons lists)
		(if (null? lists)
				nil
				(let ((w (car lists))
					(next (cdr lists)))
					(if (judge w)
							(cons w (get-cons next))
							(get-cons next)))))
	(get-cons listes))
; ok，提取出judge
(define (filter judge lists)
		(cond ((null? lists) nil)
			  ((judge (car lists))
					(cons (car lists) 
						  (filter judge (cdr lists))))
			  (else (filter judge (cdr lists)))))

(define judge (lambda(x) (if (even? x) even? odd?)))
(filter odd? (list 1 2 3 4 5 6 7 8))
(filter judge(list 1 2 3 4 5))



(define (f w . lists)
	(display(w)
	display(" ")
	display(lists)))
	
(define (deep-reverse lists)
	(cond ((null? lists)
		'())
		((not (pair? lists))
			lists)
		(else (list (deep-reverse (cadr lists))
				  (deep-reverse (car lists))))))
(deep-reverse (list (list 1 2) (list 3 4)))

; list为第一个参数 才能append
(define (fringe lists)
	(cond ((null? lists)
			'())
		  ((not (pair? lists))
				(list lists))
		  (else (append (fringe (car lists))
						(fringe (cadr lists))))))
(define x (list (list 1 2) (list 3 4)))
(fringe x)



(define (make-moblie left right)
	(list left right))
(define (left-branch moblie) (car moblie))
(define (right-branch moblie) (cdr moblie))
(define (make-branch length structure)
	(list length structure))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (cdr branch))


(define (branch-weight branch)
    (if (hangs-another-mobile? branch)
        (total-weight (branch-structure branch))
        (branch-structure branch)))

(define (hangs-another-mobile? branch) 
    (pair? (branch-structure branch)))

(define (total-weight moblie) 
	(+ branch-weight(left-branch moblie)
	   branch-weight(right-branch moblie)))


(define (branch-torque branch)
    (* (branch-length branch)
       (branch-weight branch)))


(define (mobile-banlance? mobile)
	(let ((left) (left-branch mobile)
		  (right) (right-branch mobile))
		(and
			(same-torque? left right)
			(branch-banlance? left)
			(branch-banlance? right)
		)))

(define (branch-banlance? branch)
	(if (hangs-another-mobile? branch)
		(mobile-banlance? (branch-structure branch))
		#t))

(define (same-torque? left right)
    (= (branch-torque left)
       (branch-torque right)))



;
	(cond ((null? mobile) '())
		  ((not (pair? mobile)) ret)
		  ((= (branch-length left) (branch-length right))
				(if (pair? (branch-structure branch))
					(= (total-weight left) (total-weight right))))
;

(define (square x) (* x x))
(define (square-tree tree)
	(cond ((null? tree) '())
		  ((not (pair? tree))
			(square tree))
		  (else 
			(list ((car tree)) 
				  (cadr tree)))))
(square-tree (list (list 1 2) (list 3 4)))

(define (square-tree tree)
	(map (lambda(sub-tree) 
			(if (pair? sub-tree)
				(square-tree sub-tree)
				(square sub-tree)))
		tree))

;list要用cadr，cons用cdr
(define (square x) (* x x))
(define (tree-map f tree)
	(cond((null? tree) '())
		((not (pair? tree)) (f tree))
		(else
			(list (tree-map f (car tree))
				(tree-map f (cdr tree))))))

(define (square-tree tree) (tree-map square tree))

(tree-map square (list (list 1 2) (list 3 4)))

(define (map proc items)
	(if(null? items) '()
		(else
			(cons (proc items)
				(map proc (cadr items))))))

(define (accumlate op initial sequence)
	(if(null? sequence)
		initial
		(op (car sequence)
			(accumlate op initial (cdr sequence)))))

(define (reverse sequence)
    (fold-right (lambda (x y)
                    (cons y (list x)))
                '()
                sequence))
	
(define (enumerate-tree tree)
	(cond((null? tree) '())
		((not (pair? tree))
			(list tree))
		(else
			(append (enumerate-tree (car tree)
				(enumerate-tree (cdr tree)))))))

				
(define (enumerate-interval low high)
	(if(> low high)
		nil
		(cons low (enumerate-interval (+ low 1) high))))

(define (prime-sum? pair)
		(prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
	(list (car pair) (cadr pair) (+ (car pair) (cadr pair))))


(define (flatmap proc seq)
	(map proc seq))

(define (prime-sum-pairs n)
	(make-pair-sum
		(filter prime-sum? (unique-pairs n))))
						
(define (unique-pairs n)
	(flatmap
		(lambda(x)
		(map (lambda(y) (list x y))
				(enumerate-interval 1 (- n 1))))
				(enumerate-interval 1 n)))

(define (sum-s? s seq)
	(= s (accumlate + 0 seq)))

(define (unique-pairs n)
	(flatmap
		(lambda(x)
		(map (lambda(y) (list x y))
				(enumerate-interval 1 (- n 1))))
				(enumerate-interval 1 n)))
(define (unique-triples n)
	(flatmap
		(lambda(x)
			(map (lambda(y) (list x y))
					(unique-pairs (- x 1))))
		(enumerate-interval 1 n)))
		
(define (sum-s-pairs n)
	(make-pair-sum
		(filter sum-s? (unique-pairs n))))
		

(define (split big-combiner small-combiner)
    (lambda (painter n)
        (if (= n 0)
            painter
            (let ((smaller ((split big-combiner small-combiner) painter (- n 1))))
                (big-combiner painter
                              (small-combiner smaller smaller))))))

(define (element-of-set? x set)
	(cond((null? set) false)
		((equal? x (car set)) true)
		(else
			(element-of-set? x (cdr set)))))

(define (union-set set1 set2)
	(cond((null? set1) set2)
		((null? set2) set1)
		((element-of-set? (car set1) set2)
			(union-set (cdr set1) set2))
		(else
			(append (list (car set1)) (union-set (cdr set1) set2)))))
			
			

(define (list->tree elements)
    (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
    (if (= n 0)
        (cons '() elts)
        (let ((left-size (quotient (- n 1) 2)))
            (let ((left-result (partial-tree elts left-size)))
                (let ((left-tree (car left-result))
                      (non-left-elts (cdr left-result))
                      (right-size (- n (+ left-size 1))))
                    (let ((this-entry (car non-left-elts))
                          (right-result (partial-tree (cdr non-left-elts)
                                                      right-size)))
                        (let ((right-tree (car right-result))
                              (remaining-elts (cdr right-result)))
                            (cons (make-tree this-entry left-tree right-tree)
                                  remaining-elts))))))))