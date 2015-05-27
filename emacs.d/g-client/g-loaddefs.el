;;;Auto generated

;;;### (autoloads (g-auth-lifetime) "g-auth" "g-auth.el" (20379 9383))
;;; Generated autoloads from g-auth.el

(defvar g-auth-lifetime "4 hours" "\
Auth lifetime.")

(custom-autoload (quote g-auth-lifetime) "g-auth" nil)

;;;***

;;;### (autoloads (gblogger-sign-in gblogger-sign-out gblogger-add-label
;;;;;;  gblogger-delete-entry gblogger-new-entry gblogger-edit-entry
;;;;;;  gblogger-atom-display gblogger-blog) "gblogger" "gblogger.el"
;;;;;;  (20328 48785))
;;; Generated autoloads from gblogger.el

(autoload (quote gblogger-blog) "gblogger" "\
Retrieve and display feed of feeds after authenticating.

\(fn)" t nil)

(autoload (quote gblogger-atom-display) "gblogger" "\
Retrieve and display specified feed after authenticating.

\(fn FEED-URL)" t nil)

(autoload (quote gblogger-edit-entry) "gblogger" "\
Retrieve entry and prepare it for editting.
The retrieved entry is placed in a buffer ready for editing.
`url' is the URL of the entry.

\(fn URL)" t nil)

(autoload (quote gblogger-new-entry) "gblogger" "\
Create a new Blog post.

\(fn URL &optional TITLE TEXT)" t nil)

(autoload (quote gblogger-delete-entry) "gblogger" "\
Delete item at specified edit URL.

\(fn EDIT-URL)" t nil)

(autoload (quote gblogger-add-label) "gblogger" "\
Adds labels to gblogger entry being editted.

\(fn LABEL)" t nil)

(autoload (quote gblogger-sign-out) "gblogger" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gblogger-sign-in) "gblogger" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

;;;***

;;;### (autoloads (gbooks-sign-in gbooks-sign-out) "gbooks" "gbooks.el"
;;;;;;  (20336 46200))
;;; Generated autoloads from gbooks.el

(autoload (quote gbooks-sign-out) "gbooks" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gbooks-sign-in) "gbooks" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

;;;***

;;;### (autoloads (gcal-sign-in gcal-sign-out gcal-emacs-calendar-setup
;;;;;;  gcal-show-event gcal-view gcal-calendar-agenda-days gcal-reject-event
;;;;;;  gcal-delete-event gcal-quickadd-event gcal-add-event gcal-user-email
;;;;;;  gcal-default-user-email) "gcal" "gcal.el" (20328 48785))
;;; Generated autoloads from gcal.el

(defvar gcal-default-user-email nil "\
Default user id for Calendar.")

(custom-autoload (quote gcal-default-user-email) "gcal" t)

(defvar gcal-user-email nil "\
Mail address that identifies calendar user.")

(custom-autoload (quote gcal-user-email) "gcal" t)

(autoload (quote gcal-add-event) "gcal" "\
Add a calendar event.

\(fn)" t nil)

(autoload (quote gcal-quickadd-event) "gcal" "\
Add a calendar event.
Specify the event in plain English.

\(fn EVENT-DESC)" t nil)

(autoload (quote gcal-delete-event) "gcal" "\
Delete a calendar event.

\(fn EVENT-URI)" t nil)

(autoload (quote gcal-reject-event) "gcal" "\
Reject (RSVP)  a calendar event.

\(fn EVENT-URI)" t nil)

(defvar gcal-calendar-agenda-days 5 "\
Number of days for which we show an agenda by default.")

(custom-autoload (quote gcal-calendar-agenda-days) "gcal" t)

(autoload (quote gcal-view) "gcal" "\
Retrieve and display resource after authenticating.

\(fn RESOURCE)" t nil)

(autoload (quote gcal-show-event) "gcal" "\
Show event at URL.

\(fn URL)" t nil)

(define-prefix-command (quote gcal-calendar-prefix-map))

(autoload (quote gcal-emacs-calendar-setup) "gcal" "\
Setup GCal keybindings in Emacs calendar.

\(fn)" nil nil)

(autoload (quote gcal-sign-out) "gcal" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gcal-sign-in) "gcal" "\
Sign in, useful when changing to a different user profile.

\(fn)" t nil)

;;;***

;;;### (autoloads (gcontacts-create gcontacts-initialize) "gcontacts"
;;;;;;  "gcontacts.el" (20328 48785))
;;; Generated autoloads from gcontacts.el

(autoload (quote gcontacts-initialize) "gcontacts" "\
Initialize GContacts process handle.

\(fn USERNAME)" t nil)

(autoload (quote gcontacts-create) "gcontacts" "\
Create a new contact as specified.

\(fn NAME EMAIL MOBILE)" t nil)

;;;***

;;;### (autoloads (gdocs-sign-in gdocs-sign-out gdocs-view-item gdocs-delete-item
;;;;;;  gdocs-add-collaborator gdocs-doclist) "gdocs" "gdocs.el"
;;;;;;  (20328 48785))
;;; Generated autoloads from gdocs.el

(autoload (quote gdocs-doclist) "gdocs" "\
Retrieve and display feed of feeds after authenticating.
Interactive prefix arg prompts for a query string.

\(fn &optional QUERY)" t nil)

(autoload (quote gdocs-add-collaborator) "gdocs" "\
Add collaborator to ACL at acl-url.
You can find the acl-url through the DocList.

\(fn EMAIL ACL-URL)" t nil)

(autoload (quote gdocs-delete-item) "gdocs" "\
Delete specified item.

\(fn URL)" t nil)

(autoload (quote gdocs-view-item) "gdocs" "\
View specified item.

\(fn URL)" t nil)

(autoload (quote gdocs-sign-out) "gdocs" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gdocs-sign-in) "gdocs" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

;;;***

;;;### (autoloads (gfeeds-lookup-and-view gfeeds-view gfeeds-titles
;;;;;;  gfeeds-freshness) "gfeeds" "gfeeds.el" (20328 48785))
;;; Generated autoloads from gfeeds.el

(defsubst gfeeds-feed (feed-url) "\
Return feed structure." (declare (special gfeeds-feeds-url gfeeds-referer)) (let ((result nil)) (g-using-scratch (call-process g-curl-program nil t nil "-s" "-e" gfeeds-referer (format gfeeds-feeds-url (g-url-encode feed-url))) (goto-char (point-min)) (setq result (json-read)) (when (= 200 (g-json-get (quote responseStatus) result)) (g-json-get (quote feed) (g-json-get (quote responseData) result))))))

(defsubst gfeeds-lookup (url) "\
Lookup feed for a given Web page." (declare (special gfeeds-lookup-url gfeeds-referer)) (let ((result nil)) (g-using-scratch (call-process g-curl-program nil t nil "-s" "-e" gfeeds-referer (format gfeeds-lookup-url (g-url-encode url))) (goto-char (point-min)) (setq result (json-read)) (when (= 200 (g-json-get (quote responseStatus) result)) (g-json-get (quote url) (g-json-get (quote responseData) result))))))

(defsubst gfeeds-find (query) "\
Find feeds matching a query." (declare (special gfeeds-find-url gfeeds-referer)) (let ((result nil)) (g-using-scratch (call-process g-curl-program nil t nil "-s" "-e" gfeeds-referer (format gfeeds-find-url (g-url-encode query))) (goto-char (point-min)) (setq result (json-read)) (when (= 200 (g-json-get (quote responseStatus) result)) (g-json-get (quote entries) (g-json-get (quote responseData) result))))))

(defvar gfeeds-freshness "1 hour" "\
Freshness used to decide if we return titles.")

(custom-autoload (quote gfeeds-freshness) "gfeeds" nil)

(autoload (quote gfeeds-titles) "gfeeds" "\
Return list of titles from feed at feed-url.

\(fn FEED-URL)" nil nil)

(autoload (quote gfeeds-view) "gfeeds" "\
Display Feed in a browser.
Interactive prefix arg causes the feed url to be looked up given a Web site.

\(fn URL &optional LOOKUP)" t nil)

(autoload (quote gfeeds-lookup-and-view) "gfeeds" "\
Lookup feed URL for a site and browse result.

\(fn SITE)" t nil)

;;;***

;;;### (autoloads (gfinance-sign-in gfinance-sign-out gfinance-display-feed
;;;;;;  gfinance-portfolios) "gfinance" "gfinance.el" (20328 48785))
;;; Generated autoloads from gfinance.el

(autoload (quote gfinance-portfolios) "gfinance" "\
Retrieve and display feed of feeds after authenticating.

\(fn)" t nil)

(autoload (quote gfinance-display-feed) "gfinance" "\
Retrieve and display feedat feed-url  after authenticating.

\(fn FEED-URL)" t nil)

(autoload (quote gfinance-sign-out) "gfinance" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gfinance-sign-in) "gfinance" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

;;;***

;;;### (autoloads (ghealth-sign-in ghealth-sign-out) "ghealth" "ghealth.el"
;;;;;;  (20328 48785))
;;; Generated autoloads from ghealth.el

(autoload (quote ghealth-sign-out) "ghealth" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote ghealth-sign-in) "ghealth" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

;;;***

;;;### (autoloads (gphoto-edit-entry gphoto-sign-in gphoto-sign-out
;;;;;;  gphoto-comment-or-tag gphoto-directory-add-photos gphoto-photo-add
;;;;;;  gphoto-album-create gphoto-user-tagsearch gphoto-user-search
;;;;;;  gphoto-recent gphoto-community-search gphoto-download gphoto-view
;;;;;;  gphoto-tags gphoto-albums gphoto-feeds) "gphoto" "gphoto.el"
;;;;;;  (20328 48785))
;;; Generated autoloads from gphoto.el

(autoload (quote gphoto-feeds) "gphoto" "\
Retrieve and display feed of albums or tags after authenticating.

\(fn KIND USER)" t nil)

(autoload (quote gphoto-albums) "gphoto" "\
Display feed of albums.
Interactive prefix arg prompts for userid whose albums we request.

\(fn &optional PROMPT)" t nil)

(autoload (quote gphoto-tags) "gphoto" "\
View feed of tags.

\(fn)" t nil)

(autoload (quote gphoto-view) "gphoto" "\
Retrieve and display resource after authenticating.

\(fn RESOURCE)" t nil)

(autoload (quote gphoto-download) "gphoto" "\
Download resource after authenticating.

\(fn RESOURCE)" t nil)

(autoload (quote gphoto-community-search) "gphoto" "\
Search all public photos.

\(fn QUERY)" t nil)

(autoload (quote gphoto-recent) "gphoto" "\
Retrieve feed of recently uploaded photos or comments.

\(fn USER KIND)" t nil)

(autoload (quote gphoto-user-search) "gphoto" "\
Retrieve feed of recently uploaded comments for  specified user.

\(fn USER QUERY)" t nil)

(autoload (quote gphoto-user-tagsearch) "gphoto" "\
Retrieve feed o matches comments for  specified user.

\(fn USER TAG)" t nil)

(autoload (quote gphoto-album-create) "gphoto" "\
Create a new GPhoto album.

\(fn)" t nil)

(autoload (quote gphoto-photo-add) "gphoto" "\
Add a photo to an existing album.

\(fn ALBUM-NAME PHOTO)" t nil)

(autoload (quote gphoto-directory-add-photos) "gphoto" "\
Add all jpeg files in a directory to specified album.

\(fn DIRECTORY ALBUM-NAME)" t nil)

(autoload (quote gphoto-comment-or-tag) "gphoto" "\
Add comments or tags  to an existing photo.

\(fn TYPE RESOURCE)" t nil)

(autoload (quote gphoto-sign-out) "gphoto" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gphoto-sign-in) "gphoto" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gphoto-edit-entry) "gphoto" "\
Retrieve metadata for entry and prepare it for editting.
The retrieved entry is placed in a buffer ready for editing.
`url' is the URL of the entry.

\(fn URL)" t nil)

;;;***

;;;### (autoloads (greader-re-authenticate greader-sign-in greader-sign-out
;;;;;;  greader-search greader-find-feeds greader-star greader-add-label
;;;;;;  greader-update-subscription greader-untag-feed greader-tag-feed
;;;;;;  greader-title-feed greader-unsubscribe-feed greader-subscribe-feed
;;;;;;  greader-opml greader-feed-list greader-subscriptions greader-subscription-list
;;;;;;  greader-preferences greader-reading-list) "greader" "greader.el"
;;;;;;  (20328 48784))
;;; Generated autoloads from greader.el

(autoload (quote greader-reading-list) "greader" "\
Ensure our cookies are live, and get the reading list.
Optional interactive prefix `state' prompts for state to retrieve

e.g., starred.

\(fn &optional STATE)" t nil)

(autoload (quote greader-preferences) "greader" "\
Ensure our cookies are live, and get all preferences for this
user.

\(fn)" t nil)

(autoload (quote greader-subscription-list) "greader" "\
Return list of subscribed urls.

\(fn)" nil nil)

(autoload (quote greader-subscriptions) "greader" "\
Return list of subscribed feeds.

\(fn)" nil nil)

(autoload (quote greader-feed-list) "greader" "\
Retrieve list of subscribed feeds.

\(fn)" t nil)

(autoload (quote greader-opml) "greader" "\
Retrieve OPML representation of our subscription list.

\(fn)" t nil)

(autoload (quote greader-subscribe-feed) "greader" "\
Subscribe to specified feed.

\(fn FEED-URL)" t nil)

(autoload (quote greader-unsubscribe-feed) "greader" "\
UnSubscribe from specified feed.

\(fn FEED-URL)" t nil)

(autoload (quote greader-title-feed) "greader" "\
Title  specified feed.

\(fn FEED-URL)" t nil)

(autoload (quote greader-tag-feed) "greader" "\
Tag  specified feed.

\(fn FEED-URL)" t nil)

(autoload (quote greader-untag-feed) "greader" "\
Remove Tag from specified feed.

\(fn FEED-URL)" t nil)

(autoload (quote greader-update-subscription) "greader" "\
Perform specified subscribe, unsubscribe, or edit action.

\(fn FEED-URL ACTION)" nil nil)

(autoload (quote greader-add-label) "greader" "\
Add label to this item.

\(fn ITEM-URL LABEL)" t nil)

(autoload (quote greader-star) "greader" "\
Star this item.

\(fn ITEM-URL)" t nil)

(autoload (quote greader-find-feeds) "greader" "\
Find feeds matching query.

\(fn QUERY)" t nil)

(autoload (quote greader-search) "greader" "\
GReader search.

\(fn QUERY)" t nil)

(autoload (quote greader-sign-out) "greader" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote greader-sign-in) "greader" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote greader-re-authenticate) "greader" "\
Reauthenticate current user.

\(fn)" t nil)

;;;***

;;;### (autoloads (gsheet-sign-in gsheet-sign-out gsheet-sheets gsheet-fetch)
;;;;;;  "gsheet" "gsheet.el" (20328 48785))
;;; Generated autoloads from gsheet.el

(autoload (quote gsheet-fetch) "gsheet" "\
Fetch specified sheet.

\(fn SHEET-URL)" t nil)

(autoload (quote gsheet-sheets) "gsheet" "\
Retrieve and display feed of feeds after authenticating.

\(fn)" t nil)

(autoload (quote gsheet-sign-out) "gsheet" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gsheet-sign-in) "gsheet" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

;;;***

;;;### (autoloads (gskeleton-sign-in gskeleton-sign-out) "gskeleton"
;;;;;;  "gskeleton.el" (20328 48784))
;;; Generated autoloads from gskeleton.el

(autoload (quote gskeleton-sign-out) "gskeleton" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

(autoload (quote gskeleton-sign-in) "gskeleton" "\
Resets client so you can start with a different userid.

\(fn)" t nil)

;;;***

;;;### (autoloads (gtube-video-featured gtube-video-by-user gtube-video-popular
;;;;;;  gtube-video-playlist gtube-video-by-category-and-tag gtube-video-by-tag
;;;;;;  gtube-video-details gtube-user-friends gtube-user-favorites
;;;;;;  gtube-user-profile) "gtube" "gtube.el" (20328 48785))
;;; Generated autoloads from gtube.el

(autoload (quote gtube-user-profile) "gtube" "\
Retrieve user profile.

\(fn &optional USER)" t nil)

(autoload (quote gtube-user-favorites) "gtube" "\
Retrieve user favorites.

\(fn &optional USER)" t nil)

(autoload (quote gtube-user-friends) "gtube" "\
Retrieve user profile.

\(fn &optional USER)" t nil)

(autoload (quote gtube-video-details) "gtube" "\
Display details of specified video.

\(fn VIDEO-ID)" t nil)

(autoload (quote gtube-video-by-tag) "gtube" "\
Retrieve content having specified tag.
optional args page and count specify position in result-set and
  number of results to retrieve.

\(fn TAG &optional PAGE COUNT)" t nil)

(autoload (quote gtube-video-by-category-and-tag) "gtube" "\
Retrieve content from specified category having specified tag.
optional args page and count specify position in result-set and
  number of results to retrieve.

\(fn CATEGORY TAG &optional PAGE COUNT)" t nil)

(autoload (quote gtube-video-playlist) "gtube" "\
Retrieve content in specified playlist.
optional args page and count specify position in result-set and
  number of results to retrieve.

\(fn PLAYLIST-ID &optional PAGE COUNT)" t nil)

(autoload (quote gtube-video-popular) "gtube" "\
Retrieve popular content for specified time-range.
  Time-range is one of day, week, month, or all.

\(fn TIME-RANGE)" t nil)

(autoload (quote gtube-video-by-user) "gtube" "\
Retrieve content from specified user.
optional args page and count specify position in result-set and
  number of results to retrieve.

\(fn USER &optional PAGE COUNT)" t nil)

(autoload (quote gtube-video-featured) "gtube" "\
Retrieved featured video list.

\(fn)" t nil)

;;;***

;;;### (autoloads (gweb-my-address gweb-maps-reverse-geocode gweb-maps-geocode
;;;;;;  gweb-google-at-point) "gweb" "gweb.el" (20328 48785))
;;; Generated autoloads from gweb.el

(defsubst gweb-google-autocomplete-with-corpus (corpus) "\
Read user input using Google Suggest for auto-completion.
Uses specified corpus for prompting and suggest selection." (let* ((completer (intern (format "gweb-%s-suggest-completer" corpus))) (minibuffer-completing-file-name t) (completion-ignore-case t) (word (thing-at-point (quote word))) (query nil)) (unless (fboundp completer) (error "No  suggest handler for corpus %s" corpus)) (setq query (completing-read corpus completer nil nil word (quote gweb-history))) (pushnew query gweb-history) (g-url-encode query)))

(autoload (quote gweb-google-at-point) "gweb" "\
Google for term at point, and display top result succinctly.
Attach URL at point so we can follow it later --- subsequent invocations of this command simply follow that URL.
Optional interactive prefix arg refresh forces this cached URL to be refreshed.

\(fn SEARCH-TERM &optional REFRESH)" t nil)

(autoload (quote gweb-maps-geocode) "gweb" "\
Geocode given address.
Optional argument `raw-p' returns complete JSON  object.

\(fn ADDRESS &optional RAW-P)" nil nil)

(autoload (quote gweb-maps-reverse-geocode) "gweb" "\
Reverse geocode lat-long.
Optional argument `raw-p' returns raw JSON  object.

\(fn LAT-LONG &optional RAW-P)" nil nil)

(defvar gweb-my-location nil "\
Geo coordinates --- automatically set by reverse geocoding gweb-my-address")

(defvar gweb-my-address nil "\
Location address. Setting this updates gweb-my-location coordinates  via geocoding.")

(custom-autoload (quote gweb-my-address) "gweb" nil)

;;;***

;;;### (autoloads nil nil ("g-autogen.el" "g-cus-load.el" "g-load-path.el"
;;;;;;  "g-utils.el" "g.el" "gnotebook.el" "gwis.el" "indent-files.el"
;;;;;;  "org2blogger.el") (20578 587 818082))

;;;***

;;;### (autoloads (g-app-view g-app-publish) "g-app" "g-app.el" (20328
;;;;;;  48785))
;;; Generated autoloads from g-app.el

(autoload (quote g-app-publish) "g-app" "\
Publish current entry.

\(fn)" t nil)

(autoload (quote g-app-view) "g-app" "\
View feed using auth credentials in auth-handle.

\(fn AUTH-HANDLE FEED-URL)" t nil)

;;;***
