package MetaNotes::Views;
use common::sense;

use aliased 'XML::Feed';
use aliased 'XML::Feed::Entry';

use Data::Dump 'pp';
use Text::Xslate;

our $tx;
our $root;

sub init {
  $tx = Text::Xslate->new(
    function => {
      pp => \&pp
    }
  );
  $root = $MetaNotes::CONFIG{root};
}

our %V;
our @V = (

  V(
    'default',

    layout => sub {
      my ($self, $v, $content) = @_;
      $v->{content} = $content;
      $tx->render("$root/layout.html", $v);
    },

    _ => sub {
      my ($self, $v) = @_;
      $v->{self} = $self;
      $tx->render("$root/$self->{template}.html", $v);
    }
  ),

  # TODO - REDO
  V(
    'atom',
    home => sub {
      my ($self, $v) = @_;
      my $feed = Feed->new('Atom');
      $feed->id("http://metanotes.com/");
      $feed->title("MetaNotes");
      $feed->link("http://metanotes.com/");
      $feed->self_link("http://metanotes.com/feed");
      $feed->modified(DateTime->now);

      for (@{ $v->{pictures} }) {
        my $person = $_->persons->first;
        my $entry  = Entry->new;
        $entry->id($self->atom_id($_));
        $entry->link("http://metanotes.com".
          R('Picture', $person->name_, sprintf('%x', $_->id)));
        $entry->title($person->name);
        $entry->content($V{default}->_picture({
          picture    => $_,
          size       => 'm',
          image_host => $v->{image_host},
        }));
        $entry->modified($_->updated_on);
        $feed->add_entry($entry);
      }

      $feed->as_xml;
    },

    atom_id => sub {
      my ($self, $pic) = @_;
      my $first_person = $pic->persons->first;
      "tag:metanotes.com," .
      $pic->created_on->ymd   .
      ":"                     .
      R('Picture', $first_person->name_, sprintf('%x', $pic->id));
    },
  ),

);

1;
