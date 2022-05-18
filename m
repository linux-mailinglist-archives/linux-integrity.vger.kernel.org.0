Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3452AFA1
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 03:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiERBJ5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 21:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiERBJ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 21:09:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA736E16;
        Tue, 17 May 2022 18:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7751AB81BEA;
        Wed, 18 May 2022 01:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC81AC385B8;
        Wed, 18 May 2022 01:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652836191;
        bh=fXm/jNWiR+uB6y2skR3sOXI5YjTEgz3MjlGfetpWRgc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SyUEAn+gBKLP4/y7Dp2x8gWSW1lqeyqAXiL2vBFEZeB2RkB5kpLoHp6ZrlZ8QfQ+v
         CJiDHmKolgvDy3q0WmtL/Fr4i/y1mA+txWjVxbXEPA2LASDGCfeihKmNBcJIKZlODp
         yctJBSwOgWdGhXJS4xHrCWRbCe6soNnAOJjOEe1KGpFwQatT201u0KiW6A8msecgLb
         UP3yu7Hl05XwGV7BFMKjs1U0Dr8VO2eIf5Y1I2quQOw/uJNgGivzuP+cknMFzbkQVn
         WaswSxl512pCH+OJw40YH93JG3CE5Zvt6DbCKBydO1c9zaoLwCzSeoxMZaOeISSshJ
         qIh02HXYMpZgQ==
Message-ID: <c511995075cafb35bfefcbfe6fa6e84aa31c536f.camel@kernel.org>
Subject: Re: [PATCH v10 0/7] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 18 May 2022 04:08:15 +0300
In-Reply-To: <4d4ecd4b-9683-08a0-7a5f-11a7ff86ea6d@pengutronix.de>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
         <YoKZwFkfcl7ixTF4@kernel.org>
         <4d4ecd4b-9683-08a0-7a5f-11a7ff86ea6d@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-05-17 at 14:44 +0200, Ahmad Fatoum wrote:
> Hello Herbert,
>=20
> On 16.05.22 20:36, Jarkko Sakkinen wrote:
> > On Fri, May 13, 2022 at 04:56:58PM +0200, Ahmad Fatoum wrote:
> > I can probably pick these unless objections?
>=20
> Pankaj has given his Reviewed-by for the CAAM parts he co-maintains,
> is it ok for this to go in via Jarkko's tree?
>=20
> Note that applying this series on top of jarkko/linux-tpmdd.git has a
> trivial conflict when merged with herbert/cryptodev-2.6.git:
> Two independently added Kconfig options need to coexist in
> drivers/crypto/caam/Kconfig.
>=20
> I can resend my series rebased if needed.
>=20
> Cheers,
> Ahmad
>=20
> >=20
> > BR, Jarkko
> >=20
>=20
>=20

This came up:

https://lore.kernel.org/keyrings/0e8da958a222e5c1dccaaf1600b08bdb8705b48e.c=
amel@kernel.org/

BR, Jarkko
