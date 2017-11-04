con = url("http://biostat.jhsph.edu/~jleek/contact.html")
  
numbered <- readLines(con)
numbered

numbered[100]

nchar(numbered[10])
nchar(numbered[20])
nchar(numbered[30])
nchar(numbered[100])

