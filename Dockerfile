FROM jupyter/scipy-notebook:latest
MAINTAINER Hiromasa OHASHI <stoicheia1986@gmail.com>

RUN pip install --upgrade jupyterlab-git jupyterlab_code_formatter autopep8 black \
  sounddevice pyroomacoustics soundfile jupyter-server-proxy streamlit librosa voila
RUN jupyter serverextension enable --py jupyterlab_git
RUN jupyter serverextension enable --py jupyterlab_code_formatter

RUN conda install xeus-python -c conda-forge

RUN jupyter labextension install \
  @jupyterlab/toc \
  @lckr/jupyterlab_variableinspector \
  @ryantam626/jupyterlab_code_formatter \
  @axlair/jupyterlab_vim \
  @jupyterlab/debugger \
  @jupyterlab/server-proxy

RUN jupyter lab build

# for nikola
RUN pip install \
  'ghp-import2' \
  'webassets' \
  'Nikola[extras]'

# for pybind11
RUN pip install pybind11
RUN git clone https://github.com/aldanor/ipybind.git && cd ipybind && python setup.py build && python setup.py install

# for openfst
RUN conda install -c conda-forge openfst
#RUN pip install openfst-python

# install as root
USER root
RUN apt update && apt install -y graphviz

USER ${NB_USER}
