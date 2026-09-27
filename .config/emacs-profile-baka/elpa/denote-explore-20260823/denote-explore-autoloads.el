;;; denote-explore-autoloads.el --- automatically extracted autoloads

;;; Code:

(autoload 'denote-explore-network "denote-explore" "Visualise the Denote notes network." t)
(autoload 'denote-explore-network-regenerate "denote-explore" "Regenerate the network data for the Denote notes network." t)
(autoload 'denote-explore-barchart-degree "denote-explore" "Show a barchart of the degree of each note." t)
(autoload 'denote-explore-barchart-backlinks "denote-explore" "Show a barchart of backlinks for each note." t)
(autoload 'denote-explore-count-notes "denote-explore" "Count the number of notes in the Denote directory." t)
(autoload 'denote-explore-count-keywords "denote-explore" "Count keywords in the Denote directory." t)
(autoload 'denote-explore-barchart-filetypes "denote-explore" "Show a barchart of file types in the Denote directory." t)
(autoload 'denote-explore-barchart-keywords "denote-explore" "Show a barchart of keywords in the Denote directory." t)
(autoload 'denote-explore-barchart-timeline "denote-explore" "Show a barchart timeline of notes." t)
(autoload 'denote-explore-random-note "denote-explore" "Open a random note." t)
(autoload 'denote-explore-random-regex "denote-explore" "Open a random note matching REGEXP." t)
(autoload 'denote-explore-random-link "denote-explore" "Follow a random link from the current note." t)
(autoload 'denote-explore-random-keyword "denote-explore" "Open a random note with a random keyword." t)
(autoload 'denote-explore-duplicate-notes "denote-explore" "Find duplicate notes." t)
(autoload 'denote-explore-duplicate-notes-dired "denote-explore" "Find duplicate notes and open in Dired." t)
(autoload 'denote-explore-missing-links "denote-explore" "Find missing links." t)
(autoload 'denote-explore-zero-keywords "denote-explore" "Find notes with zero keywords." t)
(autoload 'denote-explore-single-keywords "denote-explore" "Find keywords used only once." t)
(autoload 'denote-explore-rename-keywords "denote-explore" "Rename keywords." t)
(autoload 'denote-explore-sync-metadata "denote-explore" "Sync front matter with filename." t)
(autoload 'denote-explore-isolated-files "denote-explore" "Find isolated files." t)

;;;###autoload
(define-derived-mode denote-explore-network-mode fundamental-mode "Denote Explore Network"
  "Major mode for the Denote Explore Network buffer."
  (setq-local mode-name "Denote Explore Network"))

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; denote-explore-autoloads.el ends here
