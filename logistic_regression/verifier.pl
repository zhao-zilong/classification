#!/usr/bin/perl

# take a parameter  of test set
my $Test=$ARGV[0]; # Tableau des paramètres
my $Hyperplan=$ARGV[1];
#dimension de hyperplan
my $dimension = 0;
open(T,$Test) || die "Erreur d'ouverture du fichier $Test\n";
open(H,$Hyperplan) || die "Erreur d'ouverture du fichier $Hyperplan\n";
my $ligne = <H>;
my @coeffcient = split(' ',$ligne);

my $counter = 0;
my @record;
while (my $ligne = <T>){
  my @mail = split(' ',$ligne);
  $dimension = (scalar @mail);
  for(my $i = 0; $i < $dimension; $i++){
    $record[$counter][$i] = @mail[$i];
  }
  $counter++;
}
my $t = 0;
my $right = 0;
my $wrong = 0;

while($t < $counter){
  my $result = 0;
  for(my $i = 0; $i < $dimension-1; $i++){
     $result = $result + $record[$t][$i+1]*$coeffcient[$i+1];
  }
  $result = $result + $coeffcient[0]; #w0
  if(($result >= 0 && $record[$t][0] == 1) || ($result <= 0 && $record[$t][0] == -1)){
      $right++;
  }
  else{
      $wrong++;
  }
  $t++;

}
print "right: $right; wrong: $wrong\n";
my $error_ratio = $wrong/($counter);

open(my $fh, '>>', "result.txt");
say $fh "$error_ratio";
close $fh;

close(T);
close(H);
