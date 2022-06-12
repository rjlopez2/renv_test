FROM rocker/verse:4.1.1

RUN apt-get update -y && apt-get install -y libtiff5-dev libwebp-dev libzstd-dev

ENV BUILD_DATE=2022-04-06
RUN MRAN=https://mran.microsoft.com/snapshot/${BUILD_DATE} \
#RUN MRAN=https://mran.revolutionanalytics.com/snapshot/${BUILD_DATE} \
  && echo MRAN=$MRAN >> /etc/environment \
  && export MRAN=$MRAN \
  && echo "options(repos = c(CRAN='$MRAN'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site

RUN Rscript -e 'options(timeout=2.4e6)'

WORKDIR /home/rstudio

RUN R -e "install.packages('remotes')"
