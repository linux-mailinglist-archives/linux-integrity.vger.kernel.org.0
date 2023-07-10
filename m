Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915C674DB11
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjGJQ31 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 12:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGJQ30 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 12:29:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192C11A;
        Mon, 10 Jul 2023 09:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BAB4610FB;
        Mon, 10 Jul 2023 16:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48292C433C8;
        Mon, 10 Jul 2023 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689006565;
        bh=gGS6Bp0zO0jZ5gm24xn8vWGiXBkCmkpxDeqSun0NkJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EfJEVfrHcX8E2SmXehQdcrKOzStoMKH9MWG/Yx/YmGVvKPXRaq6+6oPW4DHY6Evjw
         1ww3H9BhgXgCnzvcQSLVwf0Jb6X5OXi5Dxlwsyuz3Z7oQivbFu7QvDjN78hu2H+Ohc
         R2IfADOWQdyLzIid6elw9nGK6BjhNtNb4Zps6GZSzdT4QovZ5kRnYOlIGA2FqW6A9Q
         R/MKYSpg47GTdASK+Grw4IHQDhRXf1dgOZVYklTcB2gpGR5szH6l5xxIMOfz8wl/xT
         4sHwypDZZRFc1hITW5NvMkh94OCYa8JcQp1U/SCEQ8OurMsnxv5zw7H+PSPTRnPImc
         EC1Sl2ohKdl+A==
Message-ID: <48da39d3c5cc4be56965ff7515844a761217ffe7.camel@kernel.org>
Subject: Re: [PATCH 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Christian Hesse <mail@eworm.de>, linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Date:   Mon, 10 Jul 2023 19:29:21 +0300
In-Reply-To: <20230710133836.4367-1-mail@eworm.de>
References: <c0ee4b7c-9d63-0bb3-c677-2be045deda43@leemhuis.info>
         <20230710133836.4367-1-mail@eworm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-07-10 at 15:38 +0200, Christian Hesse wrote:
> This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> force polling.
>=20
> https://bugs.archlinux.org/user/38129
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217631
>=20
> Fixes: e644b2f498d297a928efcb7ff6f900c27f8b788e
> Cc: stable@vger.kernel.org
> Reported-by:  <roubro1991@gmail.com>
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7db3593941ea..2979f8b9aaa0 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -114,6 +114,14 @@ static int tpm_tis_disable_irq(const struct dmi_syst=
em_id *d)
>  }
> =20
>  static const struct dmi_system_id tpm_tis_dmi_table[] =3D {
> +	{
> +		.callback =3D tpm_tis_disable_irq,
> +		.ident =3D "Framework Laptop Intel 12th gen",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "A4"),
> +		},
> +	},
>  	{
>  		.callback =3D tpm_tis_disable_irq,
>  		.ident =3D "ThinkPad T490s",

Hi, no other issues except fixes tag should be in both:

Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")

I.e.

# $1 =3D commit ID
function git-fixes {
  git --no-pager log --format=3D'Fixes: %h ("%s")' --abbrev=3D12 -1 $1;
}

I'll update them, thank you.

BR, Jarkko
