(define (problem example6)

    ; EXAMPLE 6:  go from "2" to "6" , from "3" to "6" and from "1" to "5" when both cars are stationed at "0" with refill.
    ; Taking into consideration the refuel constrains graphs only 
    (:domain bus)

    (:objects
        car0 - car
        car1 - car

    )
    (:init

        (= (distance p0 p2) 4)
        (= (distance p2 p3) 2)
        (= (distance p3 p6) 13)
        (= (distance p6 p8) 4)
        (= (distance p8 p0) 5)
        (= (distance p0 p1) 5)
        (= (distance p0 p4) 2)
        (= (distance p5 p0) 6)
        (= (distance p1 p5) 11)
        (=(distance p6 p0) 8)
        (=(distance p5 p8) 7)
        (=(distance p7 p8) 4)
        (=(distance p7 p0) 9)

        (location car0 p0)

        (= (elapsed_time) 0)
        (= (time_in_station car0 p0) 0)
        (= (time_in_station car0 p1) 0)
        (= (time_in_station car0 p2) 0)
        (= (time_in_station car0 p3) 0)
        (= (time_in_station car0 p5) 0)
        (= (time_in_station car0 p6) 0)

        (location car1 p0)

        (= (time_in_station car1 p0) 0)
        (= (time_in_station car1 p1) 0)
        (= (time_in_station car1 p2) 0)
        (= (time_in_station car1 p3) 0)
        (= (time_in_station car1 p5) 0)
        (= (time_in_station car1 p6) 0)

        (= (min_arrival_time p1) 5)
        (= (max_arrival_time p1) 15)

        (= (min_arrival_time p5) 30)
        (= (max_arrival_time p5) 40)

        (= (min_arrival_time p2) 5)
        (= (max_arrival_time p2) 15)

        (= (min_arrival_time p3) 5)
        (= (max_arrival_time p3) 15)

        (= (min_arrival_time p6) 40)
        (= (max_arrival_time p6) 50)

        (= (people_at_station p1) 15)
        (= (people_at_station p5) 0)

        (= (people_at_station p2) 12)
        (= (people_at_station p3) 13)
        (= (people_at_station p6) 0)

        (= (people_requested_itinerary p1 p5) 15)
        (= (people_requested_itinerary p2 p6) 12)
        (= (people_requested_itinerary p3 p6) 13)

        (= (ave_speed) 0.5) ;km/min
        (= (car-distance car0 p0) 0)
        (= (speed car0) 0)
        (= (people_in_car car0) 0)
        (= (energy car0) 50)

        (= (car-distance car1 p0) 0)
        (= (speed car1) 0)
        (= (people_in_car car1) 0)
        (= (energy car1) 50)
    )

    (:goal
        (and
            (= (people_at_station p1) 0)
            (= (people_at_station p2) 0)
            (= (people_at_station p3) 0)

            (= (people_at_station p5) 15)
            (= (people_at_station p6) 25)
            (location car0 p0)
            (location car1 p0)

        )
    )
)