#!/usr/bin/perl -w
# 
# Author: Cyril Lopez <contact@lopez-cyril.nom.fr>
# 
# Copyright 2018 Cyril Lopez
#
# Based on Boursorama (french web site), http://www.boursorama.com
# 
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
#
# LIBS
use strict;
use LWP::UserAgent;
use Mojo::DOM;
use HTML::Strip;
use feature 'say';

# URL for search
my $base = 'https://www.boursorama.com/recherche/';

# init Browser, redirect one needed from search
my $ua =
  LWP::UserAgent->new(
    agent => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
    max_redirect => 1 );

# Short name as RHT
my $stock = shift || die "Usage: $0 stock\n";
# Request
my $req = HTTP::Request->new( GET => "${base}${stock}" );

# Run the request and get the content
my $res = $ua->request($req);
my $content = $res->content();

# Parse the HTML content
my $dom = Mojo::DOM->new($content);
# Get the DIV where value is
my $selectdata = $dom->find('div.c-faceplate__price')->join;
# Cleanup and print
my $hs = HTML::Strip->new();
say $hs->parse( $selectdata );

