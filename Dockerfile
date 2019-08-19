FROM sonatype/nexus3:3.18.1

ARG NEXUS_VERSION=3.18.1
ARG NEXUS_BUILD=01
ARG HELM_VERSION=0.0.11
ARG COMP_VERSION=1.18
ARG TARGET_DIR=/opt/sonatype/nexus/system/org/sonatype/nexus/plugins/nexus-repository-helm/${HELM_VERSION}/
USER root
RUN mkdir -p ${TARGET_DIR}; \
    sed -i 's@nexus-repository-maven</feature>@nexus-repository-maven</feature>\n        <feature prerequisite="false" dependency="false">nexus-repository-helm</feature>@g' /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/${NEXUS_VERSION}-${NEXUS_BUILD}/nexus-core-feature-${NEXUS_VERSION}-${NEXUS_BUILD}-features.xml; \
    sed -i 's@<feature name="nexus-repository-maven"@<feature name="nexus-repository-helm" description="org.sonatype.nexus.plugins:nexus-repository-helm" version="'"${HELM_VERSION}"'">\n        <details>org.sonatype.nexus.plugins:nexus-repository-helm</details>\n        <bundle>mvn:org.sonatype.nexus.plugins/nexus-repository-helm/'"${HELM_VERSION}"'</bundle>\n        <bundle>mvn:org.apache.commons/commons-compress/'"${COMP_VERSION}"'</bundle>\n   </feature>\n    <feature name="nexus-repository-maven"@g' /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/${NEXUS_VERSION}-${NEXUS_BUILD}/nexus-core-feature-${NEXUS_VERSION}-${NEXUS_BUILD}-features.xml;
COPY nexus-repository-helm-${HELM_VERSION}.jar ${TARGET_DIR}

RUN ls -all ${TARGET_DIR} && ls -all /opt/sonatype/nexus/system/org/sonatype/nexus/plugins/

USER nexus


