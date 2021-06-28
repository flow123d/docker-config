# Simple makefile for building and packaging project

library       = mpich
url=http://flow.nti.tul.cz/libraries/mpich-${version}.tar.gz
base_name=mpich-$(version)
configure_options= \
	--enable-fast=O3,ndebug \
	--disable-error-checking \
	--without-timing \
	--without-mpit-pvars \
	--with-device=ch4:ofi 


include ../common_configure.mk

