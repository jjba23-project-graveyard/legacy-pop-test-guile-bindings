;; pop-test - your test orchestration master of puppets

;; Copyright (C) 2025 Josep Bigorra (jjba23) <jjbigorra@gmail.com>

;; pop-test is free software: you can redistribute it and/or modify
;; it under the terms of the Lesser GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; pop-test is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; Lesser GNU General Public License for more details.

;; You should have received a copy of the Lesser GNU General Public License
;; along with pop-test.  If not, see <https://www.gnu.org/licenses/>.

;; pop-test records in Guile Scheme

(define-module (pop-test guile)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-64)
  #:use-module (json record)
  #:use-module (json))

;; pop-test records in Guile Scheme

(define-record-type <pop-service-health-check>
  (make-pop-service-health-check type path patience-seconds always-healthy)
  pop-service-health-check?
  (type get-pop-service-health-check-type set-pop-service-health-check-type!)
  (path get-pop-service-health-check-path set-pop-service-health-check-path!)
  (patience-seconds get-pop-service-health-check-patience-seconds
                    set-pop-service-health-check-patience-seconds!)
  (always-healthy get-pop-service-health-check-always-healthy
                  set-pop-service-health-check-always-healthy!))

(define-json-mapping <pop-service-health-check>
                     make-pop-service-health-check
                     pop-service-health-check?
                     json->pop-service-health-check
                     <=>
                     pop-service-health-check->json
                     (type pop-service-health-check-type "type")
                     (path pop-service-health-check-type "path")
                     (patience-seconds pop-service-health-check-type
                                       "patience_seconds")
                     (always-healthy pop-service-health-check-type
                                     "always_healthy"))

(define-record-type <pop-service-postgres>
  (make-pop-service-postgres enabled
                             host-var
                             port-var
                             db-var
                             user-var
                             pass-var)
  pop-service-postgres?
  (enabled get-pop-service-postgres-enabled set-pop-service-postgres-enabled!)
  (host-var get-pop-service-postgres-host-var
            set-pop-service-postgres-host-var!)
  (port-var get-pop-service-postgres-port-var
            set-pop-service-postgres-port-var!)
  (db-var get-pop-service-postgres-db-var set-pop-service-postgres-db-var!)
  (user-var get-pop-service-postgres-user-var
            set-pop-service-postgres-user-var!)
  (pass-var get-pop-service-postgres-pass-var
            set-pop-service-postgres-pass-var!))

(define-json-mapping <pop-service-postgres>
                     make-pop-service-postgres
                     pop-service-postgres?
                     json->pop-service-postgres
                     <=>
                     pop-service-postgres->json
                     (enabled pop-service-postgres-enabled "enabled")
                     (host-var pop-service-postgres-host-var "host_var")
                     (port-var pop-service-postgres-port-var "port_var")
                     (db-var pop-service-postgres-db-var "db_var")
                     (user-var pop-service-postgres-user-var "user_var")
                     (pass-var pop-service-postgres-pass-var "pass_var"))

(define-record-type <pop-service-kafka>
  (make-pop-service-kafka enabled bootstrap-server-var) pop-service-kafka?
  (enabled get-pop-service-kafka-enabled set-pop-service-kafka-enabled!)
  (bootstrap-server-var get-pop-service-kafka-bootstrap-server-var
                        set-pop-service-kafka-bootstrap-server-var!))

(define-json-mapping <pop-service-kafka>
                     make-pop-service-kafka
                     pop-service-kafka?
                     json->pop-service-kafka
                     <=>
                     pop-service-kafka->json
                     (enabled pop-service-kafka-enabled "enabled")
                     (host-var pop-service-kafka-bootstrap-server-var
                               "bootstrap_server_var"))

(define-record-type <pop-service-keycloak>
  (make-pop-service-keycloak enabled url-var realm-var) pop-service-keycloak?
  (enabled get-pop-service-keycloak-enabled set-pop-service-keycloak-enabled!)
  (url-var get-pop-service-keycloak-url-var set-pop-service-keycloak-url-var!)
  (realm-var get-pop-service-keycloak-realm-var
             set-pop-service-keycloak-realm-var!))

(define-json-mapping <pop-service-keycloak>
                     make-pop-service-keycloak
                     pop-service-keycloak?
                     json->pop-service-keycloak
                     <=>
                     pop-service-keycloak->json
                     (enabled pop-service-keycloak-enabled "enabled")
                     (url-var pop-service-keycloak-url-var "url_var")
                     (realm-var pop-service-keycloak-realm-var "realm_var"))

(define-record-type <pop-service-pop-server>
  (make-pop-service-pop-server enabled url-vars) pop-service-pop-server?
  (enabled get-pop-service-pop-server-enabled
           set-pop-service-pop-server-enabled!)
  (url-vars get-pop-service-pop-server-url-vars
            set-pop-service-pop-server-url-vars!))

(define-json-mapping <pop-service-pop-server>
                     make-pop-service-pop-server
                     pop-service-pop-server?
                     json->pop-service-pop-server
                     <=>
                     pop-service-pop-server->json
                     (enabled pop-service-pop-server-enabled "enabled")
                     (url-vars pop-service-pop-server-url-vars "url_vars"))

(define-record-type <pop-service>
  (make-pop-service id
                    name
                    dir
                    base-url
                    shell-path
                    start-cmd-args
                    env-vars
                    health-check
                    postgres
                    kafka
                    keycloak
                    pop-server)
  pop-service?
  (id get-pop-service-id set-pop-service-id!)
  (name get-pop-service-name set-pop-service-name!)
  (dir get-pop-service-dir set-pop-service-dir!)
  (base-url get-pop-service-base-url set-pop-service-base-url!)
  (shell-path get-pop-service-shell-path set-pop-service-shell-path!)
  (start-cmd-args get-pop-service-start-cmd-args
                  set-pop-service-start-cmd-args!)
  (env-vars get-pop-service-env-vars set-pop-service-env-vars!)
  (health-check get-pop-service-health-check set-pop-service-health-check!)
  (postgres get-pop-service-postgres set-pop-service-postgres!)
  (kafka get-pop-service-kafka set-pop-service-kafka!)
  (keycloak get-pop-service-keycloak set-pop-service-keycloak!)
  (pop-server get-pop-service-pop-server set-pop-service-pop-server!))

(define-json-mapping <pop-service>
                     make-pop-service
                     pop-service?
                     json->pop-service
                     <=>
                     pop-service->json
                     (id pop-service-id "id")
                     (name pop-service-name "name")
                     (dir pop-service-dir "dir")
                     (base-url pop-service-base-url "base_url")
                     (shell-path pop-service-shell-path "shell_path")
                     (start-cmd-args pop-service-start-cmd-args
                                     "start_cmd_args")
                     (env-vars pop-service-env-vars "env_vars")
                     (health-check pop-service-health-check "health_check")
                     (postgres pop-service-postgres "postgres")
                     (kafka pop-service-kafka "kafka")
                     (keycloak pop-service-keycloak "keycloak")
                     (pop-server pop-service-pop-server "pop_server"))

(define-record-type <body-pattern>
  (make-body-pattern pattern condition) body-pattern?
  (pattern get-body-pattern-pattern set-body-pattern-pattern!)
  (condition get-body-pattern-condition set-body-pattern-condition!))

(define-json-mapping <body-pattern>
                     make-body-pattern
                     body-pattern?
                     json->body-pattern
                     <=>
                     body-pattern->json
                     (pattern body-pattern-pattern "pattern")
                     (condition body-pattern-condition "condition"))

(define-record-type <http-assertion>
  (make-http-assertion name
                       delay-seconds
                       assert-code
                       assert-url
                       service-id
                       method
                       json-patterns
                       html-patterns
                       with-keycloak-user-token
                       message-file-path
                       message
                       extra-headers)
  http-assertion?
  (name get-http-assertion-name set-http-assertion-name!)
  (delay-seconds get-http-assertion-delay-seconds
                 set-http-assertion-delay-seconds!)
  (assert-code get-http-assertion-assert-code set-http-assertion-assert-code!)
  (assert-url get-http-assertion-assert-url set-http-assertion-assert-url!)
  (service-id get-http-assertion-service-id set-http-assertion-service-id!)
  (method get-http-assertion-method set-http-assertion-method!)
  (json-patterns get-http-assertion-json-patterns
                 set-http-assertion-json-patterns!)
  (html-patterns get-http-assertion-html-patterns
                 set-http-assertion-html-patterns!)
  (with-keycloak-user-token get-http-assertion-with-keycloak-user-token
                            set-http-assertion-with-keycloak-user-token!)
  (message-file-path get-http-assertion-message-file-path
                     set-http-assertion-message-file-path!)
  (message get-http-assertion-message set-http-assertion-message!)
  (extra-headers get-http-assertion-extra-headers
                 set-http-assertion-extra-headers!))

(define-json-mapping <http-assertion>
                     make-http-assertion
                     http-assertion?
                     json->http-assertion
                     <=>
                     http-assertion->json
                     (name http-assertion-name "name")
                     (delay-seconds http-assertion-delay-seconds
                                    "delay_seconds")
                     (assert-code http-assertion-assert-code "assert_code")
                     (assert-url http-assertion-assert-url "assert_url")
                     (service-id http-assertion-service-id "service_id")
                     (method http-assertion-method "method")
                     (json-patterns http-assertion-json-patterns
                                    "json_patterns")
                     (html-patterns http-assertion-html-patterns
                                    "html_patterns")
                     (with-keycloak-user-token
                      http-assertion-with-keycloak-user-token
                      "with_keycloak_user_token")
                     (message-file-path http-assertion-message-file-path
                                        "message_file_path")
                     (message http-assertion-message "message")
                     (extra-headers http-assertion-extra-headers
                                    "extra_headers"))

(define-record-type <pop-postgres>
  (make-pop-postgres enabled image-name image-tag) pop-postgres?
  (enabled get-pop-postgres-enabled set-pop-postgres-enabled!)
  (image-name get-pop-postgres-image-name set-pop-postgres-image-name!)
  (image-tag get-pop-postgres-image-tag set-pop-postgres-image-tag!))

(define-json-mapping <pop-postgres>
  make-pop-postgres
  pop-postgres?
  json->pop-postgres
  <=>
  pop-postgres->json
  (enabled pop-postgres-enabled "enabled")
  (image-name pop-postgres-image-name "image_name")
  (image-tag pop-postgres-image-tag "image_tag"))

(define-record-type <pop-kafka>
  (make-pop-kafka enabled image-name image-tag) pop-kafka?
  (enabled get-pop-kafka-enabled set-pop-kafka-enabled!)
  (image-name get-pop-kafka-image-name set-pop-kafka-image-name!)
  (image-tag get-pop-kafka-image-tag set-pop-kafka-image-tag!))

(define-json-mapping <pop-kafka>
                     make-pop-kafka
                     pop-kafka?
                     json->pop-kafka
                     <=>
                     pop-kafka->json
                     (enabled pop-kafka-enabled "enabled")
                     (image-name pop-kafka-image-name "image_name")
                     (image-tag pop-kafka-image-tag "image_tag"))

(define-record-type <pop-server-behavior>
  (make-pop-server-behavior request-path
                            request-method
                            response-status
                            request-content-type
                            response-content-type
                            response-body-file
                            response-body)
  pop-server-behavior?
  (request-path get-pop-server-behavior-request-path)
  (request-method get-pop-server-behavior-request-method)
  (response-status get-pop-server-behavior-response-status)
  (request-content-type get-pop-server-behavior-request-content-type)
  (response-content-type get-pop-server-behavior-response-content-type)
  (response-body-file get-pop-server-behavior-response-body-file)
  (response-body get-pop-server-behavior-response-body))

(define-json-mapping <pop-server-behavior>
                     make-pop-server-behavior
                     pop-server-behavior?
                     json->pop-server-behavior
                     <=>
                     pop-server-behavior->json
                     (request-path pop-server-behavior-request-path
                                   "request_path")
                     (request-method pop-server-behavior-request-method
                                     "request_method")
                     (response-status pop-server-behavior-response-status
                                      "response_status")
                     (request-content-type
                      pop-server-behavior-request-content-type
                      "request_content_type")
                     (response-content-type
                      pop-server-behavior-response-content-type
                      "response_content_type")
                     (response-body-file
                      pop-server-behavior-response-body-file
                      "response_body_file")
                     (response-body pop-server-behavior-response-body
                                    "response_body"))

(define-record-type <pop-server>
  (make-pop-server enabled image-name image-tag behaviors)
  pop-server?
  (enabled get-pop-server-enabled set-pop-server-enabled!)
  (image-name get-pop-server-image-name set-pop-server-image-name!)
  (image-tag get-pop-server-image-tag set-pop-server-image-tag!)
  (behaviors get-pop-server-behaviors set-pop-server-behaviors!))

(define-json-mapping <pop-server>
                     make-pop-server
                     pop-server?
                     json->pop-server
                     <=>
                     pop-server->json
                     (enabled pop-server-enabled "enabled")
                     (image-name pop-server-image-name "image_name")
                     (image-tag pop-server-image-tag "image_tag")
                     (behaviors pop-server-behaviors "behaviors"))

(define-record-type <pop-keycloak>
  (make-pop-keycloak enabled
                     image-name
                     image-tag
                     realm
                     client-id
                     client-secret
                     email
                     username
                     password
                     roles
                     scopes)
  pop-keycloak?
  (enabled get-pop-keycloak-enabled set-pop-keycloak-enabled!)
  (image-name get-pop-keycloak-image-name set-pop-keycloak-image-name!)
  (image-tag get-pop-keycloak-image-tag set-pop-keycloak-image-tag!)
  (realm get-pop-keycloak-realm set-pop-keycloak-realm!)
  (client-id get-pop-keycloak-client-id set-pop-keycloak-client-id!)
  (client-secret get-pop-keycloak-client-secret
                 set-pop-keycloak-client-secret!)
  (email get-pop-keycloak-email set-pop-keycloak-email!)
  (username get-pop-keycloak-username set-pop-keycloak-username!)
  (password get-pop-keycloak-password set-pop-keycloak-password!)
  (roles get-pop-keycloak-roles set-pop-keycloak-roles!)
  (scopes get-pop-keycloak-scopes set-pop-keycloak-scopes!))

(define-json-mapping <pop-keycloak>
                     make-pop-keycloak
                     pop-keycloak?
                     json->pop-keycloak
                     <=>
                     pop-keycloak->json
                     (enabled pop-keycloak-enabled "enabled")
                     (image-name pop-keycloak-image-name "image_name")
                     (image-tag pop-keycloak-image-tag "image_tag")
                     (realm pop-keycloak-realm "realm")
                     (client-id pop-keycloak-client-id "client_id")
                     (client-secret pop-keycloak-client-secret "client_secret")
                     (email pop-keycloak-email "email")
                     (username pop-keycloak-username "username")
                     (password pop-keycloak-password "password")
                     (roles pop-keycloak-roles "roles")
                     (scopes pop-keycloak-scopes "scopes"))

(define-record-type <pop-sqlite>
  (make-pop-sqlite db-path) pop-sqlite?
  (db-path get-pop-sqlite-db-path set-pop-sqlite-db-path!))

(define-json-mapping <pop-sqlite>
                     make-pop-sqlite
                     pop-sqlite?
                     json->pop-sqlite
                     <=>
                     pop-sqlite->json
                     (db-path pop-sqlite-db-path "db_path"))

(define-record-type <pop-scenario>
  (make-pop-scenario pop-services
                     pop-actions
                     pop-postgres
                     pop-kafka
                     pop-server
                     pop-keycloak
                     pop-sqlite)
  pop-scenario?
  (pop-services get-pop-scenario-pop-services set-pop-services!)
  (pop-actions get-pop-scenario-pop-actions set-pop-scenario-pop-actions!)
  (pop-postgres get-pop-scenario-pop-postgres set-pop-scenario-pop-postgres!)
  (pop-kafka get-pop-scenario-pop-kafka set-pop-scenario-pop-kafka!)
  (pop-server get-pop-scenario-pop-server set-pop-scenario-pop-server!)
  (pop-keycloak get-pop-scenario-pop-keycloak set-pop-scenario-pop-keycloak!)
  (pop-sqlite get-pop-scenario-pop-sqlite set-pop-scenario-pop-sqlite!))

(define-json-mapping <pop-scenario>
                     make-pop-scenario
                     pop-scenario?
                     json->pop-scenario
                     <=>
                     pop-scenario->json
                     (pop-services pop-scenario-pop-services "pop_services")
                     (pop-actions pop-scenario-pop-actions "pop_actions")
                     (pop-postgres pop-scenario-pop-postgres "pop_postgres")
                     (pop-kafka pop-scenario-pop-kafka "pop_kafka")
                     (pop-server pop-scenario-pop-server "pop_server")
                     (pop-keycloak pop-scenario-pop-keycloak "pop_keycloak")
                     (pop-sqlite pop-scenario-pop-sqlite "pop_sqlite"))

(test-begin "pop-test-guile-bindings")

;; Green Energy Mix Example
(define-public green-energy-mix-scenario
  (make-pop-scenario
   ;; pop-services
   (list (make-pop-service
          ;; id
          "green-energy-mix"
          ;; name
          "Green Energy Mix"
          ;; dir
          "$HOME/Ontwikkeling/Werk"
          ;; base-url
          "http://localhost:50000"
          ;; shell-path
          #f
          ;; start-cmd-args
          (list "sbt \"greenEnergyMix/run\"")
          ;; env-vars
          '(("SOME-TOKEN" . "0027809ce9"))
          ;; health check
          (make-pop-service-health-check #f "/health" 120 #f)
          ;; postgres
          #f
          ;; kafka
          #f
          ;; keycloak
          #f
          ;; pop-server
          #f))
   ;; pop-actions
   (list (make-http-assertion
          ;; name
          "Check that the forecast endpoint returns a 200 with correct data, with load and solar"
          ;; delay-seconds
          #f
          ;; assert-code
          200
          ;; assert-url
          "/api/v1/forecast"
          ;; service-id
          "green-energy-mix"
          ;; method
          "GET"
          ;; json-patterns
          (list (make-body-pattern "meta.forecastDate" "non-empty-str")
                (make-body-pattern "data.[0].load" "> 0")
                (make-body-pattern "data.[0].solar" ">= 0"))
          ;; html-patterns
          #f
          ;; with-keycloak-user-token
          #f
          ;; message-file-path
          #f
          ;; message
          #f
          ;; extra-headers
          #f))

   #f ;pop-postgres
   #f ;pop-kafka
   #f ;pop-server
   #f ;pop-keycloak
   #f ;pop-sqlite
   ))

(test-assert "Scenario creation"
             (pop-scenario? green-energy-mix-scenario))
(test-assert "Service count"
             (= 1
                (length (get-pop-scenario-pop-services
                         green-energy-mix-scenario))))
(test-assert "Action count"
             (= 1
                (length (get-pop-scenario-pop-actions
                         green-energy-mix-scenario))))
(test-assert "Service ID"
             (string=? "green-energy-mix"
                       (get-pop-service-id (car (get-pop-scenario-pop-services
                                                 green-energy-mix-scenario)))))
(test-assert "Health Check Path"
             (string=? "/health"
                       (get-pop-service-health-check-path (get-pop-service-health-check
                                                           (car (get-pop-scenario-pop-services
                                                                 green-energy-mix-scenario))))))

;; TODO : finalize JSON conversion of records

;; (define (common-actions scenario)
;;   (write scenario)
;;   (display "\n\n========\n\n")
;;   (write (car (get-pop-services scenario)))
;;   (display "\n\n========\n\n")
;;   (write (get-pop-service-name (car (get-pop-services scenario))))
;;   ;; (write (pop-service->json (car (get-pop-services scenario))))
;;   #t)

;; (test-eq "do some common actions with pop-scenarios" #t
;;          (common-actions green-energy-mix-scenario))

(test-assert "healthcheck json generation works"
             (equal? #t
                     (let ((hc (make-pop-service-health-check "http" "/health"
                                                              120 #f)))
                       (write hc)
                       (write (pop-service-health-check->json hc)) #t)))

(test-end)

;; 
;; (type pop-service-health-check-type "type")
;; (path pop-service-health-check-type "path")
;; (patience-seconds pop-service-health-check-type "patience_seconds")
;; (always-healthy pop-service-health-check-type "always_healthy")
