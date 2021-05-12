Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DB37B35F
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 03:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhELBU0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 21:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhELBU0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 21:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD78861002;
        Wed, 12 May 2021 01:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620782359;
        bh=mY19LPLeJ5R4ZXUBmKxvee5mTkZMWOs5YxEaXsA9M5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hu4f/XrKnjc5mk9X/HR24vZ0TZG8qEkvvYf66vQZ6F1/Inmc0svpj5mSqQTM+o1Bq
         HsP/H/hkO6mOlFdU0w/Fy5p7qBOf6kGsygnx2A6Zr0EVNuRWrIitD8Zy/4x6L16F0l
         aQlIm1oWhhZt1O2AXprOCRsHMKtXe/e6dcA875JCt+MaQLDZhjEx4idjzfHPx0OcuW
         ABKlMfAU+12IW8fBEN3Zr6c+OpaxpfebhxUtZeCR0II0nTjqDWtLRCp4jIIYw/eQn9
         i3f3fPeAWs8brS4/MS9+49lkUZcg4qnApbNTPAtCx8VxaeQVKBz1QCMKQzt4HLzlA9
         BeYiIq0GYK1zA==
Date:   Wed, 12 May 2021 04:19:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?utf-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: set default probe function if device id not
 match
Message-ID: <YJstFJYd9GTW6J9s@kernel.org>
References: <20210507145255.44033-1-zhangliguang@linux.alibaba.com>
 <YJXxDzougt3ZC01q@kernel.org>
 <e74fd54f-1700-4b06-a320-c0e257666565@linux.alibaba.com>
 <YJhIcIXMFj/LcYwu@kernel.org>
 <0ec3ed60-6967-c14a-d1f3-0ff80c9d5003@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ec3ed60-6967-c14a-d1f3-0ff80c9d5003@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 12, 2021 at 09:07:56AM +0800, 乱石 wrote:
> 在 2021/5/10 4:39, Jarkko Sakkinen 写道:
> > On Sat, May 08, 2021 at 10:46:57AM +0800, 乱石 wrote:
> > > Hi,
> > > 
> > > 在 2021/5/8 10:01, Jarkko Sakkinen 写道:
> > > > On Fri, May 07, 2021 at 10:52:55PM +0800, Liguang Zhang wrote:
> > > > > In DSDT table, TPM _CID was SMO0768, and no _HID definition. After a
> > > > > kernel upgrade from 4.19 to 5.10, TPM probe function was changed which
> > > > > causes device probe fails. In order to make newer kernel to be
> > > > > compatible with the older acpi definition, it would be best set default
> > > > > probe function.
> > > > > 
> > > > > Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> > > > > ---
> > > > >    drivers/char/tpm/tpm_tis_spi_main.c | 12 ++++++++----
> > > > >    1 file changed, 8 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> > > > > index 3856f6ebcb34..da632a582621 100644
> > > > > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > > > > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > > > > @@ -240,10 +240,14 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
> > > > >    	tpm_tis_spi_probe_func probe_func;
> > > > >    	probe_func = of_device_get_match_data(&spi->dev);
> > > > > -	if (!probe_func && spi_dev_id)
> > > > > -		probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> > > > > -	if (!probe_func)
> > > > > -		return -ENODEV;
> > > > > +	if (!probe_func) {
> > > > > +		if (spi_dev_id) {
> > > > > +			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> > > > > +			if (!probe_func)
> > > > > +				return -ENODEV;
> > > > Perhaps also hear fallback to tpm_tis_spi_probe?
> > > 
> > > Yes, I do not think of a good way. Do you have any suggestions?
> > So, I just think that when you have this part:
> > 
> > 
> > if (!probe_func) {
> > 	if (spi_dev_id) {
> >                  probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> >                  if (!probe_func)
> >                          return -ENODEV;
> > 
> > Why in here would not you also want to fallback to tpm_tis_spi_probe?
> 
> Sorry to trouble you, do you have a good way to resolve the compatible
> problem caused by kernel update (4.19 -> 5.10) ?

I think I'll take this as it is.

I'll apply it to my tree and take it as part of next pr.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
