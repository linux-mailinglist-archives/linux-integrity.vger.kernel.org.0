Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF496EBD5A
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 08:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDWGOF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 02:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDWGOD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 02:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34E41FCC
        for <linux-integrity@vger.kernel.org>; Sat, 22 Apr 2023 23:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0810A60EFA
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 06:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C07C433EF;
        Sun, 23 Apr 2023 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682230441;
        bh=isMHYrl6b+Z6bCvM8oJ9iZzlQFJHTf2+B1vsAk0bfko=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jykyME1V9EV4YuvhuuWFtYnVH43gmzCDx/qbuCa9Agwtd/im3gMJnwzmkjtXIteVC
         w8FFVDGj+xWHmg9Ate54zUDuxfePssSUKmjniPWiE6ZnLUHkZOn9lBzQkxGgOOG8q3
         aYTZj37zjJbNWyeWWeQtpV3C6Pop1PRAzW9l21K7nppYbW1kWjPqli8yp4gGie+MY3
         HOz6cym3pfJvc92tsN8IBoTc2WoWsuZFHvxO8NsKoAKgPGGkcAl0UyNuaXMdlYFoaE
         KBXntiVBma7hByEgDzXPGSP5FE6vwsw2bCuRbQZLBMCWPLtoFnhjsJ5FTupkM31AMF
         o+QoJeYbVXg/g==
Message-ID: <f8e9ef81082ecdde4e73e27e33ad8648bb70ab9a.camel@kernel.org>
Subject: Re: [PATCH 0/3] tpm: Convert to platform remove callback returning
 void
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        kernel@pengutronix.de
Date:   Sun, 23 Apr 2023 09:13:57 +0300
In-Reply-To: <20230417060533.guw7kqfbf4t3dytr@pengutronix.de>
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
         <20230417060533.guw7kqfbf4t3dytr@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-04-17 at 08:05 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Mon, Mar 20, 2023 at 09:06:04AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > this series adapts the platform drivers below drivers/char/tpm to use t=
he
> > .remove_new() callback. Compared to the traditional .remove() callback
> > .remove_new() returns no value. This is a good thing because the driver=
 core
> > doesn't (and cannot) cope for errors during remove. The only effect of =
a
> > non-zero return value in .remove() is that the driver core emits a warn=
ing. The
> > device is removed anyhow and an early return from .remove() usually yie=
lds a
> > resource leak.
> >=20
> > The drivers converted here returned zero in their remove callback, to t=
he
> > transformation was easy.
>=20
> who is responsible to pick up this patch set (or express their concerns
> when not applying it)?
>=20
> There is (for now) no coordination necessary, the final conversion of
> platform_driver's remove callback is still far away. So applying it via
> it's usual repo would be great.

Please check https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-t=
pmdd.git/

If you see anything abnormal, please report, and I will fix before sending
the pull request to Linus.

BR, Jarkko
