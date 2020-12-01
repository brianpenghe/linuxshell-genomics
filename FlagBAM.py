import pysam
import sys

#run with the sample name as the first positional argument
sample = sys.argv[1]

bamfile = pysam.AlignmentFile("starsolo/Aligned.sortedByCoord.out.bam", "rb")
tweaked = pysam.AlignmentFile(sample+".bam", "wb", template=bamfile)
for read in bamfile.fetch():
    if read.has_tag('CB'): 
        read.set_tag('CB',sample+'-'+read.get_tag('CB'))
    tweaked.write(read)

tweaked.close()
bamfile.close()
