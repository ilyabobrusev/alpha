ETCD_VER=v3.4.14

# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

rm -f /task13/etcd-${ETCD_VER}-linux-amd64.tar.gz
rm -rf /task13/etcd/ && mkdir -p /task13/etcd/

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /task13/etcd-${ETCD_VER}-linux-amd64.tar.gz
tar xzvf /task13/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /task13/etcd --strip-components=1
rm -f /task13/etcd-${ETCD_VER}-linux-amd64.tar.gz

/task13/etcd/etcd --version
/task13/etcd/etcdctl version