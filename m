Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A47826F
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2019 01:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfG1Xkf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Jul 2019 19:40:35 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59146 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfG1Xkf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jul 2019 19:40:35 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 45F1772CC6C;
        Mon, 29 Jul 2019 02:40:32 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 2B42C4A4A29;
        Mon, 29 Jul 2019 02:40:32 +0300 (MSK)
Date:   Mon, 29 Jul 2019 02:40:31 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH v2] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190728234031.ucyu6fj4pvr4owd3@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
References: <20190727044113.3865-1-vt@altlinux.org>
 <1564334267.4245.420.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564334267.4245.420.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Sun, Jul 28, 2019 at 01:17:47PM -0400, Mimi Zohar wrote:
> On Sat, 2019-07-27 at 07:41 +0300, Vitaly Chikunov wrote:
> > - Since I still edit all 5 files I did not split the patch into multiple
> >   commits to separate the files, otherwise editing will become too
> >   complicated, as I ought to continuously rebase and edit different
> >   commits. This was really non-productive suggestion
> 
> Ok, but the review will be broken up. šFor now, the comments below are
> limited to tests/Makefile.am, tests/functions.sh and
> tests/ima_hash.test. šSome of the comments are intrusive, so I'm going
> to hold off on reviewing the other tests.

This is good, since I am reworking ima_sign/ima_verify tests into a single
test that will also cover EVM sign/verify.

> Autotools generates "test-driver". šShould it be added to git-ignore?

Didn't notice this.

> Should we be using SPDX, at least for new files?

OK.

> > +    if ! type $i; then
> 
> "type" is a bashism.

Tests are on bash.

> > +# Define FAILEARLY to exit testing on the first error.
> > +exit_early() {
> > +  if [ $FAILEARLY ]; then
> > +    exit $1
> > +  fi
> > +}
> 
> I would group all of the environment variable function checking
> together at the top of functions.sh.

Some functions check VERBOSE should they be on top too?

Or you meant this is just variable checking function? It isn't.

> The functions "pos" and "neg" are written very concisely, but they are
> part of a common set of functions, which are the crux of the tests
> scripts. šI'm really hesitant about having common functions that
> execute any command passed to it, without any form of verification.

What verification and why?

> > +  set -- evmctl $V ${ENGINE:+--engine $ENGINE} "$@"
> > +  echo $YELLOW$TMODE $*$NORM
> > +  eval "$@" >$out 2>&1
> 
> Here at least the command is limited to "evmctl".

This is emvctl runner. pos/neg can and should run anything that needs
their exit code be checked and accounted as test result.

> Is there any benefit to using "set --", as opposed to defining a local
> variable and executing it? šIs this simply a question of style?

I will make it using variable.

> > +_enable_gost_engine() {
> > +  # Do not enable if it's already working (enabled by user)
> > +  if ! openssl md_gost12_256 /dev/null >/dev/null 2>&1 \
> > +    && openssl engine gost >/dev/null 2>&1; then
> > +    ENGINE=gost
> > +  fi
> > +}
> 
> With gost provided as an Openssl engine, is it possible to be able to
> execute the first command without the gost engine enabled? šWith
> commit 782224f33cd7 ("ima-evm-utils: Rework openssl init"),

I don't understand question. What is 'first command'? `openssl
md_gost12_256` will not work if gost-engine is not configured somehow.

> I'm now wondering if the "--engine e' option is still needed?

It's needed. Why you thinking it doesn't? Commit 782224f33cd7 will not
load gost (or any other) engine on its own.

> > +# Check with constant
> > +check_const() {
> 
> This function comment doesn't provide any more details than the
> function name. šPlease either rename this function (eg. check_xattr)
> or expand the function comment.

OK.

(check* was supposed to be top-level tests. I will change this in v3.)

> > +  local alg=$1 pref=$2 hash=$3 file=$4
> > +
> > +  FOR=$alg DEL=$file 
> 
> Why not use ALG=$alg and FILE=$file as the global variable names?

check was called once for every algo. Are you proposing to change
call like

  check_const sha1 0x01 sha1-hash.txt
to
  ALG=sha1 FILE=sha1-hash.txt
  check_const 0x01
?

(I tried to put every mandatory argument into a argument list.)

> > +  cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$alg $file"
> > +  echo - $cmd
> > +  hash=$(set -o pipefail; eval "$cmd" 2>/dev/null | cut -d' ' -f2)
> 
> Is there a reason for not executing $cmd directly? šIs it safer
> calling "pipefail" and "eval"? šIs this a question of style?

I will remove eval (it also don't let me pass empty arguments into
called functions). `pipefail' is needed, so I can see exit code of
$cmd and not of `cut' in $?.

> > +  if [ $? -ne 0 ] && _is_positive_test; then
> > +    echo $CYAN"$alg test is skipped"$NORM
> > +    rm $file
> > +    return $SKIP
> > +  fi
> > +  check_const $alg $pref "$hash" $file
> > +}
> > +
> > +# check args: algo prefix hex-hash
> 
> The first keyword - test type - is missing in the comment above. šIt
> would be clearer if instead of "pos" or "neg", the key words included
> the words "pass" and "fail", to indicate that the test is expected to
> pass or fail.

pass and fail looks like imperative statements, and not like something that
will check other thing to pass or fail. I will rename them to something
else.

Thanks for the review!


