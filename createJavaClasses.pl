#!/usr/bin/perl -w

print "Klassenname eingeben: ";
chomp ($className = <>);

#Schauen ob Abstract falls ja kann es einfach eingefuegt werden nach if Anweisung
print "Abstract?(y/n): ";
chomp ($boolAbstr = <>);
$boolAbstr = $boolAbstr eq "y"? " abstract class" : "";

$boolInter = " class";
$extends = "";
$implements = "";
$extends = "";
$main = "";
$boolMethoden = "";

if($boolAbstr eq ""){
    print "Interface?(y/n): ";
    chomp ($boolInter = <>);
    $boolInter = $boolInter eq "y"? " interface" : " class";
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
    chomp ($extends = "extends " . <>);
}

if($boolInter eq " class"){
    print "Implements?(y/n): ";
    chomp ($boolImplements = <>);
    if($boolImplements eq "y"){
        #moegliche Interfaces finden
        while($programs =~ m/([A-Z](.*)\.java)/g){
            $tmp = `cat $1`;
            print "$1 " if($tmp =~ m/interface ([A-Z]([a-z]|[0-9])*)/g);
        }
        print "\nAuswahl?: ";
        chomp ($implements = "implements " . <>);
    }
}

if($boolInter eq " class"){
    print "Main?(y/n): ";
    chomp ($main = <>);
    $main = $main eq "y"? "public static void main(String[] args)\{\n\t\}" : "";
}

system ("touch $className\.java");

system ("echo 'public$abstrOrInter $className $extends $implements\{\n\t$main' >> $className\.java");

$on = 1;

if($boolInter eq " class"){
    print "Weitere Methoden?(y/n): ";
    chomp ($boolMethoden = <>);
    if($boolMethoden eq "y"){
        while($on){
            print "Public?(y/n): ";
            chomp ($public = <>);
            if($public eq "y"){
                system ("echo '\n\tpublic' >> $className\.java");
            }
        }
        system ("echo '\n\}' >> $className\.java");
    }
    else{
      system ("echo '\n\}' >> $className\.java");
      exit 1;
    }
}
