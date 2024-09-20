#!/usr/bin/env bash
helm install grafana grafana/grafana \
--set persistence.enabled=true \
--set persistence.existingClaim=grafana \
--set service.type=LoadBalancer \
--set securityContext.runAsUser=1000 \
--set securityContext.runAsGroup=1000 \
--set adminPassword="admin"
