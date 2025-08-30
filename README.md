# Hub and Spoke Network with transitivity - Azure - Terraform 

<img width="847" height="662" alt="image" src="https://github.com/user-attachments/assets/d30a1450-f08c-42f3-a353-756ddb44ed71" />


Virtual networks, are logically segmented in Azure, and are microsoft internal routed networks. Meaning they can seamlessly communicate with the resources that are present in the individual Virtual networks. 

One of the caviats with V-nets is that one Vnet can't communicate with other V-net even if they are in the same resource group. In scenarios where we need to enable seamless communication between resources in two different Vnet's, this causes an issue. This is the main reason for our use case Vnet peering.

When we "Peer" two different virtual networks, the resources within the two different virtual networks can seamlessly communicate with each other - To and Fro.

But Vnet Peering is "Non transitive", meaning if vnet1 is peered to vnet2, and vnet2 is peered with vnet3 this does not mean that vnet1 and vnet3 can communicate. 

For bypassing these issues, we can have an efficient hub and spoke vnet configuration. The hub is connected to a Vnet gateway which acts like a router for transferring messages between different Vnets by using Hub as an intermediary. This will solve our issue, incase we wan't resources in different vnets to communcate at the same time.

Here we have a Terraform code, that provisions our "Hub and Spoke" Architecture.

Here one acts as a Hub (peered with every vnet). This Common virtual network (Hub) is connected to a VPN Gatway. This VPN Gateway acts like a router in order to route traffic between the 5 different virtual networks which are peered to the common Virtual Network enabling transitivity and bypassing the restriction non transitivity.

"Hub and Spoke networks" are much more efficient than making a "Mesh" network which has a lot of complexity involved while scaling up.
