Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79F26A6D32
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 14:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCANlI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 08:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCANlI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 08:41:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F7D39BAC;
        Wed,  1 Mar 2023 05:41:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cw28so4787265edb.5;
        Wed, 01 Mar 2023 05:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677678065;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qXAb53taSbccEZagai0EBEgCI96MXIqMCVHM5azkUc=;
        b=OJZKGTc4qcrLMT6/BKM/Ya5MayDg2mw6migma8Nj1FDOxfkPtPK8fD631yPxhfqZ8T
         bzuIj84l0Jf52GwbCS7SQ64yY5broVHqJJIOubxMW74rzhxLXKMUOWrbsZQFWLLVlNN/
         RsoHNaqT5DAqhzoPJHKUnfyqLGIKrG0rJzdLjO7e8iZ4SJEoRdMwDVr8S0T/NXmHJcGc
         extQKeKXgC3eEPcKMDUCxTHJwpnoFVXqv9mOnP/LeD03LPKDiUalr492xEAQjwRC3Ci4
         RwyjLFq2R6NUjUa/V/m6bjviTddi/1gzJWsBwYjhD3AntWXRvCBZulTrBEHtTsACn7nS
         nRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677678065;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qXAb53taSbccEZagai0EBEgCI96MXIqMCVHM5azkUc=;
        b=p8g+Ep5WO5WYM3xXXRI/gn2112+QgCtzIeHuDkeYlAYg0mi71NN6dEf2u+E8O6tyhJ
         4eiHa50hAmbqcUEsNU87xLG+flCNTxEaxbuet+W4lMPkcE5qJx7gsVwDrfmz6WYQWcPK
         nMRp2hOxU0sCq/IO7WvhidGMD9d/2uyFKqdijgvvFxTgRkYYlICFjc99UAZIpc5/aVe3
         3qMeyt1FeCsDQRXwG3GK4PU8TQ1iFI7P2PCPeh+jsGRjm1YfWVkGrFMAlosbE4+DQ7Uk
         UZuwj7tle7cXtMhrju/ovsCoPaMnGWVw0ON6ty1Ia/XjN1P+7jK7v0sUI7iHrCUOIIe8
         2tjw==
X-Gm-Message-State: AO0yUKXSso/ITOGRQe6PAME3yCJ/JH3lN9icFgfGeHFusiaixpmlpeKW
        ZRi2GCTKsjKALcai3zyZ+u8=
X-Google-Smtp-Source: AK7set8FHkfSDXUUcd5t8RiBLiu5Zmr74vuTJic7kmmP31ZCfUWccx0n18ESE2U2YZxF3oiyHelwZw==
X-Received: by 2002:a17:907:7245:b0:8cf:fda0:5b9b with SMTP id ds5-20020a170907724500b008cffda05b9bmr6663074ejc.22.1677678065397;
        Wed, 01 Mar 2023 05:41:05 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170907784400b008d6e551e1bcsm5750277ejc.2.2023.03.01.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 05:41:04 -0800 (PST)
Date:   Wed, 1 Mar 2023 14:41:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V6 3/3] spi: tegra210-quad: Enable TPM wait polling
Message-ID: <Y/9V71ZYy7FGiK4g@orome>
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
 <20230227172108.8206-4-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="anIYPVtUQRiK+ddV"
Content-Disposition: inline
In-Reply-To: <20230227172108.8206-4-kyarlagadda@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--anIYPVtUQRiK+ddV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 10:51:08PM +0530, Krishna Yarlagadda wrote:
> Trusted Platform Module requires flow control. As defined in TPM
> interface specification, client would drive MISO line at same cycle as
> last address bit on MOSI.
> Tegra241 QSPI controller has TPM wait state detection feature which is
> enabled for TPM client devices reported in SPI device mode bits.
> Set half duplex flag for TPM device to detect and send entire message
> to controller in one shot.
>=20
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-q=
uad.c
> index b967576b6c96..e1165584a20a 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -142,6 +142,7 @@
> =20
>  #define QSPI_GLOBAL_CONFIG			0X1a4
>  #define QSPI_CMB_SEQ_EN				BIT(0)
> +#define QSPI_TPM_WAIT_POLL_EN			BIT(1)
> =20
>  #define QSPI_CMB_SEQ_ADDR			0x1a8
>  #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
> @@ -164,6 +165,7 @@
>  struct tegra_qspi_soc_data {
>  	bool has_dma;
>  	bool cmb_xfer_capable;
> +	bool support_tpm;

Nit: this could be "supports_tpm" for slightly more consistency with
"has_dma".

Thierry

--anIYPVtUQRiK+ddV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP/Ve8ACgkQ3SOs138+
s6HzVg/+Koo8cW9lLDnUsaNXV0MQJN99mkT5rJx5t4WjnBdiw1Zs9/ypgImIxJ5G
yVEIgDhD2HhwKrgPE/Zk6lAd7zXzvbLyzJp0iVrGztWGq8w1vGrIHbQWWltLfoKq
kRkEwxNX+MTmsI1PbboX1goTQLeZJZbSPAnUN/bltBIiT2V8mSqA1qA9B2QkSy7S
WKJD1fWBA2mDj7JJq/SFBNk0AbaujWhCjNvQ2p+nwe0SAlmIHo1eeiujA05jWl+A
27BzR+q5Uxnfgq4WUikEApJO1KyuBXaVsY6aEQB0JhRdDq64mnW+EaL4Wus2HEqf
pLJ9HUA9Csq/t2fUYsBx5O0KM1bt3fkWGt/ZZSroiHQzg5exGKKSUyJOnixTXrlL
wpy1qF2Xc+E8nQYdvMdsVLbVpS1XUQjm6HzERam6x7+Ap2pc2YcNoub32Rc8VYZk
YzRCQdDITM/sChRBKgXNYD6cttI9t+J2kJhuYYvtlvB2Csv1za7DEWdz+5V64lu7
CbK+MCGfIPuNP0v852tyFl2on/y4kE2GfNNfHHHEYa1cNUuM46pc0q6OWnVjpJTu
ZNOCokv9dAKTLptpiZZFa5joJtAtcOLuQ/E5EPdX4R6u4u8v5nbuxHTXaK5ZKyko
3gWEzSTxQWUChpr5fyQbErVX9S3mmd9QL8P4Jm5V3EUVwEnjKws=
=Yd6F
-----END PGP SIGNATURE-----

--anIYPVtUQRiK+ddV--
