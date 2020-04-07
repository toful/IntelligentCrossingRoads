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
    
    "Ater adding some facts and running the program we get the below results."
##############################################################################################
car with id 1 has arrived at cross at arrival 1
 and is going to cross the intersection from direction N
car with id 2 has arrived at cross at arrival 2
 and is going to cross the intersection from direction S
car with id 3 has arrived at cross at arrival 3
 and is going to cross the intersection from direction E
car with id 4 has arrived at cross at arrival 4
 and is going to cross the intersection from direction w
 
 (facts)
f-0     (initial-fact)
f-6     (car (id 0) (direction N) (arrival 0) (state crossed))
f-8     (car (id 1) (direction N) (arrival 1) (state crossed))
f-10    (car (id 2) (direction S) (arrival 2) (state crossed))
f-12    (car (id 3) (direction E) (arrival 3) (state crossed))
f-13    (car (id 4) (direction w) (arrival 4) (state crossing))
