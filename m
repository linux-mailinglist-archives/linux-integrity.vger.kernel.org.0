Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94626ED161
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDXPbv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDXPbu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 11:31:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD47A9B;
        Mon, 24 Apr 2023 08:31:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so34333373a12.1;
        Mon, 24 Apr 2023 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682350297; x=1684942297;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y6VlpLoyeFDIUhuCEpLwrAfvADTwZBo+tgcsp58GCM=;
        b=YJwxUq/J9GCdLIL2jCK2dcru87AfR9ie2HyWphb4MArimcUfNEEzuurkCCtAns2I9x
         +cKbCX3bPNjM+o7eyaDZd4G0YZYZgqI9BgVVjjObwV9rkB/rGtCIk7Gw8GoKqGdMX46D
         kON81OiQ5KUYPhZZlYXFjPjd2z3CVQ0TD3kQjMG71oosSHBSJV4NbNy0PSoJj23rAdQY
         QGmeCH2L1hh9+Q/iNevD1hlPc1YthJWB7mbDizRYmlKkCRRbnQlHEE3roOaYdUstheuY
         XHa/hXyP6okeltFgieCKi1BhzeLcSpzu4kluT7oUFkO9HWXDKdRSkqbAkQy6mpAlq1pS
         TxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682350297; x=1684942297;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y6VlpLoyeFDIUhuCEpLwrAfvADTwZBo+tgcsp58GCM=;
        b=lr17HvzpZOYZ4FZnbU/Q+O8TOLJazNDNy5fYXz/rb/+6/SH1OS3ZKvtyF5cMA9D+el
         duRY3g5CVLuzaHO36mIbo1EipOqiNq8xrSV3CTM0bYGzYKMq2oAg2tlvsHJvgJQATlSd
         2USFAAMIcckTZjhSzUWuaEaOlWqSLibxxaL6cK4o7TGiJzFTowXt/zNuYoJiBDrD4uMk
         0UEeQsIfTAspcs6Un4jaKj2EghE4wFwzKmv2glzEus+tEs9DD6W64zjCrX2MLoSs0nUQ
         mU0sJs8E4hTmVl1Q+7r/pMlYgR84Bv8JPOJeGE4XwGMHsmNzdje0ffKBTgdZ2tiQIv/i
         un+w==
X-Gm-Message-State: AAQBX9eN6wxZiOfd8KyBhfUtFR9/Y+kP6MnNtvyUjsUFUOOgClf6Citx
        IRd3Lso3/tKGugm9saBs/G0=
X-Google-Smtp-Source: AKy350ZJ7YUu8TOixGb73t39jePcGdOuSu946lu2XRcNjnJzhh//CbEJQJbRFD756DxcHWAlOD+SFA==
X-Received: by 2002:aa7:cd11:0:b0:4ad:738b:6706 with SMTP id b17-20020aa7cd11000000b004ad738b6706mr13752469edw.2.1682350297188;
        Mon, 24 Apr 2023 08:31:37 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709062f0a00b0094f62181917sm5597129eji.138.2023.04.24.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:31:36 -0700 (PDT)
Date:   Mon, 24 Apr 2023 17:31:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        jsnitsel@redhat.com, robh+dt@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <ZEag1lAonYcmNFXk@orome>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
 <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HoxvrgZmmApzwDPp"
Content-Disposition: inline
In-Reply-To: <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--HoxvrgZmmApzwDPp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 04:18:45PM +0100, Mark Brown wrote:
> On Mon, Apr 24, 2023 at 04:46:24PM +0200, Thierry Reding wrote:
>=20
> > Would it make sense for you to pick up patch 2/3 as well? As far as I
> > can tell there's a build dependency on patch 1/3 because of the newly
> > added SPI_TPM_HW_FLOW symbol.
>=20
> I'll include it in my pull request for spi this time round so it should
> end up in -rc1, my thinking was that I was happy with the SPI bits and
> if it was in -rc1 then the TPM bits could be handled without cross tree
> issues when the review was sorted (which it is now but wasn't at the
> time).  If the SPI side doesn't make -rc1 for some reason I can pick up
> the TPM bit as well, and/or do a signed tag.

Sounds good.

Thanks,
Thierry

--HoxvrgZmmApzwDPp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRGoNYACgkQ3SOs138+
s6Hhng//fM8OK3GgVRYeyJIuvFsW9EXaRU/OWm+n4eMdT3wGXOGeJAk4AYdptYJo
z2dDOlNAlUsKjP6ZVHfLOAH8cdZH/gGSaWRot0hv85KWlDr5pJUKZ65rsBiIPkbd
EocantA23aFpg837JDnKj1btRUKPWAXTgbAigRuQRbIDB0ZreYCDikk/YZR5vqze
h4YyeccRq+Uj1OpGzNmQ8YGWHbgRIJs653OlbYmsHiLeyinLNz7bmg3wohSiwR/0
l1h8O/aL4ZQNbTiQ02mYApcL9N+5PEyIBXj2HC/G+VPFqcRlSzOtBAvRixdnCsVe
M+/XexW7FkpalITyto2lH9DVauGaKpNI6bfwY5wBcfPT7Li0RsWmDIQe4bKyWpBJ
U6mQaBI8+rMDCrv6dajKphd7Ml9uO+eefpIYBRcWHeqg6263HaiKXUMf75rtlWAo
MJ4zCQ/NmFaVTyNf+U+8MhLHAWbh1Cb8jNPEheY7gY9CKvJrC6c5EerH2fJ8q1bU
mwlDYHqYSXXAXN2MJDC1E21HHe2dA9Guq4i9wE7bSDRw0byP0L7vz3/0nzP6hXn/
JcIMhda+b8GcYFhzEpgaJWSqC5UJdV19qjluntRLw/9kf5DW5ZO+ErdYsoAnWKs6
ZCezjFvPdDgGQ6Rhb2GFVUE01xtalPb6qYmHv34+oLMRTyWORCU=
=0QL7
-----END PGP SIGNATURE-----

--HoxvrgZmmApzwDPp--
