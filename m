Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2C37EE4B
	for <lists+linux-integrity@lfdr.de>; Thu, 13 May 2021 00:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhELV1i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 May 2021 17:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378654AbhELTRf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 May 2021 15:17:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71461613C0;
        Wed, 12 May 2021 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620846987;
        bh=K5PTwvbrmTLJBQl53tYJQmiRPWilsdtLY9PWlAxixh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBSuiavL+2xFrpT/gSTrX16wRZYTTfoFVePiiWWtpHIUl6do5C/W96vspv3tQ/yXy
         dNCTFZsbOJlCNd3zI7QdP/qvCMOfD8gN5n4lLOOG9OIuA5cFiFpm1gTXrQkNTm9V6Z
         +iPeN9B4Ovgmn5uODFZhDK6NctwDCYu8PK8eCVm0m+t7u9vjdniCD7eE3fTXhBSXoN
         xW/lKzSvs/ILOXWHhmVetKuvBTXz6nKkEM4Xi2NjSrefOB07RtVkKKlwOXIRWrGcK2
         NT7Hs8+qddqc/Etzt+5rnlr2M9fzdxqyo+MivFqLP3iGTLmcaZh+GKTs78vY/JVDO2
         9aUWiJVDxsXew==
Date:   Wed, 12 May 2021 22:16:24 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] tpm: fix error return code in
 tpm2_get_cc_attrs_tbl()
Message-ID: <YJwpiHeQO2l1qdFG@kernel.org>
References: <20210512133926.6326-1-thunder.leizhen@huawei.com>
 <20210512133926.6326-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512133926.6326-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 12, 2021 at 09:39:26PM +0800, Zhen Lei wrote:
> If the total number of commands queried through TPM2_CAP_COMMANDS is
> different from that queried through TPM2_CC_GET_CAPABILITY, it indicates
> an unknown error. In this case, an appropriate error code -EFAULT should
> be returned. However, we currently do not explicitly assign this error
> code to 'rc'. As a result, 0 was incorrectly returned.
> 
> Fixes: 58472f5cd4f6("tpm: validate TPM 2.0 commands")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index eff1f12d981ab27..c84d239512197aa 100644
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
> 2.26.0.106.g9fadedd
> 
> 
> 

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
