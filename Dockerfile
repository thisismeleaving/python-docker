FROM debian:latest

RUN apt-get update && apt-get install -y \
    liblzma-dev \
    libbz2-dev \
    libreadline-dev \
    libssl-dev \
    libffi-dev \
    curl \
    python3 python3-pip \
    git 

RUN pip install pip --upgrade

RUN curl https://pyenv.run | bash

ENV PYENV_ROOT "/root/.pyenv"
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
RUN exec $SHELL

RUN eval "$(pyenv init --path)"

RUN pyenv install 3.9.6

RUN pyenv global system 3.9.6

RUN pip install pipenv

WORKDIR /app

COPY Pipfile .

RUN pipenv install --dev

CMD pipenv run python -c "import vaex; print('forget pancakes, eat waffles!')"
