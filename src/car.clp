;;; Authors:    Cristòfol Daudén Esmel
;;;             Klevis Shkembi

(car <id> <direction> <state> )
;<id> a symbol identifying the car
;<direction> from where the car comes: N S E W 
;<state> actual state of the car: waiting - crossing - crossed

(defglobal ?*num-directions* = 4) ; there are 4 directions 1:N 2:S 3:E 4:W 
(defglobal ?*car-id* = 1)  ;counter to generate car IDs 

(deffunction new-car (?num) ;“creates num new cars willing to cross the road” 
        (loop-for-count ?num  
                (assert (car ?*car-id*  
                        (+ (mod (random) ?*num-directions*) 1) 
                        waiting
                )) 
                (bind ?*car-id* (+ 1 ?*car-id*))) ; next car-id       
        (printout T ?num " new cars created." crlf))
