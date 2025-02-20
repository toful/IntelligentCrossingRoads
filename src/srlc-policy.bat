;;; Authors:    Cristòfol Daudén Esmel
;;;             Klevis Shkembi

(load "car.clp")
(crc <state> <cars-crossed>)
 ;<state> from where cars are going to cross: N,S,E,W 
 ;<cars-crossed> number of cars that have crossed in the current state
(start_condition <start>)  ;auxiliar value in order to suply exists function
(assert (start_condition 1))

(defrule SRLC
       (declare (salience 0))
       ?car <- (car ?id ?direction waiting)
       (not (car ?id2&:(< ?id2 ?id) ?direction2 waiting)) ;cheecking the arrival order
       =>
        (retract ?car)
        (assert (car ?id ?direction crossing))
(printout t "Car with id " ?id " is going to cross the intersection from direction " ?direction crlf))

(defrule cars-crossing
       (declare (salience 1))
       ?car <- (car ?id ?direction crossing)
       =>
       (retract ?car)
       (assert (car ?id ?direction crossed))
       (printout t " Car with id " ?id " has been crossed " crlf))
       
       
(defrule start
       (declare (salience 2))
       ?aux <- (start_condition ?start)
       =>
       (retract ?aux)
       (printout t " How much cars do you want to work with " crlf)
       (bind ?r (read))
       (new-car ?r))        
       
 (run)
