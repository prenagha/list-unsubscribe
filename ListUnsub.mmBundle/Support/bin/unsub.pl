#!/usr/bin/perl

use URI;

if ($ENV{MM_LIST_UNSUB} =~ /<mailto:([^>]+)/i) {
  my $uri   = URI->new($1);
  my $to = $uri->path;
  my %query = $uri->query_form;
  my $subject = $query{subject};
  if (!defined $subject || $subject eq '') {
    $subject = "unsubscribe";
  }  
  my $body = $query{body};
  if (!defined $body || $body eq '') {
    $body = "unsubscribe";
  }  
  my $actions = <<"END_ACTIONS";
{ 
  actions = (
		{
			type = 'createMessage';
			body = '$body';
			headers = {
				"#signature" = '';
				"from" = '$ENV{MM_TO}';
				"to" = '$to';
				"subject" = '$subject';
				"in-reply-to" = '$ENV{MM_MID}';
			};
			resultActions = (
			  { 
			    type = 'sendMessage';
			  },
        {
          type = playSound;
          path = '/System/Library/Sounds/Hero.aiff';
        },
			);
		},
	);
}
END_ACTIONS
 
print $actions;
  
} elsif ($ENV{MM_LIST_UNSUB} =~ /<(https?:[^>]+)/i) {

  my $uri = $1;
  system "open", $uri;
  my $actions = <<"END_ACTIONS";
{ 
  actions = (
		{
			type = 'playSound';
			path = '/System/Library/Sounds/Hero.aiff';
		},
	);
}
END_ACTIONS
print $actions;


} else {

  my $actions = <<"END_ACTIONS";
{ 
  actions = (
		{
			type = 'notify';
			formatString = 'Unsubscribe URI not found ==$ENV{MM_LIST_UNSUB}==';
		},
		{
			type = 'playSound';
			path = '/System/Library/Sounds/Basso.aiff';
		},
	);
}
END_ACTIONS
print $actions;

}
     

