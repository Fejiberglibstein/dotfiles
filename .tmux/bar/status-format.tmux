set status-format[0] '#[align=left range=left #{E:status-left-style}]#[push-default]#{T;=/#{status-left-length}:status-left}#[pop-default]#[norange default]#[list=on align=#{status-justify}]#[list=left-marker]<#[list=right-marker]>#[list=on]#{T:@window-pre-format}#{W:#[range=window|#{window_index} #{E:window-status-style}#{?#{&&:#{window_last_flag},#{!=:#{E:window-status-last-style},default}}, #{E:window-status-last-style},}#{?#{&&:#{window_bell_flag},#{!=:#{E:window-status-bell-style},default}},#{E:window-status-bell-style},#{?#{&&:#{||:#{window_activity_flag},#{window_silence_flag}},#{!=:#{E:window-status-activity-style},default}}, #{E:window-status-activity-style},}}]#[push-default]#{T:window-status-format}#[pop-default]#[norange default]#{?window_end_flag,,#{window-status-separator}},#[range=window|#{window_index} list=focus #{?#{!=:#{E:window-status-current-style},default},#{E:window-status-current-style},#{E:window-status-style}}#{?#{&&:#{window_last_flag},#{!=:#{E:window-status-last-style},default}}, #{E:window-status-last-style},}#{?#{&&:#{window_bell_flag},#{!=:#{E:window-status-bell-style},default}}, #{E:window-status-bell-style},#{?#{&&:#{||:#{window_activity_flag},#{window_silence_flag}},#{!=:#{E:window-status-activity-style},default}}, #{E:window-status-activity-style},}}]#[push-default]#{T:window-status-current-format}#[pop-default]#[norange list=on default]#{?window_end_flag,,#{window-status-separator}}}#{T:@window-post-format}#[nolist align=right range=right #{E:status-right-style}]#[push-default]#{T;=/#{status-right-length}:status-right}#[pop-default]#[norange default]'

# #[align=left range=left #{E:status-left-style}]
# #[push-default]
# #{T;=/#{status-left-length}:status-left}
# #[pop-default]
# #[norange default]
# #[list=on align=#{status-justify}]
# #[list=left-marker]<
# #[list=right-marker]>
# #[list=on]
# #[T:@window-pre-format]
# #{W:
# 	#[range=window|#{window_index} 
# 		#{E:window-status-style}
# 		#{?
# 			#{&&:
# 				#{window_last_flag},
# 				#{!=:#{E:window-status-last-style},default}
# 			}, 
# 			#{E:window-status-last-style},
# 		}
# 		#{?
# 			#{&&:#{window_bell_flag},#{!=:#{E:window-status-bell-style},default}},
# 			#{E:window-status-bell-style},
# 			#{?
# 				#{&&:
# 					#{||:#{window_activity_flag},#{window_silence_flag}},
# 					#{!=:#{E:window-status-activity-style},default}
# 				}, 
# 			#{E:window-status-activity-style},
# 			}
# 		}
# 	]
# 	#[push-default]
# 	#{T:window-status-format}
# 	#[pop-default]
# 	#[norange default]
# 	#{?window_end_flag,,#{window-status-separator}},
# 	#[range=window|#{window_index} list=focus 
# 		#{?
# 			#{!=:#{E:window-status-current-style},default},
# 			#{E:window-status-current-style},
# 			#{E:window-status-style}
# 		}
# 		#{?
# 			#{&&:#{window_last_flag},#{!=:#{E:window-status-last-style},default}}, 
# 			#{E:window-status-last-style},
# 		}
# 		#{?
# 			#{&&:#{window_bell_flag},#{!=:#{E:window-status-bell-style},default}}, 
# 			#{E:window-status-bell-style},
# 			#{?
# 				#{&&:#{||:#{window_activity_flag},#{window_silence_flag}},#{!=:#{E:window-status-activity-style},default}}, 
# 				#{E:window-status-activity-style},
# 			}
# 		}
# 	]
# 	#[push-default]
# 	#{T:window-status-current-format}
# 	#[pop-default]
# 	#[norange list=on default]
# 	#{?window_end_flag,,#{window-status-separator}}
# }
# #[T:@window-post-format]
# #[nolist align=right range=right #{E:status-right-style}]
# #[push-default]
# #{T;=/#{status-right-length}:status-right}
# #[pop-default]
# #[norange default]

