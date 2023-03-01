Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975BB6A6D1F
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 14:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCANhv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 08:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCANhu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 08:37:50 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B233CE14;
        Wed,  1 Mar 2023 05:37:49 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so53824133eda.7;
        Wed, 01 Mar 2023 05:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677677868;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0Tm2Y+hWRKxWl4T5yrSEnRh0lFyul4U3El1HK5aNoo=;
        b=mbJl8Y9WJ0jLMqRNmVJuAmCzx7Rxb/m087TaNuWoAaxZ9yxleN+hCNRTUiBJIEo956
         FxiV5bs4Q+x8mVBiS9L15mxeX6/S0m42AE7phKF2bpeHnLnF4mKDtwm4BUr81ecfJSCl
         IF2SdYwZOWJZ35G3HNQJDcEZ9Wa5Hfw1rrZC+5aQWgVLXz1dV7AC7RhIMH+AQh3vQGd+
         23acDknu5ql09XMfvRD4vq5VDUDhBp050CaVF2qkhc2vY2d4B2y+4zxtcSd6Sb28h1Es
         SL9Dhaz9p/ZLY5H0Lflvm9Z4o+KfYCn2fHeAirGs4WmjRGqNKjfkUw53ApTBNeu9qAXA
         Z59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677677868;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0Tm2Y+hWRKxWl4T5yrSEnRh0lFyul4U3El1HK5aNoo=;
        b=7jRLC4KU5fhjlHjoECe1fYGMyM7LbCBv+2mbIsu2IDwDuLiOXyjUn5HmntamJD8EnV
         CzLz7wSbxO8AgVsJY+1G5nx0xOxqXI7gNa46RORCWrl3DuNl4tD7yaOyeOhN7MpF6aqR
         iTGkevCEi1Q+hiGPbuRMTEgPw17nHAgBlputhZYy9WYOHNFXjjhwdjuFQ5kEgl0wl6FU
         l6N60gtW8q4S4mGNj/JpIZ0dbHaOPg3tMMnFoKFL8uN0nUEr6VHHG8OhupYlA+bywhU/
         auRncrB6ftheQxVj2quAVbrVigTSUTmohTdGK9ayibCNZcPdVm8sO2obiufqZRNucaUE
         xXRw==
X-Gm-Message-State: AO0yUKUHqgPu+VoEXpFEi9kK+R8ec/IRBcPC5KaSuqUoDjH287RIHUxM
        z/pPY1GGjdVuV0S6Hz81mxQ=
X-Google-Smtp-Source: AK7set9UfrHCyrRTAxw97aQ0S7UIoo02OEM1OfFoOvnNrPoOYEXSM29xcYTuvA/FDVaBedEDIKIncQ==
X-Received: by 2002:a17:907:7e82:b0:8ab:4c4:d0f6 with SMTP id qb2-20020a1709077e8200b008ab04c4d0f6mr8733391ejc.56.1677677867732;
        Wed, 01 Mar 2023 05:37:47 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b00905a1abecbfsm1047441ejo.47.2023.03.01.05.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 05:37:47 -0800 (PST)
Date:   Wed, 1 Mar 2023 14:37:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V6 2/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/9VKV6ddpWlmU9f@orome>
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
 <20230227172108.8206-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="irPaUU4QFHK5esZZ"
Content-Disposition: inline
In-Reply-To: <20230227172108.8206-3-kyarlagadda@nvidia.com>
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


--irPaUU4QFHK5esZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 10:51:07PM +0530, Krishna Yarlagadda wrote:
[...]
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_t=
is_spi_main.c
[...]
> @@ -140,6 +206,28 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, =
u32 addr, u16 len,
>  	return ret;
>  }
> =20
> +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +			 u8 *in, const u8 *out)
> +{
> +	struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> +	struct spi_controller *ctlr =3D phy->spi_device->controller;
> +
> +	/*
> +	 * TPM flow control over SPI requires full duplex support.
> +	 * Send entire message to a half duplex controller to handle
> +	 * wait polling in controller.
> +	 * Set TPM HW flow control flag..
> +	 */
> +	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> +		phy->spi_device->mode |=3D SPI_TPM_HW_FLOW;

Can this be pushed up to tpm_tis_spi_probe()? The SPI controller flags
are fixed, so this isn't going to change at runtime, is it?

Thierry

--irPaUU4QFHK5esZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP/VSkACgkQ3SOs138+
s6EAvA//fdYOQ31cnHUmBUSq8bSgsADnXCaPRRIfUxQ9WwiLD/pwqi72FoLb8D8E
aaWr8mCE4zFlml1eMWFp9oEywyqAWGeSaXNQu02jZGg3oX79SCKzD26Y+0XfcTr0
1bix4kIpQ15X2REtvH5NwGNbdZm2fvFO5gJlx9LIjIhOgkOTGoIQT8BHS72Yvzx8
Ek+qwCvjiZb6Grv44hvrjVNox4i5Q1NGWUAuUchJiMtBJyAgvNGm+KvVraJYaPoX
WJA3UXT6h70l0uH3vp021LwmOuftwdwh6XRtgijBttSgSbewHbLf/r3qmX4tpOqs
MI6QmSi737ZK4JtA/6tjc+NX1rN5Ij3SYGBVQFuvjy84Q6TnOFY9FUw0pL98iyGk
Fr3Nj11BugNa4Yxo5+CK0+LEAAeJ/SY6Vc9T7yScnTMRmsJQZ4hoWtiK064N6SLp
/KZVwPzvz4ojmQkJ6XCvtmrlHsFPgS6hKgpDJKITPTks4ckjOVpq9bjKST6ewiso
GmYNyvQAKiNKr2gWKSUyg1n9bmq/cUzsGvbbpAxTz+aP+I94qY3yG915swfPkfkU
z8Z7RYDj09ynD9+3Tl9kM5IGijXHh2cmkAq3KqNQF+jtvjcf4i21djTnB0FMCdJM
gkMjTa22l25OZ776Hd1CHOKQ9BAXiuoD+6VXdn6dmL7a4dtwbIo=
=232t
-----END PGP SIGNATURE-----

--irPaUU4QFHK5esZZ--
