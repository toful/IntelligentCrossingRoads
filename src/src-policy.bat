;;; Authors:    Cristòfol Daudén Esmel
;;;             Klevis Shkembi

(clear)
(load "car.clp")

(defglobal ?*max-cars-crossed* = 6) ;number of cars that can cross before the traffic light changes
(crc <state> <cars-crossed>) ;Crossing Road Control
        ;<state> from where cars are going to cross: N-S:1 E-W:2 
        ;<cars-crossed> number of cars that have crossed in the current state

(start_condition <start>) ;auxiliar value in order to suply exists function
(assert (start_condition 1) )

(defrule crossN-S
        (declare (salience 0)) ; medium priority –default 0    
        ?crc <- (crc 1 ?cars-crossed&:(< ?cars-crossed ?*max-cars-crossed*) )    
        ?car <- (car ?id ?direction&:(or (= ?direction 1) (= ?direction 2)) waiting )
        (not (car ?id2&:(< ?id2 ?id) ?direction2&:(or (= ?direction2 1) (= ?direction2 2)) waiting ) ) ;checking the order
        =>      
        (retract ?crc ?car)      
        (assert (car ?id ?direction crossing ) 
                (crc 1 (+ ?cars-crossed 1)))    
        (printout T "car with id " ?id " is going to cross the intersection from " ?direction "." crlf))


(defrule crossE-W
        (declare (salience 0)) ; medium priority –default 0    
        ?crc <- (crc 2 ?cars-crossed&:(< ?cars-crossed ?*max-cars-crossed*) )    
        ?car <- (car ?id ?direction&:(or (= ?direction 3) (= ?direction 4)) waiting )
        (not (car ?id2&:(< ?id2 ?id) ?direction2&:(or (= ?direction2 3) (= ?direction2 4)) waiting ) ) ;checking the order
        =>      
        (retract ?crc ?car)      
        (assert (car ?id ?direction crossing ) 
                (crc 2 (+ ?cars-crossed 1)))    
        (printout T "car with id " ?id " is going to cross the intersection from " ?direction "." crlf))


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
        (assert (crc (+ (mod ?state 2) 1) 0))
        (printout T "Crossing direction has chanched to " (+ (mod ?state 2) 1) " (N-S:1 E-W:2)." crlf))


(defrule noMoreCarsToCross 
        (declare (salience -1)) ;min priority, when no cars in the current direction can move
        ?crc <- (crc ?state ?cars-crossed)
        ;(exists (car ?id ?direction waiting)) ;exists command does not work
        ?car_aux <- (car ?id ?direction waiting) ;to avoid an infinit loop when all cars have crossed
        =>
        (retract ?crc)
        (assert (crc (+ (mod ?state 2) 1) 0))
        (printout T "Crossing direction has chanched to " (+ (mod ?state 2) 1) " (N-S:1 E-W:2)." crlf))


(defrule start
        (declare (salience 2))
        ;(not (exists (crc))) ;exists command does not work
        ?aux <- (start_condition ?start)
        =>
        (retract ?aux)
        (printout T "How much cars do you want to work with?" crlf)
        (bind ?r (read))
        (new-car ?r)
        (printout T "How much cars can cross before the traffic lights change?" crlf)
        (bind ?*max-cars-crossed* (read))
        (assert (crc 1 0)))

(run)