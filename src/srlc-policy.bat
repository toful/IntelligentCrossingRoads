(clear)
(load "car.clp")

(defglobal ?*max-cars-crossed* = 6) ;number of cars that can cross before the traffic light changes
(crc <state> <cars-crossed>) ;Crossing Road Control
;<state> from where cars are going to cross:N,S,E,W 
;<cars-crossed> number of cars that have crossed in the current state

(defrule FIRST
        (declare (salience 0)) ; medium priority –default 0
        ?crc <-(crc 1 ?cars-crossed&:(< ?cars-crossed ?*max-cars-crossed*))
        ?car <-(car ?id ?direction ?arrival&:(= ?arrival 1) waiting)
        (not(car ?id2&(<?id2 ?id) ?direction ?arrival&:(= ?arrival 1)waiting))
        =>
        (retract ?crc ?car)
        (assert (car ?id ?direction crossing)
        	(crc 1(+?cars-crossed 1)) )
        (printout t "car with id " ?d "has arrived first at cross at " ?arrival "and is going to cross the intersection from" ?direction crlf)
)

(defrule SECOND
        (declare (salience 0)) ; medium priority –default 0
        ?crc <- (crc 2 ?cars-crossed&:(< ?cars-crossed ?*max-cars-crossed*))
        ?car <- (car ?id ?direction ?arrival&:(= ?arrival 2) waiting)
        (not(car ?id2&:(<?id2 ?id) ?direction ?arrival&:(= ?arrival 2)waiting))
        (not(car ?id3 ?direction2 ?arrival&:(= ?arrival 1)waiting))
        =>
        (retract ?crc ?car)
	(assert (car ?id ?direction crossing)
        	(crc 2(+ ?cars-crossed 1)))
        (printout t "cars with id" ?id "has arrived at cross at " ?arrival "and is going to cross the intersection from" ?direction crlf)
)

(defrule THIRD
        (declare (salience 0)); medium priority –default 0
        ?crc <- (crc 3 ?cars-crossed&:(<?cars-crossed ?*max-cars-crossed*))
        ?car <- (car ?id ?direction ?arrival&: (= ?arrival 3) waiting)
        (not(car ?id2&(< ?id2 ?id) ?direction ?arrival&:(= ?arrival 3) waiting))
        (not(car ?id3 ?direction2 ?arrival&:(=?arrival 2)waiting))
        (not(car ?id4 ?direction3 ?arrival&:(=?arrival 1) waiting))
        =>
        retract(?crc ?car)
       (assert (car ?id ?direction crossing)
	       (crc 3(+ ?car-crossed 1)))
        (printout t "car with id "?id "has arrived at cross at " ?arrival "and is going to cross the intersection from " ?direction crlf)
)

(defrule FORTH
	(declare (salience 0)); medium priority –default 0
        ?crc <- (crc 4 ?cars-crossed&:(< ?cars-crossed ?*max-cars-crossed*))
        ?car <- (car ?id ?direction ?arrival&:(= ?arrival 4) waiting)
        (not(car ?id2&:(<?id2 ?id) ?direction ?arrival&:(= ?arrival 4) waiting))
        (not(car ?id3 ?direction2 ?arrival&:(= ?arrival 3) waiting))
        (not(car ?id4 ?direction3 ?arrival&:(= ?arrival 2) waiting))
        (not(car ?id5 ?direction4 ?arrival&:(= ?arrival 1) waiting))
        =>
        (retract ?crc ?car)
        (assert (car ?id ?direction crossing)
        	(crc 4 (+ ?cars-crossed 1)))
        (printout t "car with id" ?id "have arrived at cross at" ?arrival "and is going to cross the intersection from " ?direction crlf)
)

(defrule car-crossing
        (declare (salience 1))
        ?car <- (car ?id ?direction crossing )
        =>
        (retract ?car)
        ;(assert (car ?id ?direction crossed )) ;only if we want to maintain the history
        (printout T "car with id " ?id " has crossed." crlf))



(defrule maxCarsCrossed 
        (declare (salience 0))
        ?crc <- (crc ?state ?cars-crossed&:(= ?cars-crossed ?*max-cars-crossed*) )
        =>
        (retract ?crc)
        (assert (crc (+ (mod ?arrival 4) 0)))
        (printout T "Crossing direction has chanched to " (+ (mod ?arrival 4) 0) crlf) )



(defrule noMoreCarsToCross 
        (declare (salience -1)) ;min priority, when no cars in the current direction can move
        ?crc <- (crc ?state ?cars-crossed)
        (exists (car ?id ?direction waiting)) ;to avoid an infinit loop when all cars have crossed
        =>
        (retract ?crc)
        (assert (crc (+ (mod ?arrival 4) 0)))
        (printout T "Crossing direction has chanched to " (+ (mod ?arrival 4) 0)  crlf))

(defrule start
        (declare (salience 2))
        (not (exists (crc)))
        =>
        (printout T "How much cars do you want to work with?" crlf)
        (bind ?r (read))
        (new-car ?r)
        (printout T "How much cars can cross before the traffic lights change?" crlf)
        (bind ?*max-cars-crossed* (read))
        (assert (crc 1 0)))

(run)
