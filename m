Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0E3717A9
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhECPPJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 11:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhECPPI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 11:15:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78C4661244;
        Mon,  3 May 2021 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620054855;
        bh=l/oW44h3R465Lu0dfjfqdreggvzt5yyu9gr3b7Ukl8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYjgs/I+MALOqkwkZ61dV5jreY1ObtB9q1kjCfSVVVV2f2o5uHhYt+vbmJkw35Ibd
         NVttw/rz4YoZ0fbwQcJstY2st9UMIkXL1pTtB10MTPm//eY6R8hZcoIXR3SuW3gXTY
         5hoLtIkNrJ7nvjDXbcws5Ni5KdFAlW8HRCNL66az+Afek4M/tajVJ857tMXPmtKlXJ
         JkiLbmtc9TAZ8n6LxMneOB1xaK050PO89WkYShdU0u04y8sXfZl8NBCRjFrJPn+CpB
         pMKNM13HVyRsqJBFQpQaPFztaKZQ3r8E44EgFIk2i3L/tnJRyqnldBeOCyiNhJgy1a
         CX9gzyz+ddzkA==
Date:   Mon, 3 May 2021 18:14:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] tpm: Use a threaded interrupt handler
Message-ID: <YJATRNMqzyAprCbL@kernel.org>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501135727.17747-2-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, May 01, 2021 at 03:57:24PM +0200, Lino Sanfilippo wrote:
> The interrupt handler uses tpm_tis_read32() and tpm_tis_write32() to access
> the interrupt status register. In case of SPI those accesses are done with
> the spi_bus_lock mutex held. This means that the status register cannot
> be read or written in interrupt context.
> 
> For this reason request a threaded interrupt handler so that the required
> accesses can be done in process context.
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

No fixes tag.

The short summary scopes now the whole TPM subsystem ("tpm:"), but the fix
is targetted *only* for tpm_tis_spi. How about "tpm, tpm_tis_spi: Allow to
sleep in the interrupt handler"?

This also changes the semantics tpm_tis_*, not just tpm_tis_spi, which is
not acceptable. We cannot backport a fix like this.

Probably you should just add a parameter to tpm_tis_core_init() to hint
that threaded IRQ is required, and then only conditionally do so.

/Jarkko
