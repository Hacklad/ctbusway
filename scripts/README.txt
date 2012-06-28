
To merge routes, install jython >= 2.5, setuptools or distribute for
jython, and then install geoscript.
(Jython instructions: http://wiki.python.org/jython/InstallationInstructions)
(Geoscript instructions: http://geoscript.org/py/quickstart.html)

Then use the setuptools you installed to install simplejson
(for me I just did "sudo `which easy_install-2.5` simplejson")

Finally:

  export CLASSPATH=`geoscript-classpath`
  # NOTE that may not work; if the result looks like /some/directory/*
  # then you'll have to somehow expand it to a colon-separate list of
  # individual jars
  # before setting as CLASSPATH.

  jython merge_shps.py shapefiles routes.json <OUTPUT_DIR>

The shapefiles/ subdirectory is in git now. Everything you need should
be in there, unzipped. If editing these, be sure to commit the edits.

The routes.json file is config that tells how to merge the shapefiles
in your directory.

The output dir will be used as the name of the directory to save to
*and* the basename of all the files saved within it.  Eg. if you
specify "routes", you will get output files routes/routes.shp,
routes/routes.prj, etc.

Zip and save the resulting shapefile in the shapefiles/ directory and commit.
