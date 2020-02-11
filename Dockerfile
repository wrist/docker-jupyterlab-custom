FROM jupyter/scipy-notebook
MAINTAINER Hiromasa OHASHI <stoicheia1986@gmail.com>

RUN pip install --upgrade jupyterlab-git jupyterlab_code_formatter autopep8 black
RUN jupyter serverextension enable --py jupyterlab_git
RUN jupyter serverextension enable --py jupyterlab_code_formatter

RUN jupyter labextension install \
  @jupyterlab/toc \
  @lckr/jupyterlab_variableinspector \
  @ryantam626/jupyterlab_code_formatter \
  jupyterlab_vim

RUN jupyter lab build

# for nikola
RUN pip install \
  'ghp-import2' \
  'webassets' \
  'Nikola[extras]'
