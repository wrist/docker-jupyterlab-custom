FROM jupyter/scipy-notebook:latest
LABEL maintainer="Hiromasa OHASHI <stoicheia1986@gmail.com>"

# install as root
USER root
RUN apt update && apt install -y build-essential

USER ${NB_USER}


RUN pip install --upgrade jupyter-packaging cookiecutter jupyterlab-git jupyterlab_code_formatter autopep8 black \
  sounddevice pyroomacoustics soundfile jupyter-server-proxy streamlit librosa voila jupyterlab_vim jupyterlite
RUN jupyter serverextension enable --py jupyterlab_code_formatter

RUN mamba install -y micromamba boa -c conda-forge
RUN mamba install -y xeus-python -c conda-forge

RUN jupyter labextension install \
  #@lckr/jupyterlab_variableinspector \
  @ryantam626/jupyterlab_code_formatter \
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
RUN mamba install -y -c conda-forge openfst
#RUN pip install openfst-python

# octave kernel
RUN pip install octave_kernel
RUN pip install oct2py

# install as root
USER root
RUN apt update && apt install -y graphviz octave gnuplot curl libzmq3-dev cmake

USER ${NB_USER}

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain=stable -y
ENV PATH $PATH:$HOME/.cargo/bin
RUN cargo install evcxr_jupyter
RUN evcxr_jupyter --install
RUN echo '. $HOME/.cargo/env' >> ~/.bashrc \
  echo '. $HOME/.cargo/env' >> ~/.profile
RUN source $HOME/.cargo/env

# scheme
RUN pip install --upgrade calysto-scheme
RUN python -m calysto_scheme install --user
