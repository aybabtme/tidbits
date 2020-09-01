
function install_lego() {
    local binname="lego"
    local version="3.8.0"
    local os="linux"
    local arch="amd64"
    local tarball="${binname}_v${version}_${os}_${arch}.tar.gz"
    local release_url="https://github.com/go-acme/${binname}/releases/download/v${version}/${tarball}"
    wget $release_url
    tar xvf $tarball
    cp $binname /usr/local/bin/$binname
    rm $tarball
}

function get_tls_certificate() {
    local do_api_token=$DO_TOKEN
    local dns_provider="digitalocean"
    local email=$ACME_EMAIL
    local domains="*.$WILDCARD_DOMAIN"
    local target="${data_dir}/.lego"
    local server=$ACME_SERVER

    DO_AUTH_TOKEN=$do_api_token lego \
        --email=$email \
        --domains=$domains \
        --dns=$dns_provider \
        --path=$target \
        --server=$server \
        --accept-tos \
        run
}