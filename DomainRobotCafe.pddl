
;; Realizzato da: EMANUELE PROCACCI, Department of Computer Science - University of Perugia

(define (domain robot-cafe)
  (:requirements :strips)
  (:predicates
    
    ;; predicati per gli spostamenti 
    (adj ?square-1 ?square-2)
    (lift ?square-lift)
    (at ?what ?square)
    (button-not-yet-pressed ?who)
    (lift_busy ?who)
    
    ;; predicati per prelievo bancomat 
    (bancomat ?to)
    (have_card ?who ?card ?pin)
    (available_coin ?to ?coin)
    
    ;; predicati per specificare robot o persona
    (robot ?who)
    (person ?who)
    
    ;; predicato che specifica la poszione delle macchine del caffe
    (machine ?to)
    
    ;; predicato per specificare a chi è assegnata una data moneta
    (money ?who ?coin)
  
    ;; predicato che specifica se una data bevanda è disponibile su una data macchina
    (available ?what ?machine)
    
    ;; predicato che conferma l'inserimento della moneta della macchina
    (pay ?who)
    
    ;; predicato con il quale la persona obbliga il robot a portare la bevanda
    (call ?person ?who)
    
    ;; predicato che conferma il prelievo della bevanda dalla macchina  
    (bring ?who)
    
    ;; predicato che conferma l'avvenuto pagamento al robot dalla persona mandante
    (has_paid ?who)
    
    ;; predicato necessario per collegare l'inserimento della moneta con la push_drink_robot
    (coin_inserted ?who)
    
    ;; predicato necessario per eseguire il collegamento fra bevanda e persona
    (drink_desired ?person ?what)
    
    ;; predicato che permette di raggiungere il goal
    (have_drink ?who ?what)
  )
  
  
  
;;----------------------------MOVE----------------------------------------------
   
   (:action move
     :parameters (?who ?from ?to)
     :precondition  (and 
                        (at ?who ?from)
                        (adj ?from ?to)
                        (not (lift ?from))
                        (not (lift ?to))
                        (not (coin_inserted ?who))
                    )
     :effect    (and 
                    (not (at ?who ?from))
                (at ?who ?to)
            )
    )
    
    
;;------------------------------ENTER-------------------------------------------
    
    (:action enter
     :parameters (?who ?from ?to)
     :precondition  (and 
                        (at ?who ?from)
                        (adj ?from ?to)
                        (lift ?to)
                        (not (lift_busy ?who))
                        (not (coin_inserted ?who))
                    )
     :effect    (and
                    (not (at ?who ?from))
                    (at ?who ?to)
                    (lift_busy ?who)
                )
    )


;;------------------------------EXIT--------------------------------------------
    
    (:action exit
     :parameters (?who ?from ?to)
     :precondition  (and
                        (at ?who ?from)
                        (adj ?from ?to)
                        (lift ?from)
                        (not (button-not-yet-pressed ?from))
                        (lift_busy ?who)
                        (not (coin_inserted ?who))
                    )
     :effect    (and 
                    (not (at ?who ?from))
                    (at ?who ?to)
                    (button-not-yet-pressed ?from)
                    (not (lift_busy ?who))
                )
    )
    
    
;;------------------------------PUSH LIFT---------------------------------------

    (:action push_lift
     :parameters (?who ?from)
     :precondition  (and 
                        (at ?who ?from)
                        (lift ?from)
                        (button-not-yet-pressed ?from)
                        (not (coin_inserted ?who))
                    )
     :effect   (not (button-not-yet-pressed ?from))
    )
      
  
;;------------------------------INSERT MONEY PERSON-----------------------------
    
    (:action insert_money_person
    :parameters (?who ?from ?to ?coin ?robot)
    :precondition   (and 
                        (at ?who ?from)
		                (adj ?from ?to)
		                (person ?who)
		                (robot ?robot)
		                (not (call ?who ?robot))
		                (machine ?to)
        		        (money ?who ?coin)
        		    )
    :effect (and
                (pay ?who)
		        (not(money ?who ?coin))
		    )
    )
    

;-----------------------------PUSH DRINK PERSON---------------------------------

    (:action push_drink_person
    :parameters (?who ?from ?to ?what ?robot)
    :precondition   (and
                        (at ?who ?from)
		                (adj ?from ?to)
		                (person ?who)
		                (robot ?robot)
		                (not (call ?who ?robot))
		                (machine ?to)
        		        (pay ?who)
        		        (available ?what ?to)
        		    )
    :effect (and 
                (not(pay ?who))
                (have_drink ?who ?what)
                (not (available ?what ?to))
            )
    )

 
;;------------------------------INSERT MONEY ROBOT------------------------------
    
    (:action insert_money_robot
    :parameters (?who ?from ?to ?coin ?person)
    :precondition   (and 
                        (at ?who ?from)
		                (adj ?from ?to)
		                (robot ?who)
		                (person ?person)
		                (call ?person ?who)
		                (machine ?to)
        		        (money ?who ?coin)
        		    )
    :effect (and
                (pay ?who)
		        (not(money ?who ?coin))
		        (coin_inserted ?who)
		    )
    )
    
    
;-----------------------------PUSH DRINK ROBOT----------------------------------
   
    (:action push_drink_robot
    :parameters (?who ?from ?to ?what ?person)
    :precondition   (and
                        (at ?who ?from)
		                (adj ?from ?to)
		                (robot ?who)
		                (person ?person)
		                (call ?person ?who)
		                (machine ?to)
        		        (pay ?who)
        		        (available ?what ?to)
        		        (coin_inserted ?who)
        		        (drink_desired ?person ?what)
        		    )
    :effect (and
                (not(pay ?who))
                (not(available ?what ?to))
                (bring ?who)
                (not (coin_inserted ?who))
            )
    )
 
 
;;----------------------------------DELIVER-------------------------------------

    (:action deliver
     :parameters (?who ?from ?to ?person ?what)
     :precondition  (and
                        (at ?who ?from)
                        (adj ?from ?to)
                        (at ?person ?to)
                        (robot ?who)
                        (not(lift ?to))
                        (not(lift ?from))
                        (bring ?who)
                        (call ?person ?who)
                        (has_paid ?person)
                        (drink_desired ?person ?what)
                    )
     :effect    (and
                    (not (bring ?who))
                    (have_drink ?person ?what)
                    (not (has_paid ?person))
                    (not (drink_desired ?person ?what))
                )
    )


;;--------------------------WITHDRAW--------------------------------------------
    
    (:action withdraw
    :parameters (?who ?from ?to ?coin ?card ?pin)
    :precondition   (and 
                        (at ?who ?from)
		                (adj ?from ?to)
        		        (bancomat ?to)
        		        (person ?who)
        		        (have_card ?who ?card ?pin)
        		        (not (money ?who ?coin))
        		        (available_coin ?to ?coin)
        		    )
    :effect (and 
                (money ?who ?coin)
		        (not(available_coin ?to ?coin))
            )
    )


    
;;----------------------------------PAY POST------------------------------------

    (:action pay_post
     :parameters (?who ?from ?to ?robot ?coin)
     :precondition  (and
                        (at ?who ?from)
                        (adj ?from ?to)
                        (at ?robot ?to)
                        (person ?who)
                        (robot ?robot)
                        (call ?who ?robot)
                        (not(lift ?to))
                        (not(lift ?from))
                        (money ?who ?coin)
                        (bring ?robot)
                        (not (has_paid ?who))
                    )
     :effect    (and 
                    (not (money ?who ?coin)) 
                    (money ?robot ?coin)
                    (has_paid ?who)
                )
    )


;;----------------------------------PAY PRE-------------------------------------

    (:action pay_pre
     :parameters (?who ?from ?to ?robot ?coin)
     :precondition  (and
                        (at ?who ?from)
                        (adj ?from ?to)
                        (at ?robot ?to)
                        (person ?who)
                        (robot ?robot)
                        (call ?who ?robot)
                        (not (lift ?to))
                        (not (lift ?from))
                        (money ?who ?coin)
                        (not (bring ?robot))
                    )
     :effect    (and 
                    (not (money ?who ?coin)) 
                    (money ?robot ?coin)
                    (has_paid ?who)
                )
    )
    
    

)








