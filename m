Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C7228952
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jul 2020 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgGUTik (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 15:38:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730972AbgGUTii (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 15:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595360317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/5FQTzNceZ8+x82aqOM3eIUsHFNM5pTOLDBmqIIiW0=;
        b=Qr4rtIFHr9ipbR/dp+trfrx4JQaOET/ALufCzAgzC5dBsYKAvqvIOc7GS/dw3bTSRe5Db0
        5V9MYiHUGTeVXAu3dsWvRKepMKMDKJsDewnmbiILo1L3vZuESudNl0ht59XKg0qnKHbaRy
        bIjI2DPnSKoBiP9HXZWo0G0LsVxMd5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-KyfIS5FeMT-drxH4SXRg7A-1; Tue, 21 Jul 2020 15:38:33 -0400
X-MC-Unique: KyfIS5FeMT-drxH4SXRg7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D224680BCAE;
        Tue, 21 Jul 2020 19:38:31 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B898756BE;
        Tue, 21 Jul 2020 19:38:31 +0000 (UTC)
Date:   Tue, 21 Jul 2020 16:38:30 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
        erichte@linux.ibm.com, nayna@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v6] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
Message-ID: <20200721193830.GE2716@glitch>
References: <20200713164830.101165-1-bmeneg@redhat.com>
 <d337cbba-e996-e898-1e75-9f142d480e5e@linux.vnet.ibm.com>
 <1595257015.5055.8.camel@linux.ibm.com>
 <20200720153841.GG10323@glitch>
 <1595352376.5311.8.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1595352376.5311.8.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 01:26:16PM -0400, Mimi Zohar wrote:
> On Mon, 2020-07-20 at 12:38 -0300, Bruno Meneguele wrote:
> > On Mon, Jul 20, 2020 at 10:56:55AM -0400, Mimi Zohar wrote:
> > > On Mon, 2020-07-20 at 10:40 -0400, Nayna wrote:
> > > > On 7/13/20 12:48 PM, Bruno Meneguele wrote:
> > > > > The IMA_APPRAISE_BOOTPARAM config allows enabling different "ima_=
appraise=3D"
> > > > > modes - log, fix, enforce - at run time, but not when IMA archite=
cture
> > > > > specific policies are enabled. =A0This prevents properly labeling=
 the
> > > > > filesystem on systems where secure boot is supported, but not ena=
bled on the
> > > > > platform. =A0Only when secure boot is actually enabled should the=
se IMA
> > > > > appraise modes be disabled.
> > > > >
> > > > > This patch removes the compile time dependency and makes it a run=
time
> > > > > decision, based on the secure boot state of that platform.
> > > > >
> > > > > Test results as follows:
> > > > >
> > > > > -> x86-64 with secure boot enabled
> > > > >
> > > > > [    0.015637] Kernel command line: <...> ima_policy=3Dappraise_t=
cb ima_appraise=3Dfix
> > > > > [    0.015668] ima: Secure boot enabled: ignoring ima_appraise=3D=
fix boot parameter option
> > > > >
> > >=20
> > > Is it common to have two colons in the same line? =A0Is the colon bei=
ng
> > > used as a delimiter when parsing the kernel logs? =A0Should the secon=
d
> > > colon be replaced with a hyphen? =A0(No need to repost. =A0I'll fix i=
t
> > > up.)
> > > =A0
> >=20
> > AFAICS it has been used without any limitations, e.g:
> >=20
> > PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> > clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns=
: 133484873504 ns
> > microcode: CPU0: patch_level=3D0x08701013
> > Lockdown: modprobe: unsigned module loading is restricted; see man kern=
el_lockdown.7
> > ...
> >=20
> > I'd say we're fine using it.
>=20
> Ok. =A0FYI, it's now in next-integrity.
>=20
> Mimi
>=20

Thanks Mimi.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8XRDUACgkQYdRkFR+R
okOv3QgAidrD9B9w904OYqq3pVlZyT8GUdDpbIr0jliOvPKjHKVooNHQemfJhGU+
HzoVi2pG8ARlFC4elJBAwVXR8S9KWCT/xNL9C6N0VMg8FDik0TjmMJ0DRwh4s3oZ
oriQmx4vxaS4eNEfh5gBJrG4EwJdH2rCrbWtc4ojOzEhXE06xCsK9SN9PHy4x2Gp
zMleiQuD/YVOQK5+A3DII5/BQquL5r5zcwmZ82jho8dZGo5Ot/wc0xq6W5dSLdJw
7EScY58JI/z7H0JbxQuUG3qVmQNa4pVVx9v75cyoTwn5UeZ7XtOvshiO0pRY7M3z
8xueI7dSvd0gv2/Z6BsTFphHrfjQVw==
=mPff
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--

