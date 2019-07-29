Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30585783D6
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2019 06:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfG2EKC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jul 2019 00:10:02 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60156 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfG2EKC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jul 2019 00:10:02 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A70A172CC6C;
        Mon, 29 Jul 2019 07:09:58 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 66E044A4A29;
        Mon, 29 Jul 2019 07:09:58 +0300 (MSK)
Date:   Mon, 29 Jul 2019 07:09:57 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH v2] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190729040956.bbprdbpas46mjcgh@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
References: <20190727044113.3865-1-vt@altlinux.org>
 <1564334267.4245.420.camel@linux.ibm.com>
 <20190728234031.ucyu6fj4pvr4owd3@altlinux.org>
 <1564364944.4245.452.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564364944.4245.452.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Sun, Jul 28, 2019 at 09:49:04PM -0400, Mimi Zohar wrote:
> On Mon, 2019-07-29 at 02:40 +0300, Vitaly Chikunov wrote:
> > > The functions "pos" and "neg" are written very concisely, but they are
> > > part of a common set of functions, which are the crux of the tests
> > > scripts. šI'm really hesitant about having common functions that
> > > execute any command passed to it, without any form of verification.
> > 
> > What verification and why?
> 
> Even though the tests are not running as root, it's still executing
> "$@", whatever that might be. šFor ima_hash.test, the first argument
> is "check".

I believe this will not add any security at all. As these are purely
internal functions. If somebody can call pos/neg they are already able
to call just anything they want. This is like protecting awk from
running something somehow not verified.

> > > > +_enable_gost_engine() {
> > > > +  # Do not enable if it's already working (enabled by user)
> > > > +  if ! openssl md_gost12_256 /dev/null >/dev/null 2>&1 \
> > > > +    && openssl engine gost >/dev/null 2>&1; then
> > > > +    ENGINE=gost
> > > > +  fi
> > > > +}
> > > 
> > > With gost provided as an Openssl engine, is it possible to be able to
> > > execute the first command without the gost engine enabled? šWith
> > > commit 782224f33cd7 ("ima-evm-utils: Rework openssl init"),
> > 
> > I don't understand question. What is 'first command'? `openssl
> > md_gost12_256` will not work if gost-engine is not configured somehow.
> 
> Exactly. š"openssl md_gost12_256 /dev/null" (returns 0, but is
> negated) will succeed only if the engine is enabled. šThe "openssl
> engine gost" test will never fail.

It can return non 0 and check looks correct. For example:

  debian:~$ openssl md_gost12_256 /dev/null
  Invalid command 'md_gost12_256'; type "help" for a list.
  debian:~$ echo $?
  1

If there is gost-engine in the system but it's not enabled via config - it will
be enabled for tests via `--engine gost' option.

> > > I'm now wondering if the "--engine e' option is still needed?
> > 
> > It's needed. Why you thinking it doesn't? Commit 782224f33cd7 will not
> > load gost (or any other) engine on its own.
> 
> If the gost engine is enabled in openssl.cnf then we don't need to set
> "ENGINE=gost". šI'm obviously missing something here.

There is two ways to load engine in openssl. I think it is mentioned in
the commit messages when this functionality was added to evmctl.

1. One way is via careful editing of openssl config.
2. Another is simply via --engine option.

Both ways are supported by openssl tools. (For example curl supports
--engine option.) But for tests I thought it would be simpler to use
--engine option instead of generating openssl.cnf.

If user have already configured, for example system wide, openssl.cnf to
load gost-engine this test will not add any option. I think this is
flexible.

> > (check* was supposed to be top-level tests. I will change this in v3.)
> > 
> > > > +  local alg=$1 pref=$2 hash=$3 file=$4
> > > > +
> > > > +  FOR=$alg DEL=$file 
> > > 
> > > Why not use ALG=$alg and FILE=$file as the global variable names?
> > 
> > check was called once for every algo. Are you proposing to change
> > call like
> 
> Although "FOR" is capitalized, I was reading it as "for". šIt took me
> a while to realize that "FOR" and "DEL" are global variables being
> used in "_evmctl_run". šAnything you can do to make it easier to read
> would be appreciated. šJust adding comments would help.

OK

> While further testing, "_require evmctl openssl" should also make sure
> that getfattr is installed.

Thanks!

