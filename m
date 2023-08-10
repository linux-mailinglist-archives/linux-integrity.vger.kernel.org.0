Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438EF778378
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjHJWKQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 18:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJWKQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 18:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CCF2713
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 15:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EB816333D
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 22:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FF3C433C8;
        Thu, 10 Aug 2023 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691705413;
        bh=E9Qq/D0I3KdG8XEj9VwItzZ5i+nyt+ZP387FEU1YwlY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=NFUBURAKHNRiuRpiAzHrhpAOSAKv0c81Ypa4utNLndi4+ibJkMlAMot+HE6RR1aUC
         e2pBJW/codqQBc053bFd4uCCW2k4YnM8palUeiVnQi3SaWQzO2r7ZrbuYIkFBpLLte
         7oLNYWB6MO0x9vgd8soia3aNNAuqmb2GHp5T3pjCH9dONErfpfLi7ty5roGFOmzsiO
         N4R3GzTlExsyKDynXTTqVml7ytuuGLSE9gQ9nvHeC5IlWjhWNSounLGPBvxZkI6qH1
         9MWVIhpXFME7Wss2YhmD+Dh7XI5FQfLVd1aJkpqOECZFb8UJ2GPu34JoBOTfbGNRFR
         u1Rc1SzKKMt5w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 01:10:09 +0300
Message-Id: <CUP7IOG782XM.11EAVH910MQOR@suppilovahvero>
Cc:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>,
        <linux-integrity@vger.kernel.org>, <daniil.stas@posteo.net>,
        <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: Add a helper for checking hwrng enabled
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
X-Mailer: aerc 0.14.0
References: <20230808041229.22514-1-mario.limonciello@amd.com>
 <CUOYJ45WR5I0.3JFE0U1387QC8@wks-101042-mac.ad.tuni.fi>
 <17b312c5-d8e7-4f3c-9b38-ba82233eb003@amd.com>
In-Reply-To: <17b312c5-d8e7-4f3c-9b38-ba82233eb003@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 10, 2023 at 6:08 PM EEST, Limonciello, Mario wrote:
>
>
> On 8/10/2023 10:07 AM, Jarkko Sakkinen wrote:
> > On Tue Aug 8, 2023 at 7:12 AM EEST, Mario Limonciello wrote:
> >> The same checks are repeated in 3 places to decide whether to use
> >> hwrng.  Consolidate these into a helper.
> >>
> >> Also this fixes a case that one of them was missing a check in the
> >> cleanup path.
> >>
> >> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/char/tpm/tpm-chip.c | 19 ++++++++++++++-----
> >>   1 file changed, 14 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> >> index e904aae9771be..ea6b4013bc38f 100644
> >> --- a/drivers/char/tpm/tpm-chip.c
> >> +++ b/drivers/char/tpm/tpm-chip.c
> >> @@ -521,10 +521,20 @@ static int tpm_hwrng_read(struct hwrng *rng, voi=
d *data, size_t max, bool wait)
> >>   	return tpm_get_random(chip, data, max);
> >>   }
> >>  =20
> >> +static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
> >> +{
> >> +	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> >> +		return false;
> >> +	if (tpm_is_firmware_upgrade(chip))
> >> +		return false;
> >> +	if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
> >> +		return false;
> >> +	return true;
> >> +}
> >> +
> >>   static int tpm_add_hwrng(struct tpm_chip *chip)
> >>   {
> >> -	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chi=
p) ||
> >> -	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
> >> +	if (!tpm_is_hwrng_enabled(chip))
> >>   		return 0;
> >>  =20
> >>   	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> >> @@ -629,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *chip)
> >>   	return 0;
> >>  =20
> >>   out_hwrng:
> >> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chi=
p))
> >> +	if (tpm_is_hwrng_enabled(chip))
> >>   		hwrng_unregister(&chip->hwrng);
> >>   out_ppi:
> >>   	tpm_bios_log_teardown(chip);
> >> @@ -654,8 +664,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
> >>   void tpm_chip_unregister(struct tpm_chip *chip)
> >>   {
> >>   	tpm_del_legacy_sysfs(chip);
> >> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chi=
p) &&
> >> -	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
> >> +	if (tpm_is_hwrng_enabled(chip))
> >>   		hwrng_unregister(&chip->hwrng);
> >>   	tpm_bios_log_teardown(chip);
> >>   	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(ch=
ip))
> >=20
> > Given my previous queries: should I apply this or revert and apply v3?
> >=20
> > BR, Jarkko
>
> Linus picked it up already directly.

I came two days behind, sorry.

BR, Jarkko
