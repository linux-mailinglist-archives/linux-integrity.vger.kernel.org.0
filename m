Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB04B6A6D29
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 14:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCANjg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 08:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCANje (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 08:39:34 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE53330DF;
        Wed,  1 Mar 2023 05:39:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cw28so4768170edb.5;
        Wed, 01 Mar 2023 05:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677677972;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlqXxPhHUGf+ZMStbk2u65C8VeGJJmG1x4p4aNMo314=;
        b=EFGYbXGRzMcDGa2uoJVTno+ZYO6aNFraJOGz3YaQ3BF35UVa0uAPwmJNEBXVxVOQ5I
         JDzqzZRx9miLp+/LL3WdtdxYSWE2BeZIT8nSxOoQPOr3q/2V3PpiFZUD0TKRmhcZWIfo
         5M7lRit9kaDI2LsrxnulibdYe23fFbPbnu2rpEGDlmRF5AVxxZYiwznxXjdRaB0VwFpJ
         DglxAwdFqIU5w1W3LVMcwpW4Ts948msKlsvMpkZhSj09V5EylR18Ye9afgXt8xjT5Ht6
         8ZpcEsLtivsLATxpRhDWmiATL6yzN20/qdfV/BwuOXBIKovXp6BKCJXMfTFy4TEfdEvR
         56og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677677972;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlqXxPhHUGf+ZMStbk2u65C8VeGJJmG1x4p4aNMo314=;
        b=ontdEsHKklsvo1HXf+SJYAnlo5L0Kgg7C0qc3PJfkhZ+1Ssu1gDe1DVrMOJWPqALKZ
         CPxY/dlgtft2d01hr6giFKVeWeHEsIhGFj9Sp2MhOl2zizJ3/siNJ1uUnm/gQyFTzY6w
         vlThUzd+AWsux+cbEX7gkWzaVzBtLuijoRMimGpqK950T7tw3YdaRcNunZR/4lUXmGxJ
         Qk4wj0irgWXz2AsqhjO7nns/UZEo7IY4Pbc5vLED5WOGpRcZEhG+m1CrA4t4wra2dcxK
         3ESHerW/SNd4MrXeYTyCb4qaoS+wZPYwG0h8v49yJJB3V6l//Y66HnFRNIJiXHFmfGGZ
         aD/w==
X-Gm-Message-State: AO0yUKWX4C0uDNCGw9uebQp1ROyskUuxdBWxSHz8TTS3NMvmicG7zYQU
        IN1XwWj9KSuB/wNKhU7f08E=
X-Google-Smtp-Source: AK7set+Jusjn82oiZYWpg97yY9K8MmneoqJmwZKq5CQgd1wC8xEu0EBkkk8Rewu/CjtyEJAnl6P4jQ==
X-Received: by 2002:a17:907:2d1f:b0:88f:8a5:b4cd with SMTP id gs31-20020a1709072d1f00b0088f08a5b4cdmr7956882ejc.1.1677677972412;
        Wed, 01 Mar 2023 05:39:32 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c89-20020a509fe2000000b004aeeb476c5bsm5563086edf.24.2023.03.01.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 05:39:31 -0800 (PST)
Date:   Wed, 1 Mar 2023 14:39:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V6 3/3] spi: tegra210-quad: Enable TPM wait polling
Message-ID: <Y/9Vkk1ioFWq+XLm@orome>
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
 <20230227172108.8206-4-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7CYPnN6GGv8TW0P1"
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


--7CYPnN6GGv8TW0P1
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

Acked-by: Thierry Reding <treding@nvidia.com>

--7CYPnN6GGv8TW0P1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP/VZIACgkQ3SOs138+
s6Hi8hAAjC6P2k1n6s/uy9sFmSyNUN/z/M+jWR/gtGEeEB2CmOGxgUPfx4MJVOQb
OVq8lRF2Qi/5e5dihv7AxwjJMzZamGlvrmhCUtx1YeFwlIkwFbCKCfyI2y/JB15X
v8qHzE48qmJfYlhpXlTKaYvsUs4X/oEIU9edj+tLM6u4+OtcXr+ncVCqXN64oZHy
izDYTEBoa7tTSSeDzgsRg/x7+gpcfmMdGV6TtUlVItGwaLrdaSR/r2fs3LLAcO/e
yA5VPepoYSBKMYm+vz5p40zVBT/BmlAWX8D7J8Lys9lOvTSyMJtmIPDaiseHMF9V
ZOCKRWp904yKW5zDMWW7025S7AjM2CmATw25kLTSBcHxh4Y9DrRIKbyh+ucQwm6h
t3SBITPhg/xefb2VURunt9MvcnyakbvBPR0XCLGQ7tsdGU+UWIsMF/Mg4sB7T7p7
8yyFf0Zn9nGt8pTislbgubs8k/XXCrqGBh2/CaJ/6t0pCmzAdJlaQnrhpTWQhSwo
UUXwFMR94nUS0/NbYYvkf034E9GytHZI3uqT2ooUJQwxjtrAunPIr8chFlKCiGId
0N7imv9UE3KW5vlr0mHd+jw2Hc4hwdraQKu/rIKx3eWqmd5/N41W76oAoM4f3Hf3
ox26xXqnNZkH+ZXpPloE7+spd7P2gMgzy8MINpArstbZwa75iS4=
=Pxsk
-----END PGP SIGNATURE-----

--7CYPnN6GGv8TW0P1--
