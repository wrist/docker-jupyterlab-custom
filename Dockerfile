FROM jupyter/scipy-notebook
MAINTAINER Hiromasa OHASHI <stoicheia1986@gmail.com>

RUN pip install jupyterlab_git jupyterlab_code_formatter autopep8 black
RUN jupyter serverextension enable --py jupyterlab_git
RUN jupyter serverextension enable --py jupyterlab_code_formatter

RUN jupyter labextension install \
  @jupyterlab/toc @jupyterlab/git \
  @lckr/jupyterlab_variableinspector \
  @ryantam626/jupyterlab_code_formatter

RUN jupyter lab build
