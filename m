Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC18760912D
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Oct 2022 06:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJWEeP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Oct 2022 00:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJWEeO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Oct 2022 00:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6C785AF;
        Sat, 22 Oct 2022 21:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1471860B7C;
        Sun, 23 Oct 2022 04:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F137C433D6;
        Sun, 23 Oct 2022 04:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666499652;
        bh=Q3s1OLxzArfWy9GccENd4cbB843/Dd9hjqQDGmE9cK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFNlvXHVcv/Y9xiXrSffphyuPHkvt/EnAGRiP+tpr/S3X06jdOoEM3LOdPPyF4qHO
         3K78/r1FThzCAreKEn9w22rV3C6Bvsx6Cq9AYWrN95xjbtxPQB3amuCVI+evj7zhCZ
         s7OcVcQnyHSq5TBS48QEI9KAgGlxunIdw9e5CW69gi8KU/RkSJ2ongX6PM+TeaOU8w
         +Um7RaJr9eNa3HQZN8Cf+SYH8mMNmkSBWyQufSavX9S+8hIDARytxbtF1Tm8iZUCzq
         Mt2DCBJtOwOJEMBzSOyRxJGBKnMJDlJGOgbSO0MqP8HLaw0FBna/7Wuuy3jzDjrn0L
         xlNPTAOVFBEkg==
Date:   Sun, 23 Oct 2022 07:34:05 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 11/11] tpm, tpm_tis: Enable interrupt test
Message-ID: <Y1TEPW02O7AyX8ty@kernel.org>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-12-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221017235732.10145-12-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 18, 2022 at 01:57:32AM +0200, Lino Sanfilippo wrote:
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
> Tested-by: Michael Niewöhner <linux@mniewoehner.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 42f628e52cde..9778860e1598 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -793,11 +793,16 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  	if (ret < 0)
>  		return ret;
>  
> +	chip->flags |= TPM_CHIP_FLAG_IRQ;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>  	else
>  		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
>  
> +	if (ret)
> +		chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +
>  	tpm_tis_release_locality(chip, 0);
>  
>  	return ret;
> -- 
> 2.36.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
