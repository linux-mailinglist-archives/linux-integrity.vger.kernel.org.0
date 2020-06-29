Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2420E99D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2020 02:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgF2Xry (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 19:47:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46654 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbgF2Xrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 19:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593474471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3X7bMdmXYLPV1bgt216Pq1jCmm70y9kfUsDpzK1qB2c=;
        b=IEDmAs7zPVRE7EbXP3Ac1srPSe/L41FlqeddMfiqPzOo2EYtgHzy9Mit5rQst9iuvBXYI5
        dDXrtJRIpUAtbH0stbTZGAZyIx5pgZPEadhGohWaBSjsYO8wUr12IL4/r1ajA9ssgjyW05
        XmUohyfScJe36B1Ba/ZtXU60aUuA3Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Ddv_56adN4qvuL7PBuBJuA-1; Mon, 29 Jun 2020 19:47:47 -0400
X-MC-Unique: Ddv_56adN4qvuL7PBuBJuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE555804001;
        Mon, 29 Jun 2020 23:47:45 +0000 (UTC)
Received: from localhost (ovpn-116-13.gru2.redhat.com [10.97.116.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C6E67BEA3;
        Mon, 29 Jun 2020 23:47:45 +0000 (UTC)
Date:   Mon, 29 Jun 2020 20:47:44 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        erichte@linux.ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH v3 2/2] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
Message-ID: <20200629234744.GA2756@glitch>
References: <20200623202640.4936-1-bmeneg@redhat.com>
 <20200623202640.4936-3-bmeneg@redhat.com>
 <1593204023.27152.476.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1593204023.27152.476.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 04:40:23PM -0400, Mimi Zohar wrote:
> On Tue, 2020-06-23 at 17:26 -0300, Bruno Meneguele wrote:
> <snip>
>=20
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kc=
onfig
> > index edde88dbe576..62dc11a5af01 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -232,7 +232,7 @@ config IMA_APPRAISE_REQUIRE_POLICY_SIGS
> > =20
> >  config IMA_APPRAISE_BOOTPARAM
> >  =09bool "ima_appraise boot parameter"
> > -=09depends on IMA_APPRAISE && !IMA_ARCH_POLICY
> > +=09depends on IMA_APPRAISE
>=20
> Ok
>=20
> >  =09default y
> >  =09help
> >  =09  This option enables the different "ima_appraise=3D" modes
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/i=
ma/ima_policy.c
> > index e493063a3c34..6742f86b6c60 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -732,12 +732,20 @@ void __init ima_init_policy(void)
> >  =09 * and custom policies, prior to other appraise rules.
> >  =09 * (Highest priority)
> >  =09 */
> > -=09arch_entries =3D ima_init_arch_policy();
> > -=09if (!arch_entries)
> > -=09=09pr_info("No architecture policies found\n");
> > -=09else
> > -=09=09add_rules(arch_policy_entry, arch_entries,
> > -=09=09=09  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
> > +=09if (arch_ima_secure_or_trusted_boot()) {
>=20
> Today only "measure" and "appraise" rules are included in the arch
> specific policy, but someone might decide they want to include "audit"
> rules as well.
>=20

Right, but both arches (powerpc and x86) using specific arch policies
only add it in case secure and/or trusted boot are enabled. That's why I
considered enclosing the whole arch_policy loading in the secure/trusted
boot checking there. I would say that a fine-grained check for which
action the rules have can be added later, in a separate patchset.

> I'm not if the "secure_boot" flag is available prior to calling
> default_appraise_setup(), but if it is, you could modify the test
> there to also check if the system is booted in secure boot mode (eg.
> IS_ENABLED(CONFIG_IMA_APPRAISE_BOOTPARAM) &&
> !arch_ima_get_secureboot())
>=20

Well pointed. I built a custom x86 kernel with some workaround to get
this flag status within default_appraise_setup() and as a result the
flag is was correctly available.=20

Considering the nature of this flag (platform's firmware (in all
arches?)) can we trust that every arch supporting secure/trusted boot
will have it available in the __setup() call time?

> > +=09=09/* In secure and/or trusted boot the appraisal must be
> > +=09=09 * enforced, regardless kernel parameters, preventing
> > +=09=09 * runtime changes */
>=20
> Only "appraise" rules are enforced.
>=20

Hmm.. do you mean the comment wording is wrong/"could be better",
pointing the "appraise" action explicitly?

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl76faAACgkQYdRkFR+R
okMLmggA3nIQT9QxSR+kvsm9ER9rJ4LdYST0Odjic5gOMCinrq/2+kQJvvz20EQh
S7lDHgt34xk+9SXfvRXm6jx3wudqBKR0uIU/kjbF+AuMeRLaYsN+ZZ+8sgkB2sa8
LZ85CcKiaQ6ja7SOE5jjtdKdBbxAnY782bYVT3HEnqob9zSUTRIu4Rf0v4jMte/0
mcj4eLll0ReJLBhJXLUntr5USSlxGFJI1THEsOeQ+qx4O/AT+vIapStsrdFYVn0B
M1k2Kq4xEG+kO2YudOxUAH6jAcaQtI0y4+Vm/qBDAnnJ0KC+bw/ov7W9zOC2UpJQ
xMp/8UOUsrqR+3ZVRD7dLF06pC/pYg==
=BYOV
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

