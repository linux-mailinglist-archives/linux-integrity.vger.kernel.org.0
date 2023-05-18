Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA37087F2
	for <lists+linux-integrity@lfdr.de>; Thu, 18 May 2023 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjERSrq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 May 2023 14:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjERSrq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 May 2023 14:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C3E4A;
        Thu, 18 May 2023 11:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80641616FB;
        Thu, 18 May 2023 18:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A11C433EF;
        Thu, 18 May 2023 18:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684435663;
        bh=NsbnxtEzgAzoeXZx9WYXO2/RO6UdhwD4NgAifwAV/VA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=oVSHH8LoUVurzufCaswmXnX7HteuNTZmLU6nLAhQ4B7O9WvTeGEj4V+wD7/zmeQA4
         XKgRA6iiqWjjv+6xCV9S+fCPty5HMr+6jRuft8Vf7lPUvyzfvyUEVU1ZnIgM1IclgC
         uvXDGvEeLDrXy24SVE297mzhulnwJ6EVZrHcz5K+NDjRNQOLBQ+b8w3+XxrFcpqA1W
         YcMbqvGNWCUOnvwJGL3WJRGRy/TYzN6RlgXsN4dIJ+H9x2LTyAf9HczNRSkzgdmjfy
         xfcxghu9bobHSN6qKg7+pzcZ+MOlUp8xbEX6zNOe9nhdMR31hifCIwTlg4kOVBi17e
         Sq4BchR7EGYdw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 May 2023 21:47:40 +0300
Message-Id: <CSPMLVNACU9D.12AL98T5URAQ9@suppilovahvero>
Cc:     <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <jsnitsel@redhat.com>
Subject: Re: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON
 UPX-i11
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
        <peterhuewe@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
 <CSPMEFNB9ADX.1N4JNLRA0A9TD@suppilovahvero>
In-Reply-To: <CSPMEFNB9ADX.1N4JNLRA0A9TD@suppilovahvero>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 18, 2023 at 9:37 PM EEST, Jarkko Sakkinen wrote:
> On Wed May 17, 2023 at 3:29 PM EEST, Peter Ujfalusi wrote:
> > The interrupts initially works on the device but they will stop arrivin=
g
> > after about 200 interrupts.
> >
> > On system reboot/shutdown this will cause a long wait (120000 jiffies).
> >
> > The interrupts on this device got enabled by commit
> > e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> >
> > Prior to this point the interrupts were not enabled on this machine.
> >
> > Complements: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
>
> Complements -> Fixes
>
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > ---
> > Hi,
> >
> > This patch applies on top of mainline since 6.4-rc1 takes about 2 minut=
es to
> > reboot on this machine, linux-next have
> > e7d3e5c4b1dd tpm/tpm_tis: Disable interrupts for more Lenovo devices
> >
> > I'm not sure if I shouold send this on top of next or mainline is fine,=
 please
> > let me know the preferred way to get this to 6.4.
> >
> > Regards,
> > Peter
> >
> >  drivers/char/tpm/tpm_tis.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
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
> > +		.matches =3D {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> > +		},
> > +	},
> >  	{}
> >  };
> > =20
> > --=20
> > 2.40.1
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I adjusted the commit message a bit:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3Dd46f47575cf97d397fbe8a6150353f41d2917936

BR, Jarkko
