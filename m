Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE256A3D67
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 09:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjB0Iq6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 03:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjB0Iq1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 03:46:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BB21F5E0;
        Mon, 27 Feb 2023 00:39:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C26560DB5;
        Mon, 27 Feb 2023 08:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3095BC433D2;
        Mon, 27 Feb 2023 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677487081;
        bh=K6zjfpGeRqhj20EF3kr8kZVgDzjn8p9pMMSaDUqqJXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEmomDMd8U2TDn4kYq/IBjv4qo62DUAKHB8gyc83mJS7wgzH9Uu24HOji1PbXZwUA
         M9bF4tYeZiD0ctbU30GSSAfBHSjfpgXUhsn6buUYdNmkPTi5Nst/mfsL3Fr3emxeVW
         BK9kEGWIAByLLuAQVDkmckfVRGegSfCDdGe9Q6BoTSJMIu8bL9+IrfoaiZ5EAJBF3L
         Qrzh+MVotSgj3VkAdxapHN+KNaBcNeLTPKJ++KzU2+SKAnwnT/7IVSPtzxx3zDuDZa
         bQke6jWnA81HKGuVIz58KY1gbqqJKQ+hHE3oybVKiA1j8mDurTaZcA60bYNMWF4Sw+
         rzCt+dp6aaFDg==
Date:   Mon, 27 Feb 2023 10:37:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 06/12] tpm: export the context save and load commands
Message-ID: <Y/xr53SmY3aDZV2D@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
 <20230216201410.15010-7-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216201410.15010-7-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 16, 2023 at 03:14:04PM -0500, James Bottomley wrote:
> The TPM2 session HMAC and encryption handling code needs to save and
> restore a single volatile context for the elliptic curve version of
> the NULL seed, so export the APIs which do this for internal use.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

These did not need EXPORT_SYMBOL_GPL()?

> ---
>  drivers/char/tpm/tpm.h        | 4 ++++
>  drivers/char/tpm/tpm2-space.c | 8 ++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 24ee4e1cc452..a5fe37977103 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -237,6 +237,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
>  		      size_t *bufsiz);
>  int tpm_devs_add(struct tpm_chip *chip);
>  void tpm_devs_remove(struct tpm_chip *chip);
> +int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> +		      unsigned int buf_size, unsigned int *offset);
> +int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> +		      unsigned int *offset, u32 *handle);
>  
>  void tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index ffb35f0154c1..d77ee4af9d65 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -68,8 +68,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  	kfree(space->session_buf);
>  }
>  
> -static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> -			     unsigned int *offset, u32 *handle)
> +int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> +		      unsigned int *offset, u32 *handle)
>  {
>  	struct tpm_buf tbuf;
>  	struct tpm2_context *ctx;
> @@ -119,8 +119,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
>  	return 0;
>  }
>  
> -static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> -			     unsigned int buf_size, unsigned int *offset)
> +int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> +		      unsigned int buf_size, unsigned int *offset)
>  {
>  	struct tpm_buf tbuf;
>  	unsigned int body_size;
> -- 
> 2.35.3
> 

BR, Jarkko
