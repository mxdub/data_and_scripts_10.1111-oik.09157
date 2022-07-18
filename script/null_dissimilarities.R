lstF = list.files("./data/presence/")

allspeciespresences = list()
for(i in lstF){
  sp = strsplit(i,'_')[[1]][2]
  allspeciespresences[[sp]] = read.table(paste0("./data/presence/",i))
  allspeciespresences[[sp]][allspeciespresences[[sp]] == 0] = NA
  allspeciespresences[[sp]][allspeciespresences[[sp]] == 1] = 0
  allspeciespresences[[sp]][allspeciespresences[[sp]] == 2] = 1
}

nsite = 250
alldt = structure(.Data = rep(NA, 17*nsite*27*2), .Dim = c(nsite,17,27,2))

for(i in 1:27){
  for(j in 1:2){
    if(j == 1){
      alldt[,,i,j] = as.matrix(allspeciespresences[[i]][1:nsite,1:17])
    }else{
      alldt[,,i,j] = as.matrix(allspeciespresences[[i]][1:nsite,18:34])
    }
  }
}

btSor = function(x,y){
  if(sum(is.na(x))+sum(is.na(y)) !=0 ) return(NA)
  
  a = sum(x==1 & y == 1)
  b = sum(x==1 & y == 0)
  c = sum(x==0 & y == 1)
  
  if(a+b == 0 | a+c == 0) return(NA)
  
  return((b+c)/(2*a+b+c))
}

btSim = function(x,y){
  if(sum(is.na(x))+sum(is.na(y)) !=0 ) return(NA)
  
  a = sum(x==1 & y == 1)
  b = sum(x==1 & y == 0)
  c = sum(x==0 & y == 1)
  
  if(a+b == 0 | a+c == 0) return(NA)
  
  return(min(b,c)/(a+min(b,c)))
}

sorDistNull = apply(alldt, c(1,2), FUN = function(x) btSor(x[,1],x[,2]))
simDistNull = apply(alldt, c(1,2), FUN = function(x) btSim(x[,1],x[,2]))
nestDistNull = 1-simDistNull/sorDistNull

mean(sorDistNull, na.rm = T)
sd(sorDistNull, na.rm = T)

mean(simDistNull, na.rm = T)
sd(simDistNull, na.rm = T)

mean(nestDistNull, na.rm = T)
sd(nestDistNull, na.rm = T)
  