seqfile = .//AKAP10.phy   * input sequence file
treefile = .//AKAP10.tree   * input tree structure file
outfile = AKAP10_mlc   * output file

noisy = 4   * 0,1,2,3,9: how much rubbish on the screen
verbose = 1 * 1: detailed output, 0: concise output
runmode = 0 * 0: user tree, 1: seq pair, 2: NSsites, 3: branch sites

seqtype = 1 * 1: codons
CodonFreq = 1 * 0: equal, 1: F1X4, 2: F3X4

aaDist = 0 * 0: equal, +: equal + kappa

model = 0 * 0: one ratio, 1: nearly neutral, 2: positive selection, 3: branch, 4: 2 or more dN/dS ratios

NSsites = 0 1 2 7 8 * 0: one ratio
icode = 0   * 0: universal code, 1: mitochondrial code
fix_kappa = 0 * 1: kappa fixed, 0: kappa estimated
kappa = 2 * initial or fixed kappa
fix_omega = 0 * 1: omega fixed, 0: omega estimated
omega = 0.4   * initial or fixed omega ratio

fix_alpha = 1 * 1: alpha fixed, 0: alpha estimated
alpha = 0   * initial or fixed alpha, 0: constant omega
Malpha = 0 * 0: different, 1: same alpha for all branches
ncatG = 5 * # of categories in the discrete gamma model
getSE = 1 * 0: no, 1: estimate SE for parameters
RateAncestor = 0 * 0: rates (dN/dS) not at ancestral nodes, 1: rates at ancestral nodes
Small_Diff = .5e-6
cleandata = 0 * remove sites with ambiguity data (1:yes, 0:no)?
fix_blength = 0 * 0: ignore, -1: random, 1: fixed
