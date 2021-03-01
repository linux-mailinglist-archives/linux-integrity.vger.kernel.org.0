Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3A327B2B
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 10:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhCAJvO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 04:51:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234290AbhCAJtn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 04:49:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 432AD601FE;
        Mon,  1 Mar 2021 09:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614592139;
        bh=+Q6uo8HussmsthNL0tuh7Mi0QnPFU2RSHlhSZManMPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGB11C5s5a2cxOdVfWltWgrRweMroTFuFh6ybShzIc9FnEk3JKZvqggIQuznYxsQY
         UvEfkyMINs+BF96NdpGpk7htGDAXZdUkHQapA+CjG16p+KSFDZ2D15P0OAPe0KYLUI
         kV0m2sHXQ1ZYrbAtzgbfqI3PndZrxxpO+9qr/vzY10K7iLHMo4oCN191f4AiyBZ4l7
         M+iZtbz5hT/VFwQnhc0xhf0b7cRN6yj9rlkyJRRtX5CFOC7yNSt5E6cI1k2gOEw2b3
         cYYj02A0StLM6nDUJxBiavNklh2QvoI01afb4F83lXxvln0X1X430CJr9N9Q/+gcle
         0be3ottgdLjwA==
Date:   Mon, 1 Mar 2021 11:48:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add missing check in tpm_inf_recv
Message-ID: <YDy4d5qO8MrNwImx@kernel.org>
References: <20210228093230.5676-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228093230.5676-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 28, 2021 at 05:32:30PM +0800, Dinghao Liu wrote:
> The use of wait() in tpm_inf_recv() is almost the same. It's odd that
> we only check the return value and terminate execution flow of one call.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Is the unchecked return value of wait() the problem? I don't see the
function even mentioned in the description.

/Jarkko

> ---
>  drivers/char/tpm/tpm_infineon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 9c924a1440a9..abe00f45aa45 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -263,7 +263,9 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  		size = ((buf[2] << 8) | buf[3]);
>  
>  		for (i = 0; i < size; i++) {
> -			wait(chip, STAT_RDA);
> +			ret = wait(chip, STAT_RDA);
> +			if (ret)
> +				return -EIO;
>  			buf[i] = tpm_data_in(RDFIFO);
>  		}
>  
> -- 
> 2.17.1
> 
> 
