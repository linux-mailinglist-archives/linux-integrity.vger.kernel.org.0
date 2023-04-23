Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0B6EC0DA
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 17:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDWPoI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWPoI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 11:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1675F10E5
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 08:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A408B60F89
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 15:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71DBC433A0;
        Sun, 23 Apr 2023 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682264646;
        bh=uSLYnoKvWhn8Ny3fJJStKfVtljBLYUTY5T/AJvF7Klo=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=RoS5HXrTyjigoASd2tV7JnuOqiqb6cdTYwlkTja2K4UNkXvJySoR/copMt0IvUrFw
         BeGFF7qpvc5zc1FSOtlAy6vconxw6oQWQL+DUsK1f/H3SKMixjbfl+hT+D7c/7JVlR
         dbM9OCAZ0ODyeLh86Jcbix3S0mipzTVcPdJGxV5sWrSnXaY7wXNnBagB5UMCr3DMHV
         HrsqzqV48WcNxYeYpXDRtAvwl3vItzAaOcDVoakmhKLgaEmLQ0p1pu0kxaLAee38PM
         niLvre/BjJcJVpNBauEFMlpnPsO6+lETzZUvuqcBJ8zG8ZgqVSZBcUuK5Zwh9/14/0
         0i3Ti4jjpePag==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 18:44:03 +0300
Message-Id: <CS491O52MT6O.M3EEZC3J2NLU@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH 0/3] tpm: Convert to platform remove callback returning
 void
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Mailer: aerc 0.14.0
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
 <20230417060533.guw7kqfbf4t3dytr@pengutronix.de>
 <f8e9ef81082ecdde4e73e27e33ad8648bb70ab9a.camel@kernel.org>
 <20230423080205.3jeyqjaacfmo3eej@pengutronix.de>
In-Reply-To: <20230423080205.3jeyqjaacfmo3eej@pengutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Apr 23, 2023 at 11:02 AM EEST, Uwe Kleine-K=C3=B6nig wrote:
> Hello Jarkko,
>
> On Sun, Apr 23, 2023 at 09:13:57AM +0300, Jarkko Sakkinen wrote:
> > On Mon, 2023-04-17 at 08:05 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >=20
> > > On Mon, Mar 20, 2023 at 09:06:04AM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > this series adapts the platform drivers below drivers/char/tpm to u=
se the
> > > > .remove_new() callback. Compared to the traditional .remove() callb=
ack
> > > > .remove_new() returns no value. This is a good thing because the dr=
iver core
> > > > doesn't (and cannot) cope for errors during remove. The only effect=
 of a
> > > > non-zero return value in .remove() is that the driver core emits a =
warning. The
> > > > device is removed anyhow and an early return from .remove() usually=
 yields a
> > > > resource leak.
> > > >=20
> > > > The drivers converted here returned zero in their remove callback, =
to the
> > > > transformation was easy.
> > >=20
> > > who is responsible to pick up this patch set (or express their concer=
ns
> > > when not applying it)?
> > >=20
> > > There is (for now) no coordination necessary, the final conversion of
> > > platform_driver's remove callback is still far away. So applying it v=
ia
> > > it's usual repo would be great.
> >=20
> > Please check https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/lin=
ux-tpmdd.git/
>
> Looking at the topmost three commits in your next branch (i.e.
> 0760dc1b2f58fe741bddb6a0030720dfd6ac4689) it looks fine to me.

OK, thanks a lot for verifying that!

BR, Jarkko
