Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3B74D7C8
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjGJNe3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjGJNeT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 09:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E20EE79;
        Mon, 10 Jul 2023 06:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BCF60FF4;
        Mon, 10 Jul 2023 13:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E69C433C9;
        Mon, 10 Jul 2023 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688996042;
        bh=pVxBdWCdEp7vxQUapSYR0qDalqiMWNMErASB1VrWpxY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=j6KZ0TjPxiupJkKmZDpTjYR+37NUEKuymsUa5+2V3oBljnMLtuhg/gcWOnqaFh8xV
         IalhPYIHarTc0dTdmtRNIfQOU6BqDhzaTh5ETl6CJtdDHoMUg9eopON3armO3+K/ev
         66Pymb56FSCH/hXvAfQoePjJDWgCPz+8mCFt+YfHIX1IRr06Sc3qSVLP+RRI57EFAp
         CAQZin/y4nJXJPPxXV3if4jiIFcwDWS2yQoYPpaT1cwtc2g3lJJTYV8k3Ll8/TQFhP
         vkVDQ7I+80+ZrKqkjh4ETa6MvAopekszQ3P7ck8QXiq9FqJmS4LrCbdEgB396z843g
         fnHr5GbhWu6hg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 10 Jul 2023 16:33:58 +0300
Message-Id: <CTYJ4KD2K9GO.25KSGPKKJSEN0@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Do not remap from ACPI resouces again for
 Pluton TPM
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Valentin David" <valentin.david@gmail.com>,
        "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.14.0
References: <20230701153329.6476-1-valentin.david@gmail.com>
 <20230706191409.737080-1-valentin.david@gmail.com>
In-Reply-To: <20230706191409.737080-1-valentin.david@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jul 6, 2023 at 10:13 PM EEST, Valentin David wrote:
> For Pluton TPM devices, it was assumed that there was no ACPI memory
> regions. This is not true for ASUS ROG Ally. ACPI advertises
> 0xfd500000-0xfd5fffff.
>
> Since remapping is already done in `crb_map_pluton`, remapping again
> in `crb_map_io` causes EBUSY error:
> ```
> [    3.510453] tpm_crb MSFT0101:00: can't request region for resource [me=
m 0xfd500000-0xfd5fffff]
> [    3.510463] tpm_crb: probe of MSFT0101:00 failed with error -16
> ```
>
> Signed-off-by: Valentin David <valentin.david@gmail.com>

Please add a fixes tag.

> ---
> v2: add missing sign-off in commit message
> ---
>  drivers/char/tpm/tpm_crb.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index d43a0d7b97a8..1a5d09b18513 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -563,15 +563,18 @@ static int crb_map_io(struct acpi_device *device, s=
truct crb_priv *priv,
>  	u32 rsp_size;
>  	int ret;
> =20
> -	INIT_LIST_HEAD(&acpi_resource_list);
> -	ret =3D acpi_dev_get_resources(device, &acpi_resource_list,
> -				     crb_check_resource, iores_array);
> -	if (ret < 0)
> -		return ret;
> -	acpi_dev_free_resource_list(&acpi_resource_list);
> -
> -	/* Pluton doesn't appear to define ACPI memory regions */
> +	/*
> +	 * Pluton sometimes does not define ACPI memory regions.
> +	 * Mapping is then done in crb_map_pluton
> +	 */
>  	if (priv->sm !=3D ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
> +		INIT_LIST_HEAD(&acpi_resource_list);
> +		ret =3D acpi_dev_get_resources(device, &acpi_resource_list,
> +					     crb_check_resource, iores_array);
> +		if (ret < 0)
> +			return ret;
> +		acpi_dev_free_resource_list(&acpi_resource_list);
> +
>  		if (resource_type(iores_array) !=3D IORESOURCE_MEM) {
>  			dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resourc=
e\n");
>  			return -EINVAL;
> --=20
> 2.41.0

I don't see anything else to complain about.

BR, Jarkko
