#!/bin/bash

    # ./pre-traiter.pl spambase/spambase.data
    # ./normalize.pl format > max_line.txt
    # rm format result.txt
    # ./preparer.pl spambase/spambase.data
    rm result.txt
    ./repartir_aleatoire.pl format
for i in {0.00001,0.0001,0.001,0.01,0.1}
  do

    for j in {1..5}
      do
        ./repartir_validation.pl apprentissage
        ./adaline.pl apprentissage_validation $i
        ./verifier.pl test_validation hyperplan
      done
      echo $i
      ./calculate_average.pl result.txt
      rm result.txt
  done
