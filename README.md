# Azure pipeline agent
Agent for .NET Core 2.1, 3.1 and npm builds (node 10.x). This build comparing to [original](https://hub.docker.com/_/microsoft-azure-pipelines-vsts-agent) (~10GB) is more compact and it is possible to customize dependencies for specific needs.

# Usage

- Create personal access token (PAT) (https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=preview-page)
  - Select following token options
    - **Agent Pools:** Read/Read & manage
    - **Build:** Read/Read & execute
    - **Code:** Read
    - **Work Items:** Read/Read & write (depends on the use)
- Create agent pool and setup security (https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?toc=%2Fazure%2Fdevops%2Forganizations%2Ftoc.json&bc=%2Fazure%2Fdevops%2Forganizations%2Fbreadcrumb%2Ftoc.json&view=azure-devops&tabs=yaml%2Cbrowser)

  

- To register agent
  - `docker-compose build`
  - `docker run -it --rm -v azure_agent:/home/agent azure-agent:latest /home/agent/config.sh` - this will trigger interactive registration process
  - `docker-compose up` or `docker-compose up -d`
- Volume **azure_agent** is used to store configuration after the registration process

## Dockerfile
Container is based on **centos:centos7** image. In general it installs and configures repositories required for the installations using **yum** package manager. Last phase is download and installation of the **azure agent** in the **/home/agent** folder. **Azure agent** scripts do not allow to run as root so container is started with **agent** user.
