#!/usr/bin/env bash
helm install prometheus prometheus-community/prometheus \
--set prometheus-pushgateway.enabled=false \
--set alertmanager.enabled=false \
--set nodeExporter.tolerations[0].key=node-role.kubernetes.io/control-plane \
--set nodeExporter.tolerations[0].effect=NoSchedule \
--set nodeExporter.tolerations[0].operator=Exists \
--set server.persistentVolume.existingClaim="prometheus-server" \
--set server.securityContext.runAsGroup=1000 \
--set server.securityContext.runAsUser=1000 \
--set server.service.type="LoadBalancer" \
--set server.extraFlags[0]="storage.tsdb.no-lockfile"
