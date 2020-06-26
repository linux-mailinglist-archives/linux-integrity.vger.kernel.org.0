Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD620B246
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFZNPb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 09:15:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:53142 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgFZNPb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 09:15:31 -0400
IronPort-SDR: HxEDOqxTPyTSOdR5I7BL61eMwqdzQvW1iG0wcKIOBOxmNhI5lQbRVoUkzyrDUgiahRaK+nHzRf
 Rx9kv628Y6Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144397394"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="144397394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 06:15:29 -0700
IronPort-SDR: DGohzh70JRmED+Bfs3e8Gjz+osHqrEZMPwo0AnSiTY3NaXBWchusvr8qm/WibhkMBmMnOp/o2J
 tJvgsIP8YSZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="311404315"
Received: from cgheban-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.199])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2020 06:15:24 -0700
Date:   Fri, 26 Jun 2020 16:15:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200626131523.GB7853@linux.intel.com>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
 <20200625062150.idm6j3vm2neyt4sh@cantor>
 <20200625210202.GA20341@linux.intel.com>
 <20200625211923.2jirvix6zbrbgj6e@cantor>
 <1593120239.3332.17.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593120239.3332.17.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 02:23:59PM -0700, James Bottomley wrote:
> On Thu, 2020-06-25 at 14:19 -0700, Jerry Snitselaar wrote:
> > On Fri Jun 26 20, Jarkko Sakkinen wrote:
> > > On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
> > > > On Thu Jun 25 20, Jarkko Sakkinen wrote:
> > > > > Acer C720 running Linux v5.3 reports this in klog:
> > > > > 
> > > > > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
> > > > > tpm tpm0: tpm_try_transmit: send(): error -5
> > > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the
> > > > > timeouts
> > > > > tpm_tis tpm_tis: Could not get TPM timeouts and durations
> > > > > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
> > > > > tpm tpm0: tpm_try_transmit: send(): error -5
> > > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the
> > > > > timeouts
> > > > > tpm_tis 00:08: Could not get TPM timeouts and durations
> > > > > ima: No TPM chip found, activating TPM-bypass!
> > > > > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
> > > > > 
> > > > > % git --no-pager grep IFX0102 drivers/char/tpm
> > > > > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
> > > > > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		
> > > > > /* Infineon */
> > > > > 
> > > > > Obviously IFX0102 was added to the HID table for the TCG TIS
> > > > > driver by
> > > > > mistake.
> > > > > 
> > > > > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
> > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
> > > > > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
> > > > > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com
> > > > > >
> > > > 
> > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > 
> > > Bugzilla has an example of similar behavior with v4.15. I'll apply
> > > this asap.
> > > 
> > > /Jarkko
> > > 
> > 
> > Any idea what happened to git.infradead.org? It was offline the other
> > day, and at the moment not all repos from before seem to be there.
> 
> Infradead has been playing up for a while on other things (non git
> services I use).
> 
> Perhaps it's time to get a kernel.org repository ...

I have an obstacle with that.

I lost my previous PGP key a year ago and created a new one, which is
not trusted yet by anyone [*]. I've backed this up now and have it
stored inside Nitrokey Pro 2 in order to prevent this happening again.

Now the problem is that in order to get a kernel.org account, I need
to be in the web of trust of the kernel maintainers.

I can request an accunt only after I see face to face another kernel
maintainers, so that I can proof that I am I.

[*] http://keys.gnupg.net/pks/lookup?op=get&search=0x3AB05486C7752FE1

/Jarkko
