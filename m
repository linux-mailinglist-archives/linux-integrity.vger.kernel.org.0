Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9212708807
	for <lists+linux-integrity@lfdr.de>; Thu, 18 May 2023 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjERSxJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 May 2023 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjERSxI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 May 2023 14:53:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AEBE5A;
        Thu, 18 May 2023 11:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 630F961017;
        Thu, 18 May 2023 18:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E206C433D2;
        Thu, 18 May 2023 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684435986;
        bh=kd/5cvF4bHybt7qDKC2s37Sdg655nn3LTyy01sTtqgY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=UL2dZNoK5qR7v2in8k57H6ZGYfUT0JsqXAwygJp/5jXP6dNYAFwA01Gt5VcP/FSu5
         +MzJIDTacVFSHZY5irBvHMJTdQusEH+x6WbU/hU+o/iMa3T76UUBSfoC7kyr/LkFFR
         A4/KnVegeZVtjgTFVgaLbH7fZf87zxbElOQ1Al8E8g4IabCWuntKS53wkBn4lZbHaM
         vxMbxsmIGFrlrHmD1W+HM3R8lQCo3xj1h8TNSzMDHhG+jOsPOW5ruZkkqVQssr8V+Q
         6g3K4Jf3ZFzshj1wMO3HvuA6qgA47DGLco68Hra+wBHX6FuOm4ZsdbV6uQBldvQ6rO
         QTiIcACVXw1uA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 May 2023 21:53:03 +0300
Message-Id: <CSPMQ03V3G7G.EBWKDRE4B0XY@suppilovahvero>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON
 UPX-i11
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>,
        "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>
X-Mailer: aerc 0.14.0
References: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
 <ohdpul6hax5bj5hhsnpt7i3ejbttivufmoolzunbhipexjkczi@meg3zx2yqkc7>
In-Reply-To: <ohdpul6hax5bj5hhsnpt7i3ejbttivufmoolzunbhipexjkczi@meg3zx2yqkc7>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 18, 2023 at 9:50 PM EEST, Jerry Snitselaar wrote:
> On Wed, May 17, 2023 at 03:29:31PM +0300, Peter Ujfalusi wrote:
> > The interrupts initially works on the device but they will stop arrivin=
g
> > after about 200 interrupts.
> >=20
> > On system reboot/shutdown this will cause a long wait (120000 jiffies).
> >=20
> > The interrupts on this device got enabled by commit
> > e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> >=20
> > Prior to this point the interrupts were not enabled on this machine.
> >=20
> > Complements: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > ---
> > Hi,
> >=20
> > This patch applies on top of mainline since 6.4-rc1 takes about 2 minut=
es to
> > reboot on this machine, linux-next have
> > e7d3e5c4b1dd tpm/tpm_tis: Disable interrupts for more Lenovo devices
> >=20
> > I'm not sure if I shouold send this on top of next or mainline is fine,=
 please
> > let me know the preferred way to get this to 6.4.
> >=20
> > Regards,
> > Peter
> >=20
> >  drivers/char/tpm/tpm_tis.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> > index 7af389806643..aad682c2ab21 100644
> > --- a/drivers/char/tpm/tpm_tis.c
> > +++ b/drivers/char/tpm/tpm_tis.c
> > @@ -122,6 +122,13 @@ static const struct dmi_system_id tpm_tis_dmi_tabl=
e[] =3D {
> >  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
> >  		},
> >  	},
> > +	{
> > +		.callback =3D tpm_tis_disable_irq,
> > +		.ident =3D "UPX-TGL",
>
> Is this the product version returned by dmidecode? If yes,
> then the entry could be made more specific by adding a
> DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"), and only disable
> for this device instead of any system that matches the vendor
> AAEON.

I can squash this to the commit I pushed (it is not yet mirrored
to linux-next), if I get the dmidecode info.

BR, Jarkko
