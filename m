Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF377438F5
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jun 2023 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjF3KHd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Jun 2023 06:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjF3KHa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Jun 2023 06:07:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9384204;
        Fri, 30 Jun 2023 03:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CCFB6170B;
        Fri, 30 Jun 2023 10:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BE5C433C0;
        Fri, 30 Jun 2023 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688119625;
        bh=dRTq5GwVmzPLKyaKbw23kgA98h3wm06ktUQGye1ZKaY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=fOtZKOvDVMoHj53Mx+Gy2LoFyyPmdIwT32O71yXb2Ehtqebk+gPyiRV5jGGGYA1fM
         vQBd/9NbGQVNmfCHFMxjVqzdd4+YKiLVOe2YDTuVToChdJa4HXCu2m9DsqTDouCRVy
         KwwiPbZYx/iOnVzdS0R8CNDFA+x1AbUpElvJhZBOYQzF3UKU7vpZIiZrBz11yx2ulK
         e9AA85m24IfeJO3WDJ1DXlEFCTOvZ2ZrUqRd8GxdH8DmYcedTRr1+Nuo+hyYRM06Ma
         JsCJxVVICp+CZDck9Xgcy+EQeeW0kz1eHEJoElv9WJQdqklenA15EtRRxV8T4HMPmb
         CW7GkzK+xY3sg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 30 Jun 2023 13:07:00 +0300
Message-Id: <CTPWGNGECE0A.7MSU6S60YWDK@suppilovahvero>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Peter Huewe" <peterhuewe@gmx.de>, <stable@vger.kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Sachin Sant" <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tpm: return false from tpm_amd_is_rng_defective on
 non-x86 platforms
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230629204147.1852823-1-jsnitsel@redhat.com>
In-Reply-To: <20230629204147.1852823-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jun 29, 2023 at 11:41 PM EEST, Jerry Snitselaar wrote:
> tpm_amd_is_rng_defective is for dealing with an issue related to the
> AMD firmware TPM, so on non-x86 architectures just have it inline and
> return false.
>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: stable@vger.kernel.org
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3=
@linux.ibm.com/
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index cd48033b804a..cf5499e51999 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -518,6 +518,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip=
)
>   * 6.x.y.z series: 6.0.18.6 +
>   * 3.x.y.z series: 3.57.y.5 +
>   */
> +#ifdef CONFIG_X86
>  static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
>  {
>  	u32 val1, val2;
> @@ -566,6 +567,12 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip=
 *chip)
> =20
>  	return true;
>  }
> +#else
> +static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_X86 */
> =20
>  static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, boo=
l wait)
>  {
> --=20
> 2.38.1

Sanity check, this was the right patch, right?

I'll apply it.

BR, Jarkko
