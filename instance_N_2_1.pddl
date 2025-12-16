(define (problem example9)

    ; EXAMPLE 8: go from "4" to "7" and from "2" to "3" and "6" when both cars are stationed at "0" with refill.
    ; Taking into consideration the refuel constrains graphs only 
    (:domain bus)

    (:objects
        car1 - car
        car2 - car

    )
    (:init
        (= (distance p1 p3) 3)
        (= (distance p1 p2) 3)
        (= (distance p2 p10) 20)
        (= (distance p10 p7) 20)
        (= (distance p2 p7) 2)
        (= (distance p7 p13) 9)
        (= (distance p13 p7) 9)
        (= (distance p3 p2) 1)
        (= (distance p3 p4) 1)
        (= (distance p4 p2) 1)
        (= (distance p7 p14) 8)
        (= (distance p14 p7) 8)
        (= (distance p13 p14) 3)

        (location car1 p1)
        (location car2 p1)

        (= (elapsed_time) 0)
        (= (time_in_station car1 p1) 0)
        (= (time_in_station car1 p2) 0)
        (= (time_in_station car1 p3) 0)
        (= (time_in_station car1 p4) 0)
        (= (time_in_station car1 p7) 0)
        (= (time_in_station car1 p10) 0)
        (= (time_in_station car1 p13) 0)
        (= (time_in_station car1 p14) 0)

        (= (time_in_station car2 p1) 0)
        (= (time_in_station car2 p2) 0)
        (= (time_in_station car2 p3) 0)
        (= (time_in_station car2 p4) 0)
        (= (time_in_station car2 p7) 0)
        (= (time_in_station car2 p10) 0)
        (= (time_in_station car2 p13) 0)
        (= (time_in_station car2 p14) 0)

        (= (min_arrival_time p1) 0)
        (= (max_arrival_time p1) 30)

        (= (min_arrival_time p2) 0)
        (= (max_arrival_time p2) 30)

        (= (min_arrival_time p3) 0)
        (= (max_arrival_time p3) 30)

        (= (min_arrival_time p4) 0)
        (= (max_arrival_time p4) 30)

        (= (min_arrival_time p10) 30)
        (= (max_arrival_time p10) 200)

        (= (min_arrival_time p13) 30)
        (= (max_arrival_time p13) 200)

        (= (min_arrival_time p14) 45)
        (= (max_arrival_time p14) 200)

        (= (people_at_station p1) 4)
        (= (people_at_station p2) 10)
        (= (people_at_station p3) 12)
        (= (people_at_station p4) 7)
        (= (people_at_station p10) 0)
        (= (people_at_station p13) 0)
        (= (people_at_station p14) 0)

        (= (people_requested_itinerary p1 p10) 4)
        (= (people_requested_itinerary p2 p13) 10)
        (= (people_requested_itinerary p3 p10) 12)
        (= (people_requested_itinerary p4 p14) 7)

        (= (ave_speed) 0.5) ;km/min
        (= (car-distance car1 p1) 0)
        (= (speed car1) 0)
        (= (people_in_car car1) 0)
        (= (energy car1) 150)

        (= (car-distance car2 p1) 0)
        (= (speed car2) 0)
        (= (people_in_car car2) 0)
        (= (energy car2) 150)

    )

    (:goal
        (and
            (= (people_at_station p1) 0)
            (= (people_at_station p2) 0)
            (= (people_at_station p3) 0)
            (= (people_at_station p4) 0)

            (= (people_at_station p10) 16)
            (= (people_at_station p13) 10)
            (= (people_at_station p14) 7)

            ;(location car1 p7)
            ;(location car2 p7)

        )
    )
)