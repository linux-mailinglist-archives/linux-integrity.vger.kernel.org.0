Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A651A5F23
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Apr 2020 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgDLOzM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Apr 2020 10:55:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:40265 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLOzM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Apr 2020 10:55:12 -0400
IronPort-SDR: hIbuTtdBmz2J3JXdthgZS0YDYC3ZZKxFcUwW6cJ7Vwt8KkcJKu9nQtL78K7LHjUNOC55y8QN6I
 pw5g4sB42+Fg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 07:55:12 -0700
IronPort-SDR: rv7kWsDheXCScBJSMLdnD5lVBZpRdohIUUAKpqpx5nNPp5nPPdO3fqr0Lsh9XCtAoA+tTSGxwP
 01iDR1UuIsIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="276676609"
Received: from apresura-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.246])
  by fmsmga004.fm.intel.com with ESMTP; 12 Apr 2020 07:55:10 -0700
Date:   Sun, 12 Apr 2020 17:55:09 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200412145509.GA74087@linux.intel.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
 <20200410210936.GB16905@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410210936.GB16905@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Apr 11, 2020 at 12:09:36AM +0300, Jarkko Sakkinen wrote:
> On Sat, Apr 11, 2020 at 12:07:02AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> > > Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> > > TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> > > the TPM_CHIP_FLAG_IRQ ever.
> > > 
> > > So the whole IRQ probing code is not useful, worse we rely on the
> > > IRQ-test path of tpm_tis_send() to call disable_interrupts() if
> > > interrupts do not work, but that path never gets entered because we
> > > never set the TPM_CHIP_FLAG_IRQ.
> > > 
> > > So the remaining IRQ probe code calls request_irq() and never calls
> > > free_irq() even when the interrupt is not working.
> > > 
> > > On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
> > > to use and never free creates an interrupt storm followed by
> > > an "irq XX: nobody cared" oops.
> > > 
> > > Since it is non-functional at the moment anyways, lets just completely
> > > disable the IRQ code in tpm_tis_core for now.
> > > 
> > > Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > > Note I'm working with Lenovo to try and get to the bottom of this.
> > > ---
> > 
> > OK if I recall correctly the reason for reverting was that the fixes
> > Stefan was sending were broken and no access to hardware were the
> > issues would be visible. The reason for not doing anything til this
> > day is that we don't have T490 available.
> > 
> > The lack of devm_free_irq() is an by itself, so please instead send
> > a fix that adds that to the code instead of "#if 0" crap.
> 
> If we were to go with your proposal, then you'd have to do "if 0" to
> bunch of other places. Otherwise, the change would be incomplete. Thus,
> it is now more sane just to free that IRQ.

Also, already the commit that has the fixes tag disables IRQ handling
and that was for the reason that some hardware that we (basically me
and Jerry) did not have access to. That's why there is no proper fix.

/Jarkko
