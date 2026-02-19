;; extends

((comment) @injection.content
	(#set! injection.language "markdown"))


(call_expression 
  function: ((identifier) @foo (#eq? @foo "deser")) 
  arguments: (argument_list 
			   (string_literal ((string_content) @injection.content
			   (#set! injection.language "json")))))
