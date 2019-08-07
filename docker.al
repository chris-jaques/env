#!/bin/sh
#
# Docker
#
#

# Install Docker
i_docker(){
	#[[ -z $1 ]] && version='latest' || version=$1
	# download and install docker into '/usr/bin'
	tag=`curl -Ls -o /dev/null -w %{url_effective} https://github.com/docker/docker-ce/releases/latest`
	tag=${tag##*/}
	version=${tag:1}
	wget "https://download.docker.com/linux/static/stable/x86_64/docker-${version}.tgz"
	tar -xvzf docker-${version}.tgz
	rsync docker/* /usr/bin/
	# create docker group
	groupadd docker
	usermod -aG docker $USER
	rm docker-${version}.tgz
	rm -rf docker/
	# add systemd scripts for docker deamon
	wget 'https://raw.githubusercontent.com/docker/docker/master/contrib/init/systemd/docker.service'
	wget 'https://raw.githubusercontent.com/docker/docker/master/contrib/init/systemd/docker.socket'
	mv docker.service docker.socket /etc/systemd/system/
	systemctl enable docker
	systemctl start docker
	# install docker-compose
	i_docker-compose
	# verify
	docker --version
	docker-compose --version
}

# Install Docker-Compose
i_dockercompose(){
	tag=`curl -Ls -o /dev/null -w %{url_effective} https://github.com/docker/compose/releases/latest`
	tag=${tag##*/}
	curl -L "https://github.com/docker/compose/releases/download/${tag}/docker-compose-`uname -s`-`uname -m`" > docker-compose
	mv docker-compose /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
}


# docker
alias d="docker"

# docker-compose up
alias dcu="docker-compose up"

# docker-compose up detached
alias dcud="dcu -d"

# docker-compose up --build
alias dcub="dcu --build"

# docker-compose up --build detached
alias dcubd="dcub -d"

# docker-compose down
alias dcd="docker-compose down"

# docker build
alias db="docker build"

# docker build tag
alias dbt="db . -t"

# docker run and cleanup
alias dr="docker run --rm"

# docker run and cleanup - interactive
alias dri="docker run -it --rm"

# Spin up a container, ssh into it and mount the env { image } { command=/bin/bash } { ...extraTags? }
dssh(){
	[ -z "$2" ] && cmd='/bin/bash' || cmd="$2"

	# Copy the command to activate the env inside the container
	# Now you can just <paste> + enter and it's activated
	echo '. ~/env/loadEnv' | cbcopy

	dr -it \
	-v $(e;pwd):/root/env \
	${@:3} \
	"$1" \
	$cmd
}

# ssh into a container and run bash { image } { ...extraTags? }
dbash(){
	dssh $1 /bin/bash ${@:2}
}

# ssh into a container and run sh { image } { ...extraTags? }
dsh(){
	dssh $1 /bin/sh ${@:2}
}

# Run Bash on Docker-Compose Service { serviceName }
dcbash(){
	docker-compose exec $1 /bin/bash
}

# Run sh on Docker-Compose Service { serviceName }
dcsh(){
	docker-compose exec $1 /bin/sh
}

# Dockerized npm. Run npm on the current directory, from within a Docker container { command }
dnpm(){
	dri -v $(pwd):/npm -w /npm -u $(id -u) node npm "${@:1}"
}
