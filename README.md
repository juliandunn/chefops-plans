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

hab-studio new
hab-studio enter

hab origin key generate chefops
build chefops-plans/{myPlan}

hab-bpm install core/hab-pkg-dockerize
hab-bpm exec core/hab-pkg-dockerize hab-pkg-dockerize chefops/{myPlan}
```

## Uploading Packages to the Depot

If you wish to upload a Package to the Depot (willem.habitat.sh), use the command:
*hab artifact upload /hab/cache/artifacts/....hart* 

**NOTE!**: Once you upload a package to the depot the supervisors will attempt to use it
to upload any runnings instances.  Only upload packages if you are sure you want them running
in the wild!



