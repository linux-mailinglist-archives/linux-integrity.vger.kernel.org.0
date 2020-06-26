Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084F920B230
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgFZNI6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 09:08:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:59339 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbgFZNI6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 09:08:58 -0400
IronPort-SDR: Y4L9UHncDkR5Bm2HFvFOFofLcl7a8rz9rGFdGzAIVM/0gKQyZMKXULTSRIP0oTfW3Smpcjhaua
 ZKAZN/WhvsJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="146805450"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="146805450"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 06:08:57 -0700
IronPort-SDR: BtcyJEMqxwQVNcf08kNSPR7KJbIxunml+DmDVbRr8F6d37dutN5JWYYJl/V3yC3qcMNRzs50SV
 Pgf5xanQQICA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="385763113"
Received: from cgheban-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.199])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2020 06:08:52 -0700
Date:   Fri, 26 Jun 2020 16:08:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200626130851.GA7853@linux.intel.com>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
 <20200625062150.idm6j3vm2neyt4sh@cantor>
 <20200625210202.GA20341@linux.intel.com>
 <20200625211923.2jirvix6zbrbgj6e@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625211923.2jirvix6zbrbgj6e@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 02:19:23PM -0700, Jerry Snitselaar wrote:
> On Fri Jun 26 20, Jarkko Sakkinen wrote:
> > On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
> > > On Thu Jun 25 20, Jarkko Sakkinen wrote:
> > > > Acer C720 running Linux v5.3 reports this in klog:
> > > >
> > > > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
> > > > tpm tpm0: tpm_try_transmit: send(): error -5
> > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> > > > tpm_tis tpm_tis: Could not get TPM timeouts and durations
> > > > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
> > > > tpm tpm0: tpm_try_transmit: send(): error -5
> > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> > > > tpm_tis 00:08: Could not get TPM timeouts and durations
> > > > ima: No TPM chip found, activating TPM-bypass!
> > > > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
> > > >
> > > > % git --no-pager grep IFX0102 drivers/char/tpm
> > > > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
> > > > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
> > > >
> > > > Obviously IFX0102 was added to the HID table for the TCG TIS driver by
> > > > mistake.
> > > >
> > > > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
> > > > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
> > > > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Bugzilla has an example of similar behavior with v4.15. I'll apply this
> > asap.
> > 
> > /Jarkko
> > 
> 
> Any idea what happened to git.infradead.org? It was offline the other day,
> and at the moment not all repos from before seem to be there.

Now the kernel tree is back online.

/Jarkko
