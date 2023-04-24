Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E196ED085
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjDXOq4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 10:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjDXOqn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 10:46:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DAE7DB4;
        Mon, 24 Apr 2023 07:46:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so8069955a12.2;
        Mon, 24 Apr 2023 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682347587; x=1684939587;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCQLHZ8uZl5RhoE45wRxXGl0sq5oZ8VUfOTDUiq565Q=;
        b=J3cse2Ha23Crwf+tPG1vxBhKr8IYToqYJZcJSkK05/rCUmZ8MbZzgXjSaGKRdAT/bh
         DkLOeqsC6PjshEM5XNVTWr2G1TOFa7oeplu+Xr3eowxsv9GcL8Im8OTqlp/FKFblluR3
         Tgl/pwl/zMo7oulExkk1ignONx0eP8+ZxNcG6Ef3Cf2rxN3CHB8WxUEavtUYyKPl8ZAl
         ugBkORBuNLAS7t7ubKTqqvf4Z3GUeTdAHTCrdhhXSrPI/gQ0nZSq4SX+cioQE9HQQZ32
         lgA0zt3XnApHXUvZBQyj2ZkV9HrlJFvjJHLC1sfQdccDCTSe4maryf/U3FzUhbdC0yp1
         nw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347587; x=1684939587;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCQLHZ8uZl5RhoE45wRxXGl0sq5oZ8VUfOTDUiq565Q=;
        b=Nq/yd+CkY9ZFRFRGrXOj9SmlPiPNY9qPGk41lY/8S4rvXg6BMQ6xziy4s6T3XD7Hu7
         XzPh68H6meQJ9M8ADCIWxKJhapxcA0si3TUd/tXr65GDLD6qBOUz6iuZtoIEUWX5LZYK
         h+dBLAXlhB/3AmYl3CRKkN+p3fb1cu7uTBFNC8FE2cQvKiIwbqN/vDZffl+xiKufgOi3
         ATulzOjaaSTMhGGDXDpla4CyMRzzVYpFvOZejK/4c1yvPFO2cB9lryo6/BWtHfGl6bok
         UvF/pZ7Yt95nW3+5c2cyr5f6ueTZYu8S+tKvtWCMENtyMhYIAF53W9mcxMRuBszHu/OK
         kzMg==
X-Gm-Message-State: AAQBX9fZppfuxJjOYg6hb/wGjVJYy3o942TAOWPw8W/kHDSSUicJ07lR
        /GxrFp9b3xUCfntFOFBn99U=
X-Google-Smtp-Source: AKy350bfq3wl+sejieaLJsTfB8wIK2a+bpIxVfb0kmH61yEYFDtS2hKxYnxAiDBTqj+lQLtH8oD7QA==
X-Received: by 2002:a05:6402:3d1:b0:506:be3f:ebb1 with SMTP id t17-20020a05640203d100b00506be3febb1mr11496356edw.26.1682347586947;
        Mon, 24 Apr 2023 07:46:26 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f20-20020a056402069400b00504ecfea8b2sm4779836edy.85.2023.04.24.07.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:46:26 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:46:24 +0200
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
Message-ID: <ZEaWQD_QTs2usVl8@orome>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="57FmpnLZgcFuqbAA"
Content-Disposition: inline
In-Reply-To: <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
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


--57FmpnLZgcFuqbAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 12:56:25PM +0100, Mark Brown wrote:
> On Sun, Apr 23, 2023 at 06:08:16PM +0300, Jarkko Sakkinen wrote:
>=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> > Should I pick these patches?
>=20
> I've queued the spi side already.

Mark,

Would it make sense for you to pick up patch 2/3 as well? As far as I
can tell there's a build dependency on patch 1/3 because of the newly
added SPI_TPM_HW_FLOW symbol.

Thierry

--57FmpnLZgcFuqbAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRGlkAACgkQ3SOs138+
s6Hg+Q/7B8MmnWqq687vs4joQwJ6x9+OVi+ErMSAxVv+TJpPLQKCcxGPQ7QVe5kt
Pix6tMfC2cu30a1t7lHRrBLltO8cTZSGRA9wkht+UqIBGtH6ULSI7wzqVdWvT+de
OsRWLLRSVY8IdWmoUVs3rLZ1vpZ2mwPWdQ8rkB5LiqnLSS4qfdDtt+fYduwjkNqz
pGJj3qpDfmEBJxLpo8s9qsyl5uK8ngvQzcuPyi7N6DejZ5v4ZAhTrzg1RIoCT15m
MGf1NyMOovaTdY7qEAgURdVgGJPL9FG86MuaKL7Mx90JvianPshZThKzm6+qXWLU
o1DrTRAwC1kkuGolxp+St+TEY7ughRxucrR13LalAp4nLZcWgbsxKyH+90YRGOUf
vxkesoxaJJvr/OgJRyRpPwuyVGBItriYqyk8299CWvt/DXDYlKkmpQh8rDNlBnPL
/DPsQe0B3qyAScqTibimKsF6PpfXVBBTaSgSzhLDrGPNKVm0a4bGtlzINHeAyPaP
FV527OCn+v1NXBOXes8iGkcp8GVuWlpEqS3Kb7E3O/JPUWg2PoJ5aWUV+IXgS3tt
FKOahRvnm1GfvcW1b3vS8hVadFS+UPrtoR42FfT7a/qpNrVj+RTsgg0l2C0903V5
PHbihTvR9OgNw6a0dbX7SpVeDNIqG3yq8kIj/rLdPXHQ5isSJ8o=
=TBED
-----END PGP SIGNATURE-----

--57FmpnLZgcFuqbAA--
