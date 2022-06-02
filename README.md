Source for a blog post, [andrewgoldstone.com/blog/ru-casual2022](https://andrewgoldstone.com/blog/ru-casual2022). To render the R markdown file exactly as it is here, you would also have to install my [custom R markdown template](https://github.com/agoldst/hugormd): `devtools::install_github("agoldst/hugormd")`. Then run `make` to download the necessary data files from [IPEDS](https://nces.ed.gov/ipeds/datacenter/) and generate the output figures. The actual analysis code does not depend on my custom template.

Also included here:

[ipeds.R](https://github.com/agoldst/ru-casual2022/blob/master/ipeds.R): a few handy functions for downloading and loading IPDES data in R. It should be a package, but whatever.

[eap-notes.Rmd](https://github.com/agoldst/ru-casual2022/blob/master/eap-notes.Rmd): notes on the IPEDS EAP data and some of the identities that hold within and among its highly redundant variables.

[staffing2020.tsv](https://github.com/agoldst/ru-casual2022/blob/master/staffing2020.tsv): a TSV file with my calculations of the proportions of T/TT, full-time NTT, part-time adjunct, and graduate workers at each university and college in 2020–2021. I give counts and fractions in three categories: instructional, non-instructional, and total. To really scrutinize my analysis, please use the [actual code](https://github.com/agoldst/ru-casual2022/blob/master/ru-casual2022.Rmd), but this may be easier for quick exploration in a spreadsheet program. 
