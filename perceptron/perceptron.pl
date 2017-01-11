#!/usr/bin/perl





# T={(x1,y1),(x2,y2)...(xN,yN)}  xi∈X=Rn，yi∈Y={-1, +1}，i=1,2...N
# n: vitesse d'apprentissage
# yi(w*xi+b) <=0
#    w = w + n*yi*xi
#    b = b + n*yi
#




my $n = 0.1; #0.1
my $b = 0;
#longeur 57
my $dimension = 0;
my @w;

#my @w = (0,0);
my ($FileName)=$ARGV[0]; # Tableau des paramètres
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
$dimension = $longer - 1;
for(my $i = 0; $i < $dimension; $i++){
  @w[$i] = 0;
}
#print "dimension of w: $dimension\n";
#print "number of line: $counter\n";

print "count: $counter\n";
#my $cmpt = 0;
my $error = 0;
while($error < 500000){
    my $ligne_chose = int(rand($counter));
    my $produit = 0;
    for(my $i = 0; $i < $dimension; $i++){
      $produit = $produit + $w[$i]*$record[$ligne_chose][$i+1];

    }
    if(($record[$ligne_chose][0])*($produit+$b) <=0){
#     print "y: $record[$ligne_chose][0]\n";
        $b = $b + $n*$record[$ligne_chose][0];
#     print "b: $b\n";
        for($j = 0; $j < $dimension; $j++){
          $w[$j] = $w[$j] + $n*$record[$ligne_chose][0]*$record[$ligne_chose][$j+1];
        }
        $error++;
    }
#  print "$error\n";
}
print "error: $error\n";
open(HP,">./hyperplan") || die "Erreur de creation de hyperplan\n";

print HP "$b "; #w0
for(my $i = 0; $i < $dimension; $i++){
  if($i != ($dimension - 1)){
      print HP "@w[$i] ";
    }
  else{
      print HP "@w[$i]\n";
    }
}
  print "count: $cmpt\n";

close(F);
close(HP);
