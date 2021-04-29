Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F336E53C
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhD2G72 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 02:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2G72 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 02:59:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64EBE6144B;
        Thu, 29 Apr 2021 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619679521;
        bh=/z94UXd9ED77kTYjdA68Q9brJalMV09S0Vx9VS9bQ88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqatBFUnI0LsTFovwJsAyBEONdkm0Yy8yz34j5ID8VfNxqIZ5Lbx9wVo7yweBeFjc
         wUD9GXpcQqmFXH+B+WzGVzAh9x90kKxaF5hYAT26HaQLucJvyjXuxQkIO48splkvOc
         jjMlbOP1QMUPq308cVV/9j5lSdvTluZ4+leKWOUa5s/RZBKGkuH3ZAjuyShjOHaTxe
         xSLrrdJY7EHmRBCYwvWQU7NP8wHLo5uXrThQva18UHiakAl907Exw1eeFvrXp1+Cxu
         EzbQvVXlSJuemf20yXb7GkWPA2FiPU2wxpqYsXoE8ZFhvoUOV74a8cwowzO4dsKWYb
         NSjoM/v08ZZQQ==
Date:   Thu, 29 Apr 2021 09:58:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Use a threaded interrupt handler
Message-ID: <YIpZH5TtEDA071EE@kernel.org>
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-2-git-send-email-LinoSanfilippo@gmx.de>
 <YIikDCTBcMMxjots@kernel.org>
 <495e816a-afba-4ea0-560c-bc748df26337@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <495e816a-afba-4ea0-560c-bc748df26337@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 29, 2021 at 12:37:40AM +0200, Lino Sanfilippo wrote:
> 
> Hi,
> 
> On 28.04.21 at 01:53, Jarkko Sakkinen wrote:
> > On Mon, Apr 26, 2021 at 01:47:17AM +0200, Lino Sanfilippo wrote:
> >> Interrupt handling at least includes reading and writing the interrupt
> >> status register from the interrupt routine. However over SPI those accesses
> >> require a sleepable context, since a mutex is used in the concerning
> >> functions.
> >> For this reason request a threaded interrupt handler which is running in
> >> (sleepable) process context.
> >>
> >> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> >> ---
> >>  drivers/char/tpm/tpm_tis_core.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> >> index e7d1eab..0959559 100644
> >> --- a/drivers/char/tpm/tpm_tis_core.c
> >> +++ b/drivers/char/tpm/tpm_tis_core.c
> >> @@ -781,8 +781,10 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
> >>  	int rc;
> >>  	u32 int_status;
> >>
> >> -	if (devm_request_irq(chip->dev.parent, irq, tis_int_handler, flags,
> >> -			     dev_name(&chip->dev), chip) != 0) {
> >> +
> >> +	if (devm_request_threaded_irq(chip->dev.parent, irq, NULL,
> >> +				      tis_int_handler, IRQF_ONESHOT | flags,
> >> +				      dev_name(&chip->dev), chip) != 0) {
> >>  		dev_info(&chip->dev, "Unable to request irq: %d for probe\n",
> >>  			 irq);
> >>  		return -1;
> >> --
> >> 2.7.4
> >>
> >
> > Why?
> >
> > https://elixir.bootlin.com/linux/v5.12/source/drivers/char/tpm/tpm_tis_core.c#L670
> >
> > I don't see anything that sleeps there.
> >
> > /Jarkko1
> >
> 
> The problem are the register read/write functions which we use to access the status register in
> the interrupt handler. In case of SPI they result in taking the spi_bus_lock which is a mutex.
> 
> E.g tpm_tis_spi_read32: tpm_tis_spi_read_bytes->tpm_tis_spi_transfer->spi_bus_lock->mutex_lock
> 
> Using a threaded interrupt handler seemed to me the easiest way to avoid this issue.
> 
> Regards,
> Lino
> 
> 
> 

This is a sentence that you should delete:

"However over SPI those accesses require a sleepable context, since a
mutex is used in the concerning functions.  "

It neither explains anything who and why sort of stuff.

Why don't you put intead something like

"Inside tpm_int_handler(), tpm_tis_read32() and tpm_tis_write32() are
invoked. The SPI subsystem requires mutex for I/O, which means that the
calls ought not to be used inside interrupt context."

(I did not check typos). Generally speaking, commit message is as, if not
more important than the code change.

/Jarkko
