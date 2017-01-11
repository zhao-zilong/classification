#!/bin/bash

    ./pre-traiter.pl ../spambase/spambase.data
for i in {1..20}
  do
     ./repartir_aleatoire.pl format
     ./perceptron.pl apprentissage
     ./verifier.pl test hyperplan
  done

     ./calculate_average.pl result.txt
