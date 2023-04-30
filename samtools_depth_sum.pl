#!/usr/bin/perl
# usage: perl samtools_depth_sum.pl [input] Illu_sorted_bam.depth [output] Illu_sum_cov.txt 

my $inp=shift@ARGV;
my $out=shift@ARGV;

open OUT,">$out" or die;
open IN,$inp or die;
my $line=<IN>;
chomp($line);
my @line=split /\t/,$line;
my $id=$line[0];
my $min=$line[1];
my $max=$line[1];
my $num=$line[2];
my $len;
my $cov;
while (<IN>){
	chomp;
	@line=split /\t/,$_;
	if ($line[0] eq $id){
		$max=$line[1];
		$num += $line[2];
	}else{
		$len=$max-$min+1;
#		$cov=$num/$len;
		$cov=$num;
		print OUT $id."\t".$len."\t".$cov."\n";
		$id=$line[0];
		$min=$line[1];
		$max=$line[1];
		$num=$line[2];
	}
}
$len=$max-$min+1;
#$cov=$num/$len;
 $cov=$num;
print OUT $id."\t".$len."\t".$cov."\n";
close IN;
close OUT;

