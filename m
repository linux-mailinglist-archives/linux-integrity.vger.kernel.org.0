Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903414C6BEC
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Feb 2022 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiB1MOk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Feb 2022 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiB1MOj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Feb 2022 07:14:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED126110;
        Mon, 28 Feb 2022 04:14:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0A246111F;
        Mon, 28 Feb 2022 12:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BECC340F0;
        Mon, 28 Feb 2022 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646050440;
        bh=Km/ETwktcu0d0SJMnDCeHyQj69xN1Lz9uFFUMONXypA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n1v5K07n8jOhxyq57xn7BQrEorbQ8yrMw4Ug0tI2DGAYQcMUtfIPciRT+HTKaJmkf
         dkKdBiPqKImphpI6YQxHf+cNb9TuS10OItQ/rTK8pj4W3/0KiXw9O9uIF9ywMDcM0c
         m9bEv7m68SSFVeCSQgAn+5MP0xwENwl1Ly2urKNly6PEGvK920nBreaupHLk/kw7wO
         VaNiktvdcmMnISxVHTTvnrtnYRP5TxzoUgc/xT33OTxlBiWD1vVxaWfaJ0R7vrjZ1k
         IvqHjKyO77AOORScaclklg9AN4faCvi26+53xWVbku2UCd9TbwZOEVL/n/je90ezi0
         wJAxsphQpIXCw==
Message-ID: <79b912b5e9e16f446753270f7b9463fee95ebac7.camel@kernel.org>
Subject: Re: [PATCH v5 4/5] crypto: caam - add in-kernel interface for blob
 generator
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Mon, 28 Feb 2022 13:14:41 +0100
In-Reply-To: <a8cb99e0-fe01-2234-9839-fea28ca09f6d@pengutronix.de>
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
         <20220222195819.2313913-5-a.fatoum@pengutronix.de>
         <YhZVmBy3/nWbqf+/@iki.fi>
         <a8cb99e0-fe01-2234-9839-fea28ca09f6d@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-02-23 at 17:20 +0100, Ahmad Fatoum wrote:
> On 23.02.22 16:41, Jarkko Sakkinen wrote:
> > On Tue, Feb 22, 2022 at 08:58:18PM +0100, Ahmad Fatoum wrote:
> > > The NXP Cryptographic Acceleration and Assurance Module (CAAM)
> > > can be used to protect user-defined data across system reboot:
> > >=20
> > > =C2=A0 - When the system is fused and boots into secure state, the ma=
ster
> > > =C2=A0=C2=A0=C2=A0 key is a unique never-disclosed device-specific ke=
y
> > > =C2=A0 - random key is encrypted by key derived from master key
> > > =C2=A0 - data is encrypted using the random key
> > > =C2=A0 - encrypted data and its encrypted random key are stored along=
side
> > > =C2=A0 - This blob can now be safely stored in non-volatile memory
> > >=20
> > > On next power-on:
> > > =C2=A0 - blob is loaded into CAAM
> > > =C2=A0 - CAAM writes decrypted data either into memory or key registe=
r
> > >=20
> > > Add functions to realize encrypting and decrypting into memory alongs=
ide
> > > the CAAM driver.
> > >=20
> > > They will be used in a later commit as a source for the trusted key
> > > seal/unseal mechanism.
> > >=20
> > > Reviewed-by: David Gstir <david@sigma-star.at>
> > > Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Tested-By: Tim Harvey <tharvey@gateworks.com>
> > > Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > ---
> > > To: "Horia Geant=C4=83" <horia.geanta@nxp.com>
> > > To: Aymen Sghaier <aymen.sghaier@nxp.com>
> > > To: Herbert Xu <herbert@gondor.apana.org.au>
> > > To: "David S. Miller" <davem@davemloft.net>
> > > Cc: James Bottomley <jejb@linux.ibm.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> > > Cc: David Gstir <david@sigma-star.at>
> > > Cc: Richard Weinberger <richard@nod.at>
> > > Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > Cc: Tim Harvey <tharvey@gateworks.com>
> > > Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Cc: linux-integrity@vger.kernel.org
> > > Cc: keyrings@vger.kernel.org
> > > Cc: linux-crypto@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-security-module@vger.kernel.org
> > > ---
> > > =C2=A0drivers/crypto/caam/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > > =C2=A0drivers/crypto/caam/Makefile=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/crypto/caam/blob_gen.c | 230 ++++++++++++++++++++++++++=
+++++++
> > > =C2=A0include/soc/fsl/caam-blob.h=C2=A0=C2=A0=C2=A0 |=C2=A0 56 ++++++=
++
> > > =C2=A04 files changed, 290 insertions(+)
> > > =C2=A0create mode 100644 drivers/crypto/caam/blob_gen.c
> > > =C2=A0create mode 100644 include/soc/fsl/caam-blob.h
> > >=20
> > > diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfi=
g
> > > index 84ea7cba5ee5..ea9f8b1ae981 100644
> > > --- a/drivers/crypto/caam/Kconfig
> > > +++ b/drivers/crypto/caam/Kconfig
> > > @@ -151,6 +151,9 @@ config CRYPTO_DEV_FSL_CAAM_RNG_API
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Selecting this=
 will register the SEC4 hardware rng to
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the hw_random =
API for supplying the kernel entropy pool.
> > > =C2=A0
> > > +config CRYPTO_DEV_FSL_CAAM_BLOB_GEN
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > > +
> > > =C2=A0endif # CRYPTO_DEV_FSL_CAAM_JR
> > > =C2=A0
> > > =C2=A0endif # CRYPTO_DEV_FSL_CAAM
> > > diff --git a/drivers/crypto/caam/Makefile b/drivers/crypto/caam/Makef=
ile
> > > index 3570286eb9ce..25f7ae5a4642 100644
> > > --- a/drivers/crypto/caam/Makefile
> > > +++ b/drivers/crypto/caam/Makefile
> > > @@ -21,6 +21,7 @@ caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI)=
 +=3D caamalg_qi.o
> > > =C2=A0caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_AHASH_API) +=3D caamhash.o
> > > =C2=A0caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API) +=3D caamrng.o
> > > =C2=A0caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PKC_API) +=3D caampkc.o pk=
c_desc.o
> > > +caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN) +=3D blob_gen.o
> > > =C2=A0
> > > =C2=A0caam-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) +=3D qi.o
> > > =C2=A0ifneq ($(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI),)
> > > diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blo=
b_gen.c
> > > new file mode 100644
> > > index 000000000000..513d3f90e438
> > > --- /dev/null
> > > +++ b/drivers/crypto/caam/blob_gen.c
> > > @@ -0,0 +1,230 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutro=
nix.de>
> > > + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.=
de>
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <soc/fsl/caam-blob.h>
> > > +
> > > +#include "compat.h"
> > > +#include "desc_constr.h"
> > > +#include "desc.h"
> > > +#include "error.h"
> > > +#include "intern.h"
> > > +#include "jr.h"
> > > +#include "regs.h"
> > > +
> > > +struct caam_blob_priv {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device jrdev;
> > > +};
> > > +
> > > +struct caam_blob_job_result {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct completion completi=
on;
> > > +};
> > > +
> > > +static void caam_blob_job_done(struct device *dev, u32 *desc, u32 er=
r, void *context)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct caam_blob_job_resul=
t *res =3D context;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ecode =3D 0;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(dev, "%s %d: err 0=
x%x\n", __func__, __LINE__, err);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ecode =3D caam_jr_strstatus(dev, err);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res->err =3D ecode;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Upon completion, desc p=
oints to a buffer containing a CAAM job
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * descriptor which encaps=
ulates data into an externally-storable
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * blob.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0complete(&res->completion)=
;
> > > +}
> > > +
> > > +static u32 *caam_blob_alloc_desc(size_t keymod_len)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t len;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* header + (key mod immed=
iate) + 2x pointers + op */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D 4 + (4 + ALIGN(key=
mod_len, 4)) + 2*(4 + 4 + CAAM_PTR_SZ_MAX) + 4;
> >=20
> > Nit: the amount of magic numbers is overwhelming here. I neither unders=
tand
> > the statement nor how that comment should help me to understand it.
>=20
> header=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D=C2=A0 4
> (key mod immediate) =3D (4 + ALIGN(keymod_len, 4))
> 2x pointer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=C2=
=A0 2 * (4 + 4 + CAAM_PTR_SZ_MAX)
> op=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=C2=A0 4

Please create a struct with the associated fields instead and then
it is just sizeof that.

BR, Jarkko
