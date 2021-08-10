Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446263E7D5D
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhHJQVo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 12:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhHJQVo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 12:21:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E2BF60249;
        Tue, 10 Aug 2021 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628612481;
        bh=yG+iEfJwheMuv6bvfl91XDL3vUDwY4OSRwYIFp8xSnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsnroX+JuNHAl9TWSqRq8BGHFcXQiwC5YipxrRlYrrltKYC8gLDSKgTPYazEfhEs2
         wzfMH7DkP/DJ0qlK9znkvW/W10sXUwzVYPWEtsCUW6EZg50FVsGAXEGKf0D9bjEe91
         YO7yXwpe7B+QWKO6DSz24r/qGTEYA+Qw/qpIN3Z18XAzuGB9hOU0OkOJgX9faZhbDu
         beyf39ZZzc1hcWF8P7EOilSktkZuKVQJvWvQ0MtSiUU1U9wUBgpMNbJRty/YlEo8Y7
         Y97x78cwuEyURW8GlEG6qDRAi98iMUAKxnKPrYmWzIBRaCxG+q7oHnH0QABfdG5vdy
         gvTGa4CyxIW/A==
Date:   Tue, 10 Aug 2021 19:21:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v3 14/14] tpm: Allow locality 2 to be set when
 initializing the TPM for Secure Launch
Message-ID: <20210810162119.htk366pmacrnzdmh@kernel.org>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
 <1628527136-2478-15-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628527136-2478-15-git-send-email-ross.philipson@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 09, 2021 at 12:38:56PM -0400, Ross Philipson wrote:
> The Secure Launch MLE environment uses PCRs that are only accessible from
> the DRTM locality 2. By default the TPM drivers always initialize the
> locality to 0. When a Secure Launch is in progress, initialize the
> locality to 2.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb..48b9351 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -23,6 +23,7 @@
>  #include <linux/major.h>
>  #include <linux/tpm_eventlog.h>
>  #include <linux/hw_random.h>
> +#include <linux/slaunch.h>
>  #include "tpm.h"
>  
>  DEFINE_IDR(dev_nums_idr);
> @@ -34,12 +35,20 @@
>  
>  static int tpm_request_locality(struct tpm_chip *chip)
>  {
> -	int rc;
> +	int rc, locality;

        int locality;
        int rc;

>  
>  	if (!chip->ops->request_locality)
>  		return 0;
>  
> -	rc = chip->ops->request_locality(chip, 0);
> +	if (slaunch_get_flags() & SL_FLAG_ACTIVE) {
> +		dev_dbg(&chip->dev, "setting TPM locality to 2 for MLE\n");
> +		locality = 2;
> +	} else {
> +		dev_dbg(&chip->dev, "setting TPM locality to 0\n");
> +		locality = 0;
> +	}

Please, remove dev_dbg()'s.

> +
> +	rc = chip->ops->request_locality(chip, locality);
>  	if (rc < 0)
>  		return rc;
>  
> -- 
> 1.8.3.1

/Jarkko
