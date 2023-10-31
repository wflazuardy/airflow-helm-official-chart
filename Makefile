PROJECT_NAMESPACE := airflow
CHART_NAME := apache-airflow/airflow
CHART_VALUES_FILE := values.yaml

install-chart:
	helm upgrade --install $(PROJECT_NAMESPACE) $(CHART_NAME) -n $(PROJECT_NAMESPACE) \
	--debug

upgrade-chart:
	helm upgrade --install $(PROJECT_NAMESPACE) $(CHART_NAME) -n $(PROJECT_NAMESPACE) \
	-f $(CHART_VALUES_FILE) \
	--debug

get-values-file:
	helm show values $(CHART_NAME) > $(CHART_VALUES_FILE)