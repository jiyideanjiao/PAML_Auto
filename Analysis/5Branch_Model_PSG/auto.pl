#!/usr/bin/perl

open fil,"$ARGV[0]";
while (<fil>) {
        chomp;
        $name=$_;
        open H0,"$name/branch_site_H0";
        while (<H0>) {
                chomp;
                if (/lnL\(ntime:.*np:(.*)\):/) {
                        $np0=$1; @a=split;
                        $lnL_H0{$name}=$a[-2];
                }
        }
        open H1,"$name/branch_site_H1";
        while (<H1>) {
                chomp;
                if (/lnL\(ntime:.*np:(.*)\):/) {
                        $np1=$1; @b=split;
                        $lnL_H1{$name}=$b[-2];
                }
        }
        if ($lnL_H1{$name} && $lnL_H0{$name}) {
                $twice = ($lnL_H1{$name} - $lnL_H0{$name})*2;
                $p=`chi2 1 $twice`; @infor=split /\s+/,$p;
                unless ($infor[-3]eq"=") {
                        $new_p=$infor[-3]/2;
                        print "$name\t$lnL_H1{$name}\t$lnL_H0{$name}\t$infor[-3]\t$new_p\n";
                }
        }
}
