FROM ubuntu:18.04



RUN apt-get update -y && apt-get install -y \
    apt-utils \
    bzip2 \
    gcc \
    make \
    ncurses-dev \
    wget \
    zlib1g-dev


ENV SOFT=/soft

RUN mkdir -p $SOFT
WORKDIR $SOFT

#Conda для Biobambam
ENV CONDA=$SOFT/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p $CONDA

ENV PATH=$CONDA/bin:$PATH


#Biobambam
RUN conda install -c bioconda biobambam
ENV BIOBAMBAM=$CONDA/pkgs/biobambam-2.0.87-h516909a_2/bin
ENV PATH=$BIOBAMBAM:$PATH





#Samtools-1.15.1
COPY samtools-1.15.1 $SOFT/samtools-1.15.1

RUN apt-get install -y libbz2-dev
RUN cd $SOFT/samtools-1.15.1/ && \
    ./configure --without-curses --disable-lzma && \
    make && \
    make install








