Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A275F70EB4E
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 04:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbjEXCZD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 22:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEXCZC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 22:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57619C2;
        Tue, 23 May 2023 19:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE9D06327B;
        Wed, 24 May 2023 02:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC511C433EF;
        Wed, 24 May 2023 02:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684895100;
        bh=BcDIiC2FzTaDGJ/pX1DSj10DEtcdQm/AsWrIB+h169U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C1zYj5ESv7YSFW2uv/Cs/jrF7Ix48tTaLCjUTRc1vs6N54BKD/pphUmLN62xxZBV9
         HFRTdfAFChJqYUnq1SiQ09dQm5817S9xk92t2czBd6ztE2Imcfb/L5uLsnjYkH3Yxm
         KwxMjm0gjY9muBNRnbyAZENOGwCQWavk1DFORh9LXyySZFpbpnL1YCPiPMKO4b6Ou/
         LF6HDlO2b68jHFM86N6Hv/Zm/gvwCcocYZhbGp9xcoDKabR7oSqxqC7VCv/H+q/aAo
         5xgnrLrKafEz6RES9DXAYET2eXQOwf3NbMLY4bp4nx2uis00J6VLqgDkbre3tsEcPy
         PuxNv/R96VLrA==
Message-ID: <4c27b79aee9ed9578fb7f00b7a99dc5ff819ca02.camel@kernel.org>
Subject: Re: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON
 UPX-i11
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?ISO-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com
Date:   Wed, 24 May 2023 05:24:57 +0300
In-Reply-To: <432df3cf-da16-1f2a-02dc-e2c371c1f29c@linux.intel.com>
References: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
         <ohdpul6hax5bj5hhsnpt7i3ejbttivufmoolzunbhipexjkczi@meg3zx2yqkc7>
         <CSPMQ03V3G7G.EBWKDRE4B0XY@suppilovahvero>
         <432df3cf-da16-1f2a-02dc-e2c371c1f29c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
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

On Thu, 2023-05-18 at 23:24 +0300, P=C3=A9ter Ujfalusi wrote:
>=20
> On 18/05/2023 21:53, Jarkko Sakkinen wrote:
> > On Thu May 18, 2023 at 9:50 PM EEST, Jerry Snitselaar wrote:
> > > On Wed, May 17, 2023 at 03:29:31PM +0300, Peter Ujfalusi wrote:
> > > > The interrupts initially works on the device but they will stop arr=
iving
> > > > after about 200 interrupts.
> > > >=20
> > > > On system reboot/shutdown this will cause a long wait (120000 jiffi=
es).
> > > >=20
> > > > The interrupts on this device got enabled by commit
> > > > e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > > >=20
> > > > Prior to this point the interrupts were not enabled on this machine=
.
> > > >=20
> > > > Complements: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > > > ---
> > > > Hi,
> > > >=20
> > > > This patch applies on top of mainline since 6.4-rc1 takes about 2 m=
inutes to
> > > > reboot on this machine, linux-next have
> > > > e7d3e5c4b1dd tpm/tpm_tis: Disable interrupts for more Lenovo device=
s
> > > >=20
> > > > I'm not sure if I shouold send this on top of next or mainline is f=
ine, please
> > > > let me know the preferred way to get this to 6.4.
> > > >=20
> > > > Regards,
> > > > Peter
> > > >=20
> > > >  drivers/char/tpm/tpm_tis.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.=
c
> > > > index 7af389806643..aad682c2ab21 100644
> > > > --- a/drivers/char/tpm/tpm_tis.c
> > > > +++ b/drivers/char/tpm/tpm_tis.c
> > > > @@ -122,6 +122,13 @@ static const struct dmi_system_id tpm_tis_dmi_=
table[] =3D {
> > > >  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
> > > >  		},
> > > >  	},
> > > > +	{
> > > > +		.callback =3D tpm_tis_disable_irq,
> > > > +		.ident =3D "UPX-TGL",
> > >=20
> > > Is this the product version returned by dmidecode? If yes,
> > > then the entry could be made more specific by adding a
> > > DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"), and only disable
> > > for this device instead of any system that matches the vendor
> > > AAEON.
>=20
> The version is used to differentiate the revisions of the UPX-i11
> boards, and this issue present in all revisions.
>=20
> > I can squash this to the commit I pushed (it is not yet mirrored
> > to linux-next), if I get the dmidecode info.
>=20
> System Information
>         Manufacturer: AAEON
>         Product Name: UPX-TGL01
>         Version: V1.0
>         Serial Number: Default string
>         UUID: a300091d-fb1c-ce1c-1d30-0007328efc11
>         Wake-up Type: Power Switch
>         SKU Number: Default string
>         Family: Default string
>=20
> I have used this description as it it is used for SOF, probably
> DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
> should be added?
>=20
> Oh, yes, the product name match should be there, we have TigerLake
> specific matching, so SOF is looking for AAEON device with TGL.
>=20
> Sorry for missing this.

I sent a PR with the original patch because I know that you've tested
it and it has worked for you.

BR, Jarkko
