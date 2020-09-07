#!/usr/bin/perl
use strict;
use warnings;

my $In = $ARGV[0]; # a test file listed all bam files in it
my $ref = $ARGV[1]; # N. gonorrhoeae NFA1090.fasta

open (INPUT, $In);
while( my $bam =<INPUT>){
chomp($bam);
my $outB = $bam;
$outB = ~ s/.bam/.bam_sorted/g;
my $outV = $bam;
$outV = ~ s/.bam/.bam.vcf/g;

##### First sort and index the bam file

system "samtools sort $bam $outB\n";
system "samtools index $outB\n";

##### Variant calling and write the output in VCF file

system "samtools mpileup -uf $ref $outB | bcftools view -vcg - >$outV\n";
} 


