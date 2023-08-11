Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81143779608
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjHKRWe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjHKRWe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 13:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5630CA;
        Fri, 11 Aug 2023 10:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13C4566CD5;
        Fri, 11 Aug 2023 17:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AA4C433C8;
        Fri, 11 Aug 2023 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691774552;
        bh=b0WAIA08t9rUAhUXRnN8z0dJFoPL6HgjNzKqMFPLAYU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=tr2F8IoMvG293irAohgUcAgQkNfYM5yx3WRsGdgPcF3RQTNeKDtkTBiy5EpU0vV05
         sVi4Bh1kGtYqMITpYv80eKH78Ulmgh/+y/b5G5EFbPigLsPzXpzuwUYUD65iIeAYwV
         wYrEw5lvSdSju8z+zKcNGIk9YzPX3+ZlMv1/nIoIU2XQxNOX4Tf7HhKqHN14T2hFWu
         4x5jSuIwxNAmqb6nF69bER5jnlUX4fBVseXHSCzl36KEn6A0JwZ9E4FWT1G4JPJSIR
         kHeNwOPrVufLA33f2IhXq6qvjY7cwYcwBjvYDsN9BtEwgdNTppCb6nnAfXkEP9TG1Q
         8hnymmzB3i7+Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 20:22:27 +0300
Message-Id: <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
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
To:     "Thorsten Leemhuis" <regressions@leemhuis.info>,
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
In-Reply-To: <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Aug 11, 2023 at 11:18 AM EEST, Thorsten Leemhuis wrote:
> On 06.08.23 18:30, Grundik wrote:
> > On Wed, 2023-07-12 at 00:50 +0300, Jarkko Sakkinen wrote:
> >>> I want to say: this issue is NOT limited to Framework laptops.
> >>>
> >>> For example this MSI gen12 i5-1240P laptop also suffers from same
> >>> problem:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Manufacturer: Micro-Star I=
nternational Co., Ltd.
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Product Name: Summit E13Fl=
ipEvo A12MT
> > [...]
> >>
> >> It will be supplemented with
> >> https://lore.kernel.org/linux-integrity/CTYXI8TL7C36.2SCWH82FAZWBO@sup=
pilovahvero/T/#me895f1920ca6983f791b58a6fa0c157161a33849
> >>
> >> Together they should fairly sustainable framework.
> >=20
> > Unfortunately, they dont. Problem still occurs in debian 6.5-rc4
> > kernel, with forementioned laptop. According to sources, these patches
> > are applied in that kernel version.
>
> Jarkko & Lino, did you see this msg Grundik posted that about a week
> ago? It looks like there is still something wrong there that need
> attention. Or am I missing something?
>
> FWIW, two more users reported that they still see similar problems with
> recent 6.4.y kernels that contain the "tpm,tpm_tis: Disable interrupts
> after 1000 unhandled IRQs" patch. Both also with MSI laptops:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217631#c18
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217631#c20
>
> No reply either afaics.
>
> Ciao, Thorsten

I was planning to send a PR to Linus with a quirk for MSI GS66 Stealth
11UG, and apparently this bug report would add two additional MSI
entries. This is becoming quickly a maintenance hell.

For Lenovo, I also added patch that will categorically disable irqs for
all with vendor "LENOVO" because there was already six entries, and I
got patch for 7th.

Now we at least know that IRQs TPMs are somewhat broken so it is time to
make decisions to make this converge to something.

I see two long-standing options:

A. Move from deny list to allow list when considering using IRQs. This
   can be supplemented with a kernel command-line parameter to enforce
   IRQs and ignore the allow list (and IRQ storm detection provides
   additional measure in case you try to enforce)
B. Change deny list to match only vendors for the time being. This can
   be supplemented with a allow list that is processed after the deny
   list for models where IRQs are known to work.

This would the implementation of (B):

static const struct dmi_system_id tpm_tis_dmi_table[] =3D {
	{
		.callback =3D tpm_tis_disable_irq,
		.matches =3D {
			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
		},
	},
	{
		.callback =3D tpm_tis_disable_irq,
		.ident =3D "MSI GS66 Stealth 11UG",
		.matches =3D {
			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
		},
	},
	{
		.callback =3D tpm_tis_disable_irq,
		.matches =3D {
			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
		},
	},
	{
		.callback =3D tpm_tis_disable_irq,
		.matches =3D {
			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
		},
	},
	{
		.callback =3D tpm_tis_disable_irq,
		.matches =3D {
			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
		},
	},
	{}
};

BR, Jarkko
