Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3988896435
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2019 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfHTPXN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Aug 2019 11:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbfHTPXM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Aug 2019 11:23:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 568A410F23E0;
        Tue, 20 Aug 2019 15:23:12 +0000 (UTC)
Received: from localhost (ovpn-116-54.gru2.redhat.com [10.97.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D90271000323;
        Tue, 20 Aug 2019 15:23:11 +0000 (UTC)
Date:   Tue, 20 Aug 2019 12:23:11 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: Change log text of hash in hash_ima
Message-ID: <20190820152311.GD7410@rhlt>
References: <20190817223229.22623-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20190817223229.22623-1-vt@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Tue, 20 Aug 2019 15:23:12 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2019 at 01:32:29AM +0300, Vitaly Chikunov wrote:
> Output value is not just a hash, but hash prefixed with header. User may
> be confused to see invalid hash value. Thus, change text so that is
> obvious this is not a raw hash.
>=20
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/evmctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/evmctl.c b/src/evmctl.c
> index ef1f289..53711f4 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -606,7 +606,7 @@ static int hash_ima(const char *file)
>  	len +=3D offset;
> =20
>  	if (imaevm_params.verbose >=3D LOG_INFO)
> -		log_info("hash(%s): ", imaevm_params.hash_algo);
> +		log_info("hdr+hash(%s): ", imaevm_params.hash_algo);
> =20
>  	if (sigdump || imaevm_params.verbose >=3D LOG_INFO)
>  		imaevm_hexdump(hash, len);
> --=20
> 2.11.0
>=20

Haha, simple but really useful change :)
Thanks.

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl1cEF4ACgkQYdRkFR+R
okO2wAf/cXoKedg9t+SWIj/TdPctL361Z0mhew+IaKIBUU2MERsv/HFTUXB49xX4
w3PKy297gq0EQC4+zFo/60jvhRq7w1EkDaCx8XIWj0GGVq9pTzyVZCJhVDiEHydW
/aW0U5uRvPlAu8Nnzjku7xvn88TeujcCKLZ+b6/f7SsTzuS9L/vC/XYfD5kbg2OE
vC/aD0bq6bbYaX3b4VdU4U0sQ9o2GhPNLbd3yBm1BY7CZYCZDMyX2U8Mmm1Qi2FG
0uug3ExhnUUlT71dKAokaEcWbZ5vIp7PQg6eSsTnqk+ZjaL0oDP2zD+OFY0M6k52
wCRQ8jDNMpd9g/++OgIHMrA7uT2AEw==
=9jLr
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
