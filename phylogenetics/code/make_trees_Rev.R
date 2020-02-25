################################################################################
#
# Dan Dediu 2019
#
# This is based on make_trees_Rev.R by S. Tarasov 2019
# but is modified to also processes the MCC trees
# indoeuropean-B-sum-matched.nex and indoeuropean-C-sum-matched.nex
#
################################################################################



# Read in data
labiodental.data <- read.csv('../data/ie_labiodental_data_d.csv', stringsAsFactors=F)

# get list of prsent languages
glot <- paste0('<', labiodental.data$glottocode, '>')
Langs <- paste0(labiodental.data$language, glot)

#----------- create tre files by sampling 1000 trees

# ----- C dataset
if( FALSE ) # don't run, so we keep the same sample as the original TU
{
  ie.c.trees <- read.nexus('../data/indoeuropean-C-20k-matched.nex')
  ie.c.trees <- lapply(ie.c.trees, function(t) {
    t <- drop.tip(t, setdiff(t$tip.label, Langs))
    return(t)
  })
  class(ie.c.trees) <- 'multiPhylo'	
  attributes(ie.c.trees)$TipLabel <- ie.c.trees[[1]]$tip.label
  
  # sample 1000 trees
  sample <- sample(c(1:length(ie.c.trees)), 1000)
  tree.sampled <- ie.c.trees[sample]
  write.tree(tree.sampled, file = '../data/indoeuropean-C.tre')
}

# MCC consensus tree
ie.c.mcc.tree <- read.nexus('../data/indoeuropean-C-sum-matched.nex')
ie.c.mcc.tree <- drop.tip(ie.c.mcc.tree, setdiff(ie.c.mcc.tree$tip.label, Langs))
write.tree(ie.c.mcc.tree, file = '../data/indoeuropean-C-sum-matched.tre')


# ----- B dataset
if( FALSE ) # don't run, so we keep the same sample as the original TU
{
  ie.c.trees <- read.nexus('../data/indoeuropean-B-10k-matched.nex')
  ie.c.trees <- lapply(ie.c.trees, function(t) {
    t <- drop.tip(t, setdiff(t$tip.label, Langs))
    return(t)
  })
  class(ie.c.trees) <- 'multiPhylo'	
  attributes(ie.c.trees)$TipLabel <- ie.c.trees[[1]]$tip.label
  
  # sample 1000 trees
  sample <- sample(c(1:length(ie.c.trees)), 1000)
  tree.sampled <- ie.c.trees[sample]
  write.tree(tree.sampled, file = '../data/indoeuropean-B.tre')
}

# MCC consensus tree
ie.c.mcc.tree <- read.nexus('../data/indoeuropean-B-sum-matched.nex')
ie.c.mcc.tree <- drop.tip(ie.c.mcc.tree, setdiff(ie.c.mcc.tree$tip.label, Langs))
write.tree(ie.c.mcc.tree, file = '../data/indoeuropean-B-sum-matched.tre')

