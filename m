Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30096283F48
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 21:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgJETFr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 15:05:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:10538 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJETFr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 15:05:47 -0400
IronPort-SDR: VHBckn8HMMgdN+3sSZ5U9uiDRvYUtzi80Rh3/IFW3CNFi2ACqint23Y6KUbkJqZxNQNscUCbyV
 7SRYi+gE515w==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="164353359"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="164353359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP; 05 Oct 2020 12:04:35 -0700
IronPort-SDR: lVT0juFXOlnD8v3NGNrMe8FtWgmhT3empH46++25vlgeDgb0kId4jd0oWqqflwZGwQoOP8+Tis
 624BEyy9wy6w==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="526259290"
Received: from unknown (HELO localhost) ([10.249.32.156])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 10:05:31 -0700
Date:   Mon, 5 Oct 2020 20:05:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 3/5] tpm_tis: Fix interrupts for TIS TPMs without
 legacy cycles
Message-ID: <20201005170527.GE6232@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001180925.13808-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 01, 2020 at 11:09:23AM -0700, James Bottomley wrote:
> If a TIS TPM doesn't have legacy cycles, any write to the interrupt
> registers is ignored unless a locality is active.  This means even to
> set up the interrupt vectors a locality must first be activated.  Fix
> this by activating the 0 locality in the interrupt probe setup.
> 
> Since the TPM_EOI signalling also requires an active locality, the
> interrupt routine cannot end an interrupt if the locality is released.
> This can lead to a situation where the TPM goes command ready after
> locality release and since the interrupt cannot be ended it refires
> continuously.  Fix this by disabling all interrupts except locality
> change when a locality is released (this only fires when a locality
> becomes active, meaning the TPM_EOI should work).
> 
> Finally, since we now disable all status based interrupts in the
> locality release, they must be re-enabled before waiting to check the
> condition, so add interrupt enabling to the status wait.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> ---
> 
> v2: renamed functions

Ditto.

/Jarkko
