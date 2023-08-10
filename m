Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F61777BAA
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjHJPHm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjHJPHm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 11:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33902686
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 08:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FC565F37
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 15:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF6C433C8;
        Thu, 10 Aug 2023 15:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691680060;
        bh=g3d0krYrFTTUapUqbzoOvaE9VdfL8df0S0ijir35Uqo=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=lrNgqIgoXOsTySiExNS9Ul3TUOvvrN2aF9d0pBXd9RivZmmq2MALhGvyepm0kLg/4
         BR8obSJCtjhdaWmpIRqYmHTJgoJGZRPDFK0+Hh81cpOy6vhAgv1vAL9iVaI4yD/NkM
         7fooP80PYHYRQ5fF9gEVD0RhWT43h9k79uZyMOswFNSxmtWZpKJU7i8xjaJ38guFb6
         bCn2hBOK1fQwh274MR3RCS8valBZnuJ7vzn/3BcZVUSQ6YGkXg0rY7L6pzUI+JwDuz
         /kH7T3+Q7gLKOv2dZ6zqZWLETWK8O4JG1AFn7J8Y58ZtMYjFmnPesGokCMKeUytRo2
         Lw/Wt0W0XlnGQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:07:33 +0300
Message-Id: <CUOYJ45WR5I0.3JFE0U1387QC8@wks-101042-mac.ad.tuni.fi>
Cc:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>,
        <linux-integrity@vger.kernel.org>, <daniil.stas@posteo.net>,
        <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: Add a helper for checking hwrng enabled
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
X-Mailer: aerc 0.15.2
References: <20230808041229.22514-1-mario.limonciello@amd.com>
In-Reply-To: <20230808041229.22514-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Aug 8, 2023 at 7:12 AM EEST, Mario Limonciello wrote:
> The same checks are repeated in 3 places to decide whether to use
> hwrng.  Consolidate these into a helper.
>
> Also this fixes a case that one of them was missing a check in the
> cleanup path.
>
> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e904aae9771be..ea6b4013bc38f 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -521,10 +521,20 @@ static int tpm_hwrng_read(struct hwrng *rng, void *=
data, size_t max, bool wait)
>  	return tpm_get_random(chip, data, max);
>  }
> =20
> +static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
> +{
> +	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> +		return false;
> +	if (tpm_is_firmware_upgrade(chip))
> +		return false;
> +	if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
> +		return false;
> +	return true;
> +}
> +
>  static int tpm_add_hwrng(struct tpm_chip *chip)
>  {
> -	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) =
||
> -	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
> +	if (!tpm_is_hwrng_enabled(chip))
>  		return 0;
> =20
>  	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> @@ -629,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *chip)
>  	return 0;
> =20
>  out_hwrng:
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
> +	if (tpm_is_hwrng_enabled(chip))
>  		hwrng_unregister(&chip->hwrng);
>  out_ppi:
>  	tpm_bios_log_teardown(chip);
> @@ -654,8 +664,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>  void tpm_chip_unregister(struct tpm_chip *chip)
>  {
>  	tpm_del_legacy_sysfs(chip);
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) =
&&
> -	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
> +	if (tpm_is_hwrng_enabled(chip))
>  		hwrng_unregister(&chip->hwrng);
>  	tpm_bios_log_teardown(chip);
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))

Given my previous queries: should I apply this or revert and apply v3?

BR, Jarkko
