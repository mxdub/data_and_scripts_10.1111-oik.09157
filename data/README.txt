	
Species data : 

	presence.zip: contains observations/non-observations for all species along the 17 years and for all sites (very raw data). 
		Note : for each species, the matrix is of size (278 x 34) : 
		- 278 sites are indeed sampled, but only the first 250 were used. Others are not on Grande-Terre Island. 
		- the 34 columns correspond to: columns 1 -> 17 : sampling, 18 -> 34 : revisits.
		- Presence/absence are encoded as follow: presence (2), absence (1) or NA (0)

		Scripts using these data: null_disimilarities.R

	GT_presence.RDS: contains (corrected observations, i.e. considering revisit data) for all species along the 17 years and for the 250 sites of Grande-Terre used here.
		Note : can be import with readRDS() - contains a list of 2D arrays (250 x 17).

		Scripts using these data: Guadeloupe-Snails---first-part.html, run_HMSC.R

Additional data:

	dry_final: contains sites states (i.e. dry or in water) for all sites, and for the 17 years (278 x 17).
		Note : encoded as : in water (1), dry (2) - for NA (0 or float between 0 and 1, reflecting probability of being in water, note used here)
		Only the first 250 have been used (others are not in Grande-Terre island)

		Scripts using these data: Guadeloupe-Snails---first-part.html, run_HMSC.R


	cov_unscale_no_habit: contains environmental variables (278 x 8)
		Note : detailed columns : size : size, veg : vegetation, connec : connectivity, litiere : litter, prof : depth, eau : water, stability : stability, ste : siteID

		Scripts using these data: Guadeloupe-Snails---first-part.html, run_HMSC.R


	sites_informations: contains sites informations (name, id, long/lat, island and habitat type - i.e. p : ponds, r : river, m : backmangrove)

		Scripts using these data: Guadeloupe-Snails---first-part.html, run_HMSC.R


	pluvio: contains cumulartive rainfalls for the rainy season, and little rainy season

		Scripts using these data: Guadeloupe-Snails---first-part.html, run_HMSC.R


	spatiotempo_mean_df.RDS: Contains precomputed mean beta diversities in space and time - see Guadeloupe-Snails---first-part.html for details.

		Scripts using these data: Guadeloupe-Snails---first-part.html


Results files:

	model_probit_Xb.RDS : compressed raw outputs (3 files) from Hmsc.	

		Scripts using these data: Guadeloupe-Snails---second-part--HMSC-.html, R2_hmsc.R
		(available on demand to corresponding authors - these three files are too large - 1.5Go each, to be stocked on GitHub)


	gwada_occ_Xb.RDS : compressed data used for HMSC (training & validation)

		Scripts using these data: R2_hmsc.R


	R2_interactions.RDS: compressed results for R2 HMSC training / validation

		Note : see R2_hmsc.R for computation (takes large amount of RAM)