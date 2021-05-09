Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636D637787E
	for <lists+linux-integrity@lfdr.de>; Sun,  9 May 2021 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhEIUkU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 9 May 2021 16:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhEIUkT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 May 2021 16:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABD6A613CD;
        Sun,  9 May 2021 20:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620592756;
        bh=vRLvHTJ7c/kDMhq7zRaMkRhfEVoym4NQkeeAZlTPBiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IhZXKM7ZfJnlicrQUDivP0G+1tfyKsZ4kc0oBHKYeJ4SZGUWOk6sIs6UsyTzV6Y9L
         p97/swEXYmNr4h4TbLPuXl2SYExSfmH9NJpXr3b+nSAZ+DBGtly4U7tM0e9L9hFJpJ
         Jn2KbB+3tv1RpXM2YfMKZ/qGnvmY3/8Jrivz7l42RKJvSe5waM5wIj8m4wEOxUOghu
         bWCZNzKfQuO27mswIeM6V9drU/xMz7pI/hFId8Hw8n6y79oZEObwlI4Ee27OKE594b
         yNz1mKguu75owFfnyUEflSY1djJ6W4CKIO7jL9nEiaErlO/EgJssHG/WoTJ0yRGFfa
         yqWVOsKfpcEBw==
Date:   Sun, 9 May 2021 23:39:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?utf-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: set default probe function if device id not
 match
Message-ID: <YJhIcIXMFj/LcYwu@kernel.org>
References: <20210507145255.44033-1-zhangliguang@linux.alibaba.com>
 <YJXxDzougt3ZC01q@kernel.org>
 <e74fd54f-1700-4b06-a320-c0e257666565@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e74fd54f-1700-4b06-a320-c0e257666565@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, May 08, 2021 at 10:46:57AM +0800, 乱石 wrote:
> Hi,
> 
> 在 2021/5/8 10:01, Jarkko Sakkinen 写道:
> > On Fri, May 07, 2021 at 10:52:55PM +0800, Liguang Zhang wrote:
> > > In DSDT table, TPM _CID was SMO0768, and no _HID definition. After a
> > > kernel upgrade from 4.19 to 5.10, TPM probe function was changed which
> > > causes device probe fails. In order to make newer kernel to be
> > > compatible with the older acpi definition, it would be best set default
> > > probe function.
> > > 
> > > Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> > > ---
> > >   drivers/char/tpm/tpm_tis_spi_main.c | 12 ++++++++----
> > >   1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> > > index 3856f6ebcb34..da632a582621 100644
> > > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > > @@ -240,10 +240,14 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
> > >   	tpm_tis_spi_probe_func probe_func;
> > >   	probe_func = of_device_get_match_data(&spi->dev);
> > > -	if (!probe_func && spi_dev_id)
> > > -		probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> > > -	if (!probe_func)
> > > -		return -ENODEV;
> > > +	if (!probe_func) {
> > > +		if (spi_dev_id) {
> > > +			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> > > +			if (!probe_func)
> > > +				return -ENODEV;
> > Perhaps also hear fallback to tpm_tis_spi_probe?
> 
> 
> Yes, I do not think of a good way. Do you have any suggestions?

So, I just think that when you have this part:


if (!probe_func) {
	if (spi_dev_id) {
                probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
                if (!probe_func)
                        return -ENODEV;

Why in here would not you also want to fallback to tpm_tis_spi_probe?

/Jarkko
