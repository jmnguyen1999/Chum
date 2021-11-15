class ChoreCycle{
  //Possible interval periods: (1) once/week, (2) twice/week, (3) thrice/week, (4) once/month
    int intervalPeriod;

    ChoreCycle([this.intervalPeriod = -1]);

    bool isNull(){
      return intervalPeriod == -1;
    }
}