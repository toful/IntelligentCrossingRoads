;;; Authors:    Cristòfol Daudén Esmel
;;;             Klevis Shkembi

(deftemplate car (slot id) (slot direction) (slot arrival) (slot state)) 
;<id>  cars identification
;<direction>  The direction where cars come from (N,S,E,W)
;<arrival> the arrival position that cars arrive at intesrsection(1,2,3,4..)
;<state> state of the car: Waiting ,crossing,crossed

(defrule SRlC      ; "Cars will pass according to their arrival at intesection point."
        ?P <- (car  (id ?id) (direction ?direction) (arrival ?arrival) (state waiting))
        ?P1 <- (car (id ?) (direction ? ) (arrival ?arrival2&:(- ?arrival2 ?arrival 1)) (state crossing))
        (not (car (id ?) (direction ?) (arrival ?arrival3&:(< ?arrival3 ?arrival)) (state waiting)))
        =>
        (retract ?P)
        (modify ?P1 (state crossed))
        (assert (car (id ?id) (direction ?direction) (arrival ?arrival) (state crossing)))
        (printout T "car with id " ?id " has arrived at cross at arrival " ?arrival crlf
        " and is going to cross the intersection from direction " ?direction crlf)) 
    
    (run)
    
