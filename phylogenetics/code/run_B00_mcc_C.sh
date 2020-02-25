#!/bin/bash

# Model-specific params:

# Run the MCC consensus tree
mccmodel="C"     # which model to run?

# Which model to use (here, M00):
brm="TUBR" # branch_rates_model
rfm="1" # root_freq_model
srm="1" # site_rates_model

# Override MCMC params for single trees (should come from the caller):
bgens=100000     # burnin_generations
gtune=10000      # burnin_tuningInterval
mcmcgens=1000000 # mcmc_generations
prmod=100        # printgen_model
mlkcats=25       # marg_lkl_cats
mlkbgens=100000  # marg_lkl_burnin_gen
mlkbtune=10000   # marg_lkl_burnin_tun
mlkgens=50000    # marg_lkl_pow_gen

# Trees (shuould come from the caller):
tworunstree=20   # up to which tree to do two runs and marginal likelihood (i.e., the "special treatment")
maxtree=100      # maximum tree number

# Ancestral states:
prancsts=1000    # number of generations at which to save the ancestral states

source ./run_template_mcc.sh
