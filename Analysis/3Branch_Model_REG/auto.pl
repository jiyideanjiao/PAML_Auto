#!/usr/bin/perl

open fil, "$ARGV[0]";
@names=<fil>;
for $name (@names) {
        chomp $name;
        open H0, "$name/one.ratio.H0";
        while (<H0>) {
                chomp;
                if (/lnL\(ntime:.*np:(.*)\):/) {
                        $np0=$1; @a=split;
                        $p_H0{$name}=$np0; $lnL_H0{$name}=$a[-2];
                }
        }
        open H1, "$name/two.ratio.H1";
        while (<H1>) {
                chomp;
                if (/lnL\(ntime:.*np:(.*)\):/) {
                        $np1=$1; @b=split;
                        $p_H1{$name}=$np1; $lnL_H1{$name}=$b[-2];
                }
                if (/\(Agen.*#.*Ncla.*/) {
                        s/#/ /g;s/\,//g;s/\(//g;s/\)//g; @c=split;
                        $fore{$name}=$c[12]; $back{$name}=$c[1];
                }
        }
        if ($lnL_H1{$name} && $lnL_H0{$name}) {
                $twice = ($lnL_H1{$name} - $lnL_H0{$name})*2;
                $p=`chi2 1 $twice`; @infor=split /\s+/,$p;
                unless ($infor[-3]eq"=") {
                        print "$name\t$fore{$name}\t$back{$name}\t$lnL_H1{$name}\t$lnL_H0{$name}\t$infor[-3]\n";
                }
        }
}
