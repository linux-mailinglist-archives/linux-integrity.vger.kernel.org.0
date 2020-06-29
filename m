Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D320E9AF
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2020 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgF2XwU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 19:52:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55540 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726019AbgF2XwU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 19:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593474738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yDZbQbffAZgKbfmHXdWfl91EskJ76dTDejso9RX8q6M=;
        b=U28YkdJUWThcr8KRqOcrK7WZEfDC70Nc79FMw8KPWpl/FUSlu7xfzVo+tGTRTUTRnmGrBU
        VPfySZrQ+Ih3BL5Ki/AS2GaHG6T97Dxk2g7V+o4JDpSgbSy8mVVXji6NdrpM1byyFehhlX
        PvFvxuPqxgZaRmu59aaRtFeYlGJ5pU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-11h7hjn8O3WvpaYjIxuK3A-1; Mon, 29 Jun 2020 19:52:12 -0400
X-MC-Unique: 11h7hjn8O3WvpaYjIxuK3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9CD8107ACCA;
        Mon, 29 Jun 2020 23:52:10 +0000 (UTC)
Received: from localhost (ovpn-116-13.gru2.redhat.com [10.97.116.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FFE05C1D4;
        Mon, 29 Jun 2020 23:52:10 +0000 (UTC)
Date:   Mon, 29 Jun 2020 20:52:09 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        erichte@linux.ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH v3 1/2] arch/ima: extend secure boot check to include
 trusted boot
Message-ID: <20200629235209.GB2756@glitch>
References: <20200623202640.4936-1-bmeneg@redhat.com>
 <20200623202640.4936-2-bmeneg@redhat.com>
 <1593202992.27152.463.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1593202992.27152.463.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 04:23:12PM -0400, Mimi Zohar wrote:
> On Tue, 2020-06-23 at 17:26 -0300, Bruno Meneguele wrote:
> <snip>
>=20
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index c1583d98c5e5..a760094e8f8d 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -694,7 +694,7 @@ int ima_load_data(enum kernel_load_data_id id)
> >  =09switch (id) {
> >  =09case LOADING_KEXEC_IMAGE:
> >  =09=09if (IS_ENABLED(CONFIG_KEXEC_SIG)
> > -=09=09    && arch_ima_get_secureboot()) {
> > +=09=09    && arch_ima_secure_or_trusted_boot()) {
> >  =09=09=09pr_err("impossible to appraise a kernel image without a file =
descriptor; try using kexec_file_load syscall.\n");
> >  =09=09=09return -EACCES;
> >  =09=09}
>=20
> Only IMA-appraisal enforces file integrity based on policy.
>=20

Right, but I didn't get the relation to the code above: I basically
renamed the function:=20

"arch_ima_get_secureboot" -> "arch_ima_secure_or_trusted_boot". =20

Which doesn't change the ima_load_data logic.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl76fqkACgkQYdRkFR+R
okMSCwf6ArclPVwGnMxzR1YUkXqbk98vyQn1q7ARf7mcpdWpVdzicAwiacFuaAMP
3uHozsXFja1TneJZpKj8ZI+noUFiHxL4G3s560qNfaIyr7eqOUd7ptKfzP1RW/5+
C049uTjHMTe38EhUtq3sG+YkBSo3NLz1e/O78eBW++44fOAqqrGyKKrJPyrmqMTx
/ieLpcfGrY9rnNtGm+pvcGWQntT0J2kddg2oxYB1JBRdbPBOXFYzfpTqQZRo1DP6
AscFZaSpcnlLgAMXr0J0TsLhaZZ4+FINhGYNRUc1R3nN1IwM0UdMWqXHi6qMW0aU
sB8+pxFQlSYmWeZGwrWZj4AKQeulYA==
=jCqQ
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

