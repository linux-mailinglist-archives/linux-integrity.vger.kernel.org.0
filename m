Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACFA74FA1D
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGKVuV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGKVuV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 17:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587E610C7;
        Tue, 11 Jul 2023 14:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E28AC61632;
        Tue, 11 Jul 2023 21:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A53C433C7;
        Tue, 11 Jul 2023 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689112219;
        bh=0T0pjrWcDkDJyoK4+B3r5UxdOezTd8UsIOmWJM7998o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SlAC4z9aPTok8aMnJvGXJWw/qO6U+Qh6b1uxRBarfOPhmzFfWu/rCK/DcN5Zrr5Qd
         N0ixjQDkXktV7lIcE5tFM4BSMOG5rXpNxST0GXXxWpjUR3VL8IjWRRrnTTnOI81HZO
         HFc1IBuLfy3CIvLyTb0ae61TjsUB9OQi5A9EEPYUCrquot7qlQdPD/D7JaookJCDeW
         DDU7jXt9vUgv210WImRXB1KNJOLkBb7WgYhsZuWxptLIP/OEY3HpqnIZ7Qz76lj77+
         LMZs5G1Udn8gEyYuYdSHv1xz+DHuvi0Mb1lhp8/gZgoiu/0/cRESooiYplzWTICMJP
         iJy2D1nmBrvHg==
Message-ID: <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Grundik <ggrundik@gmail.com>, Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jul 2023 00:50:15 +0300
In-Reply-To: <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de>
         <20230710231315.4ef54679@leda.eworm.net>
         <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
         <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
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

On Tue, 2023-07-11 at 15:41 +0300, Grundik wrote:
> On Tue, 2023-07-11 at 00:29 +0300, Jarkko Sakkinen wrote:
> > On Mon, 2023-07-10 at 23:13 +0200, Christian Hesse wrote:
> >=20
> >=20
> > OK, this good to hear! I've been late with my pull request (past rc1)
> > because of kind of conflicting timing with Finnish holiday season and
> > relocating my home office.
> >=20
> > I'll replace v2 patches with v3 and send the PR for rc2 after that.
> > So unluck turned into luck this time :-)
> >=20
> > Thank you for spotting this!
>=20
> I want to say: this issue is NOT limited to Framework laptops.
>=20
> For example this MSI gen12 i5-1240P laptop also suffers from same
> problem:
>         Manufacturer: Micro-Star International Co., Ltd.
>         Product Name: Summit E13FlipEvo A12MT
>         Version: REV:1.0
>         SKU Number: 13P3.1
>         Family: Summit
>=20
> So, probably just blacklisting affected models is not the best
> solution...

It will be supplemented with

https://lore.kernel.org/linux-integrity/CTYXI8TL7C36.2SCWH82FAZWBO@suppilov=
ahvero/T/#me895f1920ca6983f791b58a6fa0c157161a33849

Together they should fairly sustainable framework.

Lino, can you add the same fixes tag as for this. It would probably
ignore inline comments to keep the patch minimal since it is a
critical fix. Just do the renames, remove inline comments and
send v3.

For tpm_tis_check_for_interrupt_storm(), you can could rename it
simply as tpm_tis_update_unhandle_irqs() as that it what it does
(my review did not include a suggestion for this).

This way I think it should be fairly trivial to get a version that
can be landed.

To put short:
1. Do the renames as suggested, they are good enough for me.
2. Drop inline comments, their usefulness is somewhat questionable
   and they increase the diff.
3. Generally aim for minimal diff but I think this should be good
   enough if you do steps 1 and 2.

If you don't have the time at hand, I can carefully do these cleanups
and apply the patch. If you have the time and motivation, go ahead
and send v3.

BR, Jarkko
