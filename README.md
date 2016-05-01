# Chef Operations Habitat Plans 

This is the worlds first Habitat plan repository outside of Habitat itself!  

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



