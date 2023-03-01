Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425876A6D12
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 14:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCANeW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 08:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCANeV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 08:34:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2423840;
        Wed,  1 Mar 2023 05:34:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so53897787edb.3;
        Wed, 01 Mar 2023 05:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677677653;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7iN7Wsd8fSC+Wjlu891vl1hb2hoVyWo0R4dgiebbOQ=;
        b=K3BHO+GnvQzMRfxDYXi/Eeme0n+qr0UIIGF8CY48MZ9YJxZEQWJ/++71lhiPSFKTnN
         YX9B4VVQx+l4997lkb8DyKhC+f3PkXwFhV/oKeP0KA7IuoL9lAPkDNk3pkIFlhXT+IpY
         vZ72K0WOXuc3ACehxRZrLzv3DDzjDbDoTunwDiaAErxx0J16z2iZHYxpiJkG8amU9UvQ
         ImvKmMTEu30+VaTBOsU2DkrGPGFn6U9Z5RY1tpdCIoSkrKlv4GVndBoA/y/MMmrZjCzk
         kCohAdyZWrDDOqfLEyMVsorzTPdkc/fuY+hxy0ZiccnJPXLNkhzt4D/MKsknLCMy2S9S
         6zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677677653;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7iN7Wsd8fSC+Wjlu891vl1hb2hoVyWo0R4dgiebbOQ=;
        b=WBRaub0JvdRsafY5oIqjHrM24GZYaw8BWpS8wpF+52ygSve8Seg0QxlgupleLJbBMW
         eJhJiLaBNHFqIWIk//YXVOZ+0Qp7mWyUYOfeB+sfJo1w4HhgObhmXKLJQXcFFkT6qnAy
         Lhv9WyVtrwLIhUHTSJcpAzt3umT4CT9YlQGv2KrLvU3UUBdm3crwB989TE+ebNRLXQ8v
         WkIcJG1I2l54JqabHDSSVXly+VnJVrK6ElFVASWzfRImh5hDx4h7QtaT9Ac8U76yFtXk
         wx3Dwu9mi2WNt9OJqCMGPPX6OAdxQwftBCfmkxPWWN+exHVn+/TD/eDZHTUQJ+N0LF9/
         mKYg==
X-Gm-Message-State: AO0yUKVIaH/cT/vzFD55+GCGAJldHaQP2/jJcVZnXPz/4mVdjqxub2z3
        RbetS++lPtHJt7q9SrO4VPQ=
X-Google-Smtp-Source: AK7set+9dAHeexh7+d0N6+p7qHcs6ks+YxVyjpIhQEBnpYkCw1HRU0xFHAbN5jlrk8PolfC1pLov6A==
X-Received: by 2002:a17:906:5e12:b0:8b2:8857:5963 with SMTP id n18-20020a1709065e1200b008b288575963mr6448515eju.8.1677677653422;
        Wed, 01 Mar 2023 05:34:13 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g19-20020a1709061c9300b008cf8c6f5c43sm5668412ejh.83.2023.03.01.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 05:34:12 -0800 (PST)
Date:   Wed, 1 Mar 2023 14:34:11 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V6 1/3] spi: Add TPM HW flow flag
Message-ID: <Y/9UU8UA5R9eJFuZ@orome>
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
 <20230227172108.8206-2-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fOvuqwjzPmirnJCq"
Content-Disposition: inline
In-Reply-To: <20230227172108.8206-2-kyarlagadda@nvidia.com>
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


--fOvuqwjzPmirnJCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 10:51:06PM +0530, Krishna Yarlagadda wrote:
> TPM spec defines flow control over SPI. Client device can insert a wait

Maybe add a reference to where in the TPM specification this can be
found? It looks like the specifications are publicly available, though
I'm less sure about stability of the links, so perhaps it's enough to
name the document and section that this can be found in. QEMU seems to
be using this link to point to the specification, which I suppose has a
good chance of remaining stable:

	https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-=
specific-tpm-interface-specification-tis/

It looks like the latest version is 1.3 revision 27 and the details of
this flow control mechanism are in section "6.4.5. Flow Control".

> state on MISO when address is trasmitted by controller on MOSI. It can

"transmitted"

> work only on full duplex.
> Half duplex controllers need to implement flow control in HW.

This is a bit confusing because you first say it will only work for full
duplex controllers and then you say it's also possible for half-duplex
controllers.

Maybe reword this to something like:

	Detecting the wait state in software is only possible for full
	duplex controllers. For controllers that support only half-
	duplex, the wait state detection needs to be implemented in
	hardware.

> Add a flag for TPM to indicate flow control is expected in controller.

That's not exactly what the flag indicates, though, is it? It primarily
indicates that the device uses TPM flow control. It's then up to the
controller to configure itself accordingly (i.e. if it supports half-
duplex, enable detection of the wait state, otherwise leave it up to the
client driver to detect the wait state).

>=20
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  include/linux/spi/spi.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 4fa26b9a3572..6b32c90e9e20 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -184,8 +184,9 @@ struct spi_device {
>  	u8			chip_select;
>  	u8			bits_per_word;
>  	bool			rt;
> -#define SPI_NO_TX	BIT(31)		/* No transmit wire */
> -#define SPI_NO_RX	BIT(30)		/* No receive wire */
> +#define SPI_NO_TX		BIT(31)		/* No transmit wire */
> +#define SPI_NO_RX		BIT(30)		/* No receive wire */
> +#define SPI_TPM_HW_FLOW		BIT(29)		/* TPM flow control */

Maybe some (or all?) of the information in the commit message should be
duplicated here? That way people wouldn't need to go look for the commit
message in order to find out.

Given what I said above about the flag, it may be better to name this
SPI_TPM_FLOW_CONTROL, but I suppose what you have here is fine, too.

Thierry

--fOvuqwjzPmirnJCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP/VFAACgkQ3SOs138+
s6GcHRAAgAdVqqF9rjgriXHZPJTGUpsvbYJgETvJR7ksAo2iuREoiuSUx8Dr6hB/
nIHNW1Td/awiwK1aNtUyKLaWL9lITbYPhKvKRQVOrqWrbAqyT3w5CLZ+dfvcGoLE
e9hFG/U9Q2CqnKbWbdzyJMj2m1VpADrd6F9qwSS2zBLA9xh2LleICa4M3HB94nIG
ZxKw56WFnjUkphwniJMQvKNMZEagMRpMukQh7pLn/9KXIN+6aEmgv1YcLQjbIwQN
PYMdN49eFget7hBw1qYHSqSK7LN+51S4hAcL5AQAhW4ar9y0XbIwToOKh0xTdAGv
QQPTRjXosWBx6DmzDn6u0Dw18Kl2UOJWRqs4fAS1KKDKleBOUTBz2NQhd7V0+a/P
2sJhI9BKRLHmxn9oRb9NYd1fnCyJm6VvtqOm67jcD42gQJ3cT7m7SlIp7NlsiFIP
chmJh6TLRP04aLcIDx+UoVO/2ylCK/34eDTGZOhBL9TFZjMnpLvW6fR5w2gSF+It
3pt/m9B78ByAHohLa3tmdKIL0+PIlMSfPACYVaTBJIWUScDLfVdN10SH6Gc9oCIH
+Rbll//Vn6Rw0vdKW/6Jr+8QzWGE98yi3UGoG6ROU3t44aDt4kD82ezCfHhlazWA
w7PBgYEDWj+p88PoHkwqXOo6b+3LbJddLlRCOP/FqfSFpaZkRvk=
=9E1l
-----END PGP SIGNATURE-----

--fOvuqwjzPmirnJCq--
