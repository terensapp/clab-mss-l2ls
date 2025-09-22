# Containerlab On ACT Topology
This is a topology built for Arista Cloud Test (ACT)

It brings the best of both worlds of push button IaaS with ACT and the ease of use & broad community of ContainerLab (clab)

This topology bonds both of these awesome tools by leveraging ACT to easily spin up the infrastructure and ease of deployment of Arista CloudVision Portal (CVP) and Arista CloudEOS and gives you the flexibility to deploy virtually ANY firewall or third party device that can run on KVM.

ACT leverages a management network which is exposed on the tun0 interface of the tool server, this is the network clab will also use for the management network.

If you want to connect native ACT devices into the clab topology, the act-clab.sh script can be used/modified to suit to build necessary bridges to accomodate the connectivity, simply copy the script to the tool server and execute it and it'll build four bridges back to the spines: 2 links to the ZTX (cloudeos) device and 2 links to the FW (byod) device.

This topology was also built to support static MSS policies, for more information please contact your Arista SE.
