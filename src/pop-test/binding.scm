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

(define-record-type <pop-service-health-action>
  (make-pop-service-health-action type path patience-seconds always-healthy)
  pop-service-health-action?
  (type get-type set-type!)
  (path get-path set-path!)
  (patience-seconds get-patience-seconds set-patience-seconds!)
  (always-healthy get-always-healthy set-always-healthy!))

(define-record-type <pop-service-postgres>
  (make-pop-service-postgres enabled
                             host-var
                             port-var
                             db-var
                             user-var
                             pass-var)
  pop-service-postgres?
  (enabled get-enabled set-enabled!)
  (host-var get-host-var set-host-var!)
  (port-var get-port-var set-port-var!)
  (db-var get-db-var set-db-var!)
  (user-var get-user-var set-user-var!)
  (pass-var get-pass-var set-pass-var!))

(define-record-type <pop-service-kafka>
  (make-pop-service-kafka enabled bootstrap-server-var) pop-service-kafka?
  (enabled get-enabled set-enabled!)
  (bootstrap-server-var get-bootstrap-server-var set-bootstrap-server-var!))

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
                    kafka)
  pop-service?
  (id get-id set-id!)
  (name get-name set-name!)
  (dir get-dir set-dir!)
  (base-url get-base-url set-base-url!)
  (shell-path get-shell-path set-shell-path!)
  (start-cmd-args get-start-cmd-args set-start-cmd-args!)
  (env-vars get-env-vars set-env-vars!)
  (health-check get-health-check set-health-check!)
  (postgres get-postgres set-postgres!)
  (kafka get-kafka set-kafka!))

;; (define-json-mapping <pop-service>
;;                      make-pop-service
;;                      pop-service?
;;                      json->pop-service
;;                      <=>
;;                      pop-service->json

;;                      )

(define-record-type <body-pattern>
  (make-body-pattern pattern condition) body-pattern?
  (pattern get-pattern set-pattern!)
  (condition get-condition set-condition!))

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
  (name get-name set-name!)
  (delay-seconds get-delay-seconds set-delay-seconds!)
  (assert-code get-assert-code set-assert-code!)
  (assert-url get-assert-url set-assert-url!)
  (service-id get-service-id set-service-id!)
  (method get-method set-method!)
  (json-patterns get-json-patterns set-json-patterns!)
  (html-patterns get-html-patterns set-html-patterns!)
  (with-keycloak-user-token get-with-keycloak-user-token
                            set-with-keycloak-user-token!)
  (message-file-path get-message-file-path set-message-file-path!)
  (message get-message set-message!)
  (extra-headers get-extra-headers set-extra-headers!))

(define-record-type <pop-scenario>
  (make-pop-scenario pop-services
                     pop-actions
                     pop-postgres
                     pop-kafka
                     pop-server
                     pop-keycloak
                     pop-sqlite)
  pop-scenario?
  (pop-services get-pop-services set-pop-services!)
  (pop-actions get-pop-actions set-pop-actions!)
  (pop-postgres get-pop-postgres set-pop-postgres!)
  (pop-kafka get-pop-kafka set-pop-kafka!)
  (pop-server get-pop-server set-pop-server!)
  (pop-keycloak get-pop-keycloak set-pop-keycloak!)
  (pop-sqlite get-pop-sqlite set-pop-sqlite!))

;; (define-json-mapping <pop-scenario>
;;                      make-pop-scenario
;;                      pop-scenario?
;;                      json->pop-scenario
;;                      <=>
;;                      pop-scenario->json
;;                      (pop-services pop-service "pop_services"
;;                                    (lambda (v)
;;                                      (map scm->link
;;                                           (vector->list v)))
;;                                    (lambda (v)
;;                                      (list->vector (map link->scm v)))))

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
          (make-pop-service-health-action #f "/health" 120 #f)
          ;; postgres
          #f
          ;; kafka
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

(test-begin "pop-test-guile-bindings")
(test-assert "Scenario creation"
             (pop-scenario? green-energy-mix-scenario))
(test-assert "Service count"
             (= 1
                (length (get-pop-services green-energy-mix-scenario))))
(test-assert "Action count"
             (= 1
                (length (get-pop-actions green-energy-mix-scenario))))
(test-assert "Service ID"
             (string=? "green-energy-mix"
                       (get-id (car (get-pop-services
                                     green-energy-mix-scenario)))))
(test-assert "Health Check Path"
             (string=? "/health"
                       (get-path (get-health-check (car (get-pop-services
                                                         green-energy-mix-scenario))))))

;; TODO : finalize JSON conversion of records

;; (define (common-actions scenario)
;;   (write scenario)
;;   (write (pop-scenario->json scenario))
;;   #t)

;; (test-eq  "do some common actions with pop-scenarios" #t (common-actions green-energy-mix-scenario))

(test-end)

;; 
