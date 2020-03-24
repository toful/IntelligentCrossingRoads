;;; Authors:    Cristòfol Daudén Esmel
;;;             Klevis

(clear)
(load "car.clp")

(defglobal ?*max-cars-crossed* = 6) ;number of cars that can cross before the traffic light changes
(crc <state> <cars-crossed>) ;Crossing Road Control
        ;<state> from where cars are going to cross: N-S:1 E-W:2 
        ;<cars-crossed> number of cars that have crossed in the current state


(defrule crossN-S
        (declare (salience 0)) ; medium priority –default 0    
        ?crc <- (crc 1 ?cars-crossed&:(< ?cars-crossed ?*max-cars-crossed*) )    
        ?car <- (car ?id ?direction&:(or (= ?direction 1) (= ?direction 2)) waiting )
        =>      
        (retract ?crc ?car)      
        (assert (car ?id ?direction crossed ) 
                (crc 1 (+ ?cars-crossed 1)))    
        (printout T "car with id " ?id " has crossed the intersection from " ?direction "." crlf))


(defrule crossE-W
        (declare (salience 0)) ; medium priority –default 0    
        ?crc <- (crc 2 ?cars-crossed&:(< ?cars-crossed ?*max-cars-crossed*) )    
        ?car <- (car ?id ?direction&:(or (= ?direction 3) (= ?direction 4)) waiting )
        =>      
        (retract ?crc ?car)      
        (assert (car ?id ?direction crossed ) 
                (crc 2 (+ ?cars-crossed 1)))    
        (printout T "car with id " ?id " has crossed the intersection from " ?direction "." crlf))


(defrule maxCarsCrossed 
        (declare (salience 0))
        ?crc <- (crc ?state ?cars-crossed&:(= ?cars-crossed ?*max-cars-crossed*) )
        =>
        (retract ?crc)
        (assert (crc (+ (mod ?state 2) 1) 0))
        (printout T "Crossing direction has chanched to " (+ (mod ?state 2) 1) " (N-S:1 E-W:2)." crlf))


(defrule noMoreCarsToCross 
        (declare (salience -1)) ;min priority, when no cars in the current direction can move
        ?crc <- (crc ?state ?cars-crossed)
        (exists (car ?id ?direction waiting)) ;to avoid an infinit loop when all cars have crossed
        =>
        (retract ?crc)
        (assert (crc (+ (mod ?state 2) 1) 0))
        (printout T "Crossing direction has chanched to " (+ (mod ?state 2) 1) " (N-S:1 E-W:2)." crlf))


(defrule start
        (declare (salience 1))
        (not (exists (crc)))
        =>
        (printout T "How much cars do you want to work with?" crlf)
        (bind ?r (read))
        (new-car ?r)
        (printout T "How much cars can cross before the traffic lights change?" crlf)
        (bind ?*max-cars-crossed* (read))
        (assert (crc 1 0)))

(run)