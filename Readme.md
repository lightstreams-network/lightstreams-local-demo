# Lightstreams Local Demo

This project will setup and run a local cluster of Blockchain and IPFS nodes.

- Layer 1 - A network of Ethereum blockchain nodes with Tendermint consensus.
- Layer 2 - A network of IPFS nodes with Permissioned Access Control. 

## Requirements

1. Docker client
https://www.docker.com/products/docker-desktop/

2. Kebernetes Controller (kubectl)
https://kubernetes.io/docs/tasks/tools/

3. Minikube
https://minikube.sigs.k8s.io/

4. Helm
https://helm.sh/docs/intro/install/

## Setup

1. Clone this github repository
```
$ git clone git@github.com:lightstreams-network/lightstreams-local-demo.git
$ cd lightstreams-local-demo
```

2. Start Minikube
```
$ minikube start --memory=4096 --cpus=2
```

3. Create Lightchain Validators
```
$ helm install validators ./validators
```

4. Create Lightchain Agents
```
$ helm install agents ./agents
```

5. In new consoles, launch the agent apps:
```
$ minikube service agent-node1
$ minikube service agent-node2
$ minikube service agent-node3
$ minikube service agent-node4
```

## Clean up

1. Uninstall helm charts
```
$ helm uninstall agents
$ helm uninstall validators
```

2. Delete minikube cluster
```
$ minikube delete --all
```

### Troubleshooting

1. Ensure the pods are running
```
$ kubectl get pods
```

2. Check the state of the pods and logs
```
$ kubectl describe pod <podName>
$ kubectl log -f <podName>
```

## Connect IPFS to the cluster

1. Download IPFS version 0.4.18 for your OS
https://github.com/ipfs/kubo/releases/tag/v0.4.18

Example for macOS:
```
$ wget "https://github.com/ipfs/kubo/releases/download/v0.4.18/go-ipfs_v0.4.18_darwin-amd64.tar.gz" 
$ tar -xzvf go-ipfs_v0.4.18_darwin-amd64.tar.gz
$ mv ./go-ipfs/ipfs /usr/local/bin/ipfs
$ chmod u+x /usr/local/bin/ipfs
```

2. Install and run ipfs
```
$ ipfs init 
$ ipfs daemon
```

3. Create tunnel to cluster 
```
$ minikube service agent-node1-ipfs --url
```

4. In another console:
```
$ kubectl port-forward svc/agent-node1-ipfs 4002:4002
```

5.  In another console:
```
$ ipfs swarm connect /ip4/127.0.0.1/tcp/4002/ipfs/QmbrCC1nUnyGYzPuLHdu31mQG8Qf17trdDYqfnqxYtdAmG
```

Then you can pull a file:
```
$ ipfs cat Qmd...
```


