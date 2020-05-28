Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72A91E523B
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 02:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgE1Aar (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 20:30:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:57832 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1Aar (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 20:30:47 -0400
IronPort-SDR: Nf0hnbVkzV4qm0gf4RXdfSt8l9f2ggJsYAprXsMyx22I/+LeCpQs3hmth95FCVOiig2FhsOz8l
 Rf53bDaiLVtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 17:30:47 -0700
IronPort-SDR: S5SHPJ+Xm9MoDJC2vdZQKMQRCVIFpatQk41EKWiDygVs/pRpCjTwu5JB6USmIjrcM6ENgUtKeE
 lV6QGat+m/gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="302284465"
Received: from ederaloi-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.44.51])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2020 17:30:42 -0700
Date:   Thu, 28 May 2020 03:30:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Alex Guzman <alex@guzman.io>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Message-ID: <20200528003040.GA4781@linux.intel.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
 <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 26, 2020 at 12:39:37PM -0700, Tadeusz Struk wrote:
> On 5/26/20 12:14 PM, James Bottomley wrote:
> > +	/* atomic tpm command send and result receive. We only hold the ops
> > +	 * lock during this period so that the tpm can be unregistered even if
> > +	 * the char dev is held open.
> > +	 */
> > +	if (tpm_try_get_ops(priv->chip)) {
> > +		ret = -EPIPE;
> > +		goto out;
> > +	}
> > +
> Hi James,
> This won't help if the message is read by an async tcti. If the problem lies
> in the chip get locality code, perhaps this could help to debug the root-cause
> instead of masking it out in the upper layer code:

What is TCTI and async TCTI? Not following.

> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 2435216bd10a..da5ecd0376bf 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -202,20 +202,22 @@ static int request_locality(struct tpm_chip *chip, int l)
>  		return rc;
>  
>  	stop = jiffies + chip->timeout_a;
> +	timeout = stop - jiffies;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
>  again:
>  		timeout = stop - jiffies;
>  		if ((long)timeout <= 0)
> -			return -1;
> +			goto out;
> +
>  		rc = wait_event_interruptible_timeout(priv->int_queue,
> -						      (check_locality
> -						       (chip, l)),
> +						      check_locality(chip, l),
>  						      timeout);
>  		if (rc > 0)
>  			return l;
>  		if (rc == -ERESTARTSYS && freezing(current)) {
>  			clear_thread_flag(TIF_SIGPENDING);
> +			timeout = stop - jiffies;
>  			goto again;
>  		}
>  	} else {
> @@ -226,6 +228,10 @@ static int request_locality(struct tpm_chip *chip, int l)
>  			tpm_msleep(TPM_TIMEOUT);
>  		} while (time_before(jiffies, stop));
>  	}
> +out:
> +	dev_warn(&chip->dev, "%s: failed to request locality %d after %lu ms\n",
> +			 __func__, l, timeout * HZ / 1000);
> +
>  	return -1;
>  }
>  

/Jarkko
