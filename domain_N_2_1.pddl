; 

(define (domain bus)
    (:requirements :typing :fluents :preferences)
    (:types
        place car - object
    )
    (:constants
        p1 - place
        p2 - place
        p3 - place
        p4 - place
        p7 - place
        p10 - place
        p13 - place
        p14 - place
    )

    (:predicates
        (location ?c - car ?p - place)
        (connected ?p1 ?p2 -place)
        (itinerary ?c -car ?from ?to -place)
        (arrived_at ?c - car ?p - place)
        (move_people ?from ?to -place ?c -car)
        (loading ?c -car)
        (off-loading ?c -car)
        (charging ?c -car)

    )

    (:functions
        (distance ?p1 ?p2 - place)
        (car-distance ?c -car ?p -place)
        (energy ?c -car)

        (elapsed_time)
        (time_in_station ?c -car ?p -place)
        (max_arrival_time ?p -place)
        (min_arrival_time ?p -place)

        (speed ?c -car)
        (ave_speed)

        (people_at_station ?p1 -place)
        (people_in_car ?c -car)

        (people_requested_itinerary ?p1 ?p2 -place)
    )

    (:process passage_of_time
        :parameters ()
        :precondition ()
        :effect (increase (elapsed_time) (* #t 1.0))
    )

    (:action drive_p1_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p1)
            (>= (energy ?c) 5)
            ;(not(loading ?c))
        )
        :effect (and
            (not (location ?c p1))
            (itinerary ?c p1 p3)
            (assign (car-distance ?c p3) (distance p1 p3))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p1_to_p3
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p3) 0)
            (itinerary ?c p1 p3)
        )
        :effect (and
            (location ?c p3)
            (not (itinerary ?c p1 p3))
        )
    )

    (:action drive_p1_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p1)
            (>= (energy ?c) 6)
            ;(not(loading ?c))
        )
        :effect (and
            (not (location ?c p1))
            (itinerary ?c p1 p2)
            (assign (car-distance ?c p2) (distance p1 p2))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p1_to_p2
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p2) 0)
            (itinerary ?c p1 p2)
        )
        :effect (and
            (location ?c p2)
            (not (itinerary ?c p1 p2))
        )
    )

    (:action drive_p2_p10
        :parameters (?c -car)
        :precondition (and
            (location ?c p2)
            (>= (energy ?c) 41)
            ;(not(loading ?c))
        )
        :effect (and
            (not (location ?c p2))
            (itinerary ?c p2 p10)
            (assign (car-distance ?c p10) (distance p2 p10))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p2_to_p10
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p10) 0)
            (itinerary ?c p2 p10)
        )
        :effect (and
            (location ?c p10)
            (not (itinerary ?c p2 p10))
        )
    )

    (:action drive_p10_p7
        :parameters (?c -car)
        :precondition (and
            (location ?c p10)
            (>= (energy ?c) 40)
            ;(not(off-loading ?c))
        )
        :effect (and
            (not (location ?c p10))
            (itinerary ?c p10 p7)
            (assign (car-distance ?c p7) (distance p10 p7))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p10_to_p7
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p7) 0)
            (itinerary ?c p10 p7)
        )
        :effect (and
            (location ?c p7)
            (not (itinerary ?c p10 p7))
        )
    )

    (:action drive_p2_p7
        :parameters (?c -car)
        :precondition (and
            (location ?c p2)
            (>= (energy ?c) 5)
            ;(not(loading ?c))
        )
        :effect (and
            (not (location ?c p2))
            (itinerary ?c p2 p7)
            (assign (car-distance ?c p7) (distance p2 p7))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p2_to_p7
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p7) 0)
            (itinerary ?c p2 p7)
        )
        :effect (and
            (location ?c p7)
            (not (itinerary ?c p2 p7))
        )
    )

    (:action drive_p7_p13
        :parameters (?c -car)
        :precondition (and
            (location ?c p7)
            (>= (energy ?c) 18)
        )
        :effect (and
            (not (location ?c p7))
            (itinerary ?c p7 p13)
            (assign (car-distance ?c p13) (distance p7 p13))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p7_to_p13
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p13) 0)
            (itinerary ?c p7 p13)
        )
        :effect (and
            (location ?c p13)
            (not (itinerary ?c p7 p13))
        )
    )

    (:action drive_p13_p7
        :parameters (?c -car)
        :precondition (and
            (location ?c p13)
            (>= (energy ?c) 18)
            (not(off-loading ?c))
        )
        :effect (and
            (not (location ?c p13))
            (itinerary ?c p13 p7)
            (assign (car-distance ?c p7) (distance p13 p7))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p13_to_p7
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p7) 0)
            (itinerary ?c p13 p7)
        )
        :effect (and
            (location ?c p7)
            (not (itinerary ?c p13 p7))
        )
    )

    (:action drive_p3_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p3)
            (>= (energy ?c) 1)
            ;(not(loading ?c))
        )
        :effect (and
            (not (location ?c p3))
            (itinerary ?c p3 p2)
            (assign (car-distance ?c p2) (distance p3 p2))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p3_to_p2
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p2) 0)
            (itinerary ?c p3 p2)
        )
        :effect (and
            (location ?c p2)
            (not (itinerary ?c p3 p2))
        )
    )

    (:action drive_p3_p4
        :parameters (?c -car)
        :precondition (and
            (location ?c p3)
            (>= (energy ?c) 1)
            ;(not(loading ?c))
        )
        :effect (and
            (not (location ?c p3))
            (itinerary ?c p3 p4)
            (assign (car-distance ?c p4) (distance p3 p4))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p3_to_p4
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p4) 0)
            (itinerary ?c p3 p4)
        )
        :effect (and
            (location ?c p4)
            (not (itinerary ?c p3 p4))
        )
    )

    (:action drive_p4_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p4)
            (>= (energy ?c) 2)
            ;(not(loading ?c))
        )
        :effect (and
            (not (location ?c p4))
            (itinerary ?c p4 p2)
            (assign (car-distance ?c p2) (distance p4 p2))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p4_to_p2
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p2) 0)
            (itinerary ?c p4 p2)
        )
        :effect (and
            (location ?c p2)
            (not (itinerary ?c p4 p2))
        )
    )

    (:action drive_p7_p14
        :parameters (?c -car)
        :precondition (and
            (location ?c p7)
            (>= (energy ?c) 16)
        )
        :effect (and
            (not (location ?c p7))
            (itinerary ?c p7 p14)
            (assign (car-distance ?c p14) (distance p7 p14))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p7_to_p14
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p14) 0)
            (itinerary ?c p7 p14)
        )
        :effect (and
            (location ?c p14)
            (not (itinerary ?c p7 p14))
        )
    )

    (:action drive_p14_p7
        :parameters (?c -car)
        :precondition (and
            (location ?c p14)
            (>= (energy ?c) 16)
            (not(off-loading ?c))
        )
        :effect (and
            (not (location ?c p14))
            (itinerary ?c p14 p7)
            (assign (car-distance ?c p7) (distance p14 p7))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p14_to_p7
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p7) 0)
            (itinerary ?c p14 p7)
        )
        :effect (and
            (location ?c p7)
            (not (itinerary ?c p14 p7))
        )
    )

    (:action drive_p13_p14
        :parameters (?c -car)
        :precondition (and
            (location ?c p13)
            (>= (energy ?c) 5)
            (not(off-loading ?c))
        )
        :effect (and
            (not (location ?c p13))
            (itinerary ?c p13 p14)
            (assign (car-distance ?c p14) (distance p13 p14))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p13_to_p14
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p14) 0)
            (itinerary ?c p13 p14)
        )
        :effect (and
            (location ?c p14)
            (not (itinerary ?c p13 p14))
        )
    )

    (:action boarding_people_p1
        :parameters (?c -car)
        :precondition (and
            (location ?c p1)
            (> (people_at_station p1) 0)
            (>= (max_arrival_time p1) (elapsed_time))
            (<= (min_arrival_time p1) (elapsed_time))
            (> (people_requested_itinerary p1 p10) 0)
            (<=(+ (people_in_car ?c)(people_at_station p1)) 30)
        )
        :effect (and
            (decrease
                (people_at_station p1)
                (people_requested_itinerary p1 p10)
                )
            (increase
                (people_in_car ?c)
                (people_requested_itinerary p1 p10)
                )
            (move_people p1 p10 ?c)
            (assign (speed ?c) 0)
            (loading ?c)
        )
    )
    (:process stop_proc_p1
        :parameters (?c -car)
        :precondition (and
            (location ?c p1)
            (= (time_in_station ?c p1) 0)
            (= (speed ?c) 0)
            (loading ?c)
            (move_people p1 p10 ?c)
        )
        :effect (and
            (increase (time_in_station ?c p1) (* #t 1.0))
        )
    )
    (:event allow_depart_p1
        :parameters (?c -car)
        :precondition (and
            (location ?c p1)
            (= (speed ?c) 0)
            (move_people p1 p10 ?c)
            (>= (time_in_station ?c p1) 1)
            (loading ?c)
        )
        :effect (and
            (not(loading ?c))
            (assign (time_in_station ?c p1) 0)
        )
    )

    (:action boarding_people_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p2)
            (> (people_at_station p2) 0)
            (>= (max_arrival_time p2) (elapsed_time))
            (<= (min_arrival_time p2) (elapsed_time))
            (> (people_requested_itinerary p2 p13) 0)
            (<= (+ (people_in_car ?c)(people_at_station p2)) 30)
        )
        :effect (and
            (decrease
                (people_at_station p2)
                (people_requested_itinerary p2 p13)
                )
            (increase
                (people_in_car ?c)
                (people_requested_itinerary p2 p13)
                )
            (move_people p2 p13 ?c)
            (assign (speed ?c) 0)
            (loading ?c)
        )
    )
    (:process stop_proc_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p2)
            (= (time_in_station ?c p2) 0)
            (= (speed ?c) 0)
            (loading ?c)
            (move_people p2 p13 ?c)
        )
        :effect (and
            (increase (time_in_station ?c p2) (* #t 1.0))
        )
    )
    (:event allow_depart_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p2)
            (= (speed ?c) 0)
            (move_people p2 p13 ?c)
            (>= (time_in_station ?c p2) 1)
            (loading ?c)
        )
        :effect (and
            (not(loading ?c))
            (assign (time_in_station ?c p2) 0)
        )
    )

    (:action boarding_people_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p3)
            (> (people_at_station p3) 0)
            (>= (max_arrival_time p3) (elapsed_time))
            (<= (min_arrival_time p3) (elapsed_time))
            (> (people_requested_itinerary p3 p10) 0)
            (<= (+ (people_in_car ?c)(people_at_station p3)) 30)
        )
        :effect (and
            (decrease
                (people_at_station p3)
                (people_requested_itinerary p3 p10)
                )
            (increase
                (people_in_car ?c)
                (people_requested_itinerary p3 p10)
                )
            (move_people p3 p10 ?c)
            (assign (speed ?c) 0)
            (loading ?c)
        )
    )
    (:process stop_proc_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p3)
            (= (time_in_station ?c p3) 0)
            (= (speed ?c) 0)
            (loading ?c)
            (move_people p3 p10 ?c)
        )
        :effect (and
            (increase (time_in_station ?c p3) (* #t 1.0))
        )
    )
    (:event allow_depart_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p3)
            (= (speed ?c) 0)
            (move_people p3 p10 ?c)
            (>= (time_in_station ?c p3) 1)
            (loading ?c)
        )
        :effect (and
            (not(loading ?c))
            (assign (time_in_station ?c p3) 0)
        )
    )

    (:action boarding_people_p4
        :parameters (?c -car)
        :precondition (and
            (location ?c p4)
            (> (people_at_station p4) 0)
            (>= (max_arrival_time p4) (elapsed_time))
            (<= (min_arrival_time p4) (elapsed_time))
            (> (people_requested_itinerary p4 p14) 0)
            (<=(+ (people_in_car ?c)(people_at_station p4)) 30)
        )
        :effect (and
            (decrease
                (people_at_station p4)
                (people_requested_itinerary p4 p14)
                )
            (increase
                (people_in_car ?c)
                (people_requested_itinerary p4 p14)
                )
            (move_people p4 p14 ?c)
            (assign (speed ?c) 0)
            (loading ?c)
        )
    )
    (:process stop_proc_p4
        :parameters (?c -car)
        :precondition (and
            (location ?c p4)
            (= (time_in_station ?c p4) 0)
            (= (speed ?c) 0)
            (loading ?c)
            (move_people p4 p14 ?c)
        )
        :effect (and
            (increase (time_in_station ?c p4) (* #t 1.0))
        )
    )
    (:event allow_depart_p4
        :parameters (?c -car)
        :precondition (and
            (location ?c p4)
            (= (speed ?c) 0)
            (move_people p4 p14 ?c)
            (>= (time_in_station ?c p4) 1)
            (loading ?c)
        )
        :effect (and
            (not(loading ?c))
            (assign (time_in_station ?c p4) 0)
        )
    )

    (:action off_boarding_people_p10_p1
        :parameters (?c -car)
        :precondition (and
            (location ?c p10)
            (>= (max_arrival_time p10) (elapsed_time))
            (<= (min_arrival_time p10) (elapsed_time))
            (>(people_requested_itinerary p1 p10) 0)
            (move_people p1 p10 ?c)
        )
        :effect (and
            (not (move_people p1 p10 ?c))
            (increase
                (people_at_station p10)
                (people_requested_itinerary p1 p10)
                )
            (decrease
                (people_in_car ?c)
                (people_requested_itinerary p1 p10)
                )
            (assign (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p1 p10 ?c))
        )
    )
    (:process stop_proc_p10_p1
        :parameters (?c -car)
        :precondition (and
            (location ?c p10)
            (= (time_in_station ?c p10) 0)
            (= (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p1 p10 ?c))
        )
        :effect (and
            (increase (time_in_station ?c p10) (* #t 1.0))
        )
    )
    (:event allow_depart_p10_p1
        :parameters (?c -car)
        :precondition (and
            (location ?c p10)
            (= (speed ?c) 0)
            (not (move_people p1 p10 ?c))
            (>= (time_in_station ?c p10) 1)
            (off-loading ?c)
        )
        :effect (and
            (not(off-loading ?c))
            (assign (time_in_station ?c p10) 0)
        )
    )

    (:action off_boarding_people_p13_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p13)
            (>= (max_arrival_time p13) (elapsed_time))
            (<= (min_arrival_time p13) (elapsed_time))
            (>(people_requested_itinerary p2 p13) 0)
            (move_people p2 p13 ?c)
        )
        :effect (and
            (not (move_people p2 p13 ?c))
            (increase
                (people_at_station p13)
                (people_requested_itinerary p2 p13)
                )
            (decrease
                (people_in_car ?c)
                (people_requested_itinerary p2 p13)
                )
            (assign (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p2 p13 ?c))
        )
    )
    (:process stop_proc_p13_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p13)
            (= (time_in_station ?c p13) 0)
            (= (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p2 p13 ?c))
        )
        :effect (and
            (increase (time_in_station ?c p13) (* #t 1.0))
        )
    )
    (:event allow_depart_p13_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p13)
            (= (speed ?c) 0)
            (not (move_people p2 p13 ?c))
            (>= (time_in_station ?c p13) 1)
            (off-loading ?c)
        )
        :effect (and
            (not(off-loading ?c))
            (assign (time_in_station ?c p13) 0)
        )
    )

    (:action off_boarding_people_p10_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p10)
            (>= (max_arrival_time p10) (elapsed_time))
            (<= (min_arrival_time p10) (elapsed_time))
            (>(people_requested_itinerary p3 p10) 0)
            (move_people p3 p10 ?c)
        )
        :effect (and
            (not (move_people p3 p10 ?c))
            (increase
                (people_at_station p10)
                (people_requested_itinerary p3 p10)
                )
            (decrease
                (people_in_car ?c)
                (people_requested_itinerary p3 p10)
                )
            (assign (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p3 p10 ?c))
        )
    )
    (:process stop_proc_p10_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p10)
            (= (time_in_station ?c p10) 0)
            (= (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p3 p10 ?c))
        )
        :effect (and
            (increase (time_in_station ?c p10) (* #t 1.0))
        )
    )
    (:event allow_depart_p10_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p10)
            (= (speed ?c) 0)
            (not (move_people p3 p10 ?c))
            (>= (time_in_station ?c p10) 1)
            (off-loading ?c)
        )
        :effect (and
            (not(off-loading ?c))
            (assign (time_in_station ?c p10) 0)
        )
    )

    (:action off_boarding_people_p14_p4
        :parameters (?c -car)
        :precondition (and
            (location ?c p14)
            (>= (max_arrival_time p14) (elapsed_time))
            (<= (min_arrival_time p14) (elapsed_time))
            (>(people_requested_itinerary p4 p14) 0)
            (move_people p4 p14 ?c)
        )
        :effect (and
            (not (move_people p4 p14 ?c))
            (increase
                (people_at_station p14)
                (people_requested_itinerary p4 p14)
                )
            (decrease
                (people_in_car ?c)
                (people_requested_itinerary p4 p14)
                )
            (assign (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p4 p14 ?c))
        )
    )
    (:process stop_proc_p14_p4
        :parameters (?c -car)
        :precondition (and
            (location ?c p14)
            (= (time_in_station ?c p14) 0)
            (= (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p4 p14 ?c))
        )
        :effect (and
            (increase (time_in_station ?c p14) (* #t 1.0))
        )
    )
    (:event allow_depart_p14_p4
        :parameters (?c -car)
        :precondition (and
            (location ?c p14)
            (= (speed ?c) 0)
            (not (move_people p4 p14 ?c))
            (>= (time_in_station ?c p14) 1)
            (off-loading ?c)
        )
        :effect (and
            (not(off-loading ?c))
            (assign (time_in_station ?c p14) 0)
        )
    )

    (:process drive_proc
        :parameters (?c - car ?from ?to -place)
        :precondition (and
            (itinerary ?c ?from ?to)
            (> (car-distance ?c ?to) 0)
            (> (speed ?c) 0)
        )
        :effect (and
            (decrease (car-distance ?c ?to) (* #t (speed ?c)))
            (increase
                (car-distance ?c ?from)
                (* #t (speed ?c)))
            (decrease (energy ?c) (* 2 (* #t (speed ?c))))
        )
    )

)

; TODO 
;; ALIAS on zsh java -jar enhsp.jar -o dissertation-tracked/MACB-ITSC25/domain_N_2_1.pddl -f dissertation-tracked/MACB-ITSC25/instance_N_2_1.pddl