Per provare il progetto andare alla pagina: http://editor.planning.domains
e caricare i file: "DomainRobotCafe.pddl" e uno fra "ProblemRobotCafe1.pddl", "ProblemRobotCafe2.pddl" o "ProblemRobotCafe3.pddl"


La descrizione del problema da risolvere è presente nel file "PDDLDomainCompetition.pdf".


Nel primo problema (file: ProblemRobotCafe1.pddl):
- La person-1 come primo goal vuole il cioccolato-1 ed incarica il robot ti portarglielo (call person-1 agent_robot).
  La person-1 e' anche in possesso di una moneta (money person-1 coin-5).
  Il robot non possiede monete per questo, prima si reca dalla person-1 facendosi pagare in anticipo 
  attraverso la funzione (pay_pre), successivamente si reca davanti alla macchina del caffe', inserisce la moneta 
  (insert_money_robot) e seleziona la bevanda (push_drink_robot).
  Successivamente la bevanda viene portata alla person-1 e consegnata (deliver)

- La person-1 come secondo goal vuole il caffe-1 ed incarica il robot ti portarglielo (call person-1 agent_robot).
  La person-1 avendo speso l'unica moneta che possedeva per prendere la prima bevanda, per prenderne una seconda si
  deve recare al bancomat e attraverso la carta e il relativo pin puo' ritirare una moneta (withdraw).
  Successivamente dato che il robot non possiede monete si reca di nuovo dalla person-1 e si fa pagare in anticipo
  (pay_pre).
  Tramite la moneta puo' andare a prendere il caffe-1, inserendola(insert_money_robot) e successivamente 
  selezionando la bevanda (push_drink_robot).
  Una volta che questa è stata erogata, il robot la porta alla person-1 (deliver)

- La person-2 vuole un te' senza farselo portare dal robot.
  Essendo sprovvisto di monete si reca al bancomat per prelevare (withdraw) attraverso la carta e il pin.
  Una volta prelevato si reca alla macchina del caffe', inserisce la moneta (insert_money_person) e seleziona
  la bevanda (push_drink_person).
 

/* ---------------------------------------------------------------------------------------------------------------------------*/


Nel secondo problema (file: ProblemRobotCafe2.pddl):
- La person-1 vuole il cioccolato-1 ed incarica il robot ti portarglielo (call person-1 agent_robot).
  La person-1 e' anche in possesso di una moneta (money person-1 coin-5).
  Il robot possiede due monete (coin-14 e coin-15) ed essendo stato chiamato per consegnare una bevanda, si dirige verso
  la macchina-1 del caffe', inserisce la moneta (insert_money_robot) e seleziona il ciccolato (push_drink_robot).
  Successivamente il robot si reca dalla person-1, si fa pagare la bevanda (pay_post) e la consegna (deliver).

- La person-2 vuole il caffe-2 ed incarica il robot ti portarglielo (call person-2 agent_robot).
  La person-2 e' anche in possesso di una moneta (money person-2 coin-6).
  Il robot possiede due monete (coin-14 e coin-15) ed essendo stato chiamato per consegnare una bevanda, si dirige verso
  la macchina-2 del caffe' (perche' il caffe-2 si trova su questa), inserisce la moneta (insert_money_robot)
  e seleziona il caffe-2 (push_drink_robot).
  Successivamente il robot si reca dalla person-2, si fa pagare la bevanda (pay_post) e la consegna (deliver).

- La person-3 vuole il caffe-1 ma non incarica il robot ti portarglielo.
  La person-3 e' in possesso di una moneta (money person-3 coin-8).
  La person-3 si reca davanti alla macchina-1 del caffè (perche' il caffe-1 si trova su questa), inserisce 
  la moneta (insert_money_person) e seleziona la bevanda (push_drink_person).


/* ---------------------------------------------------------------------------------------------------------------------------*/


Nel terzo problema (file: ProblemRobotCafe3.pddl):
- La person-7 vuole il tea-1 ma non incarica il robot ti portarglielo.
  Essendo sprovvisto di monete si reca al bancomat e ritira una moneta (withdraw).
  Successivamente si reca alla macchina-2 del caffe, inserisce la monete (insert_money_person) e seleziona
  la bevanda tea-1 (push_drink_person).

- La person-9 vuole il tea-2 ma non incarica il robot ti portarglielo.
  Essendo sprovvisto di monete si reca al bancomat e ritira una moneta (withdraw).
  Successivamente si reca alla macchina-2 del caffe, inserisce la monete (insert_money_person) e seleziona
  la bevanda tea-2 (push_drink_person).

- Il robot si deve recare davanti alla macchina-2 del caffe passando per le scale (sqstair-2-3) attraverso
  la funzione (move).






  