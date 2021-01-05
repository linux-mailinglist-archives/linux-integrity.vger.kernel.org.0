Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED92EA517
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 07:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbhAEF7w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 00:59:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbhAEF7w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 00:59:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93A19229C4;
        Tue,  5 Jan 2021 05:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609826351;
        bh=IBN85iN/6bgEzMKuKyt4VJrGAyIKtnIaAp7AgVNDXJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAktwJXKoZWGDYre0R6qrY+C6XXqbhyn9V9Wsijq91iYpNuLLlwvrJEHtUEBwyNwQ
         CUsV5kWvj/yMNqvxH1A523qA4pD9S6X17KUAB3yaMpTCUGF6wozej8iU8o2w41ld19
         TRnNyKan7TV67jbQNO51KBKPexUZ7+OlT6nuNDc4uXTMzUhB74j4Gbm4IDJR6ZDib/
         FJQF7hZt04M07ekiCQMyLkddlHypEBVRxYK3dk6OAi0MsyYRVOy4Sg/iWlXh0orE6h
         zuw+iHp4ah6woQesyqsgy7O3otmXZgMa37W/T41ioNn2bbckUPgoiajtFv1YKJ49Vx
         ILXslm6cVfBqQ==
Date:   Tue, 5 Jan 2021 07:59:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca
Subject: Re: [PATCH -next] tpm: Use kzalloc for allocating only one thing
Message-ID: <20210105055905.GA24455@kernel.org>
References: <20201229135154.23648-1-zhengyongjun3@huawei.com>
 <788cb2e68b98513c84cdc186923f7f99eb55b983.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788cb2e68b98513c84cdc186923f7f99eb55b983.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 29, 2020 at 08:23:49AM -0800, James Bottomley wrote:
> On Tue, 2020-12-29 at 21:51 +0800, Zheng Yongjun wrote:
> > Use kzalloc rather than kcalloc(1,...)
> > 
> > The semantic patch that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> 
> What's the reason for wanting to do this transformation?
> 
> >  drivers/char/tpm/tpm1-cmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-
> > cmd.c
> > index ca7158fa6e6c..4d8415e3b778 100644
> > --- a/drivers/char/tpm/tpm1-cmd.c
> > +++ b/drivers/char/tpm/tpm1-cmd.c
> > @@ -794,7 +794,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32
> > tpm_suspend_pcr)
> >   */
> >  int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> >  {
> > -	chip->allocated_banks = kcalloc(1, sizeof(*chip-
> > >allocated_banks),
> > +	chip->allocated_banks = kzalloc(sizeof(*chip->allocated_banks),
> >  					GFP_KERNEL);
> >  	if (!chip->allocated_banks)
> >  		return -ENOMEM;
> 
> The reason tpm1 has this is because it mirrors the allocation in tpm2
> so we retain code consistency.  It's a fairly minor advantage, so it
> could be changed if you have a better rationale ... but what is it?

Yup, I neither understand this.

> James

/Jarkko
