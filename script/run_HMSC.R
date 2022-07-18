devtools::install_github('guiblanchet/HMSC') # This version is needed ! (should not using Hmsc from CRAN, nor from SourceForge)
library(HMSC)
library(reshape2)

trunc <- function(x, ..., prec = 0) base::trunc(x * 10^prec, ...) / 10^prec;

occupancies <- readRDS("./data/GT_presence.RDS")

## Considering all Melanoides morphs together (17:22)

for(i in 18:22){ 
  occupancies[[17]] = occupancies[[17]] + occupancies[[i]]
}

# There is six species in total, thus, if occ = 0 (<6) ; NA, if occ = 6 ; absence (1), if occ > 6 : presence (2) 
occupancies[[17]][occupancies[[17]] < 6] = 0
occupancies[[17]][occupancies[[17]] == 6] = 1
occupancies[[17]][occupancies[[17]] > 6] = 2

names(occupancies)[names(occupancies) == "Melanoides tuberculata PAP"] = "Melanoides tuberculata"

# Remove rare species
toKeep = c(1,2,3,4,6,7,8,9,11,12,13,14,15,16,17,23,25)
occupancies <- occupancies[toKeep]

# Turn to matrix
nsp = length(occupancies)
nsites = dim(occupancies[[1]])[1]
nyears = dim(occupancies[[1]])[2]

occ <- structure( rep(0, nsp*nsites*nyears), .Dim = c(nyears, nsites, nsp))

for(i in 1:nyears){
  for(j in 1:nsp){
    occ[i,,j] <- occupancies[[j]][,i]
  }
}

occ[occ == 0] <- NA

## Removing dry patch
dry = read.table("./data/dry_final", h = T)[1:250,-1]
dry[dry != 1] = 0

for(s in 1:nsp){
  occ[,,s][t(dry) == 0] = NA
}

# Turning presence into 1, absence into 0
occ[occ == 1] <- 0
occ[occ == 2] <- 1


#######################################################################

## Constructing Y matrix (presence/absence)
Y = occ[1,,]

for(y in 2:nyears){
  Y = rbind(Y, occ[y,,])
}

rownames(Y) <- rep(seq(1,250,1),nyears)
colnames(Y) <- names(occupancies)


## Read and construct cov matrix
covariables = read.table("./data/cov_unscale_no_habit", h = T)
habitats = read.table("./data/sites_informations", h = T)

covariables = merge(covariables, habitats, by = c("site"))
covariables = covariables[covariables$Ile == "GT",c(2:8,13)]
covariables$river = 0
covariables$mangrove = 0
covariables$river[covariables$type == "r"] = 1
covariables$mangrove[covariables$type == "m"] = 1
covariables = covariables[,-8]

pluviom = read.table("./data/pluvio")[-18,]

covariables = cbind(covariables, lrs = NA, rs = NA)

# Space cov
ncov = dim(covariables)[2]+1

Xtmp = cbind(intercept = rep(1, dim(covariables)[1]), 
             scale(covariables))

X = cbind(intercept = rep(1, dim(covariables)[1]),
          scale(Xtmp[,-1]), 
          matrix(rep(NA,nsites*nsp), ncol = nsp))

colnames(X)[ (ncov+1) :((ncov)+length(occupancies))] <- names(occupancies)

for(y in 2:nyears){
  X = rbind(X, cbind(Xtmp,occ[y-1,,]))
}

X[,"lrs"] = scale(rep(pluviom$lrs, each = nsites))
X[,"rs"] = scale(rep(pluviom$rs, each = nsites))

row_to_keep = which(apply(is.na(cbind(X,Y)),1,sum) == 0)

randomSample = sample(row_to_keep, length(row_to_keep)/1.43)



## Random matrices
Random = data.frame(sites_effect = (rep(seq(1,nsites,1),nyears)),
                    years_effect = (rep(1:nyears, each = nsites)))

# Prepare data (training)
gwada_data = HMSC::as.HMSCdata(Y=Y[randomSample,],
                               X=X[randomSample,],
                               Random = as.data.frame(lapply(Random[randomSample,], factor)), scaleX = F, interceptX = F)

# Prepare data (validation)
gwada_toPredict = HMSC::as.HMSCdata(Y=Y[setdiff(row_to_keep, randomSample),],
                              X=X[setdiff(row_to_keep, randomSample),],
                              Random = as.data.frame(lapply(Random[setdiff(row_to_keep, randomSample),],factor)), scaleX = F, interceptX = F)

# Run model
model = hmsc(gwada_data,family="probit",niter=2000000,nburn=1000000,thin=20)

# Save output (and training/Validation data)
saveRDS(model, file = "model_probit_1b.RDS")
saveRDS(list(train=gwada_data, val=gwada_toPredict), file = "gwada_occ_1b.RDS")
