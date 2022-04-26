Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3359A50EFF7
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 06:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiDZEhL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 00:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiDZEhK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 00:37:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C09D67D0D
        for <linux-integrity@vger.kernel.org>; Mon, 25 Apr 2022 21:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3FB6B81C0B
        for <linux-integrity@vger.kernel.org>; Tue, 26 Apr 2022 04:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2034C385A0;
        Tue, 26 Apr 2022 04:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650947641;
        bh=enyskBEzOGVIK0XZS1pI9iurAeea6674AKW8BFcejK4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hqzJNbQEdXHM/EuRzJhroQZDc2wCE51D0hyFBec2DvJXt6J4H6On68nBpDvnUC5Gy
         3qmWxWrxiW/AY4+qk1wQLfGDwgJPEQaiS7zC2xpeUXtnxR1FdUn+ZWuliWNkEMhMe4
         gjNxS7PVFYzuu0kyBAUrEpUMS9NaByHYaB7aymBB+kMLYOlq7GIcDe63aNosjSUwXx
         MXIZstHO93WTgccavFEA/ewqfmVXf09rAa2ngEuyyWDZ7zH1gayHZ5LkgAM9r/XZp0
         9ux2qOyoN0cLJXtVjpyARwHCiYMDXtXqGECdFxXKW3LPVETJzTk9N7n0VdEZieDNGc
         d1VBUKU9QPgZA==
Message-ID: <cf3df097d436c9b54c710401783667b56931b9b8.camel@kernel.org>
Subject: Re: [PATCH] char: tpm: cr50_i2c: Drop if with an always false
 condition
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Date:   Tue, 26 Apr 2022 07:35:29 +0300
In-Reply-To: <20220425191132.nm66acqichx4fmel@pengutronix.de>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
         <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
         <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
         <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
         <20211116173039.ilnj7pag7solqprd@pengutronix.de>
         <20220331132231.h2hbtxthcqsdxmil@pengutronix.de>
         <20220425191132.nm66acqichx4fmel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-04-25 at 21:11 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Mar 31, 2022 at 03:22:31PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Nov 16, 2021 at 06:30:39PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Nov 16, 2021 at 05:55:35PM +0200, Jarkko Sakkinen wrote:
> > > > On Sat, 2021-11-13 at 22:53 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > > Hello,
> > > > >=20
> > > > > On Sat, Nov 13, 2021 at 12:53:32PM +0200, Jarkko Sakkinen wrote:
> > > > > > On Fri, 2021-11-12 at 23:53 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > > > > tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_probe=
() returned
> > > > > > > successfully. As i2c_get_clientdata() returns driver data for=
 the
> > > > > > > client's device and this was set in tpmm_chip_alloc() it won'=
t return
> > > > > > > NULL.
> > > > > >=20
> > > > > > This does not make the check obsolete, e.g. it would catch a pr=
ogramming
> > > > > > error elsewhere.
> > > > > >=20
> > > > > > > Simplify accordingly to prepare changing the prototype of the=
 i2c remove
> > > > > > > callback to return void. Notice that already today returning =
an error
> > > > > > > code from the remove callback doesn't prevent removal.
> > > > > >=20
> > > > > > I don't understand what you are trying to say.
> > > > >=20
> > > > > The eventual goal is the following change:
> > > > >=20
> > > > > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > > > > index 16119ac1aa97..c7069ebf5a66 100644
> > > > > --- a/include/linux/i2c.h
> > > > > +++ b/include/linux/i2c.h
> > > > > @@ -273,7 +273,7 @@ struct i2c_driver {
> > > > > =C2=A0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Standard drive=
r model interfaces */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*probe)(stru=
ct i2c_client *client, const struct i2c_device_id *id);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*remove)(struct i=
2c_client *client);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void (*remove)(struct =
i2c_client *client);
> > > > > =C2=A0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* New driver mod=
el interface to aid the seamless removal of the
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * current probe(=
)'s, more commonly unused than used second parameter.
> > > > >=20
> > > > > To prepare that I want to change all remove callbacks to uncondit=
ionally
> > > > > return 0.
> > > > >=20
> > > > > The motivation for the above change is that returning an error fr=
om an
> > > > > i2c (or spi or platform) remove callback doesn't prevent the devi=
ce from
> > > > > being removed. So the ability to return an int leads to wrong
> > > > > expectations by driver authors.
> > > > >=20
> > > > > The only effect a non-zero return code has, is an error message f=
rom the
> > > > > i2c core. So if you object to my suggested change, the minimal ch=
ange I
> > > > > want to convince you of is to replace
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > > > >=20
> > > > > by
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > >=20
> > > > > .
> > > >=20
> > > > Please then include it to a patch set, where this happens.
> > >=20
> > > My plan is to do all the preparation before submitting the change to
> > > struct i2c_driver such that in the end coordination is only needed fo=
r a
> > > single patch. (As this patch should be easy to review and without sid=
e
> > > effects it should only drop "return 0;" (or replace them by "return;"=
,
> > > depending on context) to make this easy to review/verify.
> > >=20
> > > Note that the suggested change has already a benefit today because in
> > > the error case (and without the change) you get two error messages.
> > > Returning 0 suppresses the generic (and so less useful) one.
> >=20
> > Either this was not convincing or this patch fell through the cracks.
> > Whatever it was, nobody replied and the patch isn't applied either.
> >=20
> > Would you please (re)consider this patch?
>=20
> More than three weeks later still no feedback :-\
>=20
> Please consider applying the patch.
>=20
> Best regards
> Uwe

Even if chip is expected not to be NULL, a sanity check costs nothing.
As already said, this should be reviewed in the context of the callback
change.

Even then, the change should rather be:

       if (!chip) {
               dev_err(dev, "Could not get client data at remove\n");
               return;
       }=20

BR, Jarkko
