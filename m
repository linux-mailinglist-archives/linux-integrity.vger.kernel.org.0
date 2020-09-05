Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4D25E4D1
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Sep 2020 03:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgIEBRc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 21:17:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50362 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgIEBRb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 21:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599268649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aGpilxaerC14wsyR+bT51+0hex+4rvMfDw3FNxSr/o=;
        b=LZkR0f1ESlos6zq0wFT0Qqk8JU2PJgyfjh6dzReL7jsgml2xW5BfphC8CJBAFyp/K2omvy
        +ckjgGYnQKVLWueYlk0Dx93IplbpWQNeXoLuxBki4KTsl4gPbT8n3NFFqYIk+viFGSGKY5
        qfbdMcqnoWIoLfyDgnoN39Jzp7w3TJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-YPxao6oPNwSOx2QwNdRLFA-1; Fri, 04 Sep 2020 21:17:25 -0400
X-MC-Unique: YPxao6oPNwSOx2QwNdRLFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E247E801ABB;
        Sat,  5 Sep 2020 01:17:23 +0000 (UTC)
Received: from localhost (ovpn-116-18.gru2.redhat.com [10.97.116.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B3CC7E172;
        Sat,  5 Sep 2020 01:17:22 +0000 (UTC)
Date:   Fri, 4 Sep 2020 22:17:21 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ima: limit secure boot feedback scope for appraise
Message-ID: <20200905011721.GA3225@heredoc.io>
References: <20200904194100.761848-1-bmeneg@redhat.com>
 <20200904194100.761848-4-bmeneg@redhat.com>
 <f6b04ff269d3f5f72ee6b005bb97e6ac7b73b43e.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <f6b04ff269d3f5f72ee6b005bb97e6ac7b73b43e.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 05:07:08PM -0400, Mimi Zohar wrote:
> Hi Bruno,
>=20
> > +=09bool sb_state =3D arch_ima_get_secureboot();
> > +=09int appraisal_state =3D ima_appraise;
> > =20
> >  =09if (strncmp(str, "off", 3) =3D=3D 0)
> > -=09=09ima_appraise =3D 0;
> > +=09=09appraisal_state =3D 0;
> >  =09else if (strncmp(str, "log", 3) =3D=3D 0)
> > -=09=09ima_appraise =3D IMA_APPRAISE_LOG;
> > +=09=09appraisal_state =3D IMA_APPRAISE_LOG;
> >  =09else if (strncmp(str, "fix", 3) =3D=3D 0)
> > -=09=09ima_appraise =3D IMA_APPRAISE_FIX;
> > +=09=09appraisal_state =3D IMA_APPRAISE_FIX;
> >  =09else if (strncmp(str, "enforce", 7) =3D=3D 0)
> > -=09=09ima_appraise =3D IMA_APPRAISE_ENFORCE;
> > +=09=09appraisal_state =3D IMA_APPRAISE_ENFORCE;
> >  =09else
> >  =09=09pr_err("invalid \"%s\" appraise option", str);
> > +
> > +=09/* If appraisal state was changed, but secure boot is enabled,
> > +=09 * keep its default */
> > +=09if (sb_state) {
> > +=09=09if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> > +=09=09=09pr_info("Secure boot enabled: ignoring ima_appraise=3D%s opti=
on",
> > +=09=09=09=09str);
> > +=09=09else
> > +=09=09=09ima_appraise =3D appraisal_state;
> > +=09}
>=20
> Shouldn't the "else" clause be here.   No need to re-post the entire
> patch set.

Yes, of course it should.
Sorry. Sending the v3 for this patch.

>=20
> thanks,
>=20
> Mimi
>=20
> >  #endif
> >  =09return 1;
> >  }
>=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl9S5yEACgkQYdRkFR+R
okNAUwf/WI2YetZ8RfPxdxORcOb8c5C7o273T+FLI2XG3nOWiFDVsuCVQxwEAmcC
JqehdVUEMAaNn0jKC6GuaWOFWPo0DugT0suZMDZlZp1zofi4scTF4iD66IagnPx8
riIIOHTCRL/VD9I4emM0GKQu7kSNgO82zVbGi5k8d+ah3bboCR3AmQmk3uHMLAfW
nPViQLetn2KQVjYnVT4ISgpOIJNmeOXmMYPLUNDFexaMqOnCZBi8DLE7xEyv5NOu
gzwSMrVKuyi9lakjyWaVE5L500DI7kOZ/YUvP7YK2xxXTfjk8BG8LoFr72O/WxhG
/HYYZcwkbIxa0xeThLSlg8IojURQ1Q==
=OXdZ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

