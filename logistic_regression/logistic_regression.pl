#!/usr/bin/perl
#use bignum;


# we can initiate w with a value between -1 and 1

# pas d'apprentissage
my $n; #0.1
# precision
my $precision = 0.0001;

my $risqueold = 1;
my $risquenew = 0;

my @w;

my ($FileName)=$ARGV[0]; # Tableau des paramètres
my ($n)=$ARGV[1]; # utilisé quand faire la cross validation
my $round = 0;
if(! defined $n){
  $n  = 10;
}

open(F,$FileName) || die "Erreur d'ouverture du fichier $FileName\n";
my $counter = 0;
my @record;
my $longer = 0;
while (my $ligne = <F>){
  my @mail = split(' ',$ligne);
  $longer = scalar @mail;
  for(my $i = 0; $i < $longer; $i++){
    $record[$counter][$i] = @mail[$i];
  }
  $counter++;
}
#$dimension = $longer - 1;
for(my $i = 0; $i < $longer; $i++){

  my $random = rand(2);
#  print "$random\n";
  @w[$i] = $random - 1;
# print "@w[$i]\n";
#    @w[$i] = 0;
}

my $absrisque = 0;
while(abs($risquenew - $risqueold) > $precision){
#while($cmpt < $round){
        # calculate risque old
        my $produit_final_old = 0;
        for(my $i = 0; $i < $counter; $i ++){
            my $produit = 0;
            for(my $k = 1; $k < $longer; $k++){
              $produit = $produit + $w[$k]*$record[$i][$k];
            }
            #print "produit $produit\n";
            my $yh = -$record[$i][0]*($produit + $w[0]);
            #print "yh $yh\n";
            #my $eyh = $e**$yh;
            my $eyh = exp($yh);
            #my $eyh = bignum::bexp($yh,10);
#            print "$eyh\n";
            $produit_final_old = $produit_final_old + log(1+$eyh);
        }
        $risqueold = $produit_final_old/$counter;
        #print "risqueold $risqueold\n";

        # update w
        #
        our @vector_risque;
        for(my $i = 0 ; $i < $longer; $i++){
           @vector_risque[$i] = 0;
        }
        for(my $i = 0; $i < $counter; $i++){
            my $produit = 0;
            for(my $k = 1; $k < $longer; $k++){
               $produit = $produit + $w[$k]*$record[$i][$k];
            }
            my $yh = $record[$i][0]*($produit + $w[0]);
            my $eyh = exp($yh);
            my $coef = $record[$i][0]/(1+$eyh);
#            print "produit $produit yh $yh eyh $eyh coef $coef\n";
            for(my $j = 0; $j < $longer; $j++){
                if($j == 0){
                  @vector_risque[$j] = @vector_risque[$j] + $coef*1;
                }
                else{
                  @vector_risque[$j] = @vector_risque[$j] + $coef*$record[$i][$j];
                }
            }
      #     print "vecris @vector_risque[57]\n";
        }

        for(my $i = 0 ; $i < $longer; $i++){
#          print "vecris @vector_risque[$i]\n";
           @vector_risque[$i] = -(@vector_risque[$i]/$counter);
        }



        for(my $j = 0; $j < $longer; $j++){
           $w[$j] = $w[$j] - $n*@vector_risque[$j];
        }


        # calculate risquenew
        my $produit_final_new = 0;
        for(my $i = 0; $i < $counter; $i ++){
            my $produit = 0;
            for(my $k = 1; $k < $longer; $k++){
              $produit = $produit + $w[$k]*$record[$i][$k];
            }
            my $yh = -$record[$i][0]*($produit + $w[0]);
            my $eyh = exp($yh);
#            my $eyh = $e**$yh;
            $produit_final_new = $produit_final_new + log(1+$eyh);
        }
        $risquenew = $produit_final_new/$counter;
        #print "risquenew $risquenew\n";
        $absrisque = abs($risquenew - $risqueold);
#        print "abs  $absrisque\n";
#        print "abs $risquenew $risqueold\n";
#        $cmpt ++;
}
open(HP,">./hyperplan") || die "Erreur de creation de hyperplan\n";
print "absrisque $absrisque\n";
# print HP "$b "; #w0
for(my $i = 0; $i < $longer; $i++){
  if($i != ($longer - 1)){
      print HP "@w[$i] ";
    }
  else{
      print HP "@w[$i]\n";
    }
}
#  print "count: $cmpt\n";

close(F);
close(HP);
