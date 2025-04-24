library(tidyverse)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(ggpubr)
library(ggsignif)
library(readxl)
library(colorspace) 
library(ggpattern)



#For the boxplot with all clade omegas

omega_data <- read.csv("BMF_omega.csv")
head(omega_data)
omega_new <- omega_data
omega_new$Clade <- factor(omega_data$Clade, levels = c("Bird", "Mammal", "Fish"))

plot <- ggplot(omega_data,aes(x=Clade, y=Omega, fill=Clade)) + geom_boxplot(notch=TRUE, position="dodge")+
  geom_point() + geom_signif(comparisons=list(c("Mammal","Bird")), y_position = 0.75)  +
  geom_signif(comparisons=list(c("Mammal","Fish")), y_position = 0.70) +
  geom_signif(comparisons=list(c("Fish","Bird")), y_position = 0.85)
 
plot <- plot + theme_bw() + theme(legend.position="none", panel.border = element_blank(), panel.grid.major = element_blank(),
                                  panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) + scale_color_manual(values=hcl.colors(3, "Grays"))
plot

ggsave("BMF_omega_greyscale.png")

#Omega values by clade
fig4A.revised <- ggplot(omega_new, aes(x = Clade, y = Omega, fill = Clade)) + geom_boxplot(notch=TRUE, position="dodge") +
  geom_point() + scale_fill_manual(values = hcl.colors(3,"Grays")) + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(x="Clade", y = "Omega (dN/dS)") + 
  geom_signif(comparisons=list(c("Mammal","Bird")), y_position = 0.85, map_signif_level = TRUE, extend_line = -0.01)+
  geom_signif(comparisons=list(c("Mammal","Fish")), y_position = 0.85, map_signif_level = TRUE, extend_line = -0.01) +
  geom_signif(comparisons=list(c("Fish","Bird")), y_position = 0.9, map_signif_level = TRUE)
fig4A.revised
ggsave(height = 5, width = 5, "fig4A_revised.png", device='png', dpi=700)

#Comparison of pathway omega values in birds
pathway.omega.revised <- read.csv("bird_pathway_omegas.csv")

fig4B.revised <- ggplot(pathway.omega.revised, aes(x = Pathway, y = Omega, fill = Pathway))+  geom_boxplot(notch=TRUE, position="dodge") +scale_fill_manual(values = c("#d0d0d0", "#5b5b5b", "#3b3b3b")) +
  geom_point() + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(x="Pathway", y = "Omega (dN/dS)") + 
  geom_signif(comparisons=list(c("Brain","Recombination")), y_position = 0.80, map_signif_level = TRUE, extend_line = -0.01) +
  geom_signif(comparisons=list(c("Brain","Up/Downstream")), y_position = 0.85, map_signif_level = TRUE, extend_line = -0.01) +
  geom_signif(comparisons=list(c("Up/Downstream","Recombination")), y_position = 0.75, map_signif_level = TRUE, extend_line = -0.01)
fig4B.revised
ggsave(height = 5, width = 5, "fig4B_revised.png", device='png', dpi=700)

mammal.pathway <- read.csv("mammal_pathway_omegas.csv")
supp.fig.mammal <- ggplot(mammal.pathway, aes(x = Pathway, y = Omega, fill = Pathway))+  geom_boxplot(notch=TRUE, position="dodge") +scale_fill_manual(values = c("#d0d0d0", "#5b5b5b", "#3b3b3b")) +
  geom_point() + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(x="Pathway", y = "Omega (dN/dS)") + 
  geom_signif(comparisons=list(c("Brain","Recombination")), y_position = 0.80, map_signif_level = TRUE, extend_line = -0.01) +
  geom_signif(comparisons=list(c("Brain","Up/Downstream")), y_position = 0.85, map_signif_level = TRUE, extend_line = -0.01) +
  geom_signif(comparisons=list(c("Up/Downstream","Recombination")), y_position = 0.75, map_signif_level = TRUE, extend_line = -0.01)
supp.fig.mammal
ggsave(height = 5, width = 5, "mammal_comp_pathway.png", device='png', dpi=700)

fish.pathway <- read.csv("fish_pathway_omegas.csv")
supp.fig.fish <- ggplot(fish.pathway, aes(x = Pathway, y = Omega, fill = Pathway))+  geom_boxplot(notch=TRUE, position="dodge") +scale_fill_manual(values = c("#d0d0d0", "#5b5b5b", "#3b3b3b")) +
  geom_point() + theme_classic() + theme(plot.tag = element_text(),legend.position="none", text = element_text(size=12)) +labs(x="Pathway", y = "Omega (dN/dS)") + 
  geom_signif(comparisons=list(c("Brain","Recombination")), y_position = 0.80, map_signif_level = TRUE, extend_line = -0.01, test = t.test) +
  geom_signif(comparisons=list(c("Brain","Up/Downstream")), y_position = 0.85, map_signif_level = TRUE, extend_line = -0.01, test = t.test) +
  geom_signif(comparisons=list(c("Up/Downstream","Recombination")), y_position = 0.75, map_signif_level = TRUE, extend_line = -0.01, test = t.test)
supp.fig.fish
ggsave(height = 5, width = 5, "fish_comp_pathway.png", device='png', dpi=700)

#-----------------------------------------------------------------------
#Individual dN/dS plots
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(ggarrange)
library(grid)
library(gridExtra)

data <- read.csv("BMF_omega_comp1123.csv")
head(data)

#Source: https://www.roelpeters.be/how-to-add-a-regression-equation-and-r-squared-in-ggplot2/
eq <- function(x,y) {
  m <- lm(y ~ x)
  as.character(
    as.expression(
      substitute(~~italic(r)^2~"="~r2,
                 list(r2 = format(summary(m)$r.squared, digits = 3)))
    )
  )
}

plot1 <- ggplot(data, aes(x=M_omega, y= B_omega, label= Gene))+
  geom_point() +geom_text_repel(hjust=-1,vjust=0)+
  geom_smooth(method='lm', formula= y~x) +
  xlim(0, 1) + xlab("Mammal") +ylim(0, 0.75) + ylab("Bird") +
  geom_text(x=0.1, y=0.6,label = eq(data$B_omega,data$M_omega), parse = TRUE) + labs(tag = "C") +
  theme_bw() + theme(plot.tag = element_text(), legend.position="none", panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) + scale_color_manual(values=hcl.colors(3, "Grays"))

plot1

ggsave("MvB_dist_labeled.png")


plot2 <- ggplot(data, aes(x=F_omega, y= B_omega, label= Gene))+
  geom_point() +geom_text_repel(hjust=-1,vjust=0)+
  geom_smooth(method='lm', formula= y~x) +
  xlim(0, 1) + xlab("Fish") +ylim(0, 0.75) + ylab("Bird") +
  geom_text(x=0.1, y=0.6,label = eq(data$B_omega,data$F_omega), parse = TRUE) + labs(tag = "D") + 
  theme_bw() + theme(plot.tag = element_text(), legend.position="none", panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) + scale_color_manual(values=c("#d0d0d0","#999999", "#5b5b5b"))
plot2
ggsave("BvF_dist_labeled.png")

plot3 <- ggplot(data, aes(x=F_omega, y= M_omega, label= Gene))+
  geom_point() +geom_text_repel(hjust=-1,vjust=0)+
  geom_smooth(method='lm', formula= y~x) +
  xlim(0, 1) + xlab("Mammal") +ylim(0, 0.75) + ylab("Fish") +
  geom_text(x=0.1, y=0.6,label = eq(data$M_omega,data$F_omega), parse = TRUE) + labs(tag = "E") + 
  theme_bw() + theme(plot.tag = element_text(), legend.position="none", panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) + scale_color_manual(values=c("#d0d0d0","#999999", "#5b5b5b"))

plot3
ggsave("MvF_dist_labeled.png")


#------------------------------------------------------------------------
#Plotting all three clades dN/dS in one plot
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(grid)
library(gridExtra)

data <- read.csv("BMF_omega_comp.csv")
head(data)

#Source: https://www.roelpeters.be/how-to-add-a-regression-equation-and-r-squared-in-ggplot2/
eq <- function(x,y) {
  m <- lm(y ~ x)
  as.character(
    as.expression(
      substitute(~~italic(r)^2~"="~r2,
                 list(r2 = format(summary(m)$r.squared, digits = 3)))
    )
  )
}

plot1 <- ggplot(data, aes(x=M_omega, y= B_omega))+
  geom_point() +
  geom_smooth(method='lm', formula= y~x) +
  xlim(0, 0.85) + xlab("Mammal") +ylim(0, 0.8) + ylab("Bird") +
  geom_text(x=0.25, y=0.75,label = eq(data$B_omega,data$M_omega), parse = TRUE) +
  theme_bw() + theme(plot.tag = element_text(), legend.position="none", panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) + scale_color_manual(values=hcl.colors(3, "Grays"))
plot1
ggsave(height = 5, width = 5, "MvB.png", device='png', dpi=700)


plot2 <- ggplot(data, aes(x=F_omega, y= B_omega))+
  geom_point() +
  geom_smooth(method='lm', formula= y~x) +
  xlim(0, 0.85) + xlab("Fish") +ylim(0,0.8) + ylab("Bird") +
  geom_text(x=0.25, y=0.75,label = eq(data$B_omega,data$F_omega), parse = TRUE)  +
  theme_bw() + theme(plot.tag = element_text(), legend.position="none", panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) + scale_color_manual(values=c("#d0d0d0","#999999", "#5b5b5b"))
plot2
ggsave(height = 5, width = 5, "BvF.png", device='png', dpi=700)


plot3 <- ggplot(data, aes(x=F_omega, y= M_omega))+
  geom_point() +
  geom_smooth(method='lm', formula= y~x) +
  xlim(0, 0.85) + xlab("Fish") +ylim(0, 0.8) + ylab("Mammal") +
  geom_text(x=0.25, y=0.75,label = eq(data$M_omega,data$F_omega), parse = TRUE) +
  theme_bw() + theme(plot.tag = element_text(), legend.position="none", panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) + scale_color_manual(values=c("#d0d0d0","#999999", "#5b5b5b"))
plot3
ggsave(height = 5, width = 5, "MvF.png", device='png', dpi=700)

grid.arrange(plot1, plot2, plot3, nrow = 1)
ggsave(height = 5, width = 7, "MFB_comb.tiff", device='tiff', dpi=700)
ggsave("MvFvB_combo.png")


#--------------------------------------------------------------------------------
#Comparison P values

p_val_data <- read.csv("BMF_omega_comp.csv")
head(p_val_data)

BvM <- t.test(p_val_data$B_omega, p_val_data$M_omega,paired = TRUE, alternative = "two.sided")
BvM

BvF <- t.test(p_val_data$B_omega, p_val_data$F_omega,paired = TRUE, alternative = "two.sided")
BvF

BvM_corr = lm(p_val_data$B_omega ~  p_val_data$M_omega, data = p_val_data)
summary(BvM_corr)

sansTEX11 <-filter(p_val_data,  Gene != "TEX11")
BVM_noTEX11_corr = lm(sansTEX11$B_omega ~  sansTEX11$M_omega, data = sansTEX11)
summary(BVM_noTEX11_corr)

FvM_corr = lm(p_val_data$F_omega ~  p_val_data$M_omega, data = p_val_data)
summary(FvM_corr)

FvB_corr = lm(p_val_data$F_omega ~  p_val_data$B_omega, data = p_val_data)
summary(FvB_corr)
