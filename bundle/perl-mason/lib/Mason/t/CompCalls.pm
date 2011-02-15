package Mason::t::CompCalls;
use Test::Class::Most parent => 'Mason::Test::Class';

sub test_ampersand : Test(2) {
    my $self = shift;

    $self->add_comp(
        path => '/support/amper_test.mi',
        src  => <<'EOF',
amper_test.<p>
% if (%{$self->cmeta->args}) {
Arguments:<p>
%   foreach my $key (sort keys %{$self->cmeta->args}) {
<b><% $key %></b>: <% $self->cmeta->args->{$key} %><br>
%   }
% }
EOF
    );

    $self->test_comp(
        path => '/support/amper_call.m',
        src  => <<'EOF',
<&/support/amper_test.mi&>
<& amper_test.mi &>
<&  amper_test.mi, &>
<& /support/amper_test.mi
&>
<&
amper_test.mi &>
<&
/support/amper_test.mi
&>
EOF
        expect => <<'EOF',
amper_test.<p>

amper_test.<p>

amper_test.<p>

amper_test.<p>

amper_test.<p>

amper_test.<p>

EOF
    );
    $self->test_comp(
        src => <<'EOF',
<& /support/amper_test.mi, message=>'Hello World!'  &>
<& support/amper_test.mi, message=>'Hello World!',
   to=>'Joe' &>
<& "support/amper_test.mi" &>
% my $dir = "support";
% my %args = (a=>17, b=>32);
<& $dir . "/amper_test.mi", %args &>
EOF
        expect => <<'EOF',
amper_test.<p>
Arguments:<p>
<b>message</b>: Hello World!<br>

amper_test.<p>
Arguments:<p>
<b>message</b>: Hello World!<br>
<b>to</b>: Joe<br>

amper_test.<p>

amper_test.<p>
Arguments:<p>
<b>a</b>: 17<br>
<b>b</b>: 32<br>

EOF
    );
}

1;
