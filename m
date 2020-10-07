Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32E285F23
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Oct 2020 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgJGMZV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Oct 2020 08:25:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgJGMZV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Oct 2020 08:25:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CC84ADEC;
        Wed,  7 Oct 2020 12:25:20 +0000 (UTC)
Date:   Wed, 7 Oct 2020 14:25:18 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Linux Integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 3/6] ima-evm-utils: When using the IBM TSS, link in its
 library
Message-ID: <20201007122518.GB9829@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <136e154e-16bc-9d6e-90a3-075cc67be333@linux.ibm.com>
 <20201006150742.GA16684@dell5510>
 <f3b8356f-6476-5b1c-5faa-9b0dcd45d7dc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b8356f-6476-5b1c-5faa-9b0dcd45d7dc@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ken,

...
> > > diff --git a/src/Makefile.am b/src/Makefile.am
> > > index d6c779f..bf18caf 100644
> > > --- a/src/Makefile.am
> > > +++ b/src/Makefile.am
> > > @@ -26,6 +26,7 @@ if USE_PCRTSS
> > >   evmctl_SOURCES += pcr_tss.c
> > >   else
> > >   evmctl_SOURCES += pcr_tsspcrread.c
> > > +evmctl_LDADD += -libmtss
> > >   endif
> > But pcr_tsspcrread.c uses the binary (tsspcrread).

> The idea is to eliminate the calls to command line utilities that
> are not as stable as the TSS library.  Patch 4/6 does that.
I'm sorry, I overlooked that.

> I'm a git newbie.  I thought the idea was to do the patches as
> small pieces.  Thus, this one does the autotools piece.  Then
> the next one does the C code.  Should they be combined?
I'd personally put it into the 4/6 patch (code change is small and it's related
to the code change).

> > pcr_tss.c uses TSS, but that's already covered:
> > ldd src/.libs/evmctl |grep tss
> > 	libtss2-rc.so.0 => /usr/lib64/libtss2-rc.so.0 (0x00007fb82514c000)
> > 	libtss2-esys.so.0 => /usr/lib64/libtss2-esys.so.0 (0x00007fb824eba000)
> > 	libtss2-sys.so.0 => /usr/lib64/libtss2-sys.so.0 (0x00007fb8244ba000)
> > 	libtss2-mu.so.0 => /usr/lib64/libtss2-mu.so.0 (0x00007fb824276000)

> > Thus I thing this patch is invalid. Or do I miss something obvious?

> There are two TSSes.  This one's for the IBM TSS.  Your traces are
> for the ESAPI (aka
Thanks for explanation.

Kind regards,
Petr
