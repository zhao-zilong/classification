#!/bin/bash

    # ./pre-traiter.pl spambase/spambase.data
    # ./normalize.pl format > max_line.txt
    rm format result.txt
    ./preparer.pl ../spambase/spambase.data
for i in {1..20}
  do
     ./repartir_aleatoire.pl format
     ./logistic_regression.pl apprentissage
     ./verifier.pl test hyperplan
  done

     ./calculate_average.pl result.txt
