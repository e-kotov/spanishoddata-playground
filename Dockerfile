FROM ghcr.io/e-kotov/spanishoddata-playground:latest

COPY --chown=${NB_USER} . ${HOME}
