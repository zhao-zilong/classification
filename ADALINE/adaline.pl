#!/usr/bin/perl


my $n = 0.01; #0.1
my $b = 0;
#longeur 57
my $dimension = 0;
my @w;

#my @w = (0,0);
my ($FileName)=$ARGV[0]; # Tableau des paramètres
my ($n)=$ARGV[1];
my $round = 0;
if(! defined $n){
  $n  = 0.1;
  $round = 500000;
}
else{
  #print "n: $n\n";
  #for validation, we do not need very big round time
  $round = 50000;
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
$dimension = $longer - 1;
for(my $i = 0; $i < $dimension; $i++){
  @w[$i] = 0;
}
#print "dimension of w: $dimension\n";
#print "number of line: $counter\n";

my $cmpt = 0;
while($cmpt <= $round){
      my $ligne_chose = int(rand($counter));
      my $produit = 0;
      for(my $i = 0; $i < $dimension; $i++){
        $produit = $produit + $w[$i]*$record[$ligne_chose][$i+1];
        }
        my $h = $produit + $b;
        $b = $b + $n*($record[$ligne_chose][0] - $h);

        for($j = 0; $j < $dimension; $j++){
           $w[$j] = $w[$j] + $n*($record[$ligne_chose][0] - $h)*$record[$ligne_chose][$j+1];
        }
  $cmpt++;
}
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
#  print "count: $cmpt\n";

close(F);
close(HP);
