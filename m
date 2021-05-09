Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135DD377883
	for <lists+linux-integrity@lfdr.de>; Sun,  9 May 2021 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEIUmg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 9 May 2021 16:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhEIUmg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 May 2021 16:42:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4722F601FD;
        Sun,  9 May 2021 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620592892;
        bh=3kC7q5RnWbRfm2DiPPx2BVy1tt7w9Jy959UFIAMipqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXv3OuzgIyjjEa7FOG7YpTbrJQ3OfhhhSCU3/lMHAG/k5oMUCl9peaVP/y936UmYH
         RayYQxw229KyZA09DUX2bTxwrYOV/J5+B3SRrMwm2GwWXw5vsns53sPEc58cVSNK0N
         FfiU8YbhmvqkCqk0blTETMXg8v9yXYcDz5qp0di17yadIttX/c3+PJGnL7pLwlqd4i
         0g7/VAtEv7KZhDHptUdjhp17jhTRr8DUz57r8kPN9ZzYmh27YUmtE9GNF4nnumXWHi
         S/TzKkp+0+BiP3zzta3HXdxYn3TvWJdCUMvoLz49LyMLrPsuTqog5HfPCT3dQHjFBI
         DYqredzVAcLig==
Date:   Sun, 9 May 2021 23:41:30 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tpm: fix error return code in tpm2_get_cc_attrs_tbl()
Message-ID: <YJhI+lIt4devpAoS@kernel.org>
References: <20210508025444.1977-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508025444.1977-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, May 08, 2021 at 10:54:44AM +0800, Zhen Lei wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 58472f5cd4f6("tpm: validate TPM 2.0 commands")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

In the commit message:

1. Instead of writing "a negative error code", write -EFAULT.
2. Some explanation of the choice.

> ---
>  drivers/char/tpm/tpm2-cmd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index eff1f12d981a..c84d23951219 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -656,6 +656,7 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
>  
>  	if (nr_commands !=
>  	    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5])) {
> +		rc = -EFAULT;
>  		tpm_buf_destroy(&buf);
>  		goto out;
>  	}
> -- 
> 2.25.1
> 
> 
>

Other than that looks good.

/Jarkko
