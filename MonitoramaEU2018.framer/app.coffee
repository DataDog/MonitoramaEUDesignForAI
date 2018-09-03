# METRIC ARRAY
metric_array = ["aws.advisor.service_limit.reserved.usage_ratio", "aws.advisor.service_limit.usage", "aws.advisor.service_limit.usage_ratio", "aws.apigateway.4xxerror", "aws.apigateway.5xxerror", "aws.apigateway.count", "aws.apigateway.integration_latency", "aws.apigateway.latency", "aws.apigateway.latency.maximum", "aws.apigateway.latency.minimum", "aws.applicationelb.active_connection_count", "aws.applicationelb.client_tlsnegotiation_error_count", "aws.applicationelb.healthy_host_count", "aws.applicationelb.healthy_host_count.maximum", "aws.applicationelb.healthy_host_count.minimum", "aws.applicationelb.healthy_host_count_deduped", "aws.applicationelb.httpcode_elb_4xx", "aws.applicationelb.httpcode_elb_5xx", "aws.applicationelb.httpcode_target_2xx", "aws.applicationelb.httpcode_target_3xx", "aws.applicationelb.httpcode_target_4xx", "aws.applicationelb.httpcode_target_5xx", "aws.applicationelb.ipv_6processed_bytes", "aws.applicationelb.ipv_6request_count", "aws.applicationelb.new_connection_count", "aws.applicationelb.processed_bytes", "aws.applicationelb.request_count", "aws.applicationelb.request_count_per_target", "aws.applicationelb.rule_evaluations", "aws.applicationelb.target_connection_error_count", "aws.applicationelb.target_response_time.average", "aws.applicationelb.target_response_time.maximum", "aws.applicationelb.target_response_time.p95", "aws.applicationelb.target_response_time.p99"]
metriclist_array = []
metriclist_array.push(metric)

# TARGET ARRAY
target_array = ["account:carcetti", "account:staging", "account:sheepdog-prod", "active", "active-alerting", "active-colvin", "active-delancie", "active-herc", "active-hms-resolver", "active-mcnulty", "active-nicky", "active-partlow", "active-read", "active-sobotka", "active-templeton", "active-wilson", "active-write", "ansible.group:destro", "ansible.group:resource-writer", "ansible.group:trace-loom", "ansible.group:trace-stats-aggregator", "ansible.group:trace-stats-aggregator-longterm", "ansible.group:trace-writer", "ansible.group:trace-writer-longterm", "ansible.managed:true", "ansible_managed:true", "automatic-restart:true", "autoscaling:true", "autoscaling_group:alerting-metric-evaluator-c32xlarge", "autoscaling_group:alerting-metric-evaluator-c34xlarge", "autoscaling_group:alerting-metric-evaluator-r32xlarge", "autoscaling_group:alerting-metric-evaluator-r3xlarge", "autoscaling_group:apm-kafka-1-zookeeper", "autoscaling_group:appgate-controller", "autoscaling_group:bunk-agent", "autoscaling_group:bunk-app", "autoscaling_group:consul-0002e2edf2485e7bf62d6b0977", "autoscaling_group:corgi-eu-00d6cac87c3ecb4f1746dcd560", "autoscaling_group:corgi-us-00d6cac87c3ecb4f1746dcd55f", "autoscaling_group:enclave-server-003b77c11d53c5ee2a9a8aa40d", "autoscaling_group:general-kafka-1-zookeeper", "autoscaling_group:gitlab-00c013eeb2758ae5ef30316a85", "autoscaling_group:gitlab-standby-00b684cbe515b64895a1ddf6ab", "autoscaling_group:gitsync-00c013eeb2758ae5ef30316a89", "autoscaling_group:jumpbox-00c013eeb2758ae5ef30316a86", "autoscaling_group:mcnulty-events"]
targetlist_array = []
targetlist_array.push(target)

## INITIALIZATION
flow = new FlowComponent
flow.showNext(HOME)

forecast_path2.visible = false
forecast_path3.visible = false
btn_anom_dev2.visible = false
btn_anom_dev3.visible = false
anom_graph2.visible = false
anom_graph3.visible = false
percentageB.visible = false
btn_anom_range2.visible = false
btn_feed_search2.visible = false
feed2.visible = false
btn_feed_search2.visible = false

# HOME SCREEN
trg_demo_static.onTapEnd ->
	flow.showNext(STATIC_HOME)
trg_demo_forecast.onTapEnd ->
	flow.showNext(FORECAST_HOME)
trg_demo_anomaly.onTapEnd ->
	flow.showNext(ANOMALY_HOME)
trg_demo_feed.onTapEnd ->
	flow.showNext(FEED)

# GROUPBY TOGGLE
for toggle in [toggle1]
	toggle.states.off =
		backgroundColor: "rgba(255, 255, 255, 0.5)"
for knob in [knob1]
	knob.states.off =
		x: 294
		shadowSpread: 1
		shadowColor: "rgba(0,0,0,0.2)"
row_groupby.states.off =
	y: 490
	opacity: 0
btn_conditions.states.off =
	y: 592
knob1.stateSwitch("off")
toggle.stateSwitch("off")
row_groupby.stateSwitch("off")
btn_conditions.stateSwitch("off")
row_group.onTap ->
	knob1.stateCycle(time: 0.3)
	toggle1.stateCycle(time: 0.3)
	row_groupby.stateCycle(time: 0.3)
	btn_conditions.stateCycle(time: 0.3)

# METRIC SCROLLCOMPONENT
metricScroll = new ScrollComponent
	x: 0
	y: 127
	width: 375
	height: 540
	scrollHorizontal: false
metricScroll.parent = STATIC_METRICS
metric_checkbox.parent = metricScroll.content
metric_checkbox.y = 25
metric.parent = metricScroll.content
metric.y = 0

yval = 80
for m in metric_array
	li = metric.copy()
	metriclist_array.push(li)
	li.parent = metricScroll.content
	li.y = yval
	if m.length < 35
		li.children[0].text = m
	else
		li.children[0].text = m.substring(0,35) + "..."
	yval+=80
	
#TARGET SCROLLCOMPONENT
targetScroll = new ScrollComponent
	x: 0
	y: 127
	width: 375
	height: 540
	scrollHorizontal: false
targetScroll.parent = STATIC_TARGETS
target_checkbox.parent = targetScroll.content
target_checkbox.y = 25
target.parent = targetScroll.content
target.y = 0

yval = 80
for t in target_array
	li = target.copy()
	targetlist_array.push(li)
	li.parent = targetScroll.content
	li.y = yval
	if t.length < 35
		li.children[0].text = t
	else
		li.children[0].text = t.substring(0,35) + "..."
	yval+=80

# LINEGRAPH SVG
linegraph = new Layer
	parent: STATIC_HOME
	x: Align.center
	y: 170
	width: 335
	backgroundColor: "null"
linegraph.html = """<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 335 100" style="enable-background:new 0 0 335 100;" xml:space="preserve"><path stroke-linejoin="round" fill="none" stroke="#3399cc" stroke-width="4" d="M0,91.6c3.6-1.1,7.2,0.4,10.8,0.5c3.9,0.1,7.4-0.2,11.1-1.1c3.9-1,7.3-0.5,11.2-0.3c3.9,0.2,7.3,1.3,11.1-0.2c2.1-0.8,3.6-2.5,5.6-3.4c0.8-0.4,2-1.2,2.8-1.3c1.5-0.2,1.6,0.5,2.8,1.4C59,90,62,91.7,66.6,91c3.9-0.6,7.6,0.1,11.5-0.3c3.7-0.4,7.4,0.3,11.2-0.1c3.8-0.4,7.7-0.2,11.5-0.4c3.7-0.2,7.4-0.8,11.2-1.1c3.9-0.3,7.3-0.7,11.1,0.4c3.9,1.1,7.3,3.5,11.2,4.4c4.5,1.1,6.9-2,11.1-2.5c4.1-0.5,6.9,3,11.2,1.7c0.8-0.2,2.2-0.5,2.8-1c1-0.9,1-2.3,1.2-3.9c1.1-6.4,2.3-12.9,3.2-19.3c1.4-9.4,1.7-19,2.4-28.5c0.8-9.8,1.4-19.5,2.9-29.2c0.3-2.1,0.4-4.8,1.3-6.7c1.2-2.7,1.7,0.6,2.1,2.4c1,4.5,1.6,9.2,2,13.8c0.9,9.5,2.2,19.4,4.4,28.6c0.4,1.5,0.8,5,2,6c0.9,0.8,1.6,0.3,2.8,0.2c1.8-0.2,3.9-0.2,5.6,0.4c1.9,0.7,7.6,7.9,9.6,9.9c1.4,1.4,3.3,2.3,5,3.2c3.4,1.7,6.6,4.3,10.4,5c-0.5,0.4,4.2,3,5.6,3.2c2.1,0.3,4.3-0.7,6.1-0.2c2.2,0.6,4.1,3.4,6.1,4.2c2.5,1.1,4-0.2,6.4-0.5c2.6-0.4,4.1,0.6,6.3,1.6c2,0.9,4.2,0.7,6.3,0.5c4.1-0.5,8.7,0.9,12.7,1.7c3.8,0.8,10.6,4.2,14.3,1.9c-0.4,0-0.8-0.3-1.2-0.3c2-0.9,3.6-3.4,5.6-4c1.6-0.5,4.2,1,5.5,1.9c2,1.4,3,2.5,5.5,2.7c2,0.2,4-0.4,6-0.5c3.7-0.3,7.3,0.4,11,0.4c2.4,0,3.6,0.1,5.6,1.4c1.9,1.2,4,2.9,6.3,2.9c2,0,4.2-1.1,6.2-1.4c2.2-0.4,4.2,0.2,6.3,0.9"/></svg>"""

linegraph2 = linegraph.copy()
linegraph2.parent = STATIC_THRESHOLDS
linegraph2.x = Align.center
linegraph2.y = 170
linegraph2.width = 335
linegraph2.backgroundColor = "null"

# STATIC THRESHOLD
drg_warn.z = 2
drg_alert.z = 2
drg_warn.draggable.enabled = true
drg_warn.draggable.horizontal = false
drg_warn.draggable.overdrag = false
drg_warn.draggable.pixelAlign = true
drg_warn.draggable.momentum = false
drg_warn.draggable.propagateEvents = false
drg_warn.draggable.constraints = 
	y: 70
	height: 170
drg_alert.draggable.enabled = true
drg_alert.draggable.horizontal = false
drg_alert.draggable.overdrag = false
drg_alert.draggable.pixelAlign = true
drg_alert.draggable.momentum = false
drg_alert.draggable.propagateEvents = false
drg_alert.draggable.constraints = 
	y: 70
	height: 170
drg_warn.on Events.DragMove, ->
    txt_warn.text = (-10*(drg_warn.y-70)/144+10).toFixed(1)
drg_alert.on Events.DragMove, ->
    txt_alert.text = (-10*(drg_alert.y-70)/144+10).toFixed(1)

# Events
row_metric.onTap ->
	flow.showNext(STATIC_METRICS)
row_target.onTap ->
	flow.showNext(STATIC_TARGETS)

# Select Metric
for m in metriclist_array
	m.onTap ->
		metric_checkbox.parent = this
		if this.children[0].text.length < 26
			row_metric_label.text = this.children[0].text 
		else
			row_metric_label.text = this.children[0].text.substring(0,26) + "..."
		flow.showPrevious()
metric_arrow.onTap ->
	flow.showPrevious()

# Select Target
for t in targetlist_array
	t.onTap ->
		target_checkbox.parent = this
		if this.children[0].text.length < 26
			row_target_label.text = this.children[0].text 
		else
			row_target_label.text = this.children[0].text.substring(0,26) + "..."
		flow.showPrevious()
target_arrow.onTap ->
	flow.showPrevious()
btn_conditions.onTap ->
	flow.showNext(STATIC_THRESHOLDS)
btn_notifications.onTap ->
	flow.showNext(HOME)
btn_back_thresholds.onTap ->
	flow.showPrevious()

#FORECAST
btn_forecast_conditions.onClick ->
	flow.showNext(FORECAST_THRESHOLDS)
btn_forecast_back.onClick ->
	flow.showPrevious()

drg_forecast_alert.draggable.enabled = true
drg_forecast_alert.draggable.horizontal = false
drg_forecast_alert.draggable.overdrag = false
drg_forecast_alert.draggable.pixelAlign = true
drg_forecast_alert.draggable.momentum = false
drg_forecast_alert.draggable.propagateEvents = false
drg_forecast_alert.draggable.constraints = 
	y: 70
	height: 170
drg_forecast_alert.on Events.DragMove, ->
	txt_forecast_alert.text = (-10*(drg_forecast_alert.y-70)/144+10).toFixed(1)

btn_forecast1.onClick ->
	btn_forecast1.visible = false
	btn_forecast2.visible = true
	forecast_path1.visible = false
	forecast_path2.visible = true
btn_forecast2.onClick ->
	btn_forecast2.visible = false
	btn_forecast3.visible = true
	forecast_path2.visible = false
	forecast_path3.visible = true
btn_forecast3.onClick ->
	btn_forecast3.visible = false
	btn_forecast1.visible = true
	forecast_path3.visible = false
	forecast_path1.visible = true

btn_forecast_finish.onTap ->
	flow.showNext(HOME)

# ANOMALY
btn_anomaly_conditions.onClick ->
	flow.showNext(ANOMALY_THRESHOLDS)
btn_anomaly_back.onClick ->
	flow.showPrevious()
btn_anomaly_finish.onClick ->
	flow.showNext(HOME)

btn_anom_dev1.onClick ->
	btn_anom_dev1.visible = false
	btn_anom_dev2.visible = true
	anom_graph1.visible = false
	anom_graph2.visible = true
btn_anom_dev2.onClick ->
	btn_anom_dev2.visible = false
	btn_anom_dev3.visible = true
	anom_graph2.visible = false
	anom_graph3.visible = true
btn_anom_dev3.onClick ->
	btn_anom_dev3.visible = false
	btn_anom_dev1.visible = true
	anom_graph3.visible = false
	anom_graph1.visible = true

btn_anom_range1.onClick ->
	btn_anom_range1.visible = false
	btn_anom_range2.visible = true
	percentageA.visible = false
	percentageB.visible = true
btn_anom_range2.onClick ->
	btn_anom_range2.visible = false
	btn_anom_range1.visible = true
	percentageB.visible = false
	percentageA.visible = true

# FEED & ML
btn_feed_back.onClick ->
	flow.showNext(HOME)
	
btn_feed_search1.onClick ->
	btn_feed_search1.visible = false
	btn_feed_search2.visible = true
	feed1.visible = false
	feed2.visible = true
	
btn_feed_search_back.onClick ->
	btn_feed_search2.visible = false
	btn_feed_search1.visible = true
	feed2.visible = false
	feed1.visible = true

# Set states
feed_tooltip.states =
	hidden:
		y: 65
		opacity: 0
like2_tooltip.states =
	hidden:
		y: 92
		opacity: 0
btn_like.states = 
	small:
		scale: 0.75
		opacity: 0.8
		color: "#FFF"
	active:
		scale: 0.75
btn_like2.states = 
	small:
		scale: 0.75
		opacity: 0.8
		color: "#FFF"
	active:
		scale: 0.75
btn_feed_alert.states = 
	small:
		scale: 0.75
		opacity: 0.8
		color: "#FFF"
	active:
		scale: 0.75

btn_like.stateSwitch("small")
btn_like2.stateSwitch("small")
btn_feed_alert.stateSwitch("small")
feed_tooltip.stateSwitch("hidden")
like2_tooltip.stateSwitch("hidden")

btn_like.onClick ->
	# Check the current state and animate
	if btn_like.states.current.name isnt "active"
		btn_like.animate "default",
			curve: Spring(damping: .5)
			time: 0.5
		btn_like.ignoreEvents = true
		Utils.delay 0.25, ->
			btn_like.ignoreEvents = false
			btn_like.animate "active",
				curve: Spring(damping: .8)
				time: 0.5
	else
		btn_like.animate "small"
	
btn_like2.onClick ->
	# Check the current state and animate
	if btn_like2.states.current.name isnt "active"
		btn_like2.animate "default",
			curve: Spring(damping: .5)
			time: 0.5
		btn_like2.ignoreEvents = true
		like2_tooltip.animate "default",
			curve: Spring(damping: .5)
			time: 0.5
		Utils.delay 0.25, ->
			btn_like2.ignoreEvents = false
			btn_like2.animate "active",
				curve: Spring(damping: .8)
				time: 0.5
	else
		btn_like2.animate "small"
		like2_tooltip.animate "hidden",
			time: 0.5

btn_feed_alert.onClick ->
	# Check the current state and animate
	if btn_feed_alert.states.current.name isnt "active"
		btn_feed_alert.animate "default",
			curve: Spring(damping: .5)
			time: 0.5
		feed_tooltip.animate "default",
			curve: Spring(damping: .5)
			time: 0.5
		btn_feed_alert.ignoreEvents = true
		Utils.delay 0.25, ->
			btn_feed_alert.ignoreEvents = false
			btn_feed_alert.animate "active",
				curve: Spring(damping: .8)
				time: 0.5
		Utils.delay 1.5, ->
			feed_tooltip.animate "hidden",
				curve: Spring(damping: .5)
				time: 0.5
	else
		btn_feed_alert.animate "small"

