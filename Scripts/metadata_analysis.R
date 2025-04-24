library(ggplot2)
library(tibble)
library(gridExtra)
library(dplyr)
library(ggpubr)
library(grid)
library(lemon)
library(ggsignif)
library(cowplot)
library(patchwork)
library(colorspace) 
library(svglite)


# Comparing recombination rate estimated as cM/Mb and as XO/HCN
#cM/Mb = Estimated from pg
#cM/MbAlt = Estimated from genome assembly size

cMMb.fish <- c(1.31239795363013, 1.27265217391304,	0.888571428571428,	5.31043998958605,	2.33411314334326,	1.46185349871285,	2.29099781687428,	2.12258546051649,	2.94251987187092,	1.50764285714286,	1.67857142857143,	2.11115350375175,	2.827660930529)
XOHCN.fish <- c(0.96456, 2.01868965517241,	1.71586206896552,	1.69978333333333,	1.0452380952381,	0.99944,	1.48666666666667,	1.23645217391304,	1.55015625,	1.68856,	1.88,	1.27692307692308,	1.5845)
CH1.length.fish <- c(59.4,96.8,132.45,64.8,76.5,109.7,77.92,66.4,110.5,69.332,60,46.8,171.4)
species.fish <- c("Esox_lucius", "Oncorhynchus_mykiss","Salmo_salar","Takifugu_rubripes","Cynoglossus_semilaevis","Haplochromis_burtoni",
                  "Oryzias_melastigma","Gadus_morhua","Ictalurus_punctatus","Astyanax_mexicanus","Danio_rerio","Clupea_harengus","Scleropages_formosus")
group.fish <- rep(c("Fish"), each=length(cMMb.fish)) 
 
cMMb.mammals.male <- c(0.6567,0.9430,0.9556,0.7101,0.8140,0.7274,0.5554,0.3571,0.5097,0.5130,0.5346)
cMMbAlt.mammals.male <- c(0.8577,1.1850,1.0361,0.8058,1.0194,0.8034,0.6563,0.4160,0.6395,0.5527,0.5974)
XOHCN.mammals.male <- c(1.584,2.330,2.019,1.053,1.597,2.165,1.857,1.135,1.684,1.799,1.296)
MLH1.total.mammals.male <- c(47.53,62.9,60.56,40,51.11,49.8,39,22.7,32,26.99,29.8)
MLH1.total.error.mammals.male <- c(4.26,6.04,5.21,1.4,2.35,4.8,3,2.3,4.5,2.89,2)
CH1.length.mammals.male <- c(158.53,278.62,157.40,123.56,188.26,248.96,223.62,195.15,274.33,210.92,276.03)
MLH1.CH1.mammals.male <- c(2.35,3.09,3.23,1.67,NA,NA,3,1.42,2.72,NA,2.64)
MLH1.CH1.error.mammals.male <- c(0.48,0.68,0.59,0.49,NA,NA,NA,0.54,0.66,NA,0.76)
SC.length.mammals.male <- c(13.5,14.5,17.7,13.96,3.2,3.55,NA,12,20.59,NA,38.4)
SC.length.error.mammals.male <- c(1.5,1.8,2.3,1.59,NA,0.65,NA,1.2,2.43,NA,7.3)
group.mammals.male <- rep(c("Mammals"),each=length(cMMb.mammals.male))
sex.mammals.male <- rep(c("Male"),each=length(cMMb.mammals.male))
species.mammals.male <- c("Bos taurus", "Ovis aries", "Capra hircus", "Canis lupus familiiarus", "Equus cabellus", "Homo sapiens", "Macaca mulatta", "Mus musculus domesticus", "Sus scrofa", "Giraffa reticulata", "Munticacus reevesi")


cMMb.birds.male <- c(2.0911,2.0414,1.8487,1.9123,1.7241,2.4963,NA,NA,2.0804)
cMMbAlt.birds.male <- c(NA,3.0346,2.1396,2.2153,2.2367,2.9668,2.3356,2.1419,2.9197)
XOHCN.birds.male <- c(1.473,1.444,1.130,1.256,1.254,1.603,1.318,2.044,1.618)
MLH1.total.birds.male <- c(58.9,56.3,45.2,49,48.9,62.5,51.4,51.1,64.7)
MLH1.total.error.birds.male <- c(7.6,1.8,0.2,4.5,2.4,6.1,4.3,6.6,4.8)
CH1.length.birds.male <- c(NA,175.66,114.02,156.04,NA,196.45,206.45,NA,NA)
MLH1.CH1.birds.male <- c(6.7,6.1,2.1,3.4,2.9,6.8,2.8,4.8,7.7)
MLH1.CH1.error.birds.male <- c(1.3,0.8,0.4,1,0.8,1.7,1.1,1.1,1.1)
SC.length.birds.male <- c(52.1,NA,NA,25.3,19.8,39.9,30.1,27.5,NA)
SC.length.error.birds.male <- c(8.8,NA,NA,4.6,5.1,7.3,7.6,6.8,NA)
group.birds.male <- rep(c("Birds"),each=length(cMMb.birds.male))
sex.birds.male <- rep(c("Male"),each=length(cMMb.birds.male))
species.birds.male <- c("Anser anser", "Coturnix japonica", "Taeniopygia guttata", "Hirundo rustica", "Riparia diluta", "Gallus gallus", "Apus apus", "Falco subbuteo", "Columba livia domestica")


cMMb.birds.female <- c(2.6130,2.0051,1.8691,2.1699,1.6430,2.4764,NA,1.9846,2.0161,NA,2.0684,NA,NA,2.2050)
cMMbAlt.birds.female <- c(NA,2.9807,2.1633,2.5137,2.1315,2.9431,2.6274,2.3517,2.8295,NA,NA,2.0510,NA,2.5326)
XOHCN.birds.female <- c(1.840,1.418,1.143,1.426,1.195,1.590,1.525,1.398,1.568,1.297,1.432,1.158,1.951,1.413)
MLH1.total.birds.female <- c(73.6,55.3,45.7,55.6,46.6,62,61,55.9,62.7,44.1,53,44,76.1,56.5)
MLH1.total.error.birds.female <- c(7.8,2.1,0.4,6.3,3.6,5.4,NA,3.8,4.9,5,4.2,1.6,8.6,NA)
CH1.length.birds.female <- c(NA,175.66,114.02,156.04,NA,196.45,NA,207.24,NA,220.15,NA,194,116,191)
MLH1.CH1.birds.female <- c(7.4,6.6,2.3,4.4,2.9,7.2,6.8,5.4,7,4.2,5.1,2.3,6.6,8)
MLH1.CH1.error.birds.female <- c(2,0.9,0.5,1.2,0.9,1.6,1.2,1.1,NA,1.2,1.3,0.6,1.5,0.32)
SC.length.birds.female <- c(44.2,NA,NA,18.6,15.1,28.5,34.3,NA,NA,NA,NA,24.6,20.7,NA)
SC.length.error.birds.female <- c(9.9,NA,NA,3.6,2.4,5.1,NA,NA,NA,NA,NA,2.2,2.8,NA)
group.birds.female <- rep(c("Birds"),each=length(cMMb.birds.female))
sex.birds.female <- rep(c("Female"),each=length(cMMb.birds.female))
species.birds.female <- c("Anser anser", "Coturnix japonica", "Taeniopygia guttata", "Hirundo rustica", "Riparia diluta", "Gallus gallus", "Rhea americana", "Anas platyrhynchos", "Columba livia domestica", "Sterna hirundo", "Chlidonias niger", "Numida meleagris", "Motacilla alba", "Meleagris gallopavo")

cMMb.data = c(cMMb.mammals.male,cMMb.birds.male,cMMb.birds.female)
cMMbAlt.data = c(cMMbAlt.mammals.male,cMMbAlt.birds.male,cMMbAlt.birds.female)
XOHCN.data = c(XOHCN.mammals.male,XOHCN.birds.male,XOHCN.birds.female)
CH1.length.data = c(CH1.length.mammals.male, CH1.length.birds.male, CH1.length.birds.female)
MLH1.total.data = c(MLH1.total.mammals.male, MLH1.total.birds.male,MLH1.total.birds.female)
MLH1.total.error = c(MLH1.total.error.mammals.male,MLH1.total.error.birds.male,MLH1.total.error.birds.female)
MLH1.CH1.data = c(MLH1.CH1.mammals.male,MLH1.CH1.birds.male,MLH1.CH1.birds.female)
MLH1.CH1.error = c(MLH1.CH1.error.mammals.male, MLH1.CH1.error.birds.male,MLH1.CH1.error.birds.female)
SC.length.data = c(SC.length.mammals.male, SC.length.birds.male, SC.length.birds.female)
SC.length.error = c(SC.length.error.mammals.male, SC.length.error.birds.male, SC.length.error.birds.female)

df.group = c(group.mammals.male,group.birds.male,group.birds.female)
df.sex = c(sex.mammals.male,sex.birds.male,sex.birds.female)
df.species = c(species.mammals.male,species.birds.male,species.birds.female)
df = tibble("Group" = df.group, "Sex" = df.sex, "cMMb" = cMMb.data, "cMMbAlt" = cMMbAlt.data, "XOHCN" = XOHCN.data, "MLH1_Total" = MLH1.total.data, "Species" = df.species, "CH1_Length" = CH1.length.data,"MLH1_Error" = MLH1.total.error, "MLH1_CH1" = MLH1.CH1.data, "MLH1_CH1_Error" = MLH1.CH1.error, "SC_Length" = SC.length.data, "SC_Error" = SC.length.error)

#-------------------------------------------------------------------------------
# Stats

# Does recombination rate measured as cM/Mb differ significantly between mammals and birds when comparing males?
cMMb.male <- df %>% filter(Sex == "Male" & cMMb != 'NA') # Pull out male data.

t.test(cMMb.male$cMMb~cMMb.male$Group) 

plot1 <- ggplot(cMMb.male, aes(x = Group, y = cMMb, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(tag = "A",x="", y = "Recombination Rate (cM/Mb)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
plot1

#Yes.

# Does recombination rate measured as cM/Mb differ significantly by sex in birds?
cMMb.birds <- df %>% filter(Group == "Birds" & cMMb != 'NA')

t.test(cMMb.birds$cMMb~cMMb.birds$Sex)

plot2 <- ggplot(cMMb.birds, aes(x = Sex, y = cMMb, fill = Sex)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + 
  theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (cM/Mb)") +
  geom_signif(comparisons = list(c("Male", "Female")), map_signif_level = TRUE)
plot2
ggsave(height = 5, width = 5, "heterochiasmy_cMMb.png", device='png', dpi=700)


#No.

# Does recombination rate measured as cM/Mb differ significantly between male mammals and female birds?
cMMb.cross <- df %>% filter(Sex == "Female" & Group == "Birds" & cMMb != 'NA'| Group == "Mammals" & cMMb != 'NA')

t.test(cMMb.cross$cMMb~cMMb.cross$Group)

plot3 <- ggplot(cMMb.cross, aes(x = Group, y = cMMb, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (cM/Mb)")
plot3

#Yes.

#----------------------------------------------------------------------------
# Do the results differ if we use reference genome size to estimate Mb instead of pg?
#No.

# Does recombination rate measured as cM/Mb differ significantly between mammals and birds when comparing males?
cMMbAlt.male <- df %>% filter(Sex == "Male" & cMMbAlt != 'NA') # Pull out male data.

t.test(cMMbAlt.male$cMMbAlt~cMMbAlt.male$Group) 

plot4 <- ggplot(cMMbAlt.male, aes(x = Group, y = cMMbAlt, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (cM/Mb)")
plot4

#Yes.

# Does recombination rate measured as cM/Mb differ significantly by sex in birds?
cMMbAlt.birds <- df %>% filter(Group == "Birds" & cMMbAlt != 'NA')

t.test(cMMbAlt.birds$cMMbAlt~cMMbAlt.birds$Sex)

plot5 <- ggplot(cMMbAlt.birds, aes(x = Sex, y = cMMbAlt, fill = Sex)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (cM/Mb)")
plot5

#No.

# Does recombination rate measured as cM/Mb differ significantly between male mammals and female birds?
cMMbAlt.cross <- df %>% filter(Sex == "Female" & Group == "Birds" & cMMbAlt != 'NA'| Group == "Mammals" & cMMbAlt != 'NA')

t.test(cMMbAlt.cross$cMMbAlt~cMMbAlt.cross$Group)

plot6 <- ggplot(cMMbAlt.cross, aes(x = Group, y = cMMbAlt, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (cM/Mb)")
plot6

#Yes.

#-------------------------------------------------------------------------------
#Do the results differ if we measure recombination rate as XO/HCN instead of cM/Mb?
#Yes.

# Does recombination rate measured as XO/HCN differ significantly between male mammals and male birds?
XOHCN.male <- df %>% filter(Sex == "Male" & XOHCN != 'NA')

t.test(XOHCN.male$XOHCN~XOHCN.male$Group)

plot7 <- ggplot(XOHCN.male, aes(x = Group, y = XOHCN, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(tag = "B",x="", y = "Recombination Rate (XO/HCN)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)

plot7

#No.

# Does recombination rate measured as XO/HCN differ significantly by sex in birds?
XOHCN.birds <- df %>% filter(Group== "Birds" & XOHCN != 'NA')

t.test(XOHCN.birds$XOHCN~XOHCN.birds$Sex)

plot8 <- ggplot(XOHCN.birds, aes(x = Sex, y = XOHCN, fill = Sex)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + 
  theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (XO/HCN)") +
  geom_signif(comparisons = list(c("Male", "Female")), map_signif_level = TRUE)

plot8
ggsave(height = 5, width = 5, "heterochiasmy_XOHCN.png", device='png', dpi=700)

#No.

# Does recombination rate measured as XO/HCN differ significantly between male mammals and female birds?
XOHCN.cross <- df %>% filter(Sex == "Female" & Group == "Birds" & XOHCN != 'NA'| Group == "Mammals" & XOHCN != 'NA')

t.test(XOHCN.cross$XOHCN~XOHCN.cross$Group)

plot9 <- ggplot(XOHCN.cross, aes(x = Group, y = XOHCN, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (XO/HCN)")
plot9

#No.

#-------------------------------------------------------------------------------
#Comparing number of MLH1 foci on the largest chromosome between birds and mammals. 

#Does the number of MLH1 foci on the largest chromosome differ significantly between male mammals and male birds?
MLH1.male <- df %>% filter(Sex == "Male" & MLH1_CH1 != 'NA')

t.test(MLH1.male$MLH1_CH1~MLH1.male$Group)

plot10 <- ggplot(MLH1.male, aes(x = Group, y = MLH1_CH1, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(tag = "C", x="", y = "MLH1 foci on largest chromosome") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)

plot10

#Yes.

#Does the number of MLH1 foci on the largest chromosome differ significantly by sex in birds?
MLH1.birds <- df %>% filter(Group== "Birds" & MLH1_CH1 != 'NA')

t.test(MLH1.birds$MLH1_CH1~MLH1.birds$Sex)

plot11 <- ggplot(MLH1.birds, aes(x = Sex, y = MLH1_CH1, fill = Sex)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + 
  theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "MLH1 foci on largest chromosome") +
  geom_signif(comparisons = list(c("Male", "Female")), map_signif_level = TRUE)

plot11
ggsave(height = 5, width = 5, "heterochiasmy_MLH1.png", device='png', dpi=700)


#No.

#Does the number of MLH1 foci on the largest chromosome differ significantly between male mammals and female birds?
MLH1.cross <- df %>% filter(Sex == "Female" & Group == "Birds" & MLH1_CH1 != 'NA'| Group == "Mammals" & MLH1_CH1 != 'NA')

t.test(MLH1.cross$MLH1_CH1~MLH1.cross$Group)

plot12 <- ggplot(MLH1.cross, aes(x = Group, y = MLH1_CH1, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(legend.position="none", text = element_text(size=12)) +labs(x="", y = "MLH1 foci on largest chromosome")
plot12

#Yes.

#Combined plots showing trend in males
grid.arrange(plot1,plot7,plot10, nrow = 1)


#-------------------------------------------------------------------------------
#Comparison plots
#Using all data unless noted by data used

#Including Fish
cMMb.all = c(cMMb.mammals.male,cMMb.birds.male,cMMb.birds.female, cMMb.fish)
XOHCN.all = c(XOHCN.mammals.male,XOHCN.birds.male,XOHCN.birds.female, XOHCN.fish)
CH1.length.all = c(CH1.length.mammals.male, CH1.length.birds.male, CH1.length.birds.female, CH1.length.fish)

df.group.all = c(group.mammals.male,group.birds.male,group.birds.female, group.fish)
df.species.all = c(species.mammals.male,species.birds.male,species.birds.female, species.fish)
df.all = tibble("Group" = df.group.all, "cMMb" = cMMb.all, "XOHCN" = XOHCN.all, "Species" = df.species.all, "CH1_Length" = CH1.length.all)

df.all$Group <- factor(df.all$Group, levels=c("Birds", "Mammals", "Fish"))
bfA.revised <- ggplot(df.all, aes(x = Group, y = cMMb, fill = Group)) + geom_boxplot() + scale_fill_manual(values = hcl.colors(3,"Grays")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (cM/Mb)") + 
  geom_signif(comparisons = list(c("Mammals", "Birds")), tip_length = 0.01,y_position = 5, map_signif_level = TRUE)+
  geom_signif(comparisons = list(c("Fish", "Birds")), tip_length = 0.01, y_position = 4.5, map_signif_level = TRUE)+
  geom_signif(comparisons = list(c("Mammals", "Fish")), tip_length = 0.01,map_signif_level = TRUE)
bfA.revised
ggsave(height = 5, width = 5, "bigfigA_revised.png", device='png', dpi=700)

bfB.revised <- ggplot(df.all, aes(x = Group, y = XOHCN, fill = Group)) + geom_boxplot() + scale_fill_manual(values = hcl.colors(3,"Grays")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(x="", y = "Recombination Rate (XO/HCN)") + 
  geom_signif(comparisons = list(c("Mammals", "Birds")), tip_length = 0.01,y_position = 3.75, map_signif_level = TRUE)+
  geom_signif(comparisons = list(c("Fish", "Birds")), tip_length = 0.01, y_position = 3.5, map_signif_level = TRUE)+
  geom_signif(comparisons = list(c("Mammals", "Fish")), tip_length = 0.01,y_position = 3.25,map_signif_level = TRUE)
bfB.revised
ggsave(height = 5, width = 5, "bigfigB_revised.png", device='png', dpi=700)

bfC <- ggplot(df, aes(x = Group, y = MLH1_CH1, fill = Group)) + geom_boxplot() + scale_fill_manual(values = hcl.colors(3, "Grays")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(x="", y = "MLH1 foci on Chromosome 1") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
bfC
ggsave(height = 5, width = 5, "bigfigC_revised.png", device='png', dpi=700)


#Avg #MLH1 Foci on Chr1 by Species
plotdata <- df %>% filter(MLH1_CH1 != 'NA')

p <- ggplot(data = plotdata, mapping = aes(x = reorder(Species,MLH1_CH1), y = MLH1_CH1, color = Group, shape = Sex)) + geom_point(size = 3, position = position_dodge(width = 0.5), show.legend = TRUE, aes(color=Group, shape = Sex)) + scale_shape_manual(values = c(16,15)) + coord_flip() + geom_linerange(mapping = aes(ymin = MLH1_CH1 - MLH1_CH1_Error,ymax = MLH1_CH1 + MLH1_CH1_Error), position = position_dodge2(width = 0.5)) +
  theme_classic() + scale_colour_manual(name = "Group", values = hcl.colors(3, "Grays")) + theme(plot.tag = element_text(), axis.text.y = element_text(face = "italic", size = 10), axis.text.x = element_text(size = 12), legend.position = "none", axis.title = element_text(size = 16) ) + labs(x= "Species", y= "Avg. # MLH1 Foci on Chromosome 1", color = "")

p
ggsave(height = 5, width = 6, "bigfigD_revised.png", device='png', dpi=700)


#Correlation between length of Chr1 and number of XOs
XOlen = lm(MLH1_CH1 ~ CH1_Length, data = df)
summary(XOlen)

#Correlation between SC length and number of XOs
XOSClen = lm(MLH1_CH1 ~ SC_Length, data = df)
summary(XOSClen)

#Clade-specific correlations
MLH1.birds.male.data <- df %>% filter(Sex == "Male" & Group == "Birds" & MLH1_CH1 != 'NA')
XO_birds = lm(MLH1_CH1 ~ CH1_Length, data = MLH1.birds.male.data)
summary(XO_birds)

MLH1.mammals.male.data <- df %>% filter(Sex == "Male" & Group == "Mammals" & MLH1_CH1 != 'NA')
XO_mammals = lm(MLH1_CH1 ~ CH1_Length, data = MLH1.mammals.male.data)
summary(XO_mammals)

#Avg # MLH1 loci VS length of Chr 1 -> male mammals and male birds
# GET EQUATION AND R-SQUARED AS STRING
# SOURCE: https://groups.google.com/forum/#!topic/ggplot2/1TgH-kG5XMA
lm_eqn <- function(df){
  m <- lm(MLH1_CH1 ~ SC_Length, df);
  eq <- substitute(italic(y) == a - b %.% italic(x)*","~~italic(r)^2~"="~r2, 
                   list(a = format(unname(coef(m)[1]), digits = 2),
                        b = format(abs(unname(coef(m)[2])), digits = 2),
                        r2 = format(summary(m)$r.squared, digits = 3)))
  as.character(as.expression(eq));
}

# Add to print eqn. and R2 value

p3 <- ggplot(data = df, mapping = aes(x = CH1_Length, y = MLH1_CH1, color = Group)) + geom_point(size = 3, aes(color=Group, shape = Sex))+ scale_colour_manual(values = hcl.colors(3, "Grays")) + stat_smooth(method = "lm", col = "black", se = FALSE) + labs( x= "Chromosome Length (Mb)", y= "Average # of MLH1 Foci", color = "") + theme_classic() + theme(plot.tag = element_text(), legend.position = "none") + scale_shape_manual(values = c(16,15))+ theme(axis.text = element_text(size = 12), axis.title = element_text(size = 16))
p3
ggsave(height = 5, width = 5, "bigfigE_revised.png", device='png', dpi=700)

#Avg # MLH1 loci VC length of SC complex -> male mammals and male birds
lm_eqn <- function(df){
  m <- lm(MLH1_CH1 ~ SC_Length, df);
  eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
                   list(a = format(unname(coef(m)[1]), digits = 2),
                        b = format(abs(unname(coef(m)[2])), digits = 2),
                        r2 = format(summary(m)$r.squared, digits = 3)))
  as.character(as.expression(eq));
}

# Add to print eqn and R2 value
# geom_text(x = 18, y = 7, label = lm_eqn(lenXOcorr), parse = TRUE, col = "black")

p4 <- ggplot(data = df, mapping = aes(x = SC_Length, y = MLH1_CH1, color = Group)) + geom_point(size = 3, aes(color=Group, shape = Sex)) + scale_shape_manual(values = c(16,15)) + scale_colour_manual(values = hcl.colors(3,"Grays")) + stat_smooth(method = "lm", col = "black", se = FALSE) + labs(x= expression("Average SC Length"~(mu*m)), y= "Average # of MLH1 Foci", color = "") + theme_classic() + theme(plot.tag = element_text(),legend.position = "none", axis.text = element_text(size = 12), axis.title = element_text(size = 16))
p4 
ggsave(height = 5, width = 5, "bigfigF_revised.png", device='png', dpi=700)

grid_arrange_shared_legend(p, arrangeGrob(p3, p4), ncol = 2, nrow=1, position = "right")
grid.arrange(p3,p4, nrow = 1)

#Big Fig

lm_eqn1 <- function(CL_MLH1_corr){
  m <- lm(MLH1_CH1 ~ CH1_Length, df);
  eq <- substitute(~~italic(r)^2~"="~r2, 
                   list(r2 = format(summary(m)$r.squared, digits = 1)))
  as.character(as.expression(eq));
}

lm_eqn1()

lm_eqn2 <- function(SCL_MLH1_corr){
  m <- lm(MLH1_CH1 ~ SC_Length, df);
  eq <- substitute(~~italic(r)^2~"="~r2, 
                   list(r2 = format(summary(m)$r.squared, digits = 2)))
  as.character(as.expression(eq));
}

bfA <- ggplot(cMMb.male, aes(x = Group, y = cMMb, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(tag = "A",x="", y = "Recombination Rate (cM/Mb)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
bfA
ggsave(height = 5, width = 5, "bigfigA.png", device='png', dpi=700)

bfB <- ggplot(XOHCN.male, aes(x = Group, y = XOHCN, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(tag = "B",x="", y = "Recombination Rate (XO/HCN)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
bfB
ggsave(height = 5, width = 5, "bigfigB.png", device='png', dpi=700)

bfC <- ggplot(MLH1.male, aes(x = Group, y = MLH1_CH1, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(tag = "C", x="", y = "MLH1 foci on Chromosome 1") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
bfC
ggsave(height = 5, width = 5, "bigfigC.png", device='png', dpi=700)

ABC <- grid.arrange(bfA, bfB, bfC, nrow = 1, ncol = 3)
ggsave(height = 5, width = 5, "recomb_MLH1foci.png", device='png', dpi=700)

bfD <- ggplot(data = plotdata, mapping = aes(x = reorder(Species,MLH1_CH1), y = MLH1_CH1, color = Group, shape = Sex)) + geom_point(size = 3, position = position_dodge(width = 0.5), show.legend = TRUE, aes(color=Group, shape = Sex)) + scale_shape_manual(values = c(21,16)) + coord_flip() + geom_linerange(mapping = aes(ymin = MLH1_CH1 - MLH1_CH1_Error,ymax = MLH1_CH1 + MLH1_CH1_Error), position = position_dodge2(width = 0.5)) +
  theme_classic() + scale_colour_manual(name = "Group", values = c("black", "darkgrey")) + theme(plot.tag = element_text(), axis.text.y = element_text(face = "italic", size = 10), axis.text.x = element_text(size = 12), axis.title = element_text(size = 16), legend.position = "none" ) + labs(x= "Species", y= "Avg. # MLH1 Foci on Chromosome 1", color = "", tag = "D") 
bfD
ggsave(height = 5, width = 7, "bigfigD.png", device='png', dpi=700)

bfE <- ggplot(data = df, mapping = aes(x = CH1_Length, y = MLH1_CH1, color = Group)) + geom_point(size = 3, aes(color=Group, shape = Sex))+ scale_colour_manual(values = c("black", "darkgrey")) + stat_smooth(method = "lm", col = "black", se = FALSE) + labs(tag = "E", x= "Chromosome Length (Mb)", y= "Average # of MLH1 Foci", color = "") + theme_classic() + theme(plot.tag = element_text(), legend.position = "none") + scale_shape_manual(values = c(21,16))+ theme(axis.text = element_text(size = 12), axis.title = element_text(size = 16)) +
  geom_text(x = 250, y = 8, label = lm_eqn1(), parse = TRUE, col = "black")
bfE
ggsave(height = 5, width = 5, "bigfigE.png", device='png', dpi=700)

bfF <- ggplot(data = df, mapping = aes(x = SC_Length, y = MLH1_CH1, color = Group)) + geom_point(size = 3, aes(color=Group, shape = Sex)) + scale_shape_manual(values = c(21,16)) + scale_colour_manual(values = c("black", "darkgrey")) + stat_smooth(method = "lm", col = "black", se = FALSE) + labs(tag = "F", x= expression("Average SC Length"~(mu*m)), y= "Average # of MLH1 Foci", color = "") + theme_classic() + theme(plot.tag = element_text(),legend.position = "none", axis.text = element_text(size = 12), axis.title = element_text(size = 16)) +
  geom_text(x = 45, y = 8, label = lm_eqn2(SCL_MLH1_corr), parse = TRUE, col = "black")
bfF
ggsave(height = 5, width = 5, "bigfigF.png", device='png', dpi=700)

DEF <- grid_arrange_shared_legend(bfD, bfE, bfF, ncol = 3, nrow=1, position = "right")
DEF
ggsave(height = 5, width = 5, "mlh1_SC_length.png", device='png', dpi=700)


SC_MLH1 = lm(MLH1_CH1 ~ SC_Length, data = df)
summary(SC_MLH1)


ggarrange(ABC,DEF,nrow = 2, ncol = 1)

#Supplemental figures
plot1b <- ggplot(cMMb.male, aes(x = Group, y = cMMb, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "A",x="", y = "Recombination Rate (cM/Mb)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
plot1b
plot2b <- ggplot(cMMb.birds, aes(x = Sex, y = cMMb, fill = Sex)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "B",x="", y = "Recombination Rate (cM/Mb)") + geom_signif(comparisons = list(c("Male", "Female")), map_signif_level = TRUE)

plot3b <- ggplot(cMMb.cross, aes(x = Group, y = cMMb, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "C", x="", y = "Recombination Rate (cM/Mb)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)

plot4b <- ggplot(cMMbAlt.male, aes(x = Group, y = cMMbAlt, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "B", x="", y = "Recombination Rate (cM/Mb)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
plot4b
plot5b <- ggplot(cMMbAlt.birds, aes(x = Sex, y = cMMbAlt, fill = Sex)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "E", x="", y = "Recombination Rate (cM/Mb)") + geom_signif(comparisons = list(c("Male", "Female")), map_signif_level = TRUE)

plot6b <- ggplot(cMMbAlt.cross, aes(x = Group, y = cMMbAlt, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "F", x="", y = "Recombination Rate (cM/Mb)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)

plot7b <- ggplot(XOHCN.male, aes(x = Group, y = XOHCN, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "B",x="", y = "Recombination Rate (XO/HCN)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
plot7b
plot8b <- ggplot(XOHCN.birds, aes(x = Sex, y = XOHCN, fill = Sex)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "H", x="", y = "Recombination Rate (XO/HCN)") + geom_signif(comparisons = list(c("Male", "Female")), map_signif_level = TRUE)

plot9b <- ggplot(XOHCN.cross, aes(x = Group, y = XOHCN, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "I", x="", y = "Recombination Rate (XO/HCN)") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)

plot10b <- ggplot(MLH1.male, aes(x = Group, y = MLH1_CH1, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "C", x="", y = "MLH1 foci on largest chromosome") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)
plot10b
plot11b <- ggplot(MLH1.birds, aes(x = Sex, y = MLH1_CH1, fill = Sex)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "K", x="", y = "MLH1 foci on largest chromosome") + geom_signif(comparisons = list(c("Male", "Female")), map_signif_level = TRUE)

plot12b <- ggplot(MLH1.cross, aes(x = Group, y = MLH1_CH1, fill = Group)) + geom_boxplot() + scale_fill_manual(values = c("darkgrey","white")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=6)) +labs(tag = "L", x="", y = "MLH1 foci on largest chromosome") + geom_signif(comparisons = list(c("Mammals", "Birds")), map_signif_level = TRUE)


grid.arrange(plot1b,plot2b,plot3b,plot4b,plot5b,plot6b, nrow=2)
grid.arrange(plot7b,plot8b,plot9b,plot10b,plot11b,plot12b, nrow=2)
grid_plot <- grid.arrange(plot1b, plot7b, plot10b, nrow=1)
grob <- arrangeGrob(plot1b, plot7b, plot10b, nrow = 1)
grob
ggsave(plot = grob, height = 3, width = 8, "male_recomb_only.svg", device='svg', dpi=700)

#------------------------------------------------------------------------------
#Is there any relationship between SC complex length and size of Chr1?

#df = tibble("Group" = df.group, "Sex" = df.sex, "cMMb" = cMMb.data, "cMMbAlt" = cMMbAlt.data, "XOHCN" = XOHCN.data, "MLH1_Total" = MLH1.total.data, "Species" = df.species, "CH1_Length" = CH1.length.data,"MLH1_Error" = MLH1.total.error, "MLH1_CH1" = MLH1.CH1.data, "MLH1_CH1_Error" = MLH1.CH1.error, "SC_Length" = SC.length.data, "SC_Error" = SC.length.error)
MLH1.SC.data <- df %>% filter(CH1_Length != 'NA'  & SC_Error != 'NA')

CHvSC <- ggplot(data = MLH1.SC.data, mapping = aes(x = reorder(Species,SC_Length), y = SC_Length, color = Group, shape = Sex)) + geom_point(size = 3, position = position_dodge(width = 0.5), show.legend = TRUE, aes(color=Group, shape = Sex)) + scale_shape_manual(values = c(21,16)) + coord_flip() + 
  theme_classic() + scale_colour_manual(name = "Group", values = c("steelblue4", "lightblue2")) + theme(plot.tag = element_text(), axis.text.y = element_text(face = "italic", size = 10), axis.text.x = element_text(size = 12), legend.text = element_text(size = 16), axis.title = element_text(size = 16) ) + labs(x= "Species", y= "SC Length", color = "", tag = "A")
CHvSC
