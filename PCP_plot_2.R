if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("graph")

install.packages("PairViz")

suppressPackageStartupMessages(library(PairViz))
fred <- read.csv("C:/users/santo/desktop/fred_factors.csv", header = TRUE)
data <- fred[,c(2:7)]
pcp(data,horizontal=TRUE,lwd=2, col="grey50",
    main = "Standard PCP")

#Hamiltonian Decomposition
o <- hpaths(1:ncol(data),matrix=FALSE)
par(cex.axis=.7)
pcp(data,order=o,horizontal=TRUE,lwd=2, col="grey50",
    main = "Hamiltonian decomposition")

corw <- as.dist(cor(data))
o <- eulerian(-corw)

par(cex.axis=.7)
pcp(data,order=o,horizontal=TRUE,lwd=2, col="grey50",
    main = "Weighted eulerian")

corw <- dist2edge(corw)
edgew <- cbind(corw*(corw>0), corw*(corw<0))
par(cex.axis=.7)
guided_pcp(data,edgew, path=o,pcp.col="grey50" ,lwd=2,
           main="Weighted eulerian with correlation guide",
           bar.col = c("lightcyan1","lightpink1"),
           bar.ylim=c(-1,1),bar.axes=TRUE)

pathw <-  path_weights(corw,o)
corcols <- ifelse(pathw>0, "lightcyan1", "lightpink")
par(cex.axis=.7)
pcp(data,order=o,col="grey50" ,lwd=2,
    main="Weighted eulerian with correlation guide",
    panel.colors = corcols)

