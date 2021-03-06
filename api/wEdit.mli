(** {5 Edit queries}

  These queries affects the mediawiki database.

*)

open WTypes
open Datatypes

(** {6 Writing pages} *)

val write_page : session -> ?summary:string -> ?minor:minor_flag ->
  ?watch:watch_flag -> ?bot:bool -> ?create:create_flag ->
  page -> string -> edit_status Call.t
(** Write a given page and return the status. This function checks that there
    is no conflict thanks to the last timestamp of the page.

  @param summary Summary of the edit. Default: empty
  @param minor Set the minor flag. Default: [`DEFAULT]
  @param watch Add the page to your watchlist. Default: [`DEFAULT]
  @param bot Set the bot flag. Default: [false]
  @param create Behaviour w.r.t. the existing status. Default: [`DEFAULT]
*)

val write_title : session -> ?summary:string -> ?minor:minor_flag ->
  ?watch:watch_flag -> ?bot:bool -> ?create:create_flag ->
  Title.t -> string -> edit_status Call.t
(** As for {!write_page} but with a title only. Do not check for any conflict. *)

(** {6 Moving pages} *)

val move_page : session -> ?summary:string -> ?watch:watch_flag -> ?rdr:bool -> 
  ?subpages:bool -> ?talk:bool -> ?ignore_warnings:bool ->
  page -> Title.t -> move_result Call.t
(** Move a page to a given title.

  @param summary Reason of the move. Default: empty
  @param watch Add the page to your watchlist. Default: [`DEFAULT]
  @param rdr Create the redirect. Default: [true]
  @param subpages Also move the subpages. Default: [true]
  @param talk Also move the talk page. Default: [true]
  @param ignore_warnings Ignore any warnings. Default: [false]
*)

val move_title : session -> ?summary:string -> ?watch:watch_flag -> ?rdr:bool -> 
  ?subpages:bool -> ?talk:bool -> ?ignore_warnings:bool ->
  Title.t -> Title.t -> move_result Call.t
(** As for {!move_page} but with a title only. *)

(** {6 Deleting pages} *)

val delete_title : session -> ?summary:string -> ?watch:watch_flag -> 
  Title.t -> unit Call.t
(** Delete a given page.

  @param summary Reason for the deletion. Default: empty
  @param watch Add the page to your watchlist. Default: [`DEFAULT]
*)

(** {6 Uploading} *)

val upload_file : session -> ?summary:string -> ?text:string -> 
  ?watch:watch_flag -> ?ignore_warnings:bool -> 
  string -> string -> upload_result Call.t
(** [upload_file s dest file] uploads local file [file] to remote file [dest].

  @param summary Comment to the upload. Default: empty
  @param text Text to put on empty description pages. Default: Same as [summary]
  @param watch Add the page to your watchlist. Default: [`DEFAULT]
  @param ignore_warnings Ignore any warnings. Default: [false]
*)
