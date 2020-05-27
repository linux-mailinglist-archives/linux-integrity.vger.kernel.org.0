Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2571E4ED9
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgE0UJh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 16:09:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:52878 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgE0UJg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 16:09:36 -0400
IronPort-SDR: TaMRkLinzWzGr3EtcyDBzxPV47kU3Rcsrf2v6gVDD7H/mDbf4OyHMauQe+Z1VyYQFAaZfqQ8KA
 W6DEFsFpsk+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 13:09:35 -0700
IronPort-SDR: Uae7lhmeinT5YiWWmiUkt6Tj7A1nsDizky35Cl75Rv3tTZYtdmqBDkYOzeLGMAeuc2tnKOfKQF
 EofL5u+UPwLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="376137006"
Received: from lkakolx-mobl.ger.corp.intel.com ([10.249.43.73])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2020 13:09:30 -0700
Message-ID: <37da2695fe6de09d69e27b77f3e29e068596205f.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mario.Limonciello@dell.com, peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrin@rajagiritech.edu.in, alex@guzman.io
Date:   Wed, 27 May 2020 23:09:28 +0300
In-Reply-To: <1590521924.15108.1.camel@HansenPartnership.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
         <1590521924.15108.1.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-26 at 12:38 -0700, James Bottomley wrote:
> On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com wrote:
> > > On Tue, 2020-05-26 at 13:32 -0500, Mario Limonciello wrote:
> > > > This reverts commit d23d12484307b40eea549b8a858f5fffad913897.
> > > > 
> > > > This commit has caused regressions for the XPS 9560 containing
> > > > a Nuvoton TPM.
> > > 
> > > Presumably this is using the tis driver?
> > 
> > Correct.
> > 
> > > > As mentioned by the reporter all TPM2 commands are failing with:
> > > >   ERROR:tcti:src/tss2-tcti/tcti-
> > > > device.c:290:tcti_device_receive()
> > > >   Failed to read response from fd 3, got errno 1: Operation not
> > > > permitted
> > > > 
> > > > The reporter bisected this issue back to this commit which was
> > > > backported to stable as commit 4d6ebc4.
> > > 
> > > I think the problem is request_locality ... for some inexplicable
> > > reason a failure there returns -1, which is EPERM to user space.
> > > 
> > > That seems to be a bug in the async code since everything else
> > > gives a ESPIPE error if tpm_try_get_ops fails ... at least no-one
> > > assumes it gives back a sensible return code.
> > > 
> > > What I think is happening is that with the patch the TPM goes
> > > through a quick sequence of request, relinquish, request,
> > > relinquish and it's the third request which is failing (likely
> > > timing out).  Without the patch, the patch there's only one
> > > request,relinquish cycle because the ops are held while the async
> > > work is executed.  I have a vague recollection that there is a
> > > problem with too many locality request in quick succession, but
> > > I'll defer to Jason, who I think understands the intricacies of
> > > localities better than I do.
> > 
> > Thanks, I don't pretend to understand the nuances of this particular
> > code, but I was hoping that the request to revert got some attention
> > since Alex's kernel Bugzilla and message a few months ago to linux
> > integrity weren't.
> > 
> > > If that's the problem, the solution looks simple enough: just move
> > > the ops get down because the priv state is already protected by the
> > > buffer mutex
> > 
> > Yeah, if that works for Alex's situation it certainly sounds like a
> > better solution than reverting this patch as this patch actually does
> > fix a problem reported by Jeffrin originally.
> > 
> > Could you propose a specific patch that Alex and Jeffrin can perhaps
> > both try?
> 
> Um, what's wrong with the one I originally attached and which you quote
> below?  It's only compile tested, but I think it will work, if the
> theory is correct.

Please send a legit patch, thanks.

/Jarkko

