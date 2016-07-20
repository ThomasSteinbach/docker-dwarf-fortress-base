# thomass/dwarf-fortress

This will run [Dwarf Fortress](http://www.bay12games.com/dwarves/) inside a Docker container.

## usage

Run `docker run thomass/dwarf-fortress` and follow the instructions.

By default config, savegames and movies are stored under "$HOME/dwarf-fortress"

# use this image as base image

Mention that the folder `/df_linux/data/init` has moved to `/df_int` as the original directory is a volume.
