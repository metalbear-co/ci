FROM debian:stable as builder
# We need to build our own conntrack since -U is broken and fixe only in main https://git.netfilter.org/conntrack-tools/commit/?id=a7abf3f5dc7c43f0b25f1d38f754ffc44da54687
RUN apt update && apt install -y gcc bison flex autoconf automake libtool make pkg-config check g++ git libnfnetlink-dev libmnl-dev libnetfilter-conntrack-dev libnetfilter-cttimeout-dev libnetfilter-cthelper-dev libnetfilter-queue-dev libtirpc-dev
WORKDIR /conntrack
RUN git clone git://git.netfilter.org/conntrack-tools
# Current master head
WORKDIR /conntrack/conntrack-tools
RUN git checkout d417ceaa947c5f7f5d691037d0abe1deca957313
RUN ./autogen.sh && ./configure && make

FROM debian:stable as runtime

COPY --from=builder /conntrack/conntrack-tools/src/conntrack /usr/sbin/conntrack
# iproute2 for using ss to flush
RUN apt update && apt install -y iptables iproute2
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy \
    && update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy