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

(define green-energy-mix-service
  `((id . "green-energy-mix")
    (dir . "$HOME/Ontwikkeling/Werk/Vandebron")
    (base_url . "http://localhost:50000")
    (start_cmd_args . #("sbt \"greenEnergyMix/run\""))
    (env_vars . ((NATIONAAL_ENERGIE_DASHBOARD_TOKEN . "002b9a99a4d98cdee8aabf3abb0778cb649126ffbffc1bcde516884797809ce9")))
    (health_check . ((path . "/health")
                     (patience_seconds . 120)))))

(use-modules (json))
(scm->json green-energy-mix-service)
