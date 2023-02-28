<a href="https://karn.io">
   <img src="https://via.placeholder.com/150" alt="eSkarnhop logo" title="karn" align="right" height="60" />
</a>

# KARN - K(ubernetes) And R(PA) N(ext-gen)

KARN reference documentation.

## Introduction

KARN is new a cloud-native stack that runs Business Process Management (BPM) and Robotic Process Automation (RPA) on top of Kubernetes.

Combining BPM and RPA can bring numerous benefits to organizations. Some of these benefits include:

- Increased Efficiency: BPM and RPA combined can automate and streamline processes, leading to improved efficiency and reduced manual effort. By automating repetitive, rule-based tasks with RPA, organizations can free up human resources to focus on more complex, value-added activities.

- Improved Quality: The use of BPM and RPA can help reduce errors, improve accuracy, and enhance the overall quality of business processes. Automation can eliminate the risk of human error, and BPM can help ensure that processes are consistent and adhere to best practices.

- Better Customer Experience: By automating processes with RPA, organizations can provide faster and more consistent service to customers, leading to a better overall experience.

- Increased Agility: The combination of BPM and RPA can enable organizations to quickly adapt to changing business requirements and respond to market demands in a timely manner.

- Enhanced Analytics: By automating processes with BPM and RPA, organizations can capture and analyze data more efficiently, providing greater insights into operational performance and enabling data-driven decision making.

Overall, the combination of BPM and RPA can lead to significant cost savings, improved efficiency, and better business outcomes for organizations.

## Getting Started

Make sure you have installed [Docker](https://docs.docker.com/docker-for-windows/install/) and enable your [local Kubernetes](https://github.com/cderue/karn-doc/wiki/Deploy-to-Local-Kubernetes) cluster.
After that, install [HashiCorp Waypoint]([https://developer.hashicorp.com/waypoint/tutorials/get-started-docker/get-started-docker](https://developer.hashicorp.com/waypoint/tutorials/get-started-kubernetes/get-started-kubernetes)) in your Kubernetes cluster.
When the Waypoint Server is ready, run the below commands from the **/deploy/** directory to get started with `karn` immediately.

```powershell
waypoint init
waypoint up
```

You should be able to browse different components of the application by using the below URLs :

```
Karn Engine API : http://host.docker.internal/api/v1/engine/hc:8080/
Karn Agent API  : http://host.docker.internal/api/v1/agent/hc:5000/
```

>Note: If you are running this application in macOS then use `docker.for.mac.localhost` as DNS name in `.env` file and the above URLs instead of `host.docker.internal`.

Below are the other avenues to setup *karn*.

### Basic scenario

The basic scenario can be run locally using waypoint to deploy to Docker containers or to a local Kubernetes cluster. Refer to these Wiki pages to Get Started:

- [Local Kubernetes](https://github.com/dotnet-architecture/eShopOnContainers/wiki/Deploy-to-Local-Kubernetes)

### Advanced scenario

The Advanced scenario can be run only in a Kubernetes cluster. Currently, this scenario is the same as a basic scenario with the following differences:

- [Deploy to AKS with a Service Mesh for resiliency](https://github.com/dotnet-architecture/eShopOnContainers/wiki/Deploy-to-Azure-Kubernetes-Service-(AKS))

In the future, more features will be implemented in the advanced scenario.


## IMPORTANT NOTES!

**You must use the latest version of waypoint CLI**.

>
> ### DISCLAIMER
>
> **IMPORTANT:** The current state of KARN is **BETA**, because we are constantly evolving towards newly released technologies. Therefore, many areas could be improved and change significantly while refactoring the current code and implementing new features. Feedback with improvements and pull requests from the community will be highly appreciated and accepted.

### Architecture overview

This reference application is cross-platform at the server and client-side, thanks to Jave and Python services capable of running on Linux containers plus any browser for the client web app.
The architecture proposes a microservice oriented architecture implementation with multiple autonomous microservices (each one owning its own data/db) and implementing different framework within each microservice (Micronaut for Java services and FastAPI for Python services) using HTTP as the communication protocol between the client apps and the microservices and supports asynchronous communication for data updates propagation across multiple services based on Integration Events and an Event Bus (a light message broker, to choose between RabbitMQ or Azure Service Bus, underneath).

![](img/eshop_logo.png)
![](img/eShopOnContainers-architecture.png)

## Sending feedback and pull requests

Read the planned [Roadmap](https://github.com/cderue/karn/wiki/Roadmap) within the Wiki for further info about possible new implementations and provide feedback at the [ISSUES section](https://github.com/cderue/karn/issues) if you'd like to see any specific scenario implemented or improved. Also, feel free to discuss on any current issue.
