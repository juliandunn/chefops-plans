# Chef Operations Habitat Plans 

This is the worlds first Habitat plan repository outside of Habitat itself!  

## Getting Started with Habitat

```
# Get and Build Habitat
git clone https://github.com/habitat-sh/habitat.git
cd habitat
make distclean  ## If you have an old build, clean it out
make image	## Generate the devshell Docker container with Habitat

# Add in the chefops-plans Repo 
git clone https://github.com/chef/chefops-plans.git

# Now enter the Habitat Devshell
make shell
```

Once you are in the shell you can proceed to build the plans, as shown in the next section.

## Building the Plans

To use these plans, checkout the repository along side your **plans/** directory
in the source tree.  Then build as usual, example:

```
cd /src

studio new
studio enter

hab origin key generate chefops
build ops-plans/myPlan

hab-bpm install core/hab-pkg-dockerize
hab-bpm exec core/hab-pkg-dockerize hab-pkg-dockerize chefops/myPlan
```



