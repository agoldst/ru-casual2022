# Utility functions for getting IPEDS data files and reading them in tidily.
# Yes I know this hsould be a package. Leave me alone.

library(tidyverse)

# take a vector of zip file names, download and extract data where not already
# present, return a list of extracted files

get_ipeds_zip <- function (fs) {
    result <- fs
    names(result) <- fs
    for (zfile in fs) {
        if (!file.exists(zfile)) {
            url <- str_c("https://nces.ed.gov/ipeds/datacenter/data/",
                         basename(zfile))
            message("Downloading ", url)
            download.file(url, zfile)
            Sys.sleep(1) # don't shut down the federal government...'s server
        }
        flist <- unzip(zfile, list=T)[["Name"]]

        # check for presence of revised data;
        # derive extracted filename

        rv <- str_detect(flist, "_rv")
        if (sum(rv) > 1) {
            stop("More than one _rv file found.")
        }
        else if (sum(rv) == 1) {
            f <- flist[rv]
        } else {
            stopifnot(length(flist) == 1)
            f <- flist
        }
        f <- file.path(data_dir, f)

        if (!file.exists(f)) {
            message("Extracting  ", f)
            unzip(zfile, files=basename(f), exdir=data_dir)
        }
        result[zfile] <- f
    }
    result
}

get_ipeds <- function (prefix, years, suffix)
    get_ipeds_zip(file.path(data_dir, str_c(prefix, years, suffix, ".zip")))



load_series <- function (fs) tibble(filename=fs) %>%
    mutate(year=as.numeric(str_extract(filename, "\\d{4}"))) %>%
    mutate(frm=map(filename, read_csv)) %>%
    unnest(frm)

# given a dataframe x and column name (as string) varname, rewrite varname using IPEDS 
# data dictionary (values in coduevalue, labels in valuelabel

ipeds_label <- function (x, varname, dict) {
    dict <- dict %>% filter({{ varname }} == varname) %>%
        select(codevalue, valuelabel)

    # dplyr programming is too hard

    x[[varname]] <- as.character(x[[varname]])
    x <- inner_join(x, dict, by=setNames("codevalue", varname))
    x[[varname]] <- x$valuelabel
    x$valuelabel <- NULL
    x
}
        

