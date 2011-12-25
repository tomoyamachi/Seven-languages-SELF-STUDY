;-- Define a flag that determines if the barber shop is open
;-- for business (ie. we are still testing the amount of hair
;-- that the barber can cut). This will be used to terminate our
;-- parallel processes (as they will all cease at the COB - close
;-- of business).
(def open-for-business? (atom true))

;-- Keep track of the number of haircuts that the barber has given
;-- during the day of business.
(def haircut-count (atom 0))

;-- Define a queue to keep track of the number of customers waiting
;-- to see the barber. This queue will start off empty. Since
;-- multiple threads will be updating this queue (the barber and the
;-- "waiting room," we'll be using a (ref) for better locking.
(def waiting-room (ref []))

;-- Define the number of chairs in the waiting room.
(def waiting-room-size 3)


;-- --------------------------------------------------------- --
;-- --------------------------------------------------------- --


;-- I open the barbershop for the day (ie. a given amount of time
;-- in milliseconds for which we want to run the test).
(defn
open-shop

;-- Define arguments.
[duration]

;-- Sleep the current thread to indicate that the business is
;-- running.
(Thread/sleep duration)

;-- Now that the business day has finished, toggle the flag
;-- that indicates that the business is no longer open.
(swap! open-for-business? not)
)


;-- --------------------------------------------------------- --
;-- --------------------------------------------------------- --


;-- I bring customers into the barber shop at random intervals.
;-- I launch a parallel thread (future) that occassionally checks to
;-- see if new customers can be added to the waiting room.
(defn
add-customers

;-- Define arguments.
[]

;-- We want this function to run asynchronously to the primary
;-- thread. As such, let it run in a future where we don't have
;-- to wait for a response.
(future

;-- While we are open for business, keep trying to add a
;-- new customer to the waiting room.
(while
@open-for-business?

;-- Ouptut the current state of the waiting room.
(println "Waiting Room:" @waiting-room)

;-- Lock access to the waiting room queue inside of a
;-- transaction to make sure we don't have race
;-- conditions with our other threads when mutating.
(dosync

;-- Check to see if the waiting room is not full.
;-- When doing this, we call (ensure) on the waiting-
;-- room queue in order to allow the value to be
;-- received without blocking????????
(if
(<
(count (ensure waiting-room))
waiting-room-size
)

;-- The waiting room is not full, so add a
;-- new customer to one of the empty chairs.
(alter waiting-room conj :customer)
)

)

;-- Wait for between 10 and 30 ms before trying to add
;-- another customer to the waiting room.
(Thread/sleep
(+ 10 (rand-int 21))
)

)

)

)


;-- --------------------------------------------------------- --
;-- --------------------------------------------------------- --


;-- I cut the hair of the next person available. I launch a parallel
;-- thread (future) that checks for available customers in the
;-- waiting room. When a customer becomes available, I take them out
;-- of the waiting room and given them a haircut.
(defn
cut-hair

;-- Define arguments.
[]

;-- We want this function to run asynchronously since the barber
;-- can cut hair independently of when people are coming into the
;-- the shop. As such, let it run in a future so we don't have to
;-- block the control flow.
(future

;-- While we are open for business, keep checking to see if
;-- there are any customers that can be serviced.... ha ha
;-- I just said "serviced".
(while
@open-for-business?

;-- Check to see if we can get a customer out of the
;-- waiting room. IF WE CAN, then we will cut their hair.
(when-let
[
next-customer

;-- Lock access to the waiting room queue since
;-- we are going to be popping a value off of it.
(dosync

;-- Try to capture the "next customer."
(let
[
next-customer
(first (ensure waiting-room))
]

;-- We found the next customer, so update
;-- the queue and return the customer to
;-- the barber.
(when
next-customer

;-- Pop the customer from the queue.
(alter waiting-room rest)

;-- Return the next customer to the
;-- when-let. If we return a non-nil
;-- value, then the following body
;-- (hair cutting) will execute.
next-customer
)
)

)

]

;-- If we made it this far (in our when-let
;-- statement), then we DO have a next next customer.

;-- (println "Cutting hair...")

;-- Sleep the thread for 20ms as that is how long
;-- a hair cut will take to finish.
(Thread/sleep 20)

;-- Increment the hair cut count.
(swap! haircut-count inc)

)

)

)

)


;-- --------------------------------------------------------- --
;-- --------------------------------------------------------- --


;-- Start cutting hair.
(cut-hair)

;-- Start adding customers to the waiting room.
(add-customers)

;-- Open the business for the day (ie. 10 seconds).
(open-shop (* 10 1000))

;-- Ouptut the number of given haircuts.
(println "Number of cuts:" @haircut-count)