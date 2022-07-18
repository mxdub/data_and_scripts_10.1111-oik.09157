# data_and_scripts_10.1111-oik.09157
Data &amp; Scripts for Oikos paper entitled: Niche filtering, competition and species turnover in a metacommunity of freshwater molluscs


## Authors

__Dubart, Maxime__, Centre d'Ecologie Fonctionnelle et Evolutive, https://orcid.org/0000-0003-0549-0371
__Pointier, Jean-Pierre__, Centre de Recherches Insulaires et Observatoire de l'Environnement
__Jarne, Philippe__, Centre d'Ecologie Fonctionnelle et Evolutive
__David, Patrice__, Centre d'Ecologie Fonctionnelle et Evolutive
dubartmaxime@gmail.com, pointier@univ-perp.fr, philippe.jarne@cefe.cnrs.fr, patrice.david@cefe.cnrs.fr


## Abstract

Metacommunity structure reflects the interplay of various processes, including niche filtering, extinction / colonization, and interspecific interactions. Spatial patterns of species distributions are often analyzed to infer these processes. However, such inferences rely on often unrealistic equilibrium assumptions, and remain ambiguous, as different processes can produce similar patterns. Temporal data may improve these inferences. For example, stochastic species turnover may occur in local communities, while, on the long run, temporal changes are kept within limits set by locally available niches. Our objective is to explore how the joint analysis of spatial and temporal patterns can clarify the contribution of different processes to metacommunity structure. We recorded the occurrences of 21 freshwater mollusc species, and environmental data, in 250 sites over 17 successive years in a network of ponds in Guadeloupe (Lesser Antilles). We analyzed variation in α and β-diversities in space and time, and used a joint-species distribution mode to characterize species-environment and species-species relationships. Local communities showed pronounced temporal variation reflecting both imperfect species detection and true stochastic species turnover. On the long term however, local communities were largely controlled by niche filtering along two main environmental gradients, one driven by site connectivity, the other by hydrological stability and aquatic vegetation. Two gastropod clades, caenogastropods and pulmonates, showed contrasted spatio-temporal distributions resulting from different responses to these gradients, and these distributions seemed little altered by interspecific competition. Our study illustrates the benefit of using spatiotemporal metacommunity data to discern long-term impacts of niche filtering and species interactions behind short-term stochasticity.

## Data informations

Data collection occurs every years since 2001, usually in January/February (the beginning of the dry season). Each site was surveyed by three persons for 15 minutes, to record mollusc species and environmental characteristics. Environmental values were averaged over years to produce long-term site-specific values (file __"cov_unscale_no_habit"__). An additional variable, included in this file is the "Stability Index" : computed from variability of various variables and dessication probability - and representing the long-term hydrological regime (i.e. contrasting unstable sites with high probability of dessiccation, to stable permanent water bodies). In addition, the __'sites_informations'__ file provides sites' positions (long/lat) as well as sites' types (i.e. ponds, river, back-mangroves). Two year-specific (temporal) variables are given in file __"pluvio"__ - the cumulative rainfalls during the rainy season (RS) and during the little rainy season (LRS), which are averaged over five Guadeloupean meteorological stations.


Species presences were recorded in wet sites, and a random subset of sites (ca. 30 by year) was re-sampled to estimate species detection probabilities (__presence.zip__). The __'dry_final'__ file provides the matrix of site's states (i.e. dry – 1 or wet - 0, or a probability of being dry).


Species presences (i.e. detection) are in the __GT_presence.RDS__ compressed file (use readRDS() from R) – 0 are NA, 1 absence, and 2 presence.


All analyses are describe in __Guadeloupe-Snails---first-part.html, and Guadeloupe-Snails---second-part--HMSC-.html__. Exact content of data files are given in the __data/REAMDE.txt__ file. Additional scripts : __run_HMSC.R__ : run HMSC model, __R2_hmsc.R__ : compute R2 for training & validation datasets, __null_dissimilarities.R__ : compute null expectation for among-community dissimilarity.