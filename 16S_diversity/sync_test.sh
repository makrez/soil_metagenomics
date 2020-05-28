#!/bin/bash

mkdir -p "test";
rsync -rav "Snakefile" test/.;
rsync -rav "rules" test/.;
rsync -rav "config" test/.;
rsync -rav "resources" test/.;
rsync -rav "data_testing" test/.;
rsync -rav "scripts"

## replace threads/hours/mem_mb in rules
#-------------------------------------------------------------------------------

for i in $(ls rules); do \
# replace threads-statement
 sed "s/.*_threads'])/    int(config['testing']['testing_threads'])/g"  < \
  rules/$i | \
# replace hours-statement
 sed "s/hours.*/hours = int(config['testing']['testing_hours'])/g" | \
#replace mem_mb-statement
 sed "s/mem_mb.*/mem_mb = int(config['testing']['testing_mem_mb']),/g" > \
  test/rules/$i; done

## replace DataFolder to DataFolder_testing in Snakefile
#-------------------------------------------------------------------------------

sed "s/config\['DataFolder'\]/config['DataFolder_testing']/g" < Snakefile \
 > test/Snakefile





# #rsync -rav --delete --exclude=".*" test/* mkreuzer@binfservms01.unibe.ch:/data/projects/p532_BX-rhizosphere-metagenomics/soil_metagenomics/test/. ;
# rsync -rav --delete --exclude=".*" test/* mkreuzer@binfservms01.unibe.ch:/data/projects/p532_BX-rhizosphere-metagenomics/soil_metagenomics/test/. ;
#
# rsync -rav "Snakefile" mkreuzer@binfservms01.unibe.ch:/data/projects/p532_BX-rhizosphere-metagenomics/soil_metagenomics/. ;
# rsync -rav "rules" mkreuzer@binfservms01.unibe.ch:/data/projects/p532_BX-rhizosphere-metagenomics/soil_metagenomics/. ;
# rsync -rav "config" mkreuzer@binfservms01.unibe.ch:/data/projects/p532_BX-rhizosphere-metagenomics/soil_metagenomics/. ;
# rsync -rav "resources" mkreuzer@binfservms01.unibe.ch:/data/projects/p532_BX-rhizosphere-metagenomics/soil_metagenomics/. ;
