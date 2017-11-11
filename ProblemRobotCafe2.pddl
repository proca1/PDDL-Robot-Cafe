
;; Realizzato da: EMANUELE PROCACCI
;;                MATTEO PARROCCINI


(define (problem robot-cafe-prob)
    (:domain robot-cafe)
    (:objects     
    
        sq-1-1 sq-1-2 sq-1-3 sq-1-4             ;; celle corridoio primo piano
        sq-2-1 sq-2-2 sq-2-3 sq-2-4             ;; celle corridoio secondo piano
        sq-3-1 sq-3-2 sq-3-3 sq-3-4             ;; celle corridoio terzo piano
        
        sqlift-0-0                              ;; cella ascensore
        
        sqstair-1-2 sqstair-2-3                 ;; celle scale
        
        sqroom-1-1 sqroom-1-2 sqroom-1-3        ;; celle stanze primo piano
        sqroom-2-1 sqroom-2-2 sqroom-2-3        ;; celle stanze secondo piano
        sqroom-3-1 sqroom-3-2 sqroom-3-3        ;; celle stanze terzo piano
        
        sqbancomat-1                            ;; cella bancomat
        
        sqmachine-1 sqmachine-2                 ;; celle macchinette
                                  
        agent_robot                             ;; robot-cafe
        
        machine-1 machine-2                      ;; macchinette caffe
        
	    person-1 person-2 person-3 person-4     ;; persone
	    person-5 person-6 person-7 person-8
	    person-9
	    
	    card-1 card-2 card-3 card-4 card-5      ;; carte per prelevare
	    card-6 card-7 card-8 card-9
	    
	    pin-1 pin-2 pin-3 pin-4 pin-5           ;; pin associati alle carte
	    pin-6 pin-7 pin-8 pin-9 
	    
	    coin-1 coin-2 coin-3 coin-4             ;; monete
	    coin-5 coin-6 coin-7 coin-8
	    coin-9 coin-10 coin-11 coin-12
	    coin-13 coin-14 coin-15
	    
	    coffe-1 coffe-2                         ;; bevande
	    tea-1 tea-2
	    chocolate-1
	)
	   
    (:init 
    
        ;; adiacenze corridoio
        (adj sq-1-1 sq-1-2) (adj sq-1-2 sq-1-1)
        (adj sq-1-2 sq-1-3) (adj sq-1-3 sq-1-2)
        (adj sq-1-3 sq-1-4) (adj sq-1-4 sq-1-3)
        (adj sq-2-1 sq-2-2) (adj sq-2-2 sq-2-1)
        (adj sq-2-2 sq-2-3) (adj sq-2-3 sq-2-2)
        (adj sq-2-3 sq-2-4) (adj sq-2-4 sq-2-3)
        (adj sq-3-1 sq-3-2) (adj sq-3-2 sq-3-1)
        (adj sq-3-2 sq-3-3) (adj sq-3-3 sq-3-2)
        (adj sq-3-3 sq-3-4) (adj sq-3-4 sq-3-3)
       
        ;; adiacenze scale
        (adj sq-1-4 sqstair-1-2) (adj sqstair-1-2 sq-1-4)
        (adj sq-2-4 sqstair-1-2) (adj sqstair-1-2 sq-2-4)
        (adj sq-2-4 sqstair-2-3) (adj sqstair-2-3 sq-2-4)
        (adj sq-3-4 sqstair-2-3) (adj sqstair-2-3 sq-3-4)
        
        ;; adiacenze piani ascensore
        (adj sq-1-1 sqlift-0-0) (adj sqlift-0-0 sq-1-1)
        (adj sq-2-1 sqlift-0-0) (adj sqlift-0-0 sq-2-1)
        (adj sq-3-1 sqlift-0-0) (adj sqlift-0-0 sq-3-1)
        
        ;; adiacenze stanze
        (adj sq-1-1 sqroom-1-1) (adj sqroom-1-1 sq-1-1) 
        (adj sq-1-4 sqroom-1-2) (adj sqroom-1-2 sq-1-4)
        (adj sq-1-2 sqroom-1-3) (adj sqroom-1-3 sq-1-2)
        (adj sq-2-1 sqroom-2-1) (adj sqroom-2-1 sq-2-1)
        (adj sq-2-3 sqroom-2-2) (adj sqroom-2-2 sq-2-3)
        (adj sq-2-2 sqroom-2-3) (adj sqroom-2-3 sq-2-2)
        (adj sq-3-2 sqroom-3-1) (adj sqroom-3-1 sq-3-2)
        (adj sq-3-3 sqroom-3-2) (adj sqroom-3-2 sq-3-3)
        (adj sq-3-3 sqroom-3-3) (adj sqroom-3-3 sq-3-3)
        
        ;; adiacenza bancomat
        (adj sq-1-3 sqbancomat-1) (adj sqbancomat-1 sq-1-3)
        
        ;; adiacenze macchinette
        (adj sq-2-2 sqmachine-1) (adj sqmachine-1 sq-2-2)
        (adj sq-3-4 sqmachine-2) (adj sqmachine-2 sq-3-4)

        ;; posizione iniziale robot
        (at agent_robot sq-2-1)
        
        ;; posizione stanza con persona
        (at person-1 sqroom-1-1)
        (at person-2 sqroom-1-2)
        (at person-3 sqroom-1-3)
        (at person-4 sqroom-2-1)
        (at person-5 sqroom-2-2)
        (at person-6 sqroom-2-3)
        (at person-7 sqroom-3-1)
        (at person-8 sqroom-3-2)
        (at person-9 sqroom-3-3)
        
        ;; posizione ascensore
        (lift sqlift-0-0)
        
        ;; posizone macchinette 
        (machine sqmachine-1)
        (machine sqmachine-2)
        
        ;; posizione bancomat
        (bancomat sqbancomat-1)
        
        ;; definizione persone
        (person person-1)
        (person person-2)
        (person person-3)
        (person person-4)
        (person person-5)
        (person person-6)
        (person person-7)
        (person person-8)
        (person person-9)
        
        ;; definizione robot 
        (robot agent_robot)
        
        ;; bottone dell'ascensore non ancora premuto
        (button-not-yet-pressed sqlift-0-0)
        
        ;; bevande disponibili nelle macchinette
        (available coffe-1 sqmachine-1)
        (available chocolate-1 sqmachine-1)
        
        (available tea-1 sqmachine-2)
        (available tea-2 sqmachine-2)
        (available coffe-2 sqmachine-2)
        
        ;; carte delle persone
        (have_card person-1 card-1 pin-1)
        (have_card person-2 card-2 pin-2)
        (have_card person-3 card-3 pin-3)
        (have_card person-4 card-4 pin-4)
        (have_card person-5 card-5 pin-5)
        (have_card person-6 card-6 pin-6)
        (have_card person-7 card-7 pin-7)
        (have_card person-8 card-8 pin-8)
        (have_card person-9 card-9 pin-9)
        
        ;; monete possedute dalle persone
        (money person-1 coin-5)
        (money person-2 coin-6)
        (money person-3 coin-7)
        ;;(money person-4 coin-8)
        ;;(money person-5 coin-9)
        ;;(money person-6 coin-10)
        ;;(money person-7 coin-11)
        ;;(money person-8 coin-12)
        ;;(money person-9 coin-13)
        
        ;; monete possedute dal robot
        (money agent_robot coin-14)
        (money agent_robot coin-15)
        
        ;; monete disponibili 
        (available_coin sqbancomat-1 coin-1)
        (available_coin sqbancomat-1 coin-2)
        (available_coin sqbancomat-1 coin-3)
        (available_coin sqbancomat-1 coin-4)
        
        ;; persone che chiamano il robot per farsi portare il caffe
        (call person-1 agent_robot)
        (call person-2 agent_robot)
        
        (drink_desired person-1 chocolate-1)
        (drink_desired person-2 coffe-2)
    )
	 
    (:goal  (and
                (have_drink person-1 chocolate-1)
                (have_drink person-2 coffe-2)
                (have_drink person-3 coffe-1)
            )
    )
)
        
        
        
        
        
     