Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8245227DE5E
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgI3COf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 22:14:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:35099 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3COf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 22:14:35 -0400
IronPort-SDR: 2IUyRP3iVNw2Z77wA7+GKimls/ql2sAeU5jZHQUJMxBoBSAt3y6XD+lPYrePzm52QaoidkY5oH
 g7hDnnBMzz0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159676410"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="159676410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:14:31 -0700
IronPort-SDR: p94e2mfCv28+yFwfS2hMhUcYT66EeBAsXXIgQO7w/I18L0GJgghVdRiIoNXM2d6T/je+P4ApNK
 CU66VDES/HyQ==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="494831481"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:14:30 -0700
Date:   Wed, 30 Sep 2020 05:14:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: More interrupt problems with TIS TPM
Message-ID: <20200930021427.GE808399@linux.intel.com>
References: <ea07fe04f61fe1ad19060f600ec219679c7bae2d.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea07fe04f61fe1ad19060f600ec219679c7bae2d.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 05:52:43PM -0700, James Bottomley wrote:
> I've got hold of an infineon TIS TPM which actually has a working
> interrupt.  I find even with the other fix I still need the patch below
> to get the interrupt to fire because without it nothing ever sets
> TPM_CHIP_FLAG_IRQ which means the interrupt test code is never
> executed.
> 
> Finally with all this probing fixed, I'm seeing interrupt storms.  The
> way this TPM seems to work is that if you allow it to send command
> ready interrupts, it will send them any time it can accept a command. 
> The problem is if you clear the interrupt and it can accept a command,
> it will send another command ready interrupt ... hence the storm since
> the TPM is pretty much always in the command ready state.  The only way
> to mitigate this seems to be *only* to enable the command ready
> interrupt when you're preparing to wait for the TPM to become ready. 
> i.e. these interrupts have to be treated as one shot enable, so the
> interrupt routine has to mask the command ready interrupt before doing
> a TPM_EOI in our way of doing things.  There seems to be support for
> this in the TIS spec around line 1135 where it advises us to keep all
> interrupts masked until polling says we have to wait for a particular
> state.
> 
> James

OK, this makes a lot of sense. I'll go through the patch set that you
posted. Thank you.

> 
> ---
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 6b884badabe7..1578d158416c 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -804,6 +810,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  		return rc;
>  
>  	priv->irq_tested = false;
> +	chip->flags |= TPM_CHIP_FLAG_IRQ;
>  
>  	/* Generate an interrupt by having the core call through to
>  	 * tpm_tis_send
> 
> 

/Jarkko
