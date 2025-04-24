      seqfile = ccnb1.fasta            * Path to the alignment file
     treefile = ccnb1.tree           * Path to the tree file
      outfile = ccnb1_mlc      * Path to the output file
   
        noisy = 4                     * How much rubbish on the screen
      verbose = 1                     * More or less detailed report

      seqtype = 1                     * Data type
        ndata = 1           * Number of data sets or loci
        icode = 0                     * Genetic code 
    cleandata = 0                     * Remove sites with ambiguity data?
		
        model = 0                     * Models for ω varying across lineages
      NSsites = 0 1 2 7 8                       * Models for ω varying across sites
    CodonFreq = 1                     * Codon frequencies
      estFreq = 0                       * Use observed freqs or estimate freqs by ML
        clock = 0                     * Clock model
        icode = 0
        Mgene = 0

    fix_kappa = 0
        kappa = 2
    fix_omega = 0
        omega = 0.4

    fix_alpha = 1
        alpha = 0
       Malpha = 0
        ncatG = 5

        getSE = 0
 RateAncestor = 0

   Small_Diff = 5e-7
  fix_blength = 0
       method = 0
