Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E5283D0B
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgJERJM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 13:09:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:59175 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgJERJM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 13:09:12 -0400
IronPort-SDR: CqLnruH+n7WdDUx2phmz0FxJ2JFgJH6VQeSPQZXq3mxI5urYGtA4xb4etRSCVnRtoj19KwXX2q
 W2tvkjhfgzFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="161158159"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="161158159"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP; 05 Oct 2020 10:05:32 -0700
IronPort-SDR: ANQHzFC2SMfv8BYEnYa3XUpqhXUuKMNDHwDGRWgywb4wNqUZR7LcuyakebjrZus3mUEWVdapwG
 EoNFugQScYWA==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="526171817"
Received: from possola-mobl.ger.corp.intel.com (HELO localhost) ([10.249.32.156])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 08:34:42 -0700
Date:   Mon, 5 Oct 2020 18:34:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 1/5] tpm_tis: Fix check_locality for correct locality
 acquisition
Message-ID: <20201005153418.GB6232@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001180925.13808-2-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 01, 2020 at 11:09:21AM -0700, James Bottomley wrote:
> The TPM TIS specification says the TPM signals the acquisition of
> locality when the TMP_ACCESS_REQUEST_USE bit goes to one *and* the
> TPM_ACCESS_REQUEST_USE bit goes to zero.  Currently we only check the

Put a reference to the section.

I'm *guessing* that the spec is

https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis

Please have this and also location in this spec.

> former not the latter, so check both.  Adding the check on
> TPM_ACCESS_REQUEST_USE should fix the case where the locality is
> re-requested before the TPM has released it.  In this case the
> locality may get released briefly before it is reacquired, which
> causes all sorts of problems. However, with the added check,
> TPM_ACCESS_REQUEST_USE should remain 1 until the second request for
> the locality is granted.

The description is really good and understandable otherwise.

For me it is not obvious at all, why this is missing a fixes
tag?

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> ---
> 
> v2: added this patch

Use the cover letter for the changelog. I'm afraid that I might
miss these otherwise.

> ---
>  drivers/char/tpm/tpm_tis_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 92c51c6cfd1b..f3ecde8df47d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -125,7 +125,8 @@ static bool check_locality(struct tpm_chip *chip, int l)
>  	if (rc < 0)
>  		return false;
>  
> -	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
> +	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID
> +		       | TPM_ACCESS_REQUEST_USE)) ==
>  	    (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
>  		priv->locality = l;
>  		return true;
> -- 
> 2.28.0
> 

/Jarkko
