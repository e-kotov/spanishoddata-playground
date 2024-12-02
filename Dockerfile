FROM ghcr.io/e-kotov/spanishoddata-playground:4.4.2

COPY --chown=${NB_USER} . ${HOME}
