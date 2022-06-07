Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05053FA5F
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiFGJwj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 05:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiFGJwa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 05:52:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33FEBE8F;
        Tue,  7 Jun 2022 02:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F22EB81E79;
        Tue,  7 Jun 2022 09:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8173C385A5;
        Tue,  7 Jun 2022 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654595464;
        bh=c53iMFsek4aDHjn5Gc9SrQFad4s69M1znk7Uy+IQOB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCvag8OmWSoqImIrmPSTjMWq+V0WxOa1CPAvgU2Kq2JoBWDybCuMKFF6bumzBIRN5
         /8lTjcg0S74NlBy3wG8PTufV/iapGlVGt5UFC5BMBMqUsSEen9C6THagPJ470qJa9H
         yW3kh32Yn7myW5v5OUaFgFs0ef/peNQw6WifQLItq7od6+NnCFgaM0bDLQ6xl/jg9c
         bVc0XlyJ3LWYPnWzPcXjTCqCfVtSHcrwoTpfpUnzVm1A3oaqCt2FSqN78DadsjuQfE
         EkWwXWDwo9gcPmiygBiD7ZQ94oGwUmepxFGSsMRu6MxjBmRCFPCHaJQ8pgvrwYwlpG
         97dFZVGfWwJ8Q==
Date:   Tue, 7 Jun 2022 12:49:08 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v3] tpm: Add upgrade/reduced mode support for TPM1.2
 modules
Message-ID: <Yp8fFNMzBLAXdNig@iki.fi>
References: <20220603084156.7090-1-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603084156.7090-1-stefan.mahnke-hartmann@infineon.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 03, 2022 at 10:41:58AM +0200, Stefan Mahnke-Hartmann wrote:
> In case a TPM in failure mode is detected, the TPM should be accessible
> through a transparent communication channel for analysing purposes (e.g.
> TPM_GetTestResult) or a field upgrade. Since a TPM in failure mode has
> similar reduced functionality as in field upgrade mode, the flag
> TPM_CHIP_FLAG_FIRMWARE_UPGRADE is also valid.
> 
> As described in TCG TPM Main Part1 Design Principles, Revision 116,
> chapter 9.2.1. the TPM also allows an update function in case a TPM is
> in failure mode.
> 
> If the TPM in failure mode is detected, the function tpm1_auto_startup()
> sets TPM_CHIP_FLAG_FIRMWARE_UPGRADE flag, which is used later during
> driver initialization/deinitialization to disable functionality which
> makes no sense or will fail in the current TPM state. The following
> functionality is affected:
>  * Do not register TPM as a hwrng
>  * Do not get pcr allocation
>  * Do not register sysfs entries which provide information impossible to
>    obtain in limited mode
> 
> Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
> ---
> Changelog:
>  * v3:
>    * Change kernel messages
> 
>  drivers/char/tpm/tpm.h      | 1 +
>  drivers/char/tpm/tpm1-cmd.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2163c6ee0d36..24ee4e1cc452 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -55,6 +55,7 @@ enum tpm_addr {
>  #define TPM_WARN_DOING_SELFTEST 0x802
>  #define TPM_ERR_DEACTIVATED     0x6
>  #define TPM_ERR_DISABLED        0x7
> +#define TPM_ERR_FAILEDSELFTEST  0x1C
>  #define TPM_ERR_INVALID_POSTINIT 38
>  
>  #define TPM_TAG_RQU_COMMAND 193
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index f7dc986fa4a0..cf64c7385105 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -709,7 +709,12 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  	if (rc)
>  		goto out;
>  	rc = tpm1_do_selftest(chip);
> -	if (rc) {
> +	if (rc == TPM_ERR_FAILEDSELFTEST) {
> +		dev_warn(&chip->dev, "TPM self test failed, switching to the firmware upgrade mode\n");
> +		/* A TPM in this state possibly allows or needs a firmware upgrade */
> +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
> +		return 0;
> +	} else if (rc) {
>  		dev_err(&chip->dev, "TPM self test failed\n");
>  		goto out;
>  	}
> -- 
> 2.25.1
> 

I think this looks good now, thanks for patience:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
