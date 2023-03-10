FROM debian:stable

RUN apt update && apt install -y iptables conntrack
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy \
    && update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy