Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500E2242A0F
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Aug 2020 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHLNHh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Aug 2020 09:07:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHLNHh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Aug 2020 09:07:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80C47B149;
        Wed, 12 Aug 2020 13:07:57 +0000 (UTC)
Date:   Wed, 12 Aug 2020 15:05:48 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200812130548.GB4994@gacrux.arch.suse.de>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200803130755.GA30440@dell5510>
 <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
 <20200803164635.GB4914@dell5510>
 <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
 <20200804072234.GA4337@dell5510>
 <20200804075453.GA7285@dell5510>
 <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
 <20200805094215.GA32709@dell5510>
 <20200811173303.GA31322@dell5510>
 <146ee0acc5d5f619b6b19ae2a3bcb6a66cacce32.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146ee0acc5d5f619b6b19ae2a3bcb6a66cacce32.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Vitaly,

...
> > I prototype docker based Travis [1] (still WIP). It tests various distros,
> > including cross-compilation, using also clang, even one build with musl (Alpine
> > distro). But there are many failures.

> > The biggest problem is with ibmswtpm2 [2], which contain tpm_server binary. This
> > project is not packaged in distros, compiles only with gcc (no clang, I tested
> > versions 1332 and 1637) and ignore CFLAGS and LDFLAGS settings. It doesn't even
> > have git repository (the one on sourceforge is empty).
> > We could simply patch this file, but I'm not going to do it.
> > I guess I just skip tpm_server dependency for all non-native projects.
> > I also need always install gcc even clang is going to be used due tpm_server.

> Agreed, getting docker/travis working is independent of tpm_server. 
> Without a software TPM, the boot_aggregate test will be skipped.  For
> now, until we can straighten this out,  I would modify "make check" to
> run the other tests (e.g. make check TESTS="ima_hash.test
> sign_verify.test").
Yes, specifying tests to be tested is an option. But if skipping the compilation
for non-native builds works (e.g. tests which don't specify $VARIANT), I'd go
this way. That help us not having to remember to update tests for non-native
builds (once the new ones are added).

Gost: I just installed it for Debian / Ubuntu, which have a package. Not sure if
it's enough.

Any objections to distros used or anything else?
I'll have look on during this week and hopefully send v1 patchset.

> thanks,

> Mimi


> > It also find bug in m4/manpage-docbook-xsl.m4 for Alpine, found custom xml
> > catalog, but value is not redirected into the variable.
This is not a priority. I'll have look into this sometime in my non-work time
(Alpine doesn't have ima-evm-utils package).

Kind regards,
Petr

> > [1] https://travis-ci.org/github/pevik/ima-evm-utils/builds/716990585
> > [2] https://sourceforge.net/projects/ibmswtpm2/
