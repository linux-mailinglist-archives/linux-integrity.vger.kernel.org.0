Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA46528D31
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344980AbiEPShp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbiEPSho (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 14:37:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E243E0D2;
        Mon, 16 May 2022 11:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2901B815B8;
        Mon, 16 May 2022 18:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12983C385AA;
        Mon, 16 May 2022 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652726260;
        bh=hdvI2TLp4kCgPxPsSGeo5VgFz8oTtk9oTkBzXAHZV9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tV0zH4gix4mGWAoh4FgqNOspZQOJ/h4nbxRGJR6eJyRofKbCKf6jXRNJBmy64TS8K
         bzk8cfFxBtCM0ixeLLUWToRNRSdQ0g1PxEgXirLPRpyZzBbFAA8E4wy1eWIP04VPJ/
         4yRd4DVCn2ZSKbIT29kSQ9tx66QQ4fw4bc8hU/hN3EwpkpaDHwnzJ9oVTkVKPtCoeR
         WnQMGYR2Dc6HzW6mUSou1ITbqVMfC3aefGULexWSjALVr+qGpS5NxzqZHu0soxcFt4
         JHUOGTas62n5okSVJiQiuxqggHzJYEkb9UMgg6n3/b3NANl7o1+33pr3s+mJJsP+B1
         qVYeM7igfestA==
Date:   Mon, 16 May 2022 21:36:05 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, jsnitsel@redhat.com,
        nayna@linux.vnet.ibm.com, alexander.steffen@infineon.com
Subject: Re: [PATCH v2 2/2] tpm: Add field upgrade mode support for Infineon
 TPM2 modules
Message-ID: <YoKZlTwRnEfzgApR@kernel.org>
References: <20220513134152.270442-1-stefan.mahnke-hartmann@infineon.com>
 <20220513134152.270442-2-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513134152.270442-2-stefan.mahnke-hartmann@infineon.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 13, 2022 at 03:41:53PM +0200, Stefan Mahnke-Hartmann wrote:
> TPM2_GetCapability with a capability that has the property type value
> of TPM_PT_TOTAL_COMMANDS returns a zero length list, when an Infineon
> TPM2 is in field upgrade mode.
> Since an Infineon TPM2.0 in field upgrade mode returns RC_SUCCESS on
> TPM2_Startup, the field upgrade mode has to be detected by
> TPM2_GetCapability.
> 
> Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
> ---
> Changelog:
>  * v2:
>    * Move check of -ENODATA to if condition below.
>    * Change 'field upgrade mode' to lower case.
> 
>  drivers/char/tpm/tpm2-cmd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 04a3e23a4afc..c1eb5d223839 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -754,7 +754,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  	rc = tpm2_get_cc_attrs_tbl(chip);
>  
>  out:
> -	if (rc == TPM2_RC_UPGRADE) {
> +	/*
> +	 * Infineon TPM in field upgrade mode will return no data for the number
> +	 * of supported commands.
> +	 */
> +	if (rc == TPM2_RC_UPGRADE || rc == -ENODATA) {
>  		dev_info(&chip->dev, "TPM in field upgrade mode, requires firmware upgrade\n");
>  		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
>  		rc = 0;
> -- 
> 2.25.1
> 

Looks good to me.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
