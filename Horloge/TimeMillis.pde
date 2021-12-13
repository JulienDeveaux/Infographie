class TimeMillis {
  int start;
  int hourMs;
  int minMs;
  int secMs;
  
  TimeMillis() {
    //println(hour());
    hourMs = (hour()*60*60 + minute()*60 + second()) * 1000;
    minMs  = (minute()*60 + second()) * 1000;
    secMs  = second() * 1000;
    start  = millis(); // temps écoulé depuis le début du programme.
  }
  
  /* Heure actuelle sous la forme d'un réel entre 0 et 1 sur la journée. */
  float h() {
    int dt = (millis() - start);
    return ((((((hourMs + dt) / 1000f) / 60f) / 60f ) % 12f) / 12f);
  }
  
  /* Minute actuelle sous la forme d'un réel entre 0 et 1 sur l'heure. */
  float m() {
    int dt = (millis() - start);
    return (((minMs + dt) / 1000f) / 60f) / 60f % 1;
  }
  
  /* Seconde actuelle sous la forme d'un réel entre 0 et 1 sur la minute. */
  float s() {
    int dt = (millis() - start);
    return ((secMs + dt) / 1000f) / 60f % 1;
  }
}
