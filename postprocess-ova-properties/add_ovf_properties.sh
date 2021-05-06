#!/bin/bash

# Original Script from: https://github.com/lamw/vcenter-event-broker-appliance / William Lam

OUTPUT_PATH="../output-${APPLIANCE_NAME}"

rm -f ${OUTPUT_PATH}/${APPLIANCE_NAME}.mf

sed "s/{{APPLIANCE_VERSION}}/${APPLIANCE_VERSION}/g" appliance.xml.template > appliance.xml

if [ "$(uname)" == "Darwin" ]; then
    sed -i .bak1 's/<VirtualHardwareSection>/<VirtualHardwareSection ovf:transport="com.vmware.guestInfo">/g' ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf
    sed -i .bak2 "/    <\/vmw:BootOrderSection>/ r appliance.xml" ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf
    sed -i .bak3 '/^      <vmw:ExtraConfig ovf:required="false" vmw:key="nvram".*$/d' ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf
    sed -i .bak4 "/^    <File ovf:href=\"${APPLIANCE_NAME}-file1.nvram\".*$/d" ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf
else
    sed -i 's/<VirtualHardwareSection>/<VirtualHardwareSection ovf:transport="com.vmware.guestInfo">/g' ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf
    sed -i "/    <\/vmw:BootOrderSection>/ r appliance.xml" ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf
    sed -i '/^      <vmw:ExtraConfig ovf:required="false" vmw:key="nvram".*$/d' ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf
    sed -i "/^    <File ovf:href=\"${APPLIANCE_NAME}-file1.nvram\".*$/d" ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf
fi

ovftool ${OUTPUT_PATH}/${APPLIANCE_NAME}.ovf ${OUTPUT_PATH}/${APPLIANCE_NAME}.ova
rm -f appliance.xml
