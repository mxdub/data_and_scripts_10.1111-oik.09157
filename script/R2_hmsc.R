library(HMSC)

R2t = list()
R2v = list()
Ymean = list()

# Takes very large amount of RAM (~13Go...)
for(i in 1:3){
  library(HMSC)
  
  model = readRDS(paste("model_probit_",i,"b_noInteraction.RDS",sep=''))
  gwada_toPredict = readRDS(paste("gwada_occ_",i,"b_noInteraction.RDS",sep=''))
  
  R2t[[i]] <- Rsquared(model, averageSp=FALSE)
  Ymean[[i]] <- apply(model$data$Y,2,mean)
  R2v[[i]] <- Rsquared(model, averageSp=FALSE, newdata=gwada_toPredict$val)
  
  rm(list = c("gwada_toPredict", "model"))
  gc()
  
}

r2 = readRDS('./R2_interactions.RDS')
R2t = r2$r2t
R2v = r2$r2v

# R2 training
lapply(R2t, mean)

# R2 validation
lapply(R2v, mean)
