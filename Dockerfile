FROM centos:centos7
# repository initialization
RUN yum -y update \
	&& curl -s https://rpm.nodesource.com/setup_10.x --output /tmp/setup.sh \
	&& chmod 700 /tmp/setup.sh \
	&& bash /tmp/setup.sh \
	&& rm /tmp/setup.sh \
	&& rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm \
	&& yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm

# package installation
RUN  yum install -y  dotnet-sdk-2.1 \
		dotnet-sdk-3.1 \
		aspnetcore-runtime-2.1 \
		aspnetcore-runtime-3.1 \			
		nodejs \
		git

ARG VSTS_AGENT_PACKAGE=vsts-agent-linux-x64-2.170.1.tar.gz
RUN useradd agent
WORKDIR /home/agent/
# download azure agent package for linux and install in home directory
RUN curl https://vstsagentpackage.azureedge.net/agent/2.170.1/$VSTS_AGENT_PACKAGE --output $VSTS_AGENT_PACKAGE \
	&& tar zxvf $VSTS_AGENT_PACKAGE \
	&& rm $VSTS_AGENT_PACKAGE \
	&& chown -R agent:agent /home/agent/

USER agent
# use cmd instead of entrypoint to allow override and process registration		
CMD ["/home/agent/run.sh"]