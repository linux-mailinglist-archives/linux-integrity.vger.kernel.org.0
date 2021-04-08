Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6A3589CC
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 18:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDHQbb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 12:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhDHQb2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 12:31:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 009BE61105;
        Thu,  8 Apr 2021 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617899477;
        bh=Qp4ribM7La7vuHRZogOvMkf+36eQh6Vr/Ca3eocGvmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5SKMlP2l5Qe1XZ1mrrjnHbKK9XF8MnsZ2lWOl8YYY4mpX0Oj7gjUI/3SVYzP+DQB
         UpDpw7YxRmRHWGqV616xB4DHY732iuiXKey9leu4Xxq+zhOomUFCDraDHmXsbtlOsz
         wqxyjQT2cPHc4ghGrdg6yC36pZrhnidInw1kMU7FhJwuZMU/BWtftOHfAA/pbA+3JJ
         PCqv2zfD6h+af1fpvCfa0ahq3SiNWoXQa2JqL43FKAD+A4ON0FrJnRi7UOrslaFGas
         WoO+8fVB3launLI+IaSPbzfSAagI9vmMvMuYfcuJWm5JP8IyKh+lcMXM0/46uJybRD
         wYiDdc+gAjb7Q==
Date:   Thu, 8 Apr 2021 19:31:14 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] char: tpm: fix error return code in
 tpm_cr50_i2c_tis_recv()
Message-ID: <YG8v0hBVKxuVdEfT@kernel.org>
References: <20210408112608.1024311-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408112608.1024311-1-chengzhihao1@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 08, 2021 at 07:26:08PM +0800, Zhihao Cheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 3a253caaad11 ("char: tpm: add i2c driver for cr50")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index ec9a65e7887d..e908da78fbf4 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -483,6 +483,7 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
>  	expected = be32_to_cpup((__be32 *)(buf + 2));
>  	if (expected > buf_len) {
>  		dev_err(&chip->dev, "Buffer too small to receive i2c data\n");
> +		rc = -EIO;
>  		goto out_err;
>  	}
>  
> -- 
> 2.25.4
> 

We are using E2BIG in similar situations in a few places:

❯ git grep E2BIG drivers/char/tpm
drivers/char/tpm/tpm-dev-common.c:              return -E2BIG;
drivers/char/tpm/tpm-interface.c:               return -E2BIG;
drivers/char/tpm/tpm_crb.c:             return -E2BIG;
drivers/char/tpm/tpm_i2c_atmel.c:               return -E2BIG;
drivers/char/tpm/tpm_i2c_infineon.c:            return -E2BIG;

So, I tend to think that also in here it'd be better to use E2BIG.

/Jarkko
