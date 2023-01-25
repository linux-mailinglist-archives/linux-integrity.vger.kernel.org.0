Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF7667A8B6
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 03:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjAYCYa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 21:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjAYCY3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 21:24:29 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786414FC01;
        Tue, 24 Jan 2023 18:24:12 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 669313200583;
        Tue, 24 Jan 2023 21:24:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 24 Jan 2023 21:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1674613448; x=
        1674699848; bh=ffEhCn+X2jqCw1f4djQYZddJ1ObjP/owju4xwUAZF9M=; b=r
        PC0jYBfvHDpaNaJCwwQmpP7qPF1is0Ck4COrr6WH/bBW0mqrvB9YtLlQOP+saAQq
        DMDLbKfIZTTuDJKJhMPBJJFBhEHjhK7hdoGTemWSzUCeSk/9R2kQFvRYQw40Jbw1
        pmWxvJnh3XsXqmUQgIPWEO52gUtuLBqLbQd0/i2l0bee+Zz+NWMGILBL9Y1EtfEx
        f3A3/cYgbru3wVL4hkVL8mXOyq7Pwc2R4SLyo9Gu3lcXXLRn8qYJiFyulbBSHG3b
        8TjBvp8JU+ZOW3cAb1L5BrfsNYxtzVDZv3Ho5O2MIMrdMxXVc/sUOnYCpwoxbKjI
        sBWM7Baq6v6DqLdNA43bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674613448; x=
        1674699848; bh=ffEhCn+X2jqCw1f4djQYZddJ1ObjP/owju4xwUAZF9M=; b=k
        SKNPt84ElG2XNyl5RUZoQ4zEGzO3yLxQWI2lxv91BlhuyzXRvEB7jmaMx5sqOK26
        XPoUDEA4ITYSH0/HgfQUYeRuV/hKc2WGR8Syc/Y/mOZ7WQXtMyna5lQ+miZcxIzS
        osOrCTsiNhlxP6/lWd/u/idtd8+m/2pKpKnVLGsmQEP52BAZIrwT0gewyyeakX5W
        ph9AK/xHpTSZykSClk5/F24fT5GxBZtBwwsxD27pI+Pl4BzzzsWBdj9g0nGTnu38
        iWC3nkIcXNCnx4gZevZvzyllRrdcnQP8B2+xcX5XC+kHhxW/KkSyZusN4CyJQrjz
        SFg3fT2XWK/O14/dvQVGQ==
X-ME-Sender: <xms:xpLQY_IRjPv8eiTL8GIpdY5T_oBgY4LDe7K-8l_wB4PUkcmPgrJ6jg>
    <xme:xpLQYzIs0aF4EwfLBP7n6zyYERzndp7P-hCUCQHCVyctyqmUoLx-Wsl7bOSqUi9aS
    6CpxlDEcUThhL_xhQ>
X-ME-Received: <xmr:xpLQY3sVPeVjkrLbWYRC_CYTVghQkAqTbcAGdrcQI9PSK8UZdbsX2cO1evbC-44pQwl0QHrpn4k7kQSLd8rQK-OpFGsQYbJ5jj-cH6kn-UoM6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvuddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredt
    tderjeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruh
    hsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnheptefgieelhfeufeevvdekheeifeej
    gfefgeehtedukeeigfduuddtueekteevleelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:x5LQY4YTljiDtkQPfbJpGHaYQEScy01lrK50mgVQQScojwepytt9eg>
    <xmx:x5LQY2Z4PF2hQyK4QgoMvbvjOfSWvZ3CFX-MpDR9Xnq-IcU1U7NDMA>
    <xmx:x5LQY8CD2fkeILpCG_D2iqsYr2fyLtvv1UadaLhtioSpv5gLlYZ_9A>
    <xmx:yJLQYyRInNzf-XVfOTzu_ID1VyR-vF4ZCN3nectGWHRs2cmnx05Mow>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jan 2023 21:24:03 -0500 (EST)
Message-ID: <71b48934e26a991eaf62c9869a8dfee769e0799d.camel@russell.cc>
Subject: Re: [PATCH v4 24/24] integrity/powerpc: Support loading keys from
 pseries secvar
From:   Russell Currey <ruscur@russell.cc>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        mpe@ellerman.id.au, gjoyce@linux.ibm.com, sudhakar@linux.ibm.com,
        bgray@linux.ibm.com, erichte@linux.ibm.com, joel@jms.id.au
Date:   Wed, 25 Jan 2023 13:23:59 +1100
In-Reply-To: <57dca1ea3ef66bc0935bdd1dab4536f1151f4004.camel@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-25-ajd@linux.ibm.com>
         <57dca1ea3ef66bc0935bdd1dab4536f1151f4004.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-24 at 10:14 -0500, Mimi Zohar wrote:
> On Fri, 2023-01-20 at 18:43 +1100, Andrew Donnellan wrote:
> > From: Russell Currey <ruscur@russell.cc>
> >=20
> > The secvar object format is only in the device tree under powernv.
> > We now have an API call to retrieve it in a generic way, so we
> > should
> > use that instead of having to handle the DT here.
> >=20
> > Add support for pseries secvar, with the "ibm,plpks-sb-v1" format.
> > The object format is expected to be the same, so there shouldn't be
> > any
> > functional differences between objects retrieved from powernv and
> > pseries.
> >=20
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> >=20
> > ---
> >=20
> > v3: New patch
> >=20
> > v4: Pass format buffer size (stefanb, npiggin)
> > ---
> > =C2=A0.../integrity/platform_certs/load_powerpc.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 17 ++++++++++---
> > ----
> > =C2=A01 file changed, 10 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/security/integrity/platform_certs/load_powerpc.c
> > b/security/integrity/platform_certs/load_powerpc.c
> > index dee51606d5f4..d4ce91bf3fec 100644
> > --- a/security/integrity/platform_certs/load_powerpc.c
> > +++ b/security/integrity/platform_certs/load_powerpc.c
> > @@ -10,7 +10,6 @@
> > =C2=A0#include <linux/cred.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0#include <linux/slab.h>
> > -#include <linux/of.h>
> > =C2=A0#include <asm/secure_boot.h>
> > =C2=A0#include <asm/secvar.h>
> > =C2=A0#include "keyring_handler.h"
> > @@ -59,16 +58,22 @@ static int __init load_powerpc_certs(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *db =3D NULL, *dbx=
 =3D NULL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 dbsize =3D 0, dbxsi=
ze =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc =3D 0;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *node;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char buf[32];
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!secvar_ops)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The following only applie=
s for the edk2-compat backend.
> > */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0node =3D of_find_compatible_=
node(NULL, NULL, "ibm,edk2-
> > compat-v1");
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!node)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D secvar_ops->format(b=
uf, 32);
>=20
> "powerpc/secvar: Handle format string in the consumer"=C2=A0 defines
> opal_secvar_format() for the object format "ibm,secvar-backend".=C2=A0
> Here
> shouldn't it being returning the format for "ibm,edk2-compat-v1"?
>=20

They end up with the same value.  The DT structure on powernv looks
like this:

/proc/device-tree/ibm,opal/secvar:
name             "secvar"
compatible       "ibm,secvar-backend"
		 "ibm,edk2-compat-v1"
format           "ibm,edk2-compat-v1"
max-var-key-len  00000000 00000400
phandle          0000805a (32858)
max-var-size     00000000 00002000

The existing code is checking for a node compatible with "ibm,edk2-
compat-v1", which would match the node above.  opal_secvar_format()
checks for a node compatible with "ibm,secvar-backend" (again, matching
above) and then returns the contents of the "format" string, which is
"ibm,edk2-compat-v1".

Ultimately it's two different ways of doing the same thing, but this
way load_powerpc_certs() doesn't have to interact with the device tree.

- Russell


> Mimi
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len <=3D 0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// Check for known secure bo=
ot implementations from OPAL or
> > PLPKS
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (strcmp("ibm,edk2-compat-=
v1", buf) && strcmp("ibm,plpks-
> > sb-v1", buf)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_err("Unsupported secvar implementation \"%s\",
> > not loading certs\n", buf);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Get db, and dbx. The=
y might not exist, so it isn't an
> > error if we
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * can't get them.
> > @@ -103,8 +108,6 @@ static int __init load_powerpc_certs(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(dbx);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of_node_put(node);
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > =C2=A0}
> > =C2=A0late_initcall(load_powerpc_certs);
>=20
>=20

