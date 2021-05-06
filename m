Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19043374D02
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 03:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEFBrs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 21:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhEFBrr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 21:47:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88C666117A;
        Thu,  6 May 2021 01:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620265610;
        bh=a1mNSdMFz5kd6lmTGBydSuHQAJaIRMrNPwc8ZXDScDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzKqAx8nrA/Uy5BJmLoOlrKHZCGCdYq2tPI2XQY3ahR9tlS+uZ+b0VtWQRWm2mIvN
         ORPFB/fL2T0ZfVvlQdZgrYZLbYpwVr5f/AMVQQFyiH+JJ0b3XAKVcJQ36i/LZ9GvZ5
         Us3DTtnoRXhONqTYJglfnrwDwHkPgp5BUazMOJ/TOZSgKh9pgMZq9e4jDoWMFJnUWb
         W9fyA7+thZCSrFydHH9GGVzQl95PQb9vwxS9uWc8Los33PvLVXyHoUYpozV/CuhUV1
         Kz5pWLLnD+Wak1k2Bd4jJdDf52cnRC0lSI9S7fHQ/tLsTHT0uqvHKw31MqQFlNMJOE
         0THHTXYCJGUuw==
Date:   Thu, 6 May 2021 04:46:47 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] tpm: Use a threaded interrupt handler
Message-ID: <YJNKh2HGbURNBter@kernel.org>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-2-LinoSanfilippo@gmx.de>
 <YJATRNMqzyAprCbL@kernel.org>
 <1364a268-7173-7253-543e-792ff2104e98@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1364a268-7173-7253-543e-792ff2104e98@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 05, 2021 at 12:54:37AM +0200, Lino Sanfilippo wrote:
> 
> Hi,
> 
> 
> On 03.05.21 at 17:14, Jarkko Sakkinen wrote:
> > On Sat, May 01, 2021 at 03:57:24PM +0200, Lino Sanfilippo wrote:
> >> The interrupt handler uses tpm_tis_read32() and tpm_tis_write32() to access
> >> the interrupt status register. In case of SPI those accesses are done with
> >> the spi_bus_lock mutex held. This means that the status register cannot
> >> be read or written in interrupt context.
> >>
> >> For this reason request a threaded interrupt handler so that the required
> >> accesses can be done in process context.
> >>
> >> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> >
> > No fixes tag.
> >
> > The short summary scopes now the whole TPM subsystem ("tpm:"), but the fix
> > is targetted *only* for tpm_tis_spi. How about "tpm, tpm_tis_spi: Allow to
> > sleep in the interrupt handler"?
> >
> > This also changes the semantics tpm_tis_*, not just tpm_tis_spi, which is
> > not acceptable. We cannot backport a fix like this.
> >
> > Probably you should just add a parameter to tpm_tis_core_init() to hint
> > that threaded IRQ is required, and then only conditionally do so.
> >
> 
> Sure, this is doable although to be honest I dont see the issue with also the
> non-SPI code running in the threaded interrupt handler. The functionality should
> not change (especially since interrupts are not even working right now) and it would
> save us a special treatment of the SPI case.

It's violation of "3) Separate your changes" [*].

E.g. we do not want to introduce "improvements" or "simplifications" to
stable kernels on purpose.

[*] https://www.kernel.org/doc/html/v5.11/process/submitting-patches.html> 

/Jarkko
