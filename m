Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7029553EA2
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jun 2022 00:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354745AbiFUWjn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 18:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiFUWjm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 18:39:42 -0400
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F1A326C0;
        Tue, 21 Jun 2022 15:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1655851167; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DpfRmAmcd5mOiaI/BVsDkSresW5F0yc0PWRGqoQnFCTXk7ismPOjFenzh4n7/H6WGHB8acyI/oSN6/d081h2AdTsSTcwm33R/WET57bTT4NL6PZ1TV4GxIFwwNb2QOA0dFgDcC/MlrOcXUkgSxS12lV1hD45E1uLcWR98w52ltc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1655851167; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=D5000dkqlphKbBwJP/zZBoyInN3JBjDwNO6ElbGMMt0=; 
        b=AZiheP3R58glqWX/26Vzg3PUuhLzgUaLIrCnwZpKY5nKBLGDONOb6BT+5JKu3CIZG9nW6uztqsacurxXRylGQQ2KccwFKmLVG7+PrNRog1KCOc+rKpyhCM4FIG5PzIRmB01xi9mbrtnQ5jRl4C74cqY7uN01WW3N3iWdOW5VV5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 1655851160852616.1806560446596; Tue, 21 Jun 2022 15:39:20 -0700 (PDT)
Message-ID: <822cad1aa73867ea36c5428cb929a00aa0e82bc9.camel@mniewoehner.de>
Subject: Re: [PATCH v6 9/9] tpm, tpm_tis: Enable interrupt test
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
In-Reply-To: <20220621132447.16281-10-LinoSanfilippo@gmx.de>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
         <20220621132447.16281-10-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 22 Jun 2022 00:39:17 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.42.2 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-06-21 at 15:24 +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The test for interrupts in tpm_tis_send() is skipped if the flag
> TPM_CHIP_FLAG_IRQ is not set. Since the current code never sets the flag
> initially the test is never executed.
> 
> Fix this by setting the flag in tpm_tis_gen_interrupt() right after
> interrupts have been enabled and before the test is executed.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 1f7663ac1fc4..650c202d2f50 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -775,11 +775,16 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>         if (ret < 0)
>                 return ret;
>  
> +       chip->flags |= TPM_CHIP_FLAG_IRQ;
> +
>         if (chip->flags & TPM_CHIP_FLAG_TPM2)
>                 ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>         else
>                 ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
> 0);
>  
> +       if (ret)
> +               chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +
>         tpm_tis_release_locality(chip, 0);
>  
>         return ret;

Tested-by: Michael Niewöhner <linux@mniewoehner.de>
