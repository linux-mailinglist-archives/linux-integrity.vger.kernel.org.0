Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5925719C44
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jun 2023 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjFAMg5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Jun 2023 08:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAMg4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Jun 2023 08:36:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA6F119;
        Thu,  1 Jun 2023 05:36:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f53c06babso99794066b.3;
        Thu, 01 Jun 2023 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685623014; x=1688215014;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehHBfTfHpFq9gN1tp3vpZxZbCv0h8WUkNnRmVixaHus=;
        b=IYocw7LtLTtELs1lzYQjnzI+3n69AYNQEshwVrvy9Prnghlr8U/plLV/F9I8cU//9g
         Y3dhjiVb6PBaZjbXqngC3Iq07GkjEovEjrbqXve8vXuVnvRpzi3nfU3eqorEJeLYuI5/
         S8nu1SzkkK7bD0PfKSgLnu2Rj7cS78wliniOUPnKU2bSsTvIxRgEaxLz24RMLkAypLPk
         cCaJ64KPOLBtiW8BRSClQfZp3uoocrnUe/2PP3YDbWtdGHnfPc0ZzO5QbLqC4zeG3NDC
         WkYTJXj1hSykRJF+vWZAvI064AtIcXHMkaOCEeB9ft3RcGitzHxbPZAlHyMhy+czzszR
         55Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685623014; x=1688215014;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehHBfTfHpFq9gN1tp3vpZxZbCv0h8WUkNnRmVixaHus=;
        b=JTS3TS+86XlJOICKADT0OVs/Ca5p7HOuwG8dJHGYZiVXHPOlsfOM24agEcVSSIv30I
         TDRWXCSJ8s5CTG2VPdvasjqcrHhQu4yj3oVeB/KELmEEgKvvizQg22pREGkqpbISh0j1
         /rTK58Ut03QnSzIXwuu7oYoBBluCzxNsXjD5kOJWBBzdq7D+xjhXOVl4lJR4yl/Pnlra
         JnKq21IRPHAu7ggXHYZCyTbDsmwPbB6ejbhmpyAOYzoHipJ/gcRz1hrpRVdmWHLSOxpV
         xlm6JrGpnH1R0RlKWMaXNA055lxtBkvx/gk8sbAViT4BH4WWaPlqqdEVHT1uUz3qONch
         7HMg==
X-Gm-Message-State: AC+VfDzKA9xV66ygHHgR1cemQvG1dKkIgr2TbV5mDSgW9OsFJDsSv7Le
        TIkZB3fZjCLYBepCRDV8fYM=
X-Google-Smtp-Source: ACHHUZ73F5LLoOz2NNjkClTA4o4LIKaH39YUgnRg7PnrldgoFgqlQNVX1P6hwTrbD41XmMFEXq0S9w==
X-Received: by 2002:a17:907:25c2:b0:973:8cb7:4d81 with SMTP id ae2-20020a17090725c200b009738cb74d81mr9144506ejc.49.1685623013899;
        Thu, 01 Jun 2023 05:36:53 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id se24-20020a170906ce5800b009662b4230cesm10664574ejb.148.2023.06.01.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 05:36:53 -0700 (PDT)
Date:   Thu, 1 Jun 2023 14:36:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <ZHiQ44gAL3YEZPUh@orome>
References: <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
 <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
 <ZEag1lAonYcmNFXk@orome>
 <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com>
 <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com>
 <ZHhW_wFvRWInR_iM@orome>
 <dec901be-4bef-43e0-a125-23c5c4e92789@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BiFkO/AwryVjPFkW"
Content-Disposition: inline
In-Reply-To: <dec901be-4bef-43e0-a125-23c5c4e92789@sirena.org.uk>
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


--BiFkO/AwryVjPFkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 12:04:59PM +0100, Mark Brown wrote:
> On Thu, Jun 01, 2023 at 10:29:51AM +0200, Thierry Reding wrote:
>=20
> > any ideas on how we can best get this merged? I guess at this point it
> > could go through either tree since the SPI dependency has been in Linus'
> > tree since v6.4-rc1.
>=20
> I would expect it to go via whatever path TPM patches usually take given
> that it's a TPM patch.

There might have been a misunderstanding. My recollection was that you
had said a few weeks ago that you would pick this up. Going through the
thread again I realize that may not have been what you meant. Perhaps
Jarkko misinterpreted this in the same way.

Jarkko, can you pick this up for v6.5?

Thierry

--BiFkO/AwryVjPFkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmR4kOMACgkQ3SOs138+
s6GCWA//dGR7DSaUdohkzVJ5x9tBnEEhCZH9ZliQHAL6CV9h8/rs7jHZTlpmlgaa
HUz4RPp/EMwziWPzhD6BHw8VTRqyhQhOiIRFqU9CA3x0VhClnIaH3gt6zqHSSCiC
ie4Sn8IMKWq7ZERuwizxBiYS80x8VjWJq+DGcFP2V+DbraPL1GdsfEWbbRuwOtj2
bqw0Uvo7wd1NCtcV/oYfv2vV7ebdsPnQ7cHmyAslmcYRzcZce0C/mYYRzr/BahkX
nNwovE0ADj9jIma4qMgDfeVFq0IODhCSqOI+dThv7hfnL2vuV1zrbeWJ5N6jVq1j
mV84Yq0TQDPeGgb7xXjYi22m2KF7FZAWdI/d3Ep+WOTR4r76aVYFSOO0mBaNn1f7
BE3ZDBsRj06GHJifR8eW+Vrev0MIj5+1wvalhUiVQ8VmZt6hPirLjH8hzcUposOw
c5as4w6IaoOeUQVl/iz0ScQg0BySTd2whg2Rk1tyYZEz+hY2ndmxF6yhz/lFK8ob
8PtXQ+Sz/NFdPBRl/bpBzVMItOG8nT1DHsntVQZLxqt3W2B/oglUc7Fa+hZB0kN+
LlzKZmFgYHX2jUeCYDEnmHnlyio3XqsHmkLqeeI4IJKBFTCazNXbiTJWWWSFXEkc
qIJFEMOrUjFARVKsFbgNMD7wQ4zAYEOftP3GLpYi09SWbCCoVVI=
=E3jj
-----END PGP SIGNATURE-----

--BiFkO/AwryVjPFkW--
