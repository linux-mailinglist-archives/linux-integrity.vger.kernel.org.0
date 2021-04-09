Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B23594FC
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 07:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhDIFvH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 01:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhDIFvH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 01:51:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 647C261168;
        Fri,  9 Apr 2021 05:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617947454;
        bh=DLamBDMHwwUmraCBU8zYVL5rPaEGxzTypgMW47MM8JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qX0vGlmIo0+USN4/nQBFMnk0I85/6fDe2+mRIuO+ZyKHktYEBhHs8QV3eISWLpjfT
         zQ0aQC32q1ZaUJEYXW4gBYR/gMVFfWEihBZyGGQocIBBLY6+JTWaW0r/WQwRJI8oX7
         hu8wE4oCbhai9U4kJ6FgpkfS9ETAFI2QB9JGf1dbnsuKcEQhcQLJGRWZseoXYy3lrm
         M7/jPYOvn9iUfhU/1WZRROz9xM/n24l9lQ4J43oMzJ2hnGwv1cgyTDqZwAEoUabaHp
         UZFS8RbDZVxKBTGRUbyAD/gPvl/C8IKFYzMSZGSqyB3+lAvEFgc6XFTGN5b4MXD0As
         0Lbh0eJrziZUQ==
Date:   Fri, 9 Apr 2021 08:50:52 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] char: tpm: fix error return code in
 tpm_cr50_i2c_tis_recv()
Message-ID: <YG/rPLtWwhFTgqor@kernel.org>
References: <20210409011201.1589080-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409011201.1589080-1-chengzhihao1@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 09, 2021 at 09:12:01AM +0800, Zhihao Cheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 3a253caaad11 ("char: tpm: add i2c driver for cr50")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index ec9a65e7887d..f19c227d20f4 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -483,6 +483,7 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
>  	expected = be32_to_cpup((__be32 *)(buf + 2));
>  	if (expected > buf_len) {
>  		dev_err(&chip->dev, "Buffer too small to receive i2c data\n");
> +		rc = -E2BIG;
>  		goto out_err;
>  	}
>  
> -- 
> 2.25.4
> 
> 

/Jarkko
