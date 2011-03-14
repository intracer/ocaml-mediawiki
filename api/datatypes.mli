open Http_client

type id = int64

type query = (string * string option) list

type namespace = int

type timestamp = Netdate.t

type language = string

type token_type = [ `EDIT ]

type redirect_filter = [ `ALL | `REDIRECT | `NOT_REDIRECT ]
type user_filter = [ `ALL | `EXCLUDE of string | `ONLY of string ]
type category_filter = [ `HIDDEN | `NOT_HIDDEN ]

type minor_flag = [ `DEFAULT | `MINOR | `NOT_MINOR ]
type watch_flag = [ `DEFAULT | `WATCH | `UNWATCH | `NO_CHANGE ]
type create_flag = [ `DEFAULT | `NO_CREATE | `CREATE_ONLY | `RECREATE ]

type edit_status = [ `UPDATE | `NO_CHANGE | `NEW ]

type token = {
  token : string;
  token_type : token_type;
  token_ts : timestamp;
}

type title = {
  title_path : string;
  title_namespace : namespace;
}

type page = {
  page_title : title;
  page_id : id;
  page_touched : timestamp;
  page_lastrevid : id;
  page_length : int;
  page_redirect : bool;
  page_new : bool;
}

type revision = {
  rev_id : id;
  rev_page : id;
  rev_timestamp : timestamp;
  rev_user : string;
  rev_comment : string;
  rev_minor : bool;
}

type langlink = {
  lang_title : string;
  lang_language : language;
}

class type site =
  object
    method name : string
    method query : query -> string
    method session : session option
    method set_session : session -> unit
    method clear_session : unit -> unit
  end

and session =
  object
    method site : site
    method username : string option
    method userid : id
    method is_valid : bool
    method get_call : query -> Call.call
    method post_call : query -> Call.call
    method edit_token : token
    method logout : unit -> unit
  end
