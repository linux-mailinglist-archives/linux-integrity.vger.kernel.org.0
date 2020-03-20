Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58A18C4FF
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2020 03:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCTCAG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 22:00:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:64064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgCTCAG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 22:00:06 -0400
IronPort-SDR: LXWqOP+RbtwxnTrKG4rVcLa9cIsTzQmPhaIpp4aPzF8AADRpHcrD4gckjtKa2YuWLafPJsa0xT
 F0/kgyKoxL1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 19:00:05 -0700
IronPort-SDR: RawwS87hpiOX0iHDjgEviWu6n22EdoGvfvHAxp9w1v38Oo3tg/pWy2H8mi7PwJbA06LvDPw+bU
 OkA9bgF1vfmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,282,1580803200"; 
   d="scan'208";a="291794235"
Received: from anakash-mobl2.ger.corp.intel.com (HELO localhost) ([10.251.183.74])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2020 19:00:01 -0700
Date:   Fri, 20 Mar 2020 04:00:00 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     George Wilson <gcwilson@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH v3] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200320020000.GB183331@linux.intel.com>
References: <20200318234927.206075-1-gcwilson@linux.ibm.com>
 <20200319195011.GB24804@linux.intel.com>
 <20200319195503.GC24804@linux.intel.com>
 <20200319231552.GA25351@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319231552.GA25351@us.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 19, 2020 at 06:15:52PM -0500, George Wilson wrote:
> On Thu, Mar 19, 2020 at 09:55:03PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 19, 2020 at 09:50:16PM +0200, Jarkko Sakkinen wrote:
> > > On Wed, Mar 18, 2020 at 07:49:27PM -0400, George Wilson wrote:
> > > > tpm_ibmvtpm_send() can fail during PowerVM Live Partition Mobility resume
> > > > with an H_CLOSED return from ibmvtpm_send_crq().  The PAPR says, 'The
> > > > “partner partition suspended” transport event disables the associated CRQ
> > > > such that any H_SEND_CRQ hcall() to the associated CRQ returns H_Closed
> > > > until the CRQ has been explicitly enabled using the H_ENABLE_CRQ hcall.'
> > > > This patch adds a check in tpm_ibmvtpm_send() for an H_CLOSED return from
> > > > ibmvtpm_send_crq() and in that case calls tpm_ibmvtpm_resume() and
> > > > retries the ibmvtpm_send_crq() once.
> > > > 
> > > > Reported-by: Linh Pham <phaml@us.ibm.com>
> > > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
> > > > Tested-by: Linh Pham <phaml@us.ibm.com>
> > > > Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Unfortunately have to take that back because it has checkpatch
> > errors:
> > 
> > $ scripts/checkpatch.pl 0001-tpm-ibmvtpm-retry-on-H_CLOSED-in-tpm_ibmvtpm_send.patch
> > WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> > #11:
> > “partner partition suspended” transport event disables the associated CRQ
> 
> I'd noticed that but it appears to be a spurious checkpatch warning.
> The line is 73 chars long, the same as the first line of the commit
> description.  Maybe the quotes throw it off?

Lets just ignore this warning.

> > 
> > WARNING: Prefer using '"%s...", __func__' to using 'ibmvtpm_crq_send_init', this function's name, in a string
> > #61: FILE: drivers/char/tpm/tpm_ibmvtpm.c:152:
> > +			"ibmvtpm_crq_send_init failed rc=%d\n", rc);
> 
> I didn't change that error string because it's in an unmodified existing
> function that I moved above the caller so a declaration wasn't required.
> All other examples in the file are the same.  I'm of course happy to
> change it in this function if you think it's appropriate to do so.

What you are saying makes sense to me but given that it is rather
minuscule change I'd just sweep it away.

> > 
> > Also the fixes tag is incorrect. Should be:
> > 
> > Fixes: 132f76294744 ("drivers/char/tpm: Add new device driver to support IBM vTPM")
> 
> I see it done different ways, mostly without the path, even for the TPM
> drivers.  For example, there's no path in Stefan's "[PATCH v7 2/3] tpm:
> ibmvtpm: Wait for buffer to be set before proceeding."  I'm certainly
> happy to change it, however, and it's good to know that's the preferred
> style going forward.

"If your patch fixes a bug in a specific commit, e.g. you found an issue
using git bisect, please use the ‘Fixes:’ tag with the first 12
characters of the SHA-1 ID, and the one line summary."

https://www.kernel.org/doc/html/v5.5/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> Separate topic:  Since this fixes a migration hang, do you think it
> should also be cc'd to stable?

Sure, it would make sense.

/Jarkko
