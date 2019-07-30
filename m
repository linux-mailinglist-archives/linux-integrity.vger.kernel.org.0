Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFC47A599
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 12:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfG3KHt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 06:07:49 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45852 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfG3KHt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 06:07:49 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5960C72CCE8;
        Tue, 30 Jul 2019 13:07:43 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 3BE854A4AE7;
        Tue, 30 Jul 2019 13:07:43 +0300 (MSK)
Date:   Tue, 30 Jul 2019 13:07:41 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190730100741.wqmvkotmgxywdi4i@altlinux.org>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190729042035.7833-1-vt@altlinux.org>
 <20190730082742.GA10234@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190730082742.GA10234@dell5510>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Petr,

On Tue, Jul 30, 2019 at 10:27:43AM +0200, Petr Vorel wrote:
> only v1 runs without failure, when running v2 and v3 sign_verify fails:
> (testing on on bash 5.0.7 on openSUSE and 5.0.3 on Debian)

v3 should be run over all my other fixes I sent to pass.

> evmctl is ../src/evmctl
> openssl is /usr/bin/openssl
> xxd is /usr/bin/xxd
> getfattr is /usr/bin/getfattr
> [1;33m- evmctl ima_sign --rsa --sigfile --hashalgo md5 --key test-rsa1024.key --xattr-user md5.txt~[m
> evmctl ima_sign failed properly with (255) 
> - openssl dgst -sha1 sha1.txt
> - openssl dgst -sha1 -sign test-rsa1024.key -hex sha1.txt
> [1;33m+ evmctl ima_sign --rsa --sigfile --hashalgo sha1 --key test-rsa1024.key --xattr-user sha1.txt[m
> [1;33m+ evmctl ima_verify --key test-rsa1024.pub --xattr-user --rsa sha1.txt[m
> [1;31m
> evmctl ima_verify failed with (1) 
>   Failed to d2i_X509_fp key file: test-rsa1024.pub
>   openssl: error:0D0680A8:asn1 encoding routines:asn1_check_tlen:wrong tag
>   openssl: error:0D07803A:asn1 encoding routines:asn1_item_embed_d2i:nested asn1 error

evmctl w/o `-v` does not show why verify is failed.

This "Failed to d2i_X509_fp key file" is failure to read multiple keys
which is happen _before_ verify operation. (This is fixed in
"ima-evm-utils: Do not load keys from x509 certs if user pass --rsa").

You may re-run test with VERBOSE=1 ./sign_verify.test for more output to
see why it's actually failed to verify.

But, if you didn't apply my other fixes it's probably that public key is
not loaded.

So, this was valid bug in evmctl found by the tests.

> [1;33m- evmctl ima_verify --key test-rsa1024.pub --xattr-user --rsa /dev/null,sha1.txt[m
> evmctl ima_verify failed properly with (255) 
> - openssl dgst -sha1 sha1.txt
> - openssl dgst -sha1 -sign test-rsa1024.key -hex sha1.txt
> [1;33m+ evmctl sign --rsa --hashalgo sha1 --key test-rsa1024.key --xattr-user sha1.txt[m
> [1;31m
> evmctl sign failed with (255) 
>   Failed to read UUID. Root access might require.

I never got this error myself (always running the tests under user). This
is error from `blkid'.

I should pass `--uuid ...' for this test, thanks.

> > --- /dev/null
> > +++ b/tests/functions.sh
> > @@ -0,0 +1,269 @@
> > +#!/bin/bash
> I'd still vote for /bin/sh and posix syntax. evmctl can be cross compiled for
> embedded device. Than, it'd have to be run on the target, which can be tiny
> linux customised distro with busybox shell. That's why POSIX shell syntax
> instead of relying on bash.

Tests are not required to compile evmctl.
On tiny embedded box you may not have gcc so lets code on perl instead.
You may not have also asciidoc but it is used in ima-evm-utils build.

> Debian also has nice script that can be used to check for non-portable shell code:
> https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl

I know, but I disagree to port tests from bash to posix shell.

> > +# SPDX-License-Identifier: GPL-2.0
> This is the correct SPDX for GPL v2+:
> # SPDX-License-Identifier: GPL-2.0-or-later

I am not expert is this, but, as I understand, text in license "or later"
doesn't mean license is GPL-2.0-or-later, because both texts contain "or
later" statement.

  https://spdx.org/licenses/GPL-2.0-only.html
  https://spdx.org/licenses/GPL-2.0-or-later.html

GPL-2.0 is ambiguous enough like real license is.

I agree to change to license which is stated in COPYING of
ima-evm-utils, but what it's correct tag?

> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation; either version 2, or (at your option)
> > +# any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> SPDX license identifier replaces GPL verbose text. These 2 paragraphs can be
> deleted.

All countries agree to that?

> > +# Exit codes (compatible with automake)
> > +declare -r OK=0
> Can you please omit 'declare -r'? It's nice to have read only variables, but
> it's a bashism (not working in busybox nor in dash).

Please no dash propaganda.

> > +declare -r FAIL=1
> > +declare -r HARDFAIL=99 # hard failure no matter testing mode
> > +declare -r SKIP=77     # skip test
> Also comment "skip test" might be omitted (it's obvious).

Hm.

> > +# You can set env VERBOSE=1 to see more output from evmctl
> > +V=vvvv
> > +V=${V:0:$VERBOSE}
> > +V=${V:+-$V}
> Maybe it's just me but it's not really readable.

Yeah. But that would you suggest to make number of -v in V the same as
number in $VERBOSE?

> > +# Only allow color output on tty
> > +if tty -s; then
> BTW I'd prefer the output to file to be plain text (I have vim plugin to show
> colors, but not everybody has). Now it does not (forcing by red_always ?).
> [ -t 1 ] will do the check.
> Or, you could even have variable to allow user to chose, example from LTP [1]

Yes I will disable coloring if tests are run inside of make.
I neglected to fix that, because I found colored test-suite.log is still
useful. (Even though less -R does not show red colored parts.)

> > +  [[ "$VERBOSE" -gt 1 ]] && echo "____ START positive test: $@"
> Bashism, use [ ]

This is intentional since ['s -gt will output error if $VERBOSE is not
a number.

> > +  case $ret in
> > +    0)  testspass+=1 ;;
> Bashism, use testspass=$((testspass+1))
> > +    77) testsskip+=1 ;;
> > +    99) testsfail+=1; exit_early 1 ;;
> > +    *)  testsfail+=1; exit_early 2 ;;
> > +  esac
> > +  return $ret
> > +}
> > +
> > +# Eval negative test (one that should fail) and account its result
> > +expect_fail() {
> > +  local ret
> > +
> > +  if [ $TNESTED -gt 0 ]; then
> > +    echo $RED"expect_fail should not be run nested"$NORM
> IMHO it's safer to quote whole string (here ok, but on some circumstances shell
> handles quoted and unquoted string differently):
> echo "$REDexpect_fail should not be run nested $NORM"

I think quoting there is just a matter of style, not of safety.

> > +  TFAIL=yes
> > +  TMODE=-
> > +  TNESTED+=1
> > +  [[ "$VERBOSE" -gt 1 ]] && echo "____ START negative test: $@"
> > +  "$@"
> > +  ret=$?
> > +  [[ "$VERBOSE" -gt 1 ]] && echo "^^^^ STOP ($ret) negative test: $@"
> > +  TNESTED+=-1
> > +  case $ret in
> > +    0)  testsfail+=1; exit_early 3 ;;
> > +    77) testsskip+=1 ;;
> > +    99) testsfail+=1; exit_early 4 ;;
> > +    *)  testspass+=1 ;;
> > +  esac
> > +  TFAIL= # Restore defaults for tests run without wrappers
> > +  TMODE=+
> I guess you wanted TMODE=

No. Comment says I want to restore defaults, and default values for
these are same as for positive testing. I may expend comment.

> > +  if [ $ret -ge 126 -a $ret -lt 255 ]; then
> > +    red_always
> > +    echo "evmctl $op failed hard with ($ret) $text_for"
> > +    sed 's/^/  /' $out
> > +    color_restore
> I'd reset terminal inside coloring functions (color_restore() and $NORM).
> red()
> {
> 	printf '\033[1;31m'
> 	echo "$@"
> 	printf '\033[0m'
> }

What do you mean? Hm...

Argument in `red_always' is just to pass `-n` if needed. But it was
never needed, so I can delete it. Blank line was intentional. And
it enables red for all next lines until `color_restore' sends color 
restore.

> red "evmctl $op failed hard with ($ret) $text_for"

This may be useful for red oneliners, I thought about them, but not
added. I thought it's beneficent that I output only with `echo' and not
with some unusual custom printing function.

> > +cd $(dirname $0)
> > +PATH=../src:$PATH
> 
> > +source ./functions.sh
> Bashism, use . 

Since I don't plan to remove bashisms...

> Maybe
> 
> . $(dirname $0)/functions.sh
> 
> and in functions.sh
> export PATH="../src:$PATH"
> 
> (that reduces duplicity, but then you'd need to source it also in tests/gen-keys.sh)

You forgot to `cd'. To put it in functions.sh would be too strong side
effect.

> > +  cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$alg $file"
> Why not set ENGINE once at the beginning of the script (or in functions.sh if
> needed on more places)?

It could be replaced with two env variables.
  One for openssl with `-engine x'
  and another for evmctl with `--engine x'.
It's possible but this is purely optimisation. Maybe OK.

> > +# Convert test $type into evmctl op prefix
> > +op() {
> > +  if [ $1 = ima ]; then
> > +    echo ima_
> > +  fi
> Maybe just
> [ "$1" = "ima" ] && echo "ima_"

Maybe.

> > +# Convert test $type into xattr name
> > +xattr() {
> > +  if [ $1 = ima ]; then
> > +    echo user.ima
> > +  else
> > +    echo user.evm
> > +  fi
> Maybe just:
> [ "$1" = "ima" ] && echo "user.ima" || echo "user.evm"

Matter of style. Besides `x && y || z` is not too understandable in
shell context for general person. (Yes I use it too in non critical part
to output colors). But, what if second || affects result of echo and not
of [? (Question about ease of understandability).

> > +  local "$@"
> Not sure if this works everywhere as you expect.

It works in bash.

> In most of the cases you set these global variables anyway, so cleaner would be
> to use getopts (instead overwriting global variables).

This would require a lot of rework and make test more complicated?

> > +  local KEY=${KEY%.*}.key
> > +  local FILE=${FILE:-$ALG.txt}
> I'd use lower case for local variables.

But they are globals (becoming locals).

> > +  # Fix keyid in the prefix.
> > +  if [[ $PREF =~ K ]]; then
> Bashism, could you please use grep instead of [[ =~ ]]?

If I were against bashisms I'd suggest using expr.

> Kind regards,

Thanks for the review!

Thanks,
