Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782E54D0E7
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348705AbiFOS2s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbiFOS2r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:28:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFEC3C499;
        Wed, 15 Jun 2022 11:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54DEEB82135;
        Wed, 15 Jun 2022 18:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBC6C34115;
        Wed, 15 Jun 2022 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655317724;
        bh=23AjhX73LJw3UQG1quDZj+f6dK/0HZR4cTsHM3Aqy2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eP6SGE/AxSf/KVjXESCKKeJx9GN3NpkemKHlUJ/M2ZzPa9VfQMSqH+HmBTRNV/7/j
         fXMfvMQ8pgThQwvF9Dq58xmhEMx+ZmQM1Kh+VNlsE3+0HDG2MlD9uI2T1Sys/xujC3
         oRzve5Pda7+p03rR6xCmGBWbgttKmTRkfqCCRAxqUjAUgQBdbQxPK/Chiwv4+K8n51
         iZ0qVOlcUDdhsVsdGLJqdDje+roNtM6dPe+JmowpdtWN2Msng4hTh0VsYQFDrZaRHU
         +YgMDAJx2jIbhBiP35V81k2pIs3s32LJ8e6nZUPHYoyvkWMDj2gV0vttcS04SbVykd
         J+0lEbLrEWFlg==
Date:   Wed, 15 Jun 2022 21:26:35 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de, James.Bottomley@hansenpartnership.com
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 10/10] tpm, tpm_tis: Enable interrupt test
Message-ID: <YqokW/cNLrrsZ2ib@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-11-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-11-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:46PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The test for interrupts in tpm_tis_send() is skipped if the flag
> TPM_CHIP_FLAG_IRQ is not set. Since the current code never sets the flag
> initially the test is never executed.
> 
> Fix this by setting the flag in tpm_tis_gen_interrupt() right after
> interrupts have been enabled.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e5edf745fb23..be229c173f10 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -774,11 +774,16 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
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
>  	release_locality(chip, 0);
>  
>  	return ret;
> -- 
> 2.36.1
> 

James, do you have a chance to test this on your side? Thanks.

BR, Jarkko
