(define (problem example3)

    ; EXAMPLE 3:  go from "2" to "6" and from "3" to "6" when the car is stationed at "0" without refill.
    ; Taking into consideration the refuel constrains graphs only 
    (:domain bus)

    (:objects
        car0 - car

    )
    (:init

        (= (distance p4 p0) 2)

        (= (distance p1 p4) 3)

        (= (distance p2 p1) 2)

        (= (distance p2 p3) 2)
        (= (distance p3 p2) 2)

        (= (distance p0 p2) 4)

        (= (distance p4 p6) 6)
        (= (distance p6 p4) 6)

        (= (distance p6 p8) 4)
        (= (distance p8 p6) 4)

        (location car0 p0)

        (= (elapsed_time) 0)
        (= (time_in_station car0 p0) 0)
        (= (time_in_station car0 p2) 0)
        (= (time_in_station car0 p3) 0)
        (= (time_in_station car0 p6) 0)

        (= (min_arrival_time p2) 5)
        (= (max_arrival_time p2) 15)

        (= (min_arrival_time p3) 5)
        (= (max_arrival_time p3) 15)

        (= (min_arrival_time p6) 40)
        (= (max_arrival_time p6) 50)

        (= (people_at_station p2) 12)
        (= (people_at_station p3) 13)
        (= (people_at_station p6) 0)

        (= (people_requested_itinerary p2 p6) 12)
        (= (people_requested_itinerary p3 p6) 13)

        (= (ave_speed) 0.5) ;km/min
        (= (car-distance car0 p0) 0)
        (= (speed car0) 0)
        (= (people_in_car car0) 0)
        (= (energy car0) 100)
    )

    (:goal
        (and
            (= (people_at_station p2) 0)
            (= (people_at_station p3) 0)

            (= (people_at_station p6) 25)
            (location car0 p0)

        )
    )
)