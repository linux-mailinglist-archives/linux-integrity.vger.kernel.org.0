Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91287563E0
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jul 2023 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjGQNK5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jul 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGQNK5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jul 2023 09:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A578C94;
        Mon, 17 Jul 2023 06:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 413C661063;
        Mon, 17 Jul 2023 13:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62D3C433C8;
        Mon, 17 Jul 2023 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689599455;
        bh=wdUo7fVOgoRT8fpCi4mc4kA93c6ZqoqE5Kdua+nl4JA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=a4RT83xaKggbPZOYMru1IvZV7Bb9cJa2hLrcE4Stb0U+6aKVPhkogbiAGcSoyaleP
         08fP4Xva5/Lg9Zm5sMauyuOUrlrd0hLAKRqTRoywg+VZX0p2MMN5t666z9bv+K0Hdu
         XbFilcb/hBOuhX4b9IMr4NXH3DPpiFCr6eV6Q+UatFIf3zUUxXleKs5wPdMaOLLOeM
         Z96iM8OGahKIRoje9xzMmw+joqdVlfAlSl064W8pqww8W00dA0xbJoatk6vG79tYaC
         XnHdC/toFspodcr98D2kx96ThIWF1hB0JVK9dhEUY5sw97Tg7qrkbPhdUz/bofFn9Z
         4PRlUikuzrd7A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 13:10:51 +0000
Message-Id: <CU4H0OMVMDVX.1TU7R4PORDIUG@seitikki>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Christian Hesse" <list@eworm.de>
Cc:     <linux-integrity@vger.kernel.org>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        "Linux kernel regressions list" <regressions@lists.linux.dev>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Christian Hesse" <mail@eworm.de>, <stable@vger.kernel.org>,
        <roubro1991@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
 <20230710231315.4ef54679@leda.eworm.net>
 <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
 <31d20085105784a02b60f11d46f2c7fec4d3aa0a.camel@kernel.org>
 <20230712084850.1e12ca3f@leda.eworm.net>
In-Reply-To: <20230712084850.1e12ca3f@leda.eworm.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Jul 12, 2023 at 6:48 AM UTC, Christian Hesse wrote:
> Jarkko Sakkinen <jarkko@kernel.org> on Tue, 2023/07/11 00:51:
> > On Tue, 2023-07-11 at 00:29 +0300, Jarkko Sakkinen wrote:
> > > OK, this good to hear! I've been late with my pull request (past rc1)
> > > because of kind of conflicting timing with Finnish holiday season and
> > > relocating my home office.
> > >=20
> > > I'll replace v2 patches with v3 and send the PR for rc2 after that.
> > > So unluck turned into luck this time :-)
> > >=20
> > > Thank you for spotting this! =20
> >=20
> > Please, sanity check before I send the PR for rc2:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/
>
> Looks good and works as expected on Framework Laptop 12th Gen, verified b=
y me
> and someone in the linked bugzilla ticket. I do not have Framework Laptop
> 13th Gen available for testing.
>
> Looks like there are general workarounds by disabling interrupts after a
> number of unhandled IRQs. Will this still go in?
> --=20
> main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;M=
EH"
> "CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[=
a++];)
> putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42=
);}

So I think it should, what is deny listed now will stay like that even
if Lino's patch is included.

BR, Jarkko
