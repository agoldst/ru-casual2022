Source for a blog post, [andrewgoldstone.com/blog/ru-casual2022](https://andrewgoldstone.com/blog/ru-casual2022). To render the R markdown file exactly as it is here, you would also have to install my [custom R markdown template](https://github.com/agoldst/hugormd): `devtools::install_github("agoldst/hugormd")`. Then run `make` to download the necessary data files from [IPEDS](https://nces.ed.gov/ipeds/datacenter/) and generate the output figures. The actual analysis code does not depend on my custom template.

Also included here:

[ipeds.R](https://github.com/agoldst/ru-casual2022/ipeds.R): a few handy functions for downloading and loading IPDES data in R. It should be a package, but whatever.

[ipeds.R](https://github.com/agoldst/ru-casual2022/eap-notes.Rmd): notes on the IPEDS EAP data and some of the identities that hold within and among its highly redundant variables.

