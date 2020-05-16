resource "aws_ecs_service" "test-ecs-service" {
  	name            = "test-ecs-service"
  	iam_role        = "${aws_iam_role.ecs-service-role.name}"
  	cluster         = "${aws_ecs_cluster.test-ecs-cluster.id}"
  	task_definition = "${aws_ecs_task_definition.nginx.arn}"
  	desired_count   = 1
	depends_on	= [aws_alb.ecs-load-balancer]

	load_balancer {
    	  target_group_arn  = "${aws_alb_target_group.ecs-target-group.arn}"
    	  container_port    = 80
    	  container_name    = "nginx"
	}
   }
resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 50"
  }
}

