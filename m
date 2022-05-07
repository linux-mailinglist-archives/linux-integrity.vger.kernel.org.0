Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7937F51E98E
	for <lists+linux-integrity@lfdr.de>; Sat,  7 May 2022 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446878AbiEGTqC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 May 2022 15:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiEGTqB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 May 2022 15:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0402B275;
        Sat,  7 May 2022 12:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3DF60AF6;
        Sat,  7 May 2022 19:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62C1C385A6;
        Sat,  7 May 2022 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651952533;
        bh=dYodBgcYGaNPGX2CTgOKuHFZPVy+BN1PA48Kg/9BtXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McPiCwj3keKXl+EaovmCcxp4VUQiZKgyBCXYTrEuT2i5EC+Z8fQB1ACaEjDcq604S
         IyRyFBTAHe56QDUUlKQxPQL+xh4wq7axS6AeiaJIPjsinmLWhW7savo/0Gwu7iP3sP
         yBvBP5bx2I9zTFbrWYVla9aWz1ZJkb+mOWn0yaJ7QGKppWDtpg3U25P7U0QPom1v2i
         IqKtepjkUS/zemNxOFc8xcPIaiRfm1A/CLTMTFgRAo0m+MfkcA7rpM8onJQE7HC3RF
         p8y0DxxyzfxKfnn3May0eFVATK+OU81zrYXifykPhkZ5xgd8KfPFW0OovBUe1NJjdg
         z6cCm0Wt1a+Bw==
Date:   Sat, 7 May 2022 22:43:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marten.Lindahl@axis.com, martenli@axis.com, jgg@ziepe.ca,
        jsnitsel@redhat.com, nayna@linux.vnet.ibm.com,
        johannes.holland@infineon.com, peterhuewe@gmx.de
Subject: Re: [PATCH 2/2] tpm: Add Field Upgrade mode support for Infineon
 TPM2 modules
Message-ID: <YnbL9LwDkY+MHdkK@iki.fi>
References: <20220506123145.229058-1-stefan.mahnke-hartmann@infineon.com>
 <20220506123145.229058-2-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506123145.229058-2-stefan.mahnke-hartmann@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 06, 2022 at 02:31:48PM +0200, Stefan Mahnke-Hartmann wrote:
> TPM2_GetCapability with a capability that has the property type value
> of TPM_PT_TOTAL_COMMANDS returns a zero length list, when an Infineon
> TPM2 is in Field Upgrade mode.
> Since an Infineon TPM2.0 in Field Upgrade mode returns RC_SUCCESS on
> TPM2_Startup, the Field Upgrade mode has to be detected by
> TPM2_GetCapability.
> 
> Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index e62a644ce26b..659130e2936e 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -746,6 +746,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  	}
>  
>  	rc = tpm2_get_cc_attrs_tbl(chip);
> +	/*
> +	 * Infineon TPM in Field Upgrade mode will return no data for the number
> +	 * of supported commands.
> +	 */
> +	if (rc == -ENODATA)
> +		rc = TPM2_RC_UPGRADE;

Injecting hardware error codes like this is not considered a great idea.

>  
>  out:
>  	if (rc == TPM2_RC_UPGRADE) {
> -- 
> 2.25.1
> 

BR, Jarkko
