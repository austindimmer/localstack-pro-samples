#!/usr/env bash

echo "Hello from our entrypoint!"

# docker-init.sh will start up the Docker Engine 

# . /usr/local/share/docker-init.sh

git submodule update --init --recursive && rush update

mkdir -p /home/node/.aws
ln -s /home/node/.aws /workspaces/localstack-pro-samples/.aws
touch /home/node/.aws/credentials
touch /home/node/.aws/config
sudo chmod -R 765 /home/node/.aws
sudo chown -R node /home/node/.aws
cat <<EOF > /home/node/.aws/credentials
[default]
region = eu-west-1
output = json
EOF

cat <<EOF > /home/node/.aws/config
[default]
output=json
region = eu-west-1
EOF

# https://github.com/microsoft/vscode-dev-containers/tree/main/containers/kubernetes-helm-minikube
minikube start & > minikube.log 2>&1

# https://github.com/microsoft/vscode-dev-containers/blob/main/containers/python-3-anaconda/README.md
jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root &

# thisFolder=$(dirname $0)

# if [ -d "${thisFolder}/../.vscode" ]; then
#     echo ".vscode folder already exists. Will not overwrite."
# else
#     cp -r "${thisFolder}/.vscode" "${thisFolder}/../"
# fi

exec "$@"