Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BE374E2CB
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 02:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGKAxM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 20:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGKAxL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 20:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F4DCE;
        Mon, 10 Jul 2023 17:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 090186123C;
        Tue, 11 Jul 2023 00:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B11C433C8;
        Tue, 11 Jul 2023 00:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689036788;
        bh=36iFSagVZnDEhRLnp1kYHWCZ0Za33YWo3s47Z2TBxdY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=uKvWtMjBIhC/DsrCDw9gTGexl/Ruhp+0MpQBRVbRCnGbuR4L7E69la8SYi5y81Py3
         bTPouArMwK1w7nn/VOnIPhQgZLCwq/60Vcfv+WdWlOZHsNMyOGd3POaH41GELfwrWG
         Ndmj43x6HZ8vnThLGLbAwqQmZkQwxkGCi0vvTv+oZOm8FsELw57ogocHZogXVf5fTK
         ZhshH8ka0IV8qdoCX101OTrxEiNnH77XHRTs/sPDTayFRA5mZ91hitoHW8h7uOa7MD
         AXkK1rDPv8dgKqOs4pJzqi2J2ZoCe1zkgbjgvSqQEAbxw1h0v1bZmwA7MJOzAV3NKK
         ffTeQnaqrF+tA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Jul 2023 03:53:04 +0300
Message-Id: <CTYXKJ1LRUK2.2PJ6ECEL6ISHP@suppilovahvero>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo L590 devices
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Florian Bezdeka" <florian@bezdeka.de>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
In-Reply-To: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jun 20, 2023 at 2:11 PM EEST, Florian Bezdeka wrote:
> The Lenovo L590 suffers from an irq storm issue like the T490, T490s
> and P360 Tiny, so add an entry for it to tpm_tis_dmi_table and force
> polling.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2214069#c0
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Signed-off-by: Florian Bezdeka <florian@bezdeka.de>
> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7db3593941ea..2771abb5628f 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -138,6 +138,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[=
] =3D {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
>  		},
>  	},
> +	{
> +		.callback =3D tpm_tis_disable_irq,
> +		.ident =3D "ThinkPad L590",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> +		},
> +	},
>  	{
>  		.callback =3D tpm_tis_disable_irq,
>  		.ident =3D "UPX-TGL",
>
> ---
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> change-id: 20230620-flo-lenovo-l590-tpm-fix-4aeb6aa25667
>
> Best regards,
> --=20
> Florian Bezdeka <florian@bezdeka.de>

Thanks, applied.

BR, Jarkko
