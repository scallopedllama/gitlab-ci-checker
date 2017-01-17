FROM ubuntu:latest

MAINTAINER Joe Balough, <jbb5044@gmail.com>

RUN apt-get update
RUN apt-get install -y build-essential libpcre3-dev curl python python-pygments lcov
RUN apt-get install -y vim doxygen graphviz
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# cppcheck based off walberla/cppcheck
RUN mkdir /cfg
RUN cd /tmp \
 && curl -L https://github.com/danmar/cppcheck/archive/master.tar.gz | tar xz \
 && cd cppcheck-master \
 && SRCDIR=build CFGDIR=/cfg HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function" make \
 && SRCDIR=build CFGDIR=/cfg HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function" make install \
 && cd \
 && rm -r /tmp/cppcheck-master

