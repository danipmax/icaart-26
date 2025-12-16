; EXAMPLE 3:  go from "2" to "6" and from "3" to "6" when the car is stationed at "0" without refill.
; Taking into consideration the refuel constrains graphs only 

; NETWORK GRAPH

;		+---+             +---+             +---+
;		| 1 +------2------+ 2 +-------2-----+ 3 |
;		+-+-+             +-+-+             +-+-+
;		  |                 |                 |
;		  |                 |                 |
;		  |                 |                 |
;		  3                 4                 7
;		  |                 |                 |
;		  |                 |                 |
;		  |                 |                 |
;		+-+-+             +-+-+             +-+-+
;		| 4 +------2------+ 0 +-------6-----+ 5 |
;		+-+-+             +-+-+             +-+-+
;		  |                 |                 |
;		  |                 |                 |
;		  |                 |                 |
;		  6                 5                 3
;		  |                 |                 |
;		  |                 |                 |
;		  |                 |                 |
;		+-+-+             +-+-+             +-+-+
;		| 6 +------4------+ 8 +-------4-----+ 7 |
;		+---+             +---+             +---+

; PARAMETERS

;		+───────────+───────────────────+───────────+
;		| Notation  | Explanation       | Value     |
;		+───────────+───────────────────+───────────+
;		| E         | Full battery      | 50 kWh    |
;		|           | capacity          |           |
;		+───────────+───────────────────+───────────+
;		| Emin      | Minimum remaining | 15 kWh    |
;		|           | battery capacity  |           |
;		+───────────+───────────────────+───────────+
;		| g         | Consumption rate  | 2 kWh/km  |
;		|           |                   |           |
;		+───────────+───────────────────+───────────+
;		| h         | Charging rate     | 1 kWh/km  |
;		|           |                   |           |
;		+───────────+───────────────────+───────────+
;		| cap       | vehicle capacity  | 30 people |
;		|           |                   |           |
;		+───────────+───────────────────+───────────+
;		| v         | Average speed     | 30 km/h   |
;		|           |                   |           |
;		+───────────+───────────────────+───────────+
;		| t         | Dwell time at     | 1 min     |
;		|           | pick up and       |           |
;       |           | drop off station  |           |
;		+───────────+───────────────────+───────────+
;		| N         | The number of     | 3         |
;		|           | vehicles          |           |
;		+───────────+───────────────────+───────────+

;		+─────────+──────────────────────────+──────────────+──────────────────────────+───────────+
;		| Origin  | Time window (unit: min)  | Destination  | Time window (unit: min)  | Quantity  |
;		+─────────+──────────────────────────+──────────────+──────────────────────────+───────────+
;		| 1       | [5,15]                   | 5            | [30,40]                  | 15        |
;		+─────────+──────────────────────────+──────────────+──────────────────────────+───────────+
;		| 2       | [5,15]                   | 6            | [40,50]                  | 12        |
;		+─────────+──────────────────────────+──────────────+──────────────────────────+───────────+
;		| 3       | [5,15]                   | 6            | [35,50]                  | 13        |
;		+─────────+──────────────────────────+──────────────+──────────────────────────+───────────+
;		| 4       | [0,10]                   | 7            | [40,50]                  | 14        |
;		+─────────+──────────────────────────+──────────────+──────────────────────────+───────────+

(define (domain bus)
    (:requirements :typing :fluents :preferences)
    (:types
        place car - object
    )
    (:constants
        p0 -place
        p1 -place
        p2 -place
        p3 -place
        p4 -place
        p5 -place
        p6 -place
        p8 -place
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

        (speed ?c)
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

    (:action drive_0_2
        :parameters (?c -car)
        :precondition (and
            (location ?c p0)
            (>= (energy ?c) 26)
        )
        :effect (and
            (not (location ?c p0))
            (itinerary ?c p0 p2)
            (assign (car-distance ?c p2)(distance p0 p2))
            (assign (speed ?c) (ave_speed))
        )
    )

    (:event arrived_from_p0_to_p2
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p2) 0)
            (itinerary ?c p0 p2)
        )
        :effect (and
            (location ?c p2)
            (not (itinerary ?c p0 p2))
        )
    )

    (:action boarding_people_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p2)
            (> (people_at_station p2) 0)
            (>= (max_arrival_time p2) (elapsed_time))
            (<= (min_arrival_time p2) (elapsed_time))
            (> (people_requested_itinerary p2 p6) 0)
            (<= (people_in_car ?c) 30)
        )
        :effect (and
            (decrease
                (people_at_station p2)
                (people_requested_itinerary p2 p6)
                )
            (increase
                (people_in_car ?c)
                (people_requested_itinerary p2 p6)
                )
            (move_people p2 p6 ?c)
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
            (move_people p2 p6 ?c)
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
            (move_people p2 p6 ?c)
            (>= (time_in_station ?c p2) 1)
            (loading ?c)
        )
        :effect (and
            (not(loading ?c))
            (assign (time_in_station ?c p2) 0)
        )
    )

    (:action drive_2_1
        :parameters (?c -car)
        :precondition (and
            (location ?c p2)
            (>= (energy ?c) 24)
            (not(loading ?c))
        )
        :effect (and
            (not (location ?c p2))
            (itinerary ?c p2 p1)
            (assign (car-distance ?c p1)(distance p2 p1))
            (assign (speed ?c) (ave_speed))
        )
    )

    (:event arrived_from_p2_to_p1
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p1) 0)
            (itinerary ?c p2 p1)
        )
        :effect (and
            (location ?c p1)
            (not (itinerary ?c p2 p1))
        )
    )

    (:action drive_4_6
        :parameters (?c -car)
        :precondition (and
            (location ?c p4)
            (>= (energy ?c) 20)
            (not(loading ?c))
        )
        :effect (and
            (not (location ?c p4))
            (itinerary ?c p4 p6)
            (assign (car-distance ?c p6)(distance p4 p6))
            (assign (speed ?c) (ave_speed))
        )
    )

    (:event arrived_from_p4_to_p6
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p6) 0)
            (itinerary ?c p4 p6)
        )
        :effect (and
            (location ?c p6)
            (not (itinerary ?c p4 p6))
        )
    )

    (:action drive_6_4
        :parameters (?c -car)
        :precondition (and
            (location ?c p6)
            (>= (energy ?c) 26)
            (not(off-loading ?c))
        )
        :effect (and
            (not (location ?c p6))
            (itinerary ?c p6 p4)
            (assign (car-distance ?c p4)(distance p6 p4))
            (assign (speed ?c) (ave_speed))
        )
    )

    (:event arrived_from_p6_to_p4
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p4) 0)
            (itinerary ?c p6 p4)
        )
        :effect (and
            (location ?c p4)
            (not (itinerary ?c p6 p4))
        )
    )

    (:action drive_2_3
        :parameters (?c -car)
        :precondition (and
            (location ?c p2)
            (>= (energy ?c) 26)
            (not(loading ?c))
        )
        :effect (and
            (not (location ?c p2))
            (itinerary ?c p2 p3)
            (assign (car-distance ?c p3)(distance p2 p3))
            (assign (speed ?c) (ave_speed))
        )
    )

    (:event arrived_from_p2_to_p3
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p3) 0)
            (itinerary ?c p2 p3)
        )
        :effect (and
            (location ?c p3)
            (not (itinerary ?c p2 p3))
        )
    )

    (:action boarding_people_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p3)
            (> (people_at_station p3) 0)
            (>= (max_arrival_time p3) (elapsed_time))
            (<= (min_arrival_time p3) (elapsed_time))
            (> (people_requested_itinerary p3 p6) 0)
            (<= (people_in_car ?c) 30)
        )
        :effect (and
            (decrease
                (people_at_station p3)
                (people_requested_itinerary p3 p6)
                )
            (increase
                (people_in_car ?c)
                (people_requested_itinerary p3 p6)
                )
            (move_people p3 p6 ?c)
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
            (move_people p3 p6 ?c)
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
            (move_people p3 p6 ?c)
            (>= (time_in_station ?c p3) 1)
            (loading ?c)
        )
        :effect (and
            (not(loading ?c))
            (assign (time_in_station ?c p3) 0)
        )
    )

    (:action drive_3_2
        :parameters (?c -car)
        :precondition (and
            (location ?c p3)
            (>= (energy ?c) 22)
            (not(loading ?c))
        )
        :effect (and
            (not (location ?c p3))
            (itinerary ?c p3 p2)
            (assign (car-distance ?c p2)(distance p3 p2))
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
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
    (:action off_boarding_people_p6_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p6)
            (>= (max_arrival_time p6) (elapsed_time))
            (<= (min_arrival_time p6) (elapsed_time))
            (>(people_requested_itinerary p2 p6) 0)
            (move_people p2 p6 ?c)
        )
        :effect (and
            (not (move_people p2 p6 ?c))
            (increase
                (people_at_station p6)
                (people_requested_itinerary p2 p6)
                )
            (decrease
                (people_in_car ?c)
                (people_requested_itinerary p2 p6)
                )
            (assign (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p2 p6 ?c))
        )
    )
    (:process stop_proc_p6_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p6)
            (= (time_in_station ?c p6) 0)
            (= (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p2 p6 ?c))
        )
        :effect (and
            (increase (time_in_station ?c p6) (* #t 1.0))
        )
    )
    (:action off_boarding_people_p6_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p6)
            (>= (max_arrival_time p6) (elapsed_time))
            (<= (min_arrival_time p6) (elapsed_time))
            (>(people_requested_itinerary p3 p6) 0)
            (move_people p3 p6 ?c)
        )
        :effect (and
            (not (move_people p3 p6 ?c))
            (increase
                (people_at_station p6)
                (people_requested_itinerary p3 p6)
                )
            (decrease
                (people_in_car ?c)
                (people_requested_itinerary p3 p6)
                )
            (assign (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p3 p6 ?c))
        )
    )
    (:process stop_proc_p6_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p6)
            (= (time_in_station ?c p6) 0)
            (= (speed ?c) 0)
            (off-loading ?c)
            (not (move_people p3 p6 ?c))
        )
        :effect (and
            (increase (time_in_station ?c p6) (* #t 1.0))
        )
    )
    (:event allow_depart_p6_p2
        :parameters (?c -car)
        :precondition (and
            (location ?c p6)
            (= (speed ?c) 0)
            (not (move_people p2 p6 ?c))
            (>= (time_in_station ?c p6) 1)
            (off-loading ?c)
        )
        :effect (and
            (not(off-loading ?c))
            (assign (time_in_station ?c p6) 0)
        )
    )
    (:event allow_depart_p6_p3
        :parameters (?c -car)
        :precondition (and
            (location ?c p6)
            (= (speed ?c) 0)
            (not (move_people p3 p6 ?c))
            (>= (time_in_station ?c p6) 1)
            (off-loading ?c)
        )
        :effect (and
            (not(off-loading ?c))
            (assign (time_in_station ?c p6) 0)
        )
    )

    (:action drive_4_0
        :parameters (?c -car)
        :precondition (and
            (location ?c p4)
            (>= (energy ?c) 14)
        )
        :effect (and
            (not (location ?c p4))
            (itinerary ?c p4 p0)
            (assign (car-distance ?c p0)(distance p4 p0))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p4_to_p0
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p0) 0)
            (itinerary ?c p4 p0)
        )
        :effect (and
            (location ?c p0)
            (not (itinerary ?c p4 p0))
        )
    )

    (:action drive_1_4
        :parameters (?c -car)
        :precondition (and
            (location ?c p1)
            (>= (energy ?c) 20)
            (not(loading ?c))
        )
        :effect (and
            (not (location ?c p1))
            (itinerary ?c p1 p4)
            (assign (car-distance ?c p4)(distance p1 p4))
            (assign (speed ?c) (ave_speed))
        )
    )
    (:event arrived_from_p1_to_p4
        :parameters (?c -car)
        :precondition (and
            (<= (car-distance ?c p4) 0)
            (itinerary ?c p1 p4)
        )
        :effect (and
            (location ?c p4)
            (not (itinerary ?c p1 p4))
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
;; ALIAS on zsh java -jar enhsp.jar -o dissertation-tracked/pre-grounding/domain_example_1.pddl -f dissertation-tracked/pre-grounding/instance_example_1.pddl