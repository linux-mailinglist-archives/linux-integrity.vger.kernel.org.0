Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9EF1FC0A8
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFPVIQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 17:08:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:34637 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgFPVIQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 17:08:16 -0400
IronPort-SDR: 38s3mKvjfJBBHQKGEYM82c9NFZTBPdCz5KW8QfHcv1oMpTZ3DO6vFCce2aRZxSMxpaF+0dabvd
 Ts95Vjfr91aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 14:08:14 -0700
IronPort-SDR: uYSGeta2jHg/O7VYnU4drv0O2NvAE+qnGReSnhh1BY/tenQtJycf5uXNGK4K2kpbvHHxpEHuKC
 ++DbHNucE5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="261535509"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2020 14:08:09 -0700
Date:   Wed, 17 Jun 2020 00:08:08 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: ibmvtpm: Wait for ready buffer before probing for
 TPM2 attributes
Message-ID: <20200616210808.GJ20943@linux.intel.com>
References: <20200605063719.456277-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605063719.456277-1-david@gibson.dropbear.id.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 05, 2020 at 04:37:19PM +1000, David Gibson wrote:
> The tpm2_get_cc_attrs_tbl() call will result in TPM commands being issued,
> which will need the use of the internal command/response buffer.  But,
> we're issuing this *before* we've waited to make sure that buffer is
> allocated.
> 
> This can result in intermittent failures to probe if the hypervisor / TPM
> implementation doesn't respond quickly enough.  I find it fails almost
> every time with an 8 vcpu guest under KVM with software emulated TPM.
> 
> Fixes: 18b3670d79ae9 "tpm: ibmvtpm: Add support for TPM2"

Should be Fixes: 18b3670d79ae ("tpm: ibmvtpm: Add support for TPM2")

Also briefly state what the commit does, not just the problem
description. The code change looks legit.

Please send v2 with these changes.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 09fe45246b8c..994385bf37c0 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -683,13 +683,6 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  	if (rc)
>  		goto init_irq_cleanup;
>  
> -	if (!strcmp(id->compat, "IBM,vtpm20")) {
> -		chip->flags |= TPM_CHIP_FLAG_TPM2;
> -		rc = tpm2_get_cc_attrs_tbl(chip);
> -		if (rc)
> -			goto init_irq_cleanup;
> -	}
> -
>  	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
>  				ibmvtpm->rtce_buf != NULL,
>  				HZ)) {
> @@ -697,6 +690,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  		goto init_irq_cleanup;
>  	}
>  
> +	if (!strcmp(id->compat, "IBM,vtpm20")) {
> +		chip->flags |= TPM_CHIP_FLAG_TPM2;
> +		rc = tpm2_get_cc_attrs_tbl(chip);
> +		if (rc)
> +			goto init_irq_cleanup;
> +	}
> +
>  	return tpm_chip_register(chip);
>  init_irq_cleanup:
>  	do {
> -- 
> 2.26.2
> 

/Jarkko
