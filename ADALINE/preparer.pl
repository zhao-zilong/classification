#!/usr/bin/perl
use List::Util qw( min max );
my ($FileName)=$ARGV[0]; # Tableau des paramètres
open(F,$FileName) || die "Erreur d'ouverture du fichier $FileName\n";
open(R,">./format") || die "Erreur de creation de format\n";


my @result;
my $counter = 0;
my $longer = 0;

while (my $ligne = <F>){
  my @tab=split(',',$ligne);
  $longer = scalar @tab;
  if(@tab[$longer-1] == 1){
     $result[$counter][0] = 1;
  }
  else{
     $result[$counter][0] = -1;
  }
  for(my $i = 1; $i < $longer; $i++){
     $result[$counter][$i] = @tab[$i - 1];
  }
  $counter++;
  # for(my $i = 0; $i < $longer-1; $i++){
  #   print R "@result[$i] ";
  # }
  #   print R "@result[$longer-1]\n";
}
my $dimension = $longer - 1;
my @colonne;
my @maxline;
for($j = 0; $j < $dimension; $j++){
    for($i = 0; $i < $counter; $i++){
        @colonne[$i] = $result[$i][$j+1];
    }
    my $maxcolonne = max @colonne;
#    print "$maxcolonne\n";
    @maxline[$j] = $maxcolonne;
}

for($j = 0; $j < $counter; $j++){
  for(my $i = 1; $i < $longer; $i++){
     $result[$j][$i] =  $result[$j][$i]/@maxline[$i-1];
  }
  for(my $i = 0; $i < $longer-1; $i++){
    print R "$result[$j][$i] ";
  }
    print R "$result[$j][$longer-1]\n";
}


close(F);
close(R);



#print "@tab[56], @tab[57]\n";
