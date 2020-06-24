Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00D207EEA
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 23:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404888AbgFXVwO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 17:52:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404825AbgFXVwO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 17:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593035532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQDdZsaUYeM9ZgacZbckgx0Qk4tDtdtJaceNKAaApp8=;
        b=KmKNJJbwAgeU9HcIW+Ef2P41gtA0tSiG2G3Xbx4v89RN+WonhU3zsi1wfMkvSW5t9ieC4V
        xqC9Qu1L2aEBwk1LR9TLcEC/mmBQmPCzynEGZrtqRw5FzMYkuN7ZwvZE0PqWgoJwyJwISU
        FQHaSdFLoLgPEgtV+IaW/nHbGqVAUD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-yXroqu1WPOSlgQAPELEL1w-1; Wed, 24 Jun 2020 17:52:09 -0400
X-MC-Unique: yXroqu1WPOSlgQAPELEL1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0853464;
        Wed, 24 Jun 2020 21:52:07 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FE4260F8A;
        Wed, 24 Jun 2020 21:52:07 +0000 (UTC)
Date:   Wed, 24 Jun 2020 18:52:06 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Subject: Re: [PATCH] ima-evm-utils: tests: fix finding the "boot_aggregate"
 value
Message-ID: <20200624215206.GD2639@glitch>
References: <1592964652-30446-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1592964652-30446-1-git-send-email-zohar@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 10:10:52PM -0400, Mimi Zohar wrote:
> Searching for the last "boot_aggregate" record in the measurement list
> could inadvertently match a filename containing the string
> "boot_aggregate".  Prevent this from happening.
>=20
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  tests/boot_aggregate.test | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
> index 3e961ce5f9aa..fe0c9aa1898e 100755
> --- a/tests/boot_aggregate.test
> +++ b/tests/boot_aggregate.test
> @@ -121,7 +121,7 @@ check() {
>  =09=09if [ "$VERBOSE" !=3D "0" ]; then
>  =09=09=09echo "$hash"
>  =09=09fi
> -=09=09if grep -e "boot_aggregate$" -e "boot_aggregate.$" "${ASCII_RUNTIM=
E_MEASUREMENTS}" | tail -n 1 | grep -q "${hash}"; then
> +=09=09if grep -e " boot_aggregate$" -e " boot_aggregate.$" "${ASCII_RUNT=
IME_MEASUREMENTS}" | tail -n 1 | grep -q "${hash}"; then
>  =09=09=09echo "${GREEN}SUCCESS: boot_aggregate ${hash} found${NORM}"
>  =09=09=09return "$OK"
>  =09=09fi
> --=20
> 2.7.5
>=20

Considering whitespaces in between file name words are translated to "_"
(underscore) in measurement file:

Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7zywYACgkQYdRkFR+R
okP7oAf9GaIIJA4tvZ+5Q+tTKCaNenUiTOtYxkolIJ86jdioKsnPCZ+V0Em6pgRH
Wos0lvHzrRJJHF5IyPRtCJhsw34szNhXW0zSwXiIyPxv+xs6g2Q5HjM52MaH+uTl
jafYD4JftO5EBVp4hozXr3QQy9JYmcEyH9i6ekH8dkGvQXr7q9COlGLBkDxtBgh4
n5k46AsBWXqmmDR5TIqVpp8xTMue/Ub3TfbbMpQVHt9wYSg1ngs3AsdLagPYzigd
C32sQCecoiMcrJPtGSO8GsZ4XuGwcvVU40OmyNNObBz8qzU1Umd96qvvXpF1/cDb
Mf6z6yd2quzvla4aYLASlaLihBd7lA==
=1/o3
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

