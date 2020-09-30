Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2027DE81
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 04:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgI3C0K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 22:26:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:15662 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbgI3C0K (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 22:26:10 -0400
IronPort-SDR: cu0FWffX2bzSKfJ1MkwwWFevsY6z0msLpA2IRqzUtcye6QkokGEumcIJqy4qKhtOoibwAv0hxD
 4vPCFL5jMBWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="161562835"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="161562835"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:26:09 -0700
IronPort-SDR: ZxUdVbdEu8Lgy4TEjrP6AZ9VjmSWMRvN+6mcS1UpvJsY+dd0dMHLIY+nejooakLtK7mCpmOBUx
 vKcwKZL64VrQ==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="457489569"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:26:08 -0700
Date:   Wed, 30 Sep 2020 05:26:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
Message-ID: <20200930022606.GH808399@linux.intel.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
 <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 29, 2020 at 03:32:13PM -0700, James Bottomley wrote:
> The current release locality code seems to be based on the
> misunderstanding that the TPM interrupts when a locality is released:
> it doesn't, only when the locality is acquired.
> 
> Furthermore, there seems to be no point in waiting for the locality to
> be released.  All it does is penalize the last TPM user.  However, if
> there's no next TPM user, this is a pointless wait and if there is a
> next TPM user, they'll pay the penalty waiting for the new locality
> (or possibly not if it's the same as the old locality).
> 
> Fix the code by making release_locality as simple write to release
> with no waiting for completion.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Adding Jerry for feedback.

Probably should have (if accepted).

Fixes: 33bafe90824b ("tpm_tis: verify locality released before returning from release_locality")

> ---
>  drivers/char/tpm/tpm_tis_core.c | 47 +--------------------------------
>  1 file changed, 1 insertion(+), 46 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 92c51c6cfd1b..a9fa40714c64 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -134,58 +134,13 @@ static bool check_locality(struct tpm_chip *chip, int l)
>  	return false;
>  }
>  
> -static bool locality_inactive(struct tpm_chip *chip, int l)
> -{
> -	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	int rc;
> -	u8 access;
> -
> -	rc = tpm_tis_read8(priv, TPM_ACCESS(l), &access);
> -	if (rc < 0)
> -		return false;
> -
> -	if ((access & (TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY))
> -	    == TPM_ACCESS_VALID)
> -		return true;
> -
> -	return false;
> -}
> -
>  static int release_locality(struct tpm_chip *chip, int l)

Should be void.

>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	unsigned long stop, timeout;
> -	long rc;
>  
>  	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>  
> -	stop = jiffies + chip->timeout_a;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> -again:
> -		timeout = stop - jiffies;
> -		if ((long)timeout <= 0)
> -			return -1;
> -
> -		rc = wait_event_interruptible_timeout(priv->int_queue,
> -						      (locality_inactive(chip, l)),
> -						      timeout);
> -
> -		if (rc > 0)
> -			return 0;
> -
> -		if (rc == -ERESTARTSYS && freezing(current)) {
> -			clear_thread_flag(TIF_SIGPENDING);
> -			goto again;
> -		}
> -	} else {
> -		do {
> -			if (locality_inactive(chip, l))
> -				return 0;
> -			tpm_msleep(TPM_TIMEOUT);
> -		} while (time_before(jiffies, stop));
> -	}
> -	return -1;
> +	return 0;
>  }
>  
>  static int request_locality(struct tpm_chip *chip, int l)
> -- 
> 2.28.0
> 

/Jarkko
