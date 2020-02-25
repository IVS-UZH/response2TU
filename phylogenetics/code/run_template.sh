#!/bin/bash

# Which model to use (these should come from the caller):
#brm="MC" # branch_rates_model
#rfm="1" # root_freq_model
#srm="1" # site_rates_model

# Override MCMC params for single trees (should come from the caller):
#bgens=10000     # burnin_generations
#gtune=1000      # burnin_tuningInterval
#mcmcgens=100000 # mcmc_generations
#prmod=10        # printgen_model
#mlkcats=25      # marg_lkl_cats
#mlkbgens=10000  # marg_lkl_burnin_gen
#mlkbtune=1000   # marg_lkl_burnin_tun
#mlkgens=10000   # marg_lkl_pow_gen

# Trees (shuould come from the caller):
#tworunstree=20  # up to which tree to do two runs and marginal likelihood (i.e., the "special treatment")
#maxtree=1000    # maximum tree number

# Ancestral states:
#prancsts=500    # number of generations at which to save the ancestral states

# The trees with "special treatment" (two runs, marginal likelihood):
for ((t=1; t<=tworunstree; t++)); do
  echo "Tree " $t
    
  for i in {1..2} # number of runs
  do
    echo ">>> Tree " $t ",  run " $i
    
    # The normal MCMC run:
    if [ $i == 1 ] ; # save and compute ancestral states only for the first run (save space and time)
    then
    rb_command="clear();
                branch_rates_model=\"$brm\";
                root_freq_model=\"$rfm\";
                site_rates_model=\"$srm\";
                burnin_generations=$bgens;
                burnin_tuningInterval=$gtune;
                mcmc_generations=$mcmcgens;
                printgen_screen=10000;
                printgen_model=$prmod;
                run_ancstates_mon=TRUE;
                printgen_ancstates=$prancsts;
                run_ancstates_estim=TRUE;
                run_marg_likelihood=FALSE;
                which_tree=$t;
                run_number=$i;
                source(\"./LD_models.Rev\");"
    else
    rb_command="clear();
                branch_rates_model=\"$brm\";
                root_freq_model=\"$rfm\";
                site_rates_model=\"$srm\";
                burnin_generations=$bgens;
                burnin_tuningInterval=$gtune;
                mcmc_generations=$mcmcgens;
                printgen_screen=10000;
                printgen_model=$prmod;
                run_ancstates_mon=FALSE;
                run_marg_likelihood=FALSE;
                which_tree=$t;
                run_number=$i;
                source(\"./LD_models.Rev\");"
    fi
    echo $rb_command
    echo $rb_command | rb
  done
      
  if [[ $brm == 'MC' || $brm == 'ULR'  || $brm == 'RMC' ]]; # compute marginal likelihood?
  then
    # The marginal likelihood:
    rb_command="clear();
                branch_rates_model=\"$brm\";
                root_freq_model=\"$rfm\";
                site_rates_model=\"$srm\";
                run_marg_likelihood=TRUE;
                marg_lkl_cats=$mlkcats;
                marg_lkl_burnin_gen=$mlkbgens;
                marg_lkl_burnin_tun=$mlkbtune;
                marg_lkl_pow_gen=$mlkgens;
                which_tree=$t;
                source(\"./LD_models.Rev\");"
      echo $rb_command | rb
  fi
    
done

# The other trees (single run, no marginal likelihood):
for ((t=tworunstree+1; t<=maxtree; t++)); do
  echo ">>> Tree " $t " (1 run)"
    
  # The normal MCMC run:
  rb_command="clear();
              branch_rates_model=\"$brm\";
              root_freq_model=\"$rfm\";
              site_rates_model=\"$srm\";
              burnin_generations=$bgens;
              burnin_tuningInterval=$gtune;
              mcmc_generations=$mcmcgens;
              printgen_screen=10000;
              printgen_model=$prmod;
              run_ancstates_mon=TRUE;
              printgen_ancstates=$prancsts;
              run_ancstates_estim=TRUE;
              run_marg_likelihood=FALSE;
              which_tree=$t;
              run_number=1;
              source(\"./LD_models.Rev\");"
  echo $rb_command
  echo $rb_command | rb
    
done
