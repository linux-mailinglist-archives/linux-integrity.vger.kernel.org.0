Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684FC220DD1
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgGONPc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 09:15:32 -0400
Received: from [195.135.220.15] ([195.135.220.15]:44538 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgGONPc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 09:15:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEC56B6ED;
        Wed, 15 Jul 2020 13:15:33 +0000 (UTC)
Date:   Wed, 15 Jul 2020 15:15:29 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Check for tsspcrread in runtime
Message-ID: <20200715131529.GA32201@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200714154659.8080-1-pvorel@suse.cz>
 <1594757196.12900.191.camel@linux.ibm.com>
 <20200715062125.GA7493@dell5510>
 <1594813634.12900.264.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594813634.12900.264.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> > > Nice!  It works.
> > Thanks a lot for a testing?

> Yes, reviewed/tested together.
Sorry, I put question mark by accident, but thanks for confirmation anyway.

...
> When running these tests remotely, it helps to know which method of
> reading the PCRs is used.  How about adding something like this to
> both instances of tpm2_pcr_supported()?

>         if (imaevm_params.verbose > LOG_INFO)
>                 log_info("Using %s to read PCRs.\n", CMD);

+1

> > Shell I post v2 or you amend my patch?

> Either way is fine. 
Sending v2 in a minute. Feel free to amend it to suit your needs.

> > BTW I was thinking to create custom function / macro for handling errmsg to
> > reduce duplicity.

> Sure, I assume that would be in addition to log_err() and log_errno().
I'll probably postpone this cleanup after this patchset is merged (unless you do
the cleanup yourself). It can even wait after the release, I don't want to block
release with minor cleanup.


> > + there is minor warning on newer gcc, I'm not sure how to fix that:

> > evmctl.c: In function ‘read_tpm_banks’:
> > evmctl.c:1404:25: warning: ‘%2.2d’ directive writing between 2 and 10 bytes into a region of size 3 [-Wformat-overflow=]
> >  1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
> >       |                         ^~~~~
> > evmctl.c:1404:20: note: directive argument in the range [0, 2147483647]
> >  1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
> >       |                    ^~~~~~~~~~~
> > evmctl.c:1404:3: note: ‘sprintf’ output between 7 and 15 bytes into a destination of size 7
> >  1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> Interesting.  Checking that "i" isn't greater than 99 solves this
> warning.  Changing pcr_str size from 7 to 8 solves the other warning.
Nice, how simple. I wasn't sure myself about changing of the array size.
Feel free to just fix it.

Kind regards,
Petr

