
position_dodge_stack <- function(vjust = 1, reverse = FALSE, width = NULL,  
                                 preserve = "single", orientation = "x") {
  PositionDodgeStack
}

PositionDodgeStack <- ggplot2::ggproto("PositionDodgeStack", ggplot2::Position,
                                       type = NULL,
                                       vjust = 1,
                                       fill = FALSE,
                                       width = NULL,
                                       preserve = "single",
                                       orientation = "x",
                                       reverse = NULL,
                                       default_aes = aes(order = NULL),
                                       
                                       setup_params = function(self,data){
                                         
                                         param1 <- PositionDodgeIdentity$setup_params(data)
                                         
                                         param2 <- PositionIdentityStack$setup_params(data)
                                         # cant use self for single argument
                                         if (identical(self$preserve, "single")){
                                           param2$n <- max(as.numeric(data$drawID))
                                         }
                                         list(param1, param2)
                                       },
                                       
                                       setup_data = function(data, params, scales){
                                         data <- PositionIdentityStack$setup_data(data, params[[2]])
                                         PositionDodgeIdentity$setup_data(data, params[[1]])
                                       },
                                       compute_panel = function(self, data, params, scales) {
                                         data <- PositionIdentityStack$compute_panel(data, params[[2]])
                                         data <- PositionDodgeIdentity$compute_panel(data, params[[1]])
                                         data
                                       },
                                       
                                       extra_params = c("vjust", "reverse")
)

# FIRST POSITION STACK
position_stack_stack1 <- function(vjust = 1, reverse = FALSE, width = NULL,  
                                 preserve = "single", orientation = "x") {
  PositionStackStack1
}

PositionStackStack1 <- ggplot2::ggproto("PositionStackStack1", ggplot2::Position,
                                       type = NULL,
                                       vjust = 1,
                                       fill = FALSE,
                                       width = NULL,
                                       preserve = "single",
                                       orientation = "x",
                                       reverse = NULL,
                                       default_aes = aes(order = NULL),
                                       
                                       setup_params = function(self,data){
                                         
                                         param1 <- ggdibbler::PositionStackIdentity$setup_params(data)
                                         
                                         param2 <- PositionIdentityStack$setup_params(data)
                                         # cant use self for single argument
                                         if (identical(self$preserve, "single")){
                                           param2$n <- max(as.numeric(data$drawID))
                                         }
                                         list(param1, param2)
                                       },
                                       
                                       setup_data = function(data, params, scales){
                                         data <- PositionIdentityStack$setup_data(data, params[[2]])
                                         ggdibbler::PositionStackIdentity$setup_data(data, params[[1]])
                                       },
                                       compute_panel = function(self, data, params, scales) {
                                         data <- PositionIdentityStack$compute_panel(data, params[[2]])
                                         data <- ggdibbler::PositionStackIdentity$compute_panel(data, params[[1]])
                                         data
                                       },
                                       
                                       extra_params = c("vjust", "reverse")
)

# SECOND POSITION STACKSTACK

position_stack_stack2 <- function(vjust = 1, reverse = FALSE, width = NULL,  
                                  preserve = "single", orientation = "x") {
  PositionStackStack2
}

PositionStackStack2 <- ggplot2::ggproto("PositionStackStack2", ggplot2::Position,
                                        type = NULL,
                                        vjust = 1,
                                        fill = FALSE,
                                        width = NULL,
                                        preserve = "single",
                                        orientation = "x",
                                        reverse = NULL,
                                        default_aes = aes(order = NULL),
                                        
                                        setup_params = function(self,data){
                                          
                                          param1 <- ggdibbler::PositionStackIdentity$setup_params(data)
                                          
                                          param2 <- PositionIdentityStack$setup_params(data)
                                          # cant use self for single argument
                                          if (identical(self$preserve, "single")){
                                            param2$n <- max(as.numeric(data$drawID))
                                          }
                                          list(param1, param2)
                                        },
                                        
                                        setup_data = function(data, params, scales){
                                          data <- ggdibbler::PositionStackIdentity$setup_data(data, params[[1]])
                                          PositionIdentityStack$setup_data(data, params[[2]])
                                          
                                        },
                                        compute_panel = function(self, data, params, scales) {
                                          data1 <- ggdibbler::PositionStackIdentity$compute_panel(data, params[[1]])
                                          data2 <- PositionIdentityStack$compute_panel(data1, params[[2]])
                                          data2
                                        },
                                        
                                        extra_params = c("vjust", "reverse")
)