# this will get the IPUMS extract
Sys.getenv("IPUMS_API_KEY")
#install.packages("ipumsr")
remotes::install_github(  "ipums/ipumsr",   build_vignettes = FALSE,   dependencies = TRUE)

# See https://tech.popdata.org/ipumsr/dev/articles/ipums-api.html#sharing-an-extract-definition-1 for more details.
library(ipumsr)
basepath <- "."
datapath <- file.path(basepath)

# Recover the extract specification
submitmyextract <- function(arg) {
  extract.spec <- file.path(basepath,paste0("author-extract-",arg,".Rds"))
  clone_extract <- define_extract_from_json(
    file.path(basepath,paste0("ipums-api-extract-",arg,".json")))
  
  if ( file.exists(extract.spec)) {
    submitted_extract <- readRDS(extract.spec)
  } else {
    # Submit the extract
    submitted_extract <- submit_extract(clone_extract)
    saveRDS(submitted_extract,extract.spec)
  }
  # Provide summary info on the submitted extract
  print(submitted_extract)
}

# wait for the extracts
waitextracts <- function(arg) {
 
  extract.spec <- file.path(basepath,paste0("author-extract-",arg,".Rds"))
  if (! file.exists(extract.spec)) {
    # Don't know what to do
    message(paste0("Not sure what to do, ",extract.spec," does not exist"))
  } else {
    submitted_extract <- readRDS(extract.spec)
    # Provide summary info on the submitted extract
    print(submitted_extract)
    
    # Initial status
    get_extract_info(submitted_extract)$status
    # This will continue waiting for the extract to be created
    downloadable_extract <- wait_for_extract(submitted_extract)
    # when that finishes, we can save it.
    path_to_ddi_file <- download_extract(downloadable_extract,
                                         download_dir=datapath,
                                         overwrite = TRUE)
  }
}

args <- c("58","59","60","67","68","70")
sapply(args,submitmyextract)

sessionInfo()
