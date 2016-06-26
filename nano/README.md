# The Nano Editor, for Habitat

Nano was packaged for my amazing friend Jessica DeVita (@UberGeekGirl).  It is intended
to make every Nano user feel more comfortable and at home while working within a Habitat
Studio (where vi is the only editor available by default).

To use this package from within a Studio, simply cut & paste the following:

```bash
hab pkg install chefops/nano && export PATH=$PATH:`hab pkg path chefops/nano`/bin
```

Once the above is pasted in, you can invoke *nano* to edit your plan files, configs, etc.
