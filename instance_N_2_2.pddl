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
        (= (distance p3 p2) 1)
        (= (distance p3 p4) 1)
        (= (distance p2 p5) 1)
        (= (distance p4 p2) 1)
        (= (distance p5 p6) 1)
        (= (distance p6 p7) 1)
        (= (distance p7 p6) 1)
        (= (distance p7 p8) 2)
        (= (distance p8 p14) 6)
        (= (distance p6 p12) 10)
        (= (distance p12 p9) 5)
        (= (distance p9 p10) 4)
        (= (distance p10 p11) 2)
        (= (distance p11 p9) 3)
        (= (distance p9 p12) 5)
        (= (distance p12 p13) 6)
        (= (distance p14 p13) 3)
        (= (distance p13 p7) 9)
        (= (distance p7 p13) 9)

        (location car1 p1)
        (location car2 p1)

        (= (elapsed_time) 0)

        (= (time_in_station car1 p1) 0)
        (= (time_in_station car1 p2) 0)
        (= (time_in_station car1 p3) 0)
        (= (time_in_station car1 p4) 0)
        (= (time_in_station car1 p5) 0)
        (= (time_in_station car1 p6) 0)
        (= (time_in_station car1 p7) 0)
        (= (time_in_station car1 p8) 0)
        (= (time_in_station car1 p9) 0)
        (= (time_in_station car1 p10) 0)
        (= (time_in_station car1 p11) 0)
        (= (time_in_station car1 p12) 0)
        (= (time_in_station car1 p13) 0)
        (= (time_in_station car1 p14) 0)

        (= (time_in_station car2 p1) 0)
        (= (time_in_station car2 p2) 0)
        (= (time_in_station car2 p3) 0)
        (= (time_in_station car2 p4) 0)
        (= (time_in_station car2 p5) 0)
        (= (time_in_station car2 p6) 0)
        (= (time_in_station car2 p7) 0)
        (= (time_in_station car2 p8) 0)
        (= (time_in_station car2 p9) 0)
        (= (time_in_station car2 p10) 0)
        (= (time_in_station car2 p11) 0)
        (= (time_in_station car2 p12) 0)
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

        (= (min_arrival_time p5) 0)
        (= (max_arrival_time p5) 30)

        (= (min_arrival_time p6) 0)
        (= (max_arrival_time p6) 30)

        (= (min_arrival_time p7) 15)
        (= (max_arrival_time p7) 45)

        (= (min_arrival_time p8) 15)
        (= (max_arrival_time p8) 45)

        (= (min_arrival_time p9) 15)
        (= (max_arrival_time p9) 45)

        (= (min_arrival_time p10) 30)
        (= (max_arrival_time p10) 200)

        (= (min_arrival_time p11) 30)
        (= (max_arrival_time p11) 200)

        (= (min_arrival_time p12) 45)
        (= (max_arrival_time p12) 200)

        (= (min_arrival_time p13) 45)
        (= (max_arrival_time p13) 200)

        (= (min_arrival_time p14) 45)
        (= (max_arrival_time p14) 200)

        (= (people_at_station p1) 4)
        (= (people_at_station p2) 10)
        (= (people_at_station p3) 12)
        (= (people_at_station p4) 7)
        (= (people_at_station p5) 5)
        (= (people_at_station p6) 11)
        (= (people_at_station p7) 21)
        (= (people_at_station p8) 13)
        (= (people_at_station p9) 5)
        (= (people_at_station p10) 0)
        (= (people_at_station p11) 0)
        (= (people_at_station p12) 0)
        (= (people_at_station p13) 0)
        (= (people_at_station p14) 0)

        (= (people_requested_itinerary p1 p10) 4)
        (= (people_requested_itinerary p2 p13) 10)
        (= (people_requested_itinerary p3 p10) 12)
        (= (people_requested_itinerary p4 p14) 7)
        (= (people_requested_itinerary p5 p11) 5)
        (= (people_requested_itinerary p6 p12) 11)
        (= (people_requested_itinerary p7 p12) 21)
        (= (people_requested_itinerary p8 p14) 13)
        (= (people_requested_itinerary p9 p13) 5)

        (= (ave_speed) 0.5) ;km/min

        (= (car-distance car2 p1) 0)
        (= (speed car2) 0)
        (= (people_in_car car2) 0)
        (= (energy car2) 200)

        (= (car-distance car1 p1) 0)
        (= (speed car1) 0)
        (= (people_in_car car1) 0)
        (= (energy car1) 200)

    )

    (:goal
        (and
            (= (people_at_station p1) 0)
            (= (people_at_station p2) 0)
            (= (people_at_station p3) 0)
            (= (people_at_station p4) 0)
            ;(= (people_at_station p5) 0)
            ;(= (people_at_station p6) 0)
            ;(= (people_at_station p7) 0)
            (= (people_at_station p8) 0)
            ;(= (people_at_station p9) 0)

            (= (people_at_station p10) 16)
            ;(= (people_at_station p11) 5)
            ;(= (people_at_station p12) 32)
            (= (people_at_station p13)10)
            (= (people_at_station p14) 20)

            ; (location car1 p7)
            ;(location car2 p7)
            ;(location car3 p7)
            ;(location car4 p7)
            ;(location car5 p7)

        )
    )
)