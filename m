Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC8521BEB3
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 22:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJUos (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 16:44:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55946 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726832AbgGJUos (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 16:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594413886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gnz7GJgbmBoMsTvgBLqZK92Ol1iE/eWW4mYLXqwt/5M=;
        b=Zo67ya7pTADgpo6twUUNxjB5F3NqEw5g53EKMFQlGbRXpC2rV7crl/ZY74P35YZMyM/u73
        Ar6G7F6gb8++N1NfgDXdaCBTaXkFiMdTnU8DAHwR+VzYXU2JM84G/QKY98LFfVq7QlzWwE
        h0fpzF8rI1PNoeAvJlMx1r6sC2k9frE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-14EznLBLPde4-4q3I_GVhQ-1; Fri, 10 Jul 2020 16:44:43 -0400
X-MC-Unique: 14EznLBLPde4-4q3I_GVhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F269800597;
        Fri, 10 Jul 2020 20:44:42 +0000 (UTC)
Received: from localhost (ovpn-116-13.gru2.redhat.com [10.97.116.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F8DB60E1C;
        Fri, 10 Jul 2020 20:44:41 +0000 (UTC)
Date:   Fri, 10 Jul 2020 17:44:40 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: ima-evm-utils: before releasing a new version
Message-ID: <20200710204440.GA97283@glitch>
References: <1594405595.14405.32.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1594405595.14405.32.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mimi,

On Fri, Jul 10, 2020 at 02:26:35PM -0400, Mimi Zohar wrote:
> Hi -
>=20
> Last year I had hoped to release new versions of ima-evm-utils on a
> more frequent basis. =A0That unfortunately didn't happen. =A0All of the
> changes posted should be in the "next" branch at this point. =A0The
> changes I just posted are queued in the "next-testing" branch, waiting
> for review/testing.
>=20

Thanks for the notice.
I'm checking it right now. It's likely I have some feedback early next
week.

> Please let me know if I've missed any ima-evm-utils patches or if
> there are still some simple changes needed before the next release.
>=20

Ack.

> thanks!
>=20
> Mimi
>=20
>=20

Thank You.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8I0zgACgkQYdRkFR+R
okMDtAgA2j5EpgurNuTwJXPOY/eohdBLJH+UVMktuiCRWXFsZ6TnKRHOHKhJAaNE
ClbrTCtss5P3he58NXNuNs98rP76p5g0K0yX1Ej9vFX0s7moi1692JJTWbUfS14V
ldsAD7LhsGPPUTa/wfligC3OdJFfMPT2uPsVjrD6jKrvfxNQnncdqO/Dfxa8/J9D
+fTKovhm62v9eiSbLrcSQRfSZdQ1lXpPe9e2i3Ga82zD4+H85JYvbiN0uttaEDjv
enVqi6FuxIImfu39Q4dgKPX/WxkwBcnF2NnXcMPYxq7Bor+oRQbLNH2elikPGwDa
iilBTrbKgc0KwiMa9wJvu/X5mF861A==
=91GD
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

