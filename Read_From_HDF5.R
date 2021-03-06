source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)

#create a quick hdf5 file to work with
created = h5createFile("example.h5")
created

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")

h5ls("example.h5")