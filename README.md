# OAI gNb

The `aether-oai` repository allows OAI RAN (both physical and simulated) to work with the Aether core using Docker.
It has been tested in simulation mode and with USRP X310 as the RAN hardware.

To download the 'aether-oai' repository, use the following command:
```
git clone https://github.com/opennetworkinglab/aether-oai.git
```

## Step-by-Step Installation
To install oai-gNb, follow these steps:

1. Install Docker by running `make oai-docker-install`.
2. Configure the network for oai-gNb:
   - Set the "data_iface" parameter to the network interface name of the machine.
   - Set "network.name" to the name of the Docker network to be created.
   - Set "network.bridge.name" to the name of the interface to be created.
   - Set "subnet", which should correspond to the "ran_subnet" of 5g-core or the machine's subnet.
   - run `oai-router-install` to create the network.
      - To remove the network, run `oai-router-remove`.
3. Start the OAI-gNb Docker containers:
   - Set the container image "gNbimage" for gNb.
   - Set "simulation" to true to run in simulation mode.
   - Set "conf_file" path for coresponding conf file for gNb i.e for simulation/physical.
   - Set "ip" for gNb container, it should in same subnet as network.
   - Set "core.amf.ip" with IP address of Aether core.
   - Start docker container using `make oai-gNb-install`.
      - To stop the gNb, run `make oai-gNb-stop`.  
4. Start the UE simulation:
   - Set the container image "uEimage" for UeSimulation.
   - Set "network" same as the network name used for gNb.
   - Set "gnb.ip" with the IP address of the gNb container.
   - Set "simulation" to true to run in simulation mode.
   - Set "conf_file" path for coresponding conf file for UeSimulation.
   - Run `make oai-uEsim-start`.
      - To stop the UE simulation, run `make oai-uEsim-stop`.
5. Check the results:
   - Enter the UE Docker container using `docker exec -it rfsim5g-oai-nr-ue bash`.
   - Use `ping -I oaitun_ue1 google.com -c 2` to view the success result.

### One-Step Installation
To install OAI gNb in one go, run `make aether-oai-gNb-install`.

### Uninstall
To uninstall OAI gNb, run `make aether-oai-gNb-install`.
