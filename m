Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C28243ED3
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHMS2D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:28:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgHMS2C (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:28:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F79AADC5;
        Thu, 13 Aug 2020 18:28:24 +0000 (UTC)
Date:   Thu, 13 Aug 2020 20:28:00 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200813182800.GA6029@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200803164635.GB4914@dell5510>
 <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
 <20200804072234.GA4337@dell5510>
 <20200804075453.GA7285@dell5510>
 <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
 <20200805094215.GA32709@dell5510>
 <20200811173303.GA31322@dell5510>
 <146ee0acc5d5f619b6b19ae2a3bcb6a66cacce32.camel@linux.ibm.com>
 <20200812130548.GB4994@gacrux.arch.suse.de>
 <93793b105fc2945435e3c26a6f74eee28ae03e0f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93793b105fc2945435e3c26a6f74eee28ae03e0f.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Vitaly,

...
> > > > The biggest problem is with ibmswtpm2 [2], which contain tpm_server binary. This
> > > > project is not packaged in distros, compiles only with gcc (no clang, I tested
> > > > versions 1332 and 1637) and ignore CFLAGS and LDFLAGS settings. It doesn't even
> > > > have git repository (the one on sourceforge is empty).
> > > > We could simply patch this file, but I'm not going to do it.
> > > > I guess I just skip tpm_server dependency for all non-native projects.
> > > > I also need always install gcc even clang is going to be used due tpm_server.
> > > Agreed, getting docker/travis working is independent of tpm_server. 
> > > Without a software TPM, the boot_aggregate test will be skipped.  For
> > > now, until we can straighten this out,  I would modify "make check" to
> > > run the other tests (e.g. make check TESTS="ima_hash.test
> > > sign_verify.test").
> > Yes, specifying tests to be tested is an option. But if skipping the compilation
> > for non-native builds works (e.g. tests which don't specify $VARIANT), I'd go
> > this way. That help us not having to remember to update tests for non-native
> > builds (once the new ones are added).

> Sure.  libtmps/swtpm could be installed in lieu of the ibmswtpm2. 
> Sample directions for using it are here: 
> https://github.com/stefanberger/swtpm/wiki/Using-the-IBM-TSS-with-swtpm

Nice!
I've just send a patch which builds green without this (ibmswtpm2 is installed
just for native gcc builds). I'd prefer to leave this for somebody else.

Kind regards,
Petr
