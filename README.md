# Chef Operations Habitat Plans 

This is the worlds first Habitat plan repository outside of Habitat itself!  

## Getting Started with Habitat

Follow the instructions here: https://www.habitat.sh/docs/get-habitat/

## Building the Plans

To use these plans: 

```
git clone https://github.com/chef/chefops-plans.git
cd chefops-plans

hab studio new
hab studio enter

## If you don't have keys for your origin yet (if you do, just copy them to /hab/cache/keys/):
hab origin key generate chefops

cd {some-plan}
build 

hab pkg export docker chefops/{myPlan}
```

## Uploading Packages to the Depot

If you wish to upload a Package to the Depot (willem.habitat.sh), use the command:
*hab pkg upload -z $GITHUB_AUTH_TOKEN /hab/cache/artifacts/....hart* 

**NOTE!**: Once you upload a package to the depot the supervisors may attempt to use it
to update any runnings instances.  Only upload packages if you are sure you want them running
in the wild!

To upload your origin key to the depot: 

```
hab origin key upload ./chefops-20160510223959.pub 
```

To download the key (for verification):

```
hab origin key download chefops
```

