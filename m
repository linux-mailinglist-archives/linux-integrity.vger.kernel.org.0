Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC97B633
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2019 01:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfG3XYM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 19:24:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:58998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfG3XYM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 19:24:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 451F7AEE1;
        Tue, 30 Jul 2019 23:24:09 +0000 (UTC)
Date:   Wed, 31 Jul 2019 01:24:07 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190730232407.GA2402@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190729042035.7833-1-vt@altlinux.org>
 <20190730082742.GA10234@dell5510>
 <20190730100741.wqmvkotmgxywdi4i@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190730100741.wqmvkotmgxywdi4i@altlinux.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

> evmctl w/o `-v` does not show why verify is failed.

> This "Failed to d2i_X509_fp key file" is failure to read multiple keys
> which is happen _before_ verify operation. (This is fixed in
> "ima-evm-utils: Do not load keys from x509 certs if user pass --rsa").

> You may re-run test with VERBOSE=1 ./sign_verify.test for more output to
> see why it's actually failed to verify.

> But, if you didn't apply my other fixes it's probably that public key is
> not loaded.
I tested v3 on the top of current next, i.e. on the top of commit cf1b8fd
("ima-evm-utils: Allow EVM verify to determine hash algo").

> So, this was valid bug in evmctl found by the tests.

> > [1;33m- evmctl ima_verify --key test-rsa1024.pub --xattr-user --rsa /dev/null,sha1.txt[m
> > evmctl ima_verify failed properly with (255) 
> > - openssl dgst -sha1 sha1.txt
> > - openssl dgst -sha1 -sign test-rsa1024.key -hex sha1.txt
> > [1;33m+ evmctl sign --rsa --hashalgo sha1 --key test-rsa1024.key --xattr-user sha1.txt[m
> > [1;31m
> > evmctl sign failed with (255) 
> >   Failed to read UUID. Root access might require.

> I never got this error myself (always running the tests under user). This
> is error from `blkid'.

> I should pass `--uuid ...' for this test, thanks.
With proper cleanup VERBOSE=1 ./sign_verify.test has now only 10 failures, all
about missing key test-gost2012_256-*.key.
Now command blkid -s UUID -o value /dev/block/254:4 works even on non-root.
Not sure what happen, I suppose the problem is somewhere on my side.

> > > --- /dev/null
> > > +++ b/tests/functions.sh
> > > @@ -0,0 +1,269 @@
> > > +#!/bin/bash
> > I'd still vote for /bin/sh and posix syntax. evmctl can be cross compiled for
> > embedded device. Than, it'd have to be run on the target, which can be tiny
> > linux customised distro with busybox shell. That's why POSIX shell syntax
> > instead of relying on bash.

> Tests are not required to compile evmctl.
> On tiny embedded box you may not have gcc so lets code on perl instead.
> You may not have also asciidoc but it is used in ima-evm-utils build.
My point was cross compile on host, but run the test on target.
My assumption was that it makes sense to run tests on target.
I mean if you get a bug report on arm or unusual architecture (I got the
impression that IMA+EVM is used on arm a lot), you ask reporter to copy tests
directory and run tests. Now you have to ask for bash as well (but better than
perl/python :)).

Although, as there is AFAIK no arch dependent code, it might not make sense to
test it on target (enough to run the code compiled natively).
The changes wouldn't be that hard, just using a different style and more
external commands instead of bash specific builtins.
But whatever, I got the message that bash dependency stay, sorry for bothering you with it :).
The main goal is to cover evmctl with tests, which you did very well.

...
> > > +# You can set env VERBOSE=1 to see more output from evmctl
> > > +V=vvvv
> > > +V=${V:0:$VERBOSE}
> > > +V=${V:+-$V}
> > Maybe it's just me but it's not really readable.

> Yeah. But that would you suggest to make number of -v in V the same as
> number in $VERBOSE?
Well, my style would be to use awk (awk is very common and portable), but many
people (including me) consider awk syntax obscure and nonintuitive, so
understand it's not an option for you.

Maybe more descriptive variable would make it clearer.
And mention in docs that VERBOSE can be <1-4>.
But, again, a detail.

> > > +# Only allow color output on tty
> > > +if tty -s; then
> > BTW I'd prefer the output to file to be plain text (I have vim plugin to show
> > colors, but not everybody has). Now it does not (forcing by red_always ?).
> > [ -t 1 ] will do the check.
> > Or, you could even have variable to allow user to chose, example from LTP [1]

> Yes I will disable coloring if tests are run inside of make.
> I neglected to fix that, because I found colored test-suite.log is still
> useful. (Even though less -R does not show red colored parts.)
ok, thanks.

> > > +  [[ "$VERBOSE" -gt 1 ]] && echo "____ START positive test: $@"
> > Bashism, use [ ]

> This is intentional since ['s -gt will output error if $VERBOSE is not
> a number.

> > > +  case $ret in
> > > +    0)  testspass+=1 ;;
> > Bashism, use testspass=$((testspass+1))
> > > +    77) testsskip+=1 ;;
> > > +    99) testsfail+=1; exit_early 1 ;;
> > > +    *)  testsfail+=1; exit_early 2 ;;
> > > +  esac
> > > +  return $ret
> > > +}
> > > +
> > > +# Eval negative test (one that should fail) and account its result
> > > +expect_fail() {
> > > +  local ret
> > > +
> > > +  if [ $TNESTED -gt 0 ]; then
> > > +    echo $RED"expect_fail should not be run nested"$NORM
> > IMHO it's safer to quote whole string (here ok, but on some circumstances shell
> > handles quoted and unquoted string differently):
> > echo "$REDexpect_fail should not be run nested $NORM"

> I think quoting there is just a matter of style, not of safety.

> > > +  TFAIL=yes
> > > +  TMODE=-
> > > +  TNESTED+=1
> > > +  [[ "$VERBOSE" -gt 1 ]] && echo "____ START negative test: $@"
> > > +  "$@"
> > > +  ret=$?
> > > +  [[ "$VERBOSE" -gt 1 ]] && echo "^^^^ STOP ($ret) negative test: $@"
> > > +  TNESTED+=-1
> > > +  case $ret in
> > > +    0)  testsfail+=1; exit_early 3 ;;
> > > +    77) testsskip+=1 ;;
> > > +    99) testsfail+=1; exit_early 4 ;;
> > > +    *)  testspass+=1 ;;
> > > +  esac
> > > +  TFAIL= # Restore defaults for tests run without wrappers
> > > +  TMODE=+
> > I guess you wanted TMODE=

> No. Comment says I want to restore defaults, and default values for
> these are same as for positive testing. I may expend comment.

> > > +  if [ $ret -ge 126 -a $ret -lt 255 ]; then
> > > +    red_always
> > > +    echo "evmctl $op failed hard with ($ret) $text_for"
> > > +    sed 's/^/  /' $out
> > > +    color_restore
> > I'd reset terminal inside coloring functions (color_restore() and $NORM).
> > red()
> > {
> > 	printf '\033[1;31m'
> > 	echo "$@"
> > 	printf '\033[0m'
> > }

> What do you mean? Hm...

> Argument in `red_always' is just to pass `-n` if needed. But it was
> never needed, so I can delete it. Blank line was intentional. And
> it enables red for all next lines until `color_restore' sends color 
> restore.

> > red "evmctl $op failed hard with ($ret) $text_for"

> This may be useful for red oneliners, I thought about them, but not
> added. I thought it's beneficent that I output only with `echo' and not
> with some unusual custom printing function.

> > > +cd $(dirname $0)
> > > +PATH=../src:$PATH

> > > +source ./functions.sh
> > Bashism, use . 

> Since I don't plan to remove bashisms...

> > Maybe

> > . $(dirname $0)/functions.sh

> > and in functions.sh
> > export PATH="../src:$PATH"

> > (that reduces duplicity, but then you'd need to source it also in tests/gen-keys.sh)

> You forgot to `cd'. To put it in functions.sh would be too strong side
> effect.
Agree on both. I'd still prefer put PATH to functions.sh, but that's a detail.

> > > +  cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$alg $file"
> > Why not set ENGINE once at the beginning of the script (or in functions.sh if
> > needed on more places)?

> It could be replaced with two env variables.
>   One for openssl with `-engine x'
>   and another for evmctl with `--engine x'.
> It's possible but this is purely optimisation. Maybe OK.
I noted it, as simple variable  increases readability a bit.

> > > +# Convert test $type into evmctl op prefix
> > > +op() {
> > > +  if [ $1 = ima ]; then
> > > +    echo ima_
> > > +  fi
> > Maybe just
> > [ "$1" = "ima" ] && echo "ima_"

> Maybe.

> > > +# Convert test $type into xattr name
> > > +xattr() {
> > > +  if [ $1 = ima ]; then
> > > +    echo user.ima
> > > +  else
> > > +    echo user.evm
> > > +  fi
> > Maybe just:
> > [ "$1" = "ima" ] && echo "user.ima" || echo "user.evm"

> Matter of style. Besides `x && y || z` is not too understandable in
> shell context for general person. (Yes I use it too in non critical part
> to output colors). But, what if second || affects result of echo and not
> of [? (Question about ease of understandability).
OK, sorry for bothering with details and pushing my style.

...

Kind regards,
Petr
