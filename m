Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75C620FA0E
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2020 19:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbgF3RBF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jun 2020 13:01:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727850AbgF3RBF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jun 2020 13:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593536463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=azoIcMNsTD1M3uWCtFVYKKqCF4iC+1VT6noiu+rx+98=;
        b=fp3sIPH116hAf3RiW56ov7QkSYr59/JkpkIq6K9+FFfVITYoLxt/kOaMmZX+8lUtmOfOtk
        UtAIaeRHC8uV8uuzjSmOt4DlxE/zI7cUJf3i5aZwDkWCwYXGIGsikwoe3OeU7croppw5pt
        UoNJmNMJCW2SKOShYCksiBc6HMrVDy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-v_DFkjQ9PmiHTwVMhNkzIQ-1; Tue, 30 Jun 2020 13:00:49 -0400
X-MC-Unique: v_DFkjQ9PmiHTwVMhNkzIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1FD6800C60;
        Tue, 30 Jun 2020 17:00:47 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD44D7419A;
        Tue, 30 Jun 2020 17:00:44 +0000 (UTC)
Date:   Tue, 30 Jun 2020 14:00:43 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        erichte@linux.ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH v3 2/2] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
Message-ID: <20200630170043.GE2944@glitch>
References: <20200623202640.4936-1-bmeneg@redhat.com>
 <20200623202640.4936-3-bmeneg@redhat.com>
 <1593204023.27152.476.camel@linux.ibm.com>
 <20200629234744.GA2756@glitch>
 <1593514848.5085.82.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1593514848.5085.82.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 07:00:48AM -0400, Mimi Zohar wrote:
> On Mon, 2020-06-29 at 20:47 -0300, Bruno Meneguele wrote:
>=20
> >=20
> > > I'm not if the "secure_boot" flag is available prior to calling
> > > default_appraise_setup(), but if it is, you could modify the test
> > > there to also check if the system is booted in secure boot mode (eg.
> > > IS_ENABLED(CONFIG_IMA_APPRAISE_BOOTPARAM) &&
> > > !arch_ima_get_secureboot())
> > >=20
> >=20
> > Well pointed. I built a custom x86 kernel with some workaround to get
> > this flag status within default_appraise_setup() and as a result the
> > flag is was correctly available.=20
> >=20
> > Considering the nature of this flag (platform's firmware (in all
> > arches?)) can we trust that every arch supporting secure/trusted boot
> > will have it available in the __setup() call time?
>=20
> Calling=A0default_appraise_setup() could be deferred.
>=20

Hmmm.. ok, I'm going to investigate it further.
Didn't really know that.

> >=20
> > > > +=09=09/* In secure and/or trusted boot the appraisal must be
> > > > +=09=09 * enforced, regardless kernel parameters, preventing
> > > > +=09=09 * runtime changes */
> > >=20
> > > Only "appraise" rules are enforced.
> > >=20
> >=20
> > Hmm.. do you mean the comment wording is wrong/"could be better",
> > pointing the "appraise" action explicitly?
>=20
> No, it's more than just the comment. =A0Like "trusted boot", IMA-
> measurement only measures files, never enforces integrity.
> =A0"ima_appraise" mode is only applicable to IMA-appraisal.

ah! Ok, I see it now and in fact it shouldn't be part of the check
alongside secureboot.

Well, I'm going to rethink the approach entirely then.
As you said, only deferring default_appraise_setup() may be probably
enough.

Thanks Mimi.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl77b7sACgkQYdRkFR+R
okNjGwf/UV+yrhufZYUFNEextDOOPfw6c/3n7RAhFG0NrZcLmvEaDGVjrbJ7HflX
MFgr2AnUqeKnBUR4LG+zeVacjf3YDTITxX1ng3momgz257i0HbIYGSagCb8+h0p4
N/ITdenByra0lACxP/IK8kXsJpRXIRmTQ1Poz79uTyXqShG6W5P3GPxSzluHsBWn
FvJ06zKHysoJnF4hf/Mn4+d7LXgMs+VYOEMmuw+8U94ZNE2Az62/dqUmd3VbatM+
J6Gi+ZymVAsLhEwzIY99pgOWAO/PU2AHfgBOvghVQmQCEc7GnOxbPmgz7REQwM8t
+Q/KFfuiYbNtS6MLXgtCWgEVmfqBsw==
=j8Da
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

