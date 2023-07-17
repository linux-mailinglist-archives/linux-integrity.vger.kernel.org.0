Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1A756402
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jul 2023 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjGQNNm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jul 2023 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjGQNN3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jul 2023 09:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F28E48
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jul 2023 06:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 871B561068
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jul 2023 13:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614D2C433C7;
        Mon, 17 Jul 2023 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689599588;
        bh=wHT5mhaK6CWjF4DwCFuFnkiGRJm4FTAEmWgUV7x6zpw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Vngy0RuAO0Y/kBmwMFM/QfmEdBlbeQz6a3qBPH4SZLHidHsnZk4jb1sFJsizMYJ5R
         HgrNUDo6Stchn3jffSA7jXnCotZ9UbIa59tW41nj7p76MVKMN/kMUKBjB4v6oP5Cm9
         KcCZkAMjaueiknuI4/PXfpZi02Ojue0x8z6mjxDK575AD2zx0tHTbB+sHDUCGe+Css
         ZMBOXYiz5ibYgHdQB1K4LEV5OulhBXEeGkNBBvTY0I3yqCag3WTCADEykxiUzE7Bjy
         LkGEn4Pj9E93eFMkr7pl3SV+m73u1j/gYy1NQsrg4icE0ieNaDYLAhp1jO9ecYZJj/
         3OZkHMeallqXQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 13:13:04 +0000
Message-Id: <CU4H2DNNWI45.29POSW833WLKO@seitikki>
Cc:     <eajames@linux.ibm.com>, <jgg@ziepe.ca>,
        <yangyingliang@huawei.com>, <linux-integrity@vger.kernel.org>,
        <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 1/2] powerpc/tpm: Create linux,sml-base/size as big
 endian
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.14.0
References: <20230615123703.4028156-1-mpe@ellerman.id.au>
 <4d378d53225fc8b8cdc99dde900388d2eefaad4e.camel@kernel.org>
 <0fb26243-0d63-118b-2737-05391ba0c69a@linux.ibm.com>
 <ec564375084b6edd7b7d77eb341f451e798fb50d.camel@kernel.org>
 <87r0pde22q.fsf@mail.lhotse>
In-Reply-To: <87r0pde22q.fsf@mail.lhotse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Jul 12, 2023 at 12:39 PM UTC, Michael Ellerman wrote:
> Jarkko Sakkinen <jarkko@kernel.org> writes:
> > On Tue, 2023-07-11 at 08:47 -0400, Stefan Berger wrote:
> >> On 7/10/23 17:23, Jarkko Sakkinen wrote:
> >> > On Thu, 2023-06-15 at 22:37 +1000, Michael Ellerman wrote:
> >> > > There's code in prom_instantiate_sml() to do a "SML handover" (Sto=
red
> >> > > Measurement Log) from OF to Linux, before Linux shuts down Open
> >> > > Firmware.
> >> > >=20
> >> > > This involves creating a buffer to hold the SML, and creating two =
device
> >> > > tree properties to record its base address and size. The kernel th=
en
> >> > > later reads those properties from the device tree to find the SML.
> >> > >=20
> >> > > When the code was initially added in commit 4a727429abec ("PPC64: =
Add
> >> > > support for instantiating SML from Open Firmware") the powerpc ker=
nel
> >> > > was always built big endian, so the properties were created big en=
dian
> >> > > by default.
> >> > >=20
> >> > > However since then little endian support was added to powerpc, and=
 now
> >> > > the code lacks conversions to big endian when creating the propert=
ies.
> >> > >=20
> >> > > This means on little endian kernels the device tree properties are
> >> > > little endian, which is contrary to the device tree spec, and in
> >> > > contrast to all other device tree properties.
> >> > >=20
> >> > > To cope with that a workaround was added in tpm_read_log_of() to s=
kip
> >> > > the endian conversion if the properties were created via the SML
> >> > > handover.
> >> > >=20
> >> > > A better solution is to encode the properties as big endian as the=
y
> >> > > should be, and remove the workaround.
> >> > >=20
> >> > > Typically changing the encoding of a property like this would pres=
ent
> >> > > problems for kexec. However the SML is not propagated across kexec=
, so
> >> > > changing the encoding of the properties is a non-issue.
> >> > >=20
> >> > > Fixes: e46e22f12b19 ("tpm: enhance read_log_of() to support Physic=
al TPM event log")
> >> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >> > > ---
> >> > >   arch/powerpc/kernel/prom_init.c |  8 ++++++--
> >> > >   drivers/char/tpm/eventlog/of.c  | 23 ++++-------------------
> >> > >   2 files changed, 10 insertions(+), 21 deletions(-)
> >> >=20
> >> > Split into two patches (producer and consumer).
> >>=20
> >> I think this wouldn't be right since it would break the system when on=
ly one patch is applied since it would be reading the fields in the wrong e=
ndianess.
> >
> > I think it would help if the commit message would better explain
> > what is going on. It is somewhat difficult to decipher, if you
> > don't have deep knowledge of the powerpc architecture.
>
> I mean, it's already 8 paragraphs =C2=AF\_(=E3=83=84)_/=C2=AF
>
> But I'm happy to expand it. I just don't really know what extra detail
> is needed to make it clearer.

Adding more text is not the right way to clarify things. I'd start
by explaining shortly SML and then move to the handover. It can't
be that hard, right?

Just adding new paragraphs would probably just make it even more
confusing.

BR, Jarkko
