Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B562E7241
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Dec 2020 17:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgL2QYd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Dec 2020 11:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2QYd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Dec 2020 11:24:33 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2659C0613D6;
        Tue, 29 Dec 2020 08:23:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8C90912804FC;
        Tue, 29 Dec 2020 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1609259031;
        bh=mRv9V7Pz0EGuRWoR1V4hRnMT5CGCvBoBPUdEvd87vfQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ivv5UqWjPXqs7FJHnVX8vaTPPkaLiBaesP8RmYaQF+f8+vZdBCs6LzK3Iubt2mmbo
         Nup5KVM81tojM7jj0L8um1mtxIyuNNEkScFeSAVKYybpUpmj+5Cw0y1n2BaiAar2HM
         rXzwA8JB0dZIUK5MtjBvcd5MxnVgt3Vjmu4uVlag=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BySELZgHsVTY; Tue, 29 Dec 2020 08:23:51 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1440912800AC;
        Tue, 29 Dec 2020 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1609259031;
        bh=mRv9V7Pz0EGuRWoR1V4hRnMT5CGCvBoBPUdEvd87vfQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ivv5UqWjPXqs7FJHnVX8vaTPPkaLiBaesP8RmYaQF+f8+vZdBCs6LzK3Iubt2mmbo
         Nup5KVM81tojM7jj0L8um1mtxIyuNNEkScFeSAVKYybpUpmj+5Cw0y1n2BaiAar2HM
         rXzwA8JB0dZIUK5MtjBvcd5MxnVgt3Vjmu4uVlag=
Message-ID: <788cb2e68b98513c84cdc186923f7f99eb55b983.camel@HansenPartnership.com>
Subject: Re: [PATCH -next] tpm: Use kzalloc for allocating only one thing
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, peterhuewe@gmx.de,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jgg@ziepe.ca
Date:   Tue, 29 Dec 2020 08:23:49 -0800
In-Reply-To: <20201229135154.23648-1-zhengyongjun3@huawei.com>
References: <20201229135154.23648-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-12-29 at 21:51 +0800, Zheng Yongjun wrote:
> Use kzalloc rather than kcalloc(1,...)
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)

What's the reason for wanting to do this transformation?

>  drivers/char/tpm/tpm1-cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-
> cmd.c
> index ca7158fa6e6c..4d8415e3b778 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -794,7 +794,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32
> tpm_suspend_pcr)
>   */
>  int tpm1_get_pcr_allocation(struct tpm_chip *chip)
>  {
> -	chip->allocated_banks = kcalloc(1, sizeof(*chip-
> >allocated_banks),
> +	chip->allocated_banks = kzalloc(sizeof(*chip->allocated_banks),
>  					GFP_KERNEL);
>  	if (!chip->allocated_banks)
>  		return -ENOMEM;

The reason tpm1 has this is because it mirrors the allocation in tpm2
so we retain code consistency.  It's a fairly minor advantage, so it
could be changed if you have a better rationale ... but what is it?

James


