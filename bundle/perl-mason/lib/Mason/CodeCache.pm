package Mason::CodeCache;
use Devel::GlobalDestruction;
use Mason::Moose;
use Mason::Util;

has 'datastore' => ( is => 'ro', isa => 'HashRef', default => sub { {} } );

method get ($key) {
    return $self->{datastore}->{$key};
}

method set ( $key, $data ) {
    $self->{datastore}->{$key} = $data;
}

method remove ($key) {
    if ( my $entry = $self->{datastore}->{$key} ) {
        my $compc = $entry->{compc};
        if ( !in_global_destruction() ) {
            $compc->meta->make_mutable();
            Mason::Util::delete_package($compc);
        }
        delete $self->{datastore}->{$key};
    }
}

method get_keys () {
    return keys( %{ $self->{datastore} } );
}

1;

# ABSTRACT: Result returned from Mason request
__END__

=pod

=head1 DESCRIPTION

Internal class that Manages the cache of components for L<Mason::Interp>.

=cut
