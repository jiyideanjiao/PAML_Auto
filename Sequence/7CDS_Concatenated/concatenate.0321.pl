#!usr/bin/perl
######################################################
# Note: I need to pay attention to close filehandle!!#
######################################################
if (@ARGV != 4){print "Usage: perl concatenated.pl seq_file oneline_file concatenated_file species_list\n"};

$path=$ARGV[0];
$outputdir1=$ARGV[1]; ##seq to oneline
$outputdir2=$ARGV[2]; ##all genes of one species are concatenated in one file
$list=$ARGV[3];  ##species list, eg. Ath
		##                   LOC
		##		     Mgu

open TEST, ">>concatenate.log";

opendir DIR, "$path" or die $!;
@wholefile=readdir (DIR);
closedir DIR;

foreach $file(@wholefile){
#if(index($file,"fa")!= -1){
	open FILE, "$path/$file";
#	if(index($file,"fa")!=-1){
	next if($file eq "." or $file eq "..");
	open RESULT,">>$outputdir1/$file.oneline";
		print TEST "processing =============> $file.oneline\n";
		while(<FILE>){	chomp;
			if($_=~/(>\w+)/){	print RESULT "\n$1|";
			}else{print RESULT "$_";}
		}close RESULT;
	}close FILE;
#}

opendir DIR2, "$outputdir1" or die $!;
@wholefile2=readdir (DIR2);
closedir DIR2;
print TEST "processing ===============> @wholefile2 in directory $outputdir1\n";

open LIST,"$list" or die $!;
while(<LIST>){         chomp;
         $spec=$_;
	open OUT,">>$outputdir2/$spec.seq" or die $!;
#	print OUT ">$spec\n";##for count missing data
	print OUT "\n>$spec\n"; ##for concatenate to reconstructing phylogeny tree
print TEST "processing ===============> species is $spec\n";
	$seq_name=">$spec";

foreach $file2(@wholefile2){
	open FILE2,"$outputdir1/$file2";
	if(index($file2,"oneline")!=-1){	
print TEST "processing ================> read file $file2\n";
		$mark = 0;
		while(<FILE2>){chomp;
		$_ =~ s/\s+//g;
		@arr=split /\|/,$_;
		$seq=$arr[1];
		$len_seq=length ($seq);
		print TEST "$_\n";
		print TEST "$len_seq\n";
		if($arr[0] =~ $seq_name ){$mark=1;
			print OUT "$arr[1]";	
			next;}
		}
		if($mark == 0){	print OUT "-" x $len_seq;}
	}close FILE2;	
}close OUT;
}
#close OUT;
#close FILE2;
close LIST;
