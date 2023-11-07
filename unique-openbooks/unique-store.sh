# Make conf location
mkdir -p $ConfDir

# if no existing compsoe mods, copy template
if [ ! -f $ConfDir/compose-mod.yml ]
then
    cp $AppDir/compose-mod.yml $ConfDir/compose-mod.yml
fi

# mergs compose mode and compose templates into a single docker-compose
yq eval-all '. as $item ireduce ({}; . *+ $item)' $AppDir/docker-compose-template.yml $ConfDir/compose-mod.yml > $AppDir/docker-compose.yml

# if no data dir, make it, copy template
if [ ! -d $ConfDir/data ]
then
    echo Copying data template
    cp $AppDir/data-template $ConfDir/data -r
fi

#if no symlink to data dir, make it
if [ ! -L $AppDir/data ]
then
    echo Symlinking data directory
    ln -s $ConfDir/data $AppDir/data
fi

export UNIQUE_APP_DATA_DIR=${ConfDir}/data
