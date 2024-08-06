FROM php:8.2-fpm-bookworm

ENV DEBIAN_FRONTEND=noninteractive

COPY ./set_perm.sh /set_perm.sh

ARG USER_ID
ARG GROUP_ID
RUN echo "Create group app" && \
    groupadd -g ${GROUP_ID} app && \
    \
    echo "Create user app in group app" && \
    useradd -u ${USER_ID} -m app -g app && \
    \
    echo "Set up umask for app user (running console commands)" && \
    echo "umask 002" >> /home/app/.bashrc && \
    \
    echo "Set up umask for root user (running php-fpm)" && \
    echo "It works as set umask for www-data" && \
    echo "umask 002" >> /root/.bashrc && \
    \
    echo "Install composer" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php &&\
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    \
    echo "Create file with bash commands history" && \
    mkdir /commandhistory && \
    touch /commandhistory/.bash_history && \
    chown -R app:app /commandhistory && \
    echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" >> "/home/app/.bashrc" && \
    \
    echo "Run apt update before install every time" && \
    apt-get update && \
    \
    echo "Install gettext extension" && \
    docker-php-ext-install gettext && \
    \
    echo "Install zip extension" && \
    apt-get install --no-install-recommends -y \
        zlib1g-dev \
        libzip-dev \
        unzip && \
    docker-php-ext-install zip && \
    \
    echo "Install intl extension" && \
    apt-get install libicu-dev --no-install-recommends -y && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    \
    echo "Install mysql extension" && \
    docker-php-ext-install pdo_mysql && \
    \
    echo "Install pgsql extension" && \
    apt-get install libpq-dev -y --no-install-recommends && \
    docker-php-ext-install pdo_pgsql && \
    \
    echo "Install math extension" && \
    docker-php-ext-install bcmath && \
    \
    echo "Set permissions for script" && \
    chown app:app /set_perm.sh && \
    chmod u+x /set_perm.sh && \
    \
    echo "Install acl. Without acl system will not follow advanced acl permissions config" && \
    apt-get install acl -y --no-install-recommends && \
    \
    echo "adding nvm.sh to .bashrc to run nvm every login. It will set up nodejs version" && \
    echo "source /home/app/.nvm/nvm.sh" >> ~/.bashrc

USER app
ARG VERSION_NODE=20.14.0
ARG NPM_MIRROR
RUN echo "downloading and installing nvm" && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    \
    echo "installing node, npm" && \
    \
    echo "making nvm command available" && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \
    . "$NVM_DIR/nvm.sh" && \
    \
    echo "installing node" && \
    nvm install ${VERSION_NODE} && \
    \
    echo "setting up nodejs version" && \
    nvm use ${VERSION_NODE} && \
    \
    echo "adding nvm.sh to .bashrc to run it every login. It set up nodejs version" && \
    echo "source /home/app/.nvm/nvm.sh" >> /home/app/.bashrc && \
    \
    echo "add node to path. Now can use npm" && \
    export PATH="${PATH}:/home/app/.nvm/versions/node/v${VERSION_NODE}/bin" && \
    \
    echo "some settings to prevent connection timeout error" && \
    npm config set registry="${NPM_MIRROR}" && \
    \
    echo "default fetch-retry-maxtimeout=60000" && \
    npm config set fetch-retry-maxtimeout=240000 && \
    \
    echo "default fetch-retry-mintimeout=10000" && \
    npm config set fetch-retry-mintimeout=40000 && \
    \
    echo "default fetch-timeout=300000" && \
    npm config set fetch-timeout=1200000 && \
    \
    echo "default fetch-retries=2" && \
    npm config set fetch-retries=8 && \
    \
    echo "default fetch-retry-factor=10" && \
    npm config set fetch-retry-factor=40 && \
    \
    echo "default maxsockets=15" && \
    npm config set maxsockets=4 && \
    \
    echo "default prefer-offline=false" && \
    npm config set prefer-offline=true && \
    \
    echo "default strict-ssl=true" && \
    npm config set strict-ssl=false && \
    \
    npm config rm proxy && \
    npm config rm https-proxy
