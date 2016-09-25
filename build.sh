#!/bin/bash
build()
{
if rpm -q pungi > /dev/null; 
then 
echo "Found pungi! Starting build..."; 
pungi --nosource --nodebuginfo -G -C -B --flavor Amahi --name Amahi --ver 10 -c amahi.ks --isfinal && pungi --nosource --nodebuginfo -I --flavor Amahi --name Amahi --ver 10 -c amahi.ks --isfinal
else
dnf install pungi -y
build
fi
}
build
