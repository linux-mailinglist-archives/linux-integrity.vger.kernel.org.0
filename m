Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880CE779803
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHKUCA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKUCA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 16:02:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F930DE;
        Fri, 11 Aug 2023 13:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A738647AF;
        Fri, 11 Aug 2023 20:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D64BC433C8;
        Fri, 11 Aug 2023 20:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691784118;
        bh=UGeRy4kLv1Yj8E1RIf2OqaKJS9+bUxuImBDCoJL5HU0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=H8miYJcl51YWHF2csAydYJQUkKKHzXsVUALhwxhFOTo4h9lyerhLx6EGirlj2N4i+
         uWFG5gYxZ9SsZ7zWmiHt9SwND5jlo4rVikcBUn6m0nnbuNaLtcFRWeNsKxMzB3wFhT
         qYswuT77+lkervYtfN+kTXtbb5mzQVafF8f3hzIDunNw6V3FnVpLTcnKjFAjCJtSCM
         ekElFAgbpMStakJ1xm43G/nyKTC8GqG+UgsNlbtt4Yi8mLFmdvnbMcombOxoGWzZRz
         MM0/lTfdeeOoWrMRi2ueRTg7C+ebUuJwZoCnNXKLRS0W6NN4cd+X8GM8kdfgUxAe3B
         EWoTCokoWI6FQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 23:01:53 +0300
Message-Id: <CUPZF09RGD86.VQN9BOMEYZX5@suppilovahvero>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Grundik" <ggrundik@gmail.com>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
Cc:     "Linux kernel regressions list" <regressions@lists.linux.dev>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Christian Hesse" <mail@eworm.de>, <stable@vger.kernel.org>,
        <roubro1991@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Christian Hesse" <list@eworm.de>,
        <linux-integrity@vger.kernel.org>
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
 <CUPWEV9HSGHY.MLO0B4RRH4RR@suppilovahvero>
 <5806ebf113d52c660e1c70e8a57cc047ab039aff.camel@gmail.com>
In-Reply-To: <5806ebf113d52c660e1c70e8a57cc047ab039aff.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Aug 11, 2023 at 9:47 PM EEST, Grundik wrote:
> On Fri, 2023-08-11 at 20:40 +0300, Jarkko Sakkinen wrote:
> > On Fri Aug 11, 2023 at 8:22 PM EEST, Jarkko Sakkinen wrote:
> > > On Fri Aug 11, 2023 at 11:18 AM EEST, Thorsten Leemhuis wrote:
> > >=20
> > >=20
> > > I see two long-standing options:
> > >=20
> > > A. Move from deny list to allow list when considering using IRQs.
> > > This
> > > =C2=A0=C2=A0 can be supplemented with a kernel command-line parameter=
 to
> > > enforce
> > > =C2=A0=C2=A0 IRQs and ignore the allow list (and IRQ storm detection =
provides
> > > =C2=A0=C2=A0 additional measure in case you try to enforce)
> > > B. Change deny list to match only vendors for the time being. This
> > > can
> > > =C2=A0=C2=A0 be supplemented with a allow list that is processed afte=
r the
> > > deny
> > > =C2=A0=C2=A0 list for models where IRQs are known to work.
> [...]
> >=20
> > This is also super time consuming and takes the focus away from more
> > important matters (like most likely the AMD rng fix would have gone
> > smoother without these getting in the way all the time).
>
> Main problem of any list is maintaining of them. So, I think there
> should not be any black or white lists at all. Module should work with
> reasonable default (polling is the one, which lived without problems
> for years and years due to bug, as I understand), and probably a boot
> option to force IRQ. Maybe module should warn user to try that option.
>
> I don't know: is it even worth it to use IRQ, if it so problematic? Are
> there any significant advantages of that? I understand, polling is a
> resource consumer, but its just TPM, which is used mainly at the boot
> time, is it worth it?

+1

Thanks for sharing your opinion. I'll take the necessary steps.

BR, Jarkko
