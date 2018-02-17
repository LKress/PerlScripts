#!/usr/bin/perl -w

print "Klassenname eingeben: ";
chomp ($className = <>);

#Schauen ob Abstract falls ja kann es einfach eingefuegt werden nach if Anweisung
print "Abstract?(y/n): ";
chomp ($boolAbstr = <>);
$boolAbstr = $boolAbstr eq "y"? " abstract class" : "";

$boolInter = "";
if($boolAbstr eq ""){
    print "Interface?(y/n): ";
    chomp ($boolInter = <>);
    $boolInter = $boolInter eq "y"? " abstract class" : "";
}


$abstrOrInter = $boolAbstr . $boolInter;

#-------Extends/ Implements-------------#
#Java Programme suchen
$programs = `ls | grep .java`;

print "Extends?(y/n): ";
chomp ($boolExtends = <>);
if($boolExtends eq "y"){
    #moegliche Abstrakte Klassen finden
    $possibleAbstract = $programs;
    $possibleAbstract =~ tr/\n/\t/;
    $possibleAbstract =~ s/.java//g;
    print "$possibleAbstract\n";
    print "Auswahl?: ";
    chomp ($extends = <>);
    $extends = "extends " . $extends;
}
else{
  $extends = "";
}

if($boolInter eq ""){
    print "Implements?(y/n): ";
    chomp ($boolImplements = <>);
    if($boolImplements eq "y"){
        #moegliche Interfaces finden
        while($programs =~ m/([A-Z](.*)\.java)/g){
            $tmp = `cat $1`;
            if($tmp =~ m/interface ([A-Z]([a-z]|[0-9])*)/g){
                print "$1 ";
            }
        }
        print "\n";
        print "Auswahl?: ";
        chomp ($implements = <>);
        $implements = "implements " . $implements;
    }
    else{
        $implements = "";
    }
}
else{
    $implements = "";
}

if($boolInter eq ""){
    print "Main?(y/n): ";
    chomp ($main = <>);
    $main = $main eq "y"? "public static void main(String[] args)\{\n\t\}" : "";
}
else{
    $main = "";
}

system ("touch $className\.java");

system ("echo 'public$abstrOrInter $className $extends $implements\{\n\t$main\n\}' >> $className\.java");
