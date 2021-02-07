Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B9E31286F
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 00:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBGXm6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Feb 2021 18:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhBGXm5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Feb 2021 18:42:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF8C64DF5;
        Sun,  7 Feb 2021 23:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612741337;
        bh=Y2a27YQNjg/T/z0OzSCmnPs67jHJx1cU5KZDsx8cByg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkoEMaPYzT5wN+uYsu6LktK1Ihd32tOs2AcmSv8Id2PvtO9KDEdz5aSNRF58twbEp
         tNuWVH6cLNnHsub6wDZGAdkMG/Ocyv5KTcTlKy1I0iANOEQzD5USPMaQAcWZZARQPb
         Ghk+CkaNukQdrKlbyiOE54RcWn009aGz04fdxcQyPa6/PcNonOJUeZ1VWZKHgg05ox
         jTQd25rTdQFUjhOWEyVEAJvn6yKH2KXhYvGOYgCvHI/PtSVfY5IUfLwbkqp0kwIsLN
         9tOfAypaaWlsLrIpLwQEkIv6p58Cne8ZUvJrbiR92qLhpw0DmsfqUKL3/pBOw91JCC
         cyzbs/a4uKhQw==
Date:   Mon, 8 Feb 2021 01:42:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     wanghongzhe <wanghongzhe@huawei.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tpm_tis_spi_main: set cs_change = 0 when timesout
Message-ID: <YCB60CRpdhb7/HZ+@kernel.org>
References: <1612507325-2621-1-git-send-email-wanghongzhe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612507325-2621-1-git-send-email-wanghongzhe@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 05, 2021 at 02:42:05PM +0800, wanghongzhe wrote:
> when i reach TPM_RETRY, the cs cannot  change back to 'high'.
> So the TPM chips thinks this communication is not over.
> And next times communication cannot be effective because
> the communications mixed up with the last time.
> 
> Signed-off-by: wanghongzhe <wanghongzhe@huawei.com>
                 ~~~~~~~~~~~
                 Firstname Lastname

Please write legit sentences starting with capital letters etc.

Please write the commit message in imperative form. E.g. "Do x because y
..". I presume that *you* are not an actor in the sequence.

You also would need to have a fixes tag and preferably some description
of the failing sequence if possible.

/Jarkko

> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 3856f6ebcb34..6c52cbb28881 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -64,8 +64,18 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
>  				break;
>  		}
>  
> -		if (i == TPM_RETRY)
> +		if (i == TPM_RETRY) {
> +			/* change back to 'high',
> +			 * So the TPM chips thinks the last communication
> +			 * is done.
> +			 */
> +			spi_xfer.cs_change = 0;
> +			spi_xfer->len = 1;
> +			spi_message_init(&m);
> +			spi_message_add_tail(spi_xfer, &m);
> +			ret = spi_sync_locked(phy->spi_device, &m);
>  			return -ETIMEDOUT;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.19.1
> 
> 
