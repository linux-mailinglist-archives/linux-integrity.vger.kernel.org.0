Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6C6EBD25
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 07:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDWFI7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 01:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDWFI6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 01:08:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6891FEB
        for <linux-integrity@vger.kernel.org>; Sat, 22 Apr 2023 22:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C3EF616EF
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 05:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BA0C433EF;
        Sun, 23 Apr 2023 05:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682226536;
        bh=+tOaKRxnLFZU52JLIoyRdo9+3WQHwBIPMZEVxTKxX1w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LqaC4JfUAvvUzQW6+1FP5d0BuIuOfRyhMkYbQ9rYw170skuWP6czE9hXpJ3Gj+sYE
         89Ptk44PVg6H/jjUDWjex6SeU3/fq23QCephdYOTLZvihKcHiF592/6LTUeOuYFYUr
         AuPL+r1aZkQEPwAcYsyosd0ZId6wPps3x63V4r1WtftBCYPiTgCsu+ZJCtPB2+WQaj
         EYySgfQiuJa5LtrxIgo7kXc2nTeWEkWwBBO4LEAGdQkx/bpvmvlHK/efUlNhEqYugx
         09ObcVFpGnWgTN9kbWa/37v+TI0aGm1V281RuL3lNmDD2z8by5p6VVt7gtUe3oHZ5K
         pDM4cALxpEC6Q==
Message-ID: <c2b7263815017906fdca057197f270c5a82f67af.camel@kernel.org>
Subject: Re: [PATCH 0/3] tpm: Convert to platform remove callback returning
 void
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        kernel@pengutronix.de
Date:   Sun, 23 Apr 2023 08:08:32 +0300
In-Reply-To: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-03-20 at 09:06 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this series adapts the platform drivers below drivers/char/tpm to use the
> .remove_new() callback. Compared to the traditional .remove() callback
> .remove_new() returns no value. This is a good thing because the driver c=
ore
> doesn't (and cannot) cope for errors during remove. The only effect of a
> non-zero return value in .remove() is that the driver core emits a warnin=
g. The
> device is removed anyhow and an early return from .remove() usually yield=
s a
> resource leak.
>=20
> The drivers converted here returned zero in their remove callback, to the
> transformation was easy.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (3):
>   tpm/tpm_ftpm_tee: Convert to platform remove callback returning void
>   tpm/tpm_tis: Convert to platform remove callback returning void
>   tpm/tpm_tis_synquacer: Convert to platform remove callback returning
>     void
>=20
>  drivers/char/tpm/tpm_ftpm_tee.c      | 6 +++---
>  drivers/char/tpm/tpm_tis.c           | 6 ++----
>  drivers/char/tpm/tpm_tis_synquacer.c | 6 ++----
>  3 files changed, 7 insertions(+), 11 deletions(-)
>=20
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6

I've applied these, thank you.

BR, Jarkko
