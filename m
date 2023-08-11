Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1377964E
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 19:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjHKRkr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjHKRkq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 13:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621330DA;
        Fri, 11 Aug 2023 10:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F76463635;
        Fri, 11 Aug 2023 17:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D12C433C8;
        Fri, 11 Aug 2023 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691775644;
        bh=SyvT61gNUkdCiBQLvgXxp1aIUNGjBDnwRuKDt7gM65M=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ps9WQJupMoO4p75uC3K7b2Ba9ApiXB5JDF3miHELfVQAk35GEW9OO2tMtSNqyQpgC
         Pa4iwTbm4NKf539+MCmairMH35tXF8MSPEvvnHfdVWCe5AsrtvvbCT9AVbqfRwldWt
         VUO5/o85hk5TURItBoYYCvCToPUDJf9fXuC3bCTpp4hZ7+lGdKrDavVfqJ9K85a1sd
         +wQiYuTe2daQKpLsKrwNXzVglCaoPc3Mwq5eBVw/OBr5zswtSH2tTnLsv/dlqJSKxD
         qinnpknRnjxq57Sy27VObSc6GV23I14Jwob+jUCOIVt1DJBFiS9SxFmiIYg1AJsltY
         XOcSUCi12X5VQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 20:40:38 +0300
Message-Id: <CUPWEV9HSGHY.MLO0B4RRH4RR@suppilovahvero>
Cc:     "Linux kernel regressions list" <regressions@lists.linux.dev>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Christian Hesse" <mail@eworm.de>, <stable@vger.kernel.org>,
        <roubro1991@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Linux kernel regressions list" <regressions@lists.linux.dev>,
        "Grundik" <ggrundik@gmail.com>, "Christian Hesse" <list@eworm.de>,
        <linux-integrity@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
 <20230710231315.4ef54679@leda.eworm.net>
 <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
 <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
 <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
 <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
 <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info>
 <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
In-Reply-To: <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Aug 11, 2023 at 8:22 PM EEST, Jarkko Sakkinen wrote:
> On Fri Aug 11, 2023 at 11:18 AM EEST, Thorsten Leemhuis wrote:
> > On 06.08.23 18:30, Grundik wrote:
> > > On Wed, 2023-07-12 at 00:50 +0300, Jarkko Sakkinen wrote:
> > >>> I want to say: this issue is NOT limited to Framework laptops.
> > >>>
> > >>> For example this MSI gen12 i5-1240P laptop also suffers from same
> > >>> problem:
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Manufacturer: Micro-Star=
 International Co., Ltd.
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Product Name: Summit E13=
FlipEvo A12MT
> > > [...]
> > >>
> > >> It will be supplemented with
> > >> https://lore.kernel.org/linux-integrity/CTYXI8TL7C36.2SCWH82FAZWBO@s=
uppilovahvero/T/#me895f1920ca6983f791b58a6fa0c157161a33849
> > >>
> > >> Together they should fairly sustainable framework.
> > >=20
> > > Unfortunately, they dont. Problem still occurs in debian 6.5-rc4
> > > kernel, with forementioned laptop. According to sources, these patche=
s
> > > are applied in that kernel version.
> >
> > Jarkko & Lino, did you see this msg Grundik posted that about a week
> > ago? It looks like there is still something wrong there that need
> > attention. Or am I missing something?
> >
> > FWIW, two more users reported that they still see similar problems with
> > recent 6.4.y kernels that contain the "tpm,tpm_tis: Disable interrupts
> > after 1000 unhandled IRQs" patch. Both also with MSI laptops:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217631#c18
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217631#c20
> >
> > No reply either afaics.
> >
> > Ciao, Thorsten
>
> I was planning to send a PR to Linus with a quirk for MSI GS66 Stealth
> 11UG, and apparently this bug report would add two additional MSI
> entries. This is becoming quickly a maintenance hell.
>
> For Lenovo, I also added patch that will categorically disable irqs for
> all with vendor "LENOVO" because there was already six entries, and I
> got patch for 7th.
>
> Now we at least know that IRQs TPMs are somewhat broken so it is time to
> make decisions to make this converge to something.
>
> I see two long-standing options:
>
> A. Move from deny list to allow list when considering using IRQs. This
>    can be supplemented with a kernel command-line parameter to enforce
>    IRQs and ignore the allow list (and IRQ storm detection provides
>    additional measure in case you try to enforce)
> B. Change deny list to match only vendors for the time being. This can
>    be supplemented with a allow list that is processed after the deny
>    list for models where IRQs are known to work.
>
> This would the implementation of (B):
>
> static const struct dmi_system_id tpm_tis_dmi_table[] =3D {
> 	{
> 		.callback =3D tpm_tis_disable_irq,
> 		.matches =3D {
> 			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
> 		},
> 	},
> 	{
> 		.callback =3D tpm_tis_disable_irq,
> 		.ident =3D "MSI GS66 Stealth 11UG",
> 		.matches =3D {
> 			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
> 		},
> 	},
> 	{
> 		.callback =3D tpm_tis_disable_irq,
> 		.matches =3D {
> 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> 		},
> 	},
> 	{
> 		.callback =3D tpm_tis_disable_irq,
> 		.matches =3D {
> 			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> 		},
> 	},
> 	{
> 		.callback =3D tpm_tis_disable_irq,
> 		.matches =3D {
> 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> 		},
> 	},
> 	{}
> };
>
> BR, Jarkko

I.e. this is a non-sustainable solution:

	if (vendor && product) {
		dev_info(&chip->dev,
			"Consider adding the following entry to tpm_tis_dmi_table:\n");
		dev_info(&chip->dev, "\tDMI_SYS_VENDOR: %s\n", vendor);
		dev_info(&chip->dev, "\tDMI_PRODUCT_VERSION: %s\n", product);
	}

This is also super time consuming and takes the focus away from more
important matters (like most likely the AMD rng fix would have gone
smoother without these getting in the way all the time).

BR, Jarkko
