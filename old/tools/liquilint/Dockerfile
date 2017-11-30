FROM rocker/ropensci:latest

#RUN rm -vfr /var/lib/apt/lists/*

#RUN apt-get update && apt-get -y upgrade && apt-get install -y \
	
#RUN rm -rf /tmp/*.rds && \
#	apt-get autoclean

RUN install2.r --error \
  argparser \
  selectr

WORKDIR /home/rstudio
EXPOSE 8787
