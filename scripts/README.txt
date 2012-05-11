
To merge routes, install jython >= 2.5, setuptools or distribute for
jython, and then install geoscript.

Then use the setuptools you installed to install simplejson
(for me I just did "sudo `which easy_install-2.5` simplejson")

Finally:

  export CLASSPATH=`geoscript-classpath`
  # NOTE that may not work; if the result looks like /some/directory/*
  # then you'll have to somehow expand it to a colon-separate list of
  # individual jars
  # before setting as CLASSPATH.


  jython merge_shps.py <PATH_TO_SHAPEFILES_DIRECTORY> routes.json <OUTPUT_FILE>


The routes.json file is config that tells how to merge the shapefiles
in your directory; routes is the name of the output shapefile.
