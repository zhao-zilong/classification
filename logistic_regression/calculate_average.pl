#!/usr/bin/perl
my ($FileName)=$ARGV[0]; # Tableau des paramètres
open(F,$FileName) || die "Erreur d'ouverture du fichier $FileName\n";
my $counter = 0;
my @record;
while (my $ligne = <F>){
   @record[$counter] = $ligne;
   $counter++;
}
my $sum = 0;
for(my $i = 0; $i < $counter; $i++){
   $sum = $sum + @record[$i];
}
my $average = $sum/$counter;

print "error ratio: $average\n";
