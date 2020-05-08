Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43B1C9F79
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEHAOH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 20:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHAOH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 20:14:07 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2826C05BD43;
        Thu,  7 May 2020 17:14:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49J9mW64lkz9sRf;
        Fri,  8 May 2020 10:14:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588896844;
        bh=5JVunjKKLRhUSNnnqzV1JmO8bxvGIcNPJwEqJeM9ZSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DBt7o0ZOxEL1jBrKW5SujOI9MKaROriVgIo426I6egRbjzkgMm6JiQa19OD1PYEoh
         1rr3QHTUKXhoRXgDXRj99NYJb8bvZpnusU/kirSDt9J2EqFPd2bmANxvhrqTxQY4Or
         CLHV3GYTolkmOe9eh5Qy+6IJP6uMbUeFFZe2eEyrl42A1BEajRs80MfDq2VSngl8yp
         09YoNTVDcaykm+tSrLrM6BIJP3og6UjCVDbY8/rPbwyYbuChfkG72qMJulBaSGI/58
         vTKVaKU6DQ6EcjfGwcHkilWvVnmALULkTdX0KnnVN9IQP/kRCIv41FbipeUDQtoHQG
         KgvJN7TCqMJhg==
Date:   Fri, 8 May 2020 10:14:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     madhuparnabhowmik10@gmail.com
Cc:     zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        paulmck@kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] integrity: evm: Fix RCU list related warnings.
Message-ID: <20200508101402.267ca0f2@canb.auug.org.au>
In-Reply-To: <20200430160205.17798-1-madhuparnabhowmik10@gmail.com>
References: <20200430160205.17798-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UbniLlvkEYP3TYb2kyVKYqX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--Sig_/UbniLlvkEYP3TYb2kyVKYqX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 30 Apr 2020 21:32:05 +0530 madhuparnabhowmik10@gmail.com wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>=20
> This patch fixes the following warning and few other
> instances of traversal of evm_config_xattrnames list:
>=20
> [   32.848432] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   32.848707] WARNING: suspicious RCU usage
> [   32.848966] 5.7.0-rc1-00006-ga8d5875ce5f0b #1 Not tainted
> [   32.849308] -----------------------------
> [   32.849567] security/integrity/evm/evm_main.c:231 RCU-list traversed i=
n non-reader section!!
>=20
> Since entries are only added to the list and never deleted,
> use list_For_each_entry_lockless() instead of
> list_for_each_entry_rcu() for traversing the list.
> Also, add a relevant comment in evm_secfs.c to indicate this fact.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  security/integrity/evm/evm_crypto.c | 2 +-
>  security/integrity/evm/evm_main.c   | 4 ++--
>  security/integrity/evm/evm_secfs.c  | 9 ++++++++-
>  3 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index 35682852ddea..b2dc87da5f50 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -207,7 +207,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentr=
y,
>  	data->hdr.length =3D crypto_shash_digestsize(desc->tfm);
> =20
>  	error =3D -ENODATA;
> -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>  		bool is_ima =3D false;
> =20
>  		if (strcmp(xattr->name, XATTR_NAME_IMA) =3D=3D 0)
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index d361d7fdafc4..0d36259b690d 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -97,7 +97,7 @@ static int evm_find_protected_xattrs(struct dentry *den=
try)
>  	if (!(inode->i_opflags & IOP_XATTR))
>  		return -EOPNOTSUPP;
> =20
> -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>  		error =3D __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
>  		if (error < 0) {
>  			if (error =3D=3D -ENODATA)
> @@ -228,7 +228,7 @@ static int evm_protected_xattr(const char *req_xattr_=
name)
>  	struct xattr_list *xattr;
> =20
>  	namelen =3D strlen(req_xattr_name);
> -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>  		if ((strlen(xattr->name) =3D=3D namelen)
>  		    && (strncmp(req_xattr_name, xattr->name, namelen) =3D=3D 0)) {
>  			found =3D 1;
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/=
evm_secfs.c
> index 39ad1038d45d..cfc3075769bb 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -232,7 +232,14 @@ static ssize_t evm_write_xattrs(struct file *file, c=
onst char __user *buf,
>  		goto out;
>  	}
> =20
> -	/* Guard against races in evm_read_xattrs */
> +	/*
> +	 * xattr_list_mutex guards against races in evm_read_xattrs().
> +	 * Entries are only added to the evm_config_xattrnames list
> +	 * and never deleted. Therefore, the list is traversed
> +	 * using list_for_each_entry_lockless() without holding
> +	 * the mutex in evm_calc_hmac_or_hash(), evm_find_protected_xattrs()
> +	 * and evm_protected_xattr().
> +	 */
>  	mutex_lock(&xattr_list_mutex);
>  	list_for_each_entry(tmp, &evm_config_xattrnames, list) {
>  		if (strcmp(xattr->name, tmp->name) =3D=3D 0) {

I will apply this to linux-next today.

Is there something stopping this being applied to a tree?  And does it
need to be sent to Linus soon?
--=20
Cheers,
Stephen Rothwell

--Sig_/UbniLlvkEYP3TYb2kyVKYqX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl60pEsACgkQAVBC80lX
0GyT5gf5AV5sKJWc2s7DxIUwzMEtqo3i5TLKBASh2pPvMzQssGl/56WFeynwk+fJ
V00jxnjGGSBEj5KGnDo2tv4nakQx+dPkZnQjnnUIwszwjglf8/ByYCWAKL2uNL3t
0KzD4LMyjkF/DSPHGxHR1a/nP1vVCj6QHfejkPffplGop6RZYXjaCHRSY3llwP8W
CL990yw2YuKSvHDiMNo3/oWRaOU6PWgJPXrjsFvAkXZBRQnU0xNTX4F/yvp/6k8q
VHwrGiHGfpmdbdBcoQGbd6fye0X/dTkf/v6Ev5rsw1qEp/vscYWG8jRTK/h1FC66
u+jm+K5/l6nBsEKs6psFZBCwCBB1zQ==
=tSJR
-----END PGP SIGNATURE-----

--Sig_/UbniLlvkEYP3TYb2kyVKYqX--
