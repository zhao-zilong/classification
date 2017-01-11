#!/bin/bash

    # ./pre-traiter.pl spambase/spambase.data
    # ./normalize.pl format > max_line.txt
    # rm format result.txt
    # ./preparer.pl spambase/spambase.data
    rm result.txt
    ./repartir_aleatoire.pl format
for i in {100,10,1,0.1,0.01}
  do

    for j in {1..5}
      do
        ./repartir_validation.pl apprentissage
        ./logistic_regression.pl apprentissage_validation $i
        ./verifier.pl test_validation hyperplan
      done
      echo $i
      ./calculate_average.pl result.txt
      rm result.txt
  done
