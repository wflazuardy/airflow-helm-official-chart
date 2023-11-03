CHART_NAME := apache-airflow/airflow
CHART_VALUES_FILE := values.yaml

PROJECT_NAMESPACE := airflow
POOL_NAME := default-pool
CLUSTER_NAME := data-team-cluster
ZONE := asia-southeast1-a


# Helm Chart
install-chart:
	helm upgrade --install $(PROJECT_NAMESPACE) $(CHART_NAME) -n $(PROJECT_NAMESPACE) \
	--debug

upgrade-chart:
	helm upgrade --install $(PROJECT_NAMESPACE) $(CHART_NAME) -n $(PROJECT_NAMESPACE) \
	-f $(CHART_VALUES_FILE) \
	--debug

get-values-file:
	helm show values $(CHART_NAME) > $(CHART_VALUES_FILE)


# GKE
shutdown-node-pool:
	gcloud container clusters resize $(CLUSTER_NAME) \
    --node-pool $(POOL_NAME) \
	--zone $(ZONE) \
    --num-nodes 0

up-node-pool:
	gcloud container clusters resize $(CLUSTER_NAME) \
    --node-pool $(POOL_NAME) \
	--zone $(ZONE) \
    --num-nodes 2