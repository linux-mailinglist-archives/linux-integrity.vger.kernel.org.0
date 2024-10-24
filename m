Return-Path: <linux-integrity+bounces-3908-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E159AE3D0
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 13:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668212832DD
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2A11CF2B6;
	Thu, 24 Oct 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLcKIM66"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DC1CEE8D;
	Thu, 24 Oct 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769292; cv=none; b=SJ/sCtZZZ5yOCld1r2bF1wRH8iSd83/VngjSIYL7eUXOPxbj9HzRcK8f+QEdE2IFdEmpEdE5THvLmceFNeHzRExp8B2nr5bc9ZhwEYsGUEOTcindp5M/7bfKE5wQlcioGrFyj+jdFY32mJQbAyrNik1Trdnq8Qmk4yrJd22x3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769292; c=relaxed/simple;
	bh=0xJstpGxwArsbUOvF7f13qAmC+WKuzL6vGBoiolNIBE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RHYxiZrSnz6dNVhloHmqMOUSVpPnq3Vv3yCJsNKG4AJvLSWLMZZ47cfqDW3+qcLlQzwUOJhIcR4erz5l70ZgdJembiDfrmwWVtIefhMQrwWdwIELRvlcqrIYEsPQbD6cpN8fB9En6xKqZdMXlG0i8UEPyuprPHYOyp1D7XX2cm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLcKIM66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A218C4CEC7;
	Thu, 24 Oct 2024 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729769291;
	bh=0xJstpGxwArsbUOvF7f13qAmC+WKuzL6vGBoiolNIBE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fLcKIM668RwlSheUONJW+r0jWfzrcw+yT7TgLc0oBy9Yq6ZRRz7Ob9U5MwTfPE6EG
	 EteoQA8Bd98g6tg0G+NFGnxYlWo1CLmj5VGWQ7ihj2HVWmg2wXb3yDt+Un3ZvXwOYa
	 5x0ZmTir1FnuHw+G1bEsje4Z61MU8hlbn4TFjQ+4aZMiaVjrwLB0D6UWwMfPIwYV9e
	 GzfbnaDwgkEjTofA07mV+qUXTN7HewxO/LcHZzqidN0gM4qOltWfhe2xVNswcU7usd
	 2nX915XJKz4Nsmi9F758uC4YgTkLSbx5OxvKumzUFZ2JwJXLSt+Aq27nwg/nIXDrRn
	 cFAg+T0oFysmA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Oct 2024 14:28:07 +0300
Message-Id: <D5401CDJGBUG.1588B09HN21YS@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 4/5] tpm: Allocate chip->auth in
 tpm2_start_auth_session()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241021053921.33274-1-jarkko@kernel.org>
 <20241021053921.33274-5-jarkko@kernel.org>
 <588319e8-5983-4f15-abae-b5021f1e4fce@linux.ibm.com>
In-Reply-To: <588319e8-5983-4f15-abae-b5021f1e4fce@linux.ibm.com>

On Wed Oct 23, 2024 at 10:15 PM EEST, Stefan Berger wrote:
>
>
> On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
> > Move allocation of chip->auth to tpm2_start_auth_session() so that the
> > field can be used as flag to tell whether auth session is active or not=
.
> >=20
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5:
> > - No changes.
> > v4:
> > - Change to bug.
> > v3:
> > - No changes.
> > v2:
> > - A new patch.
> > ---
> >   drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++++------------=
-
> >   1 file changed, 25 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-s=
essions.c
> > index 78c650ce4c9f..6e52785de9fd 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -484,7 +484,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *s=
tr, u8 *pt_u, u8 *pt_v,
> >   	sha256_final(&sctx, out);
> >   }
> >  =20
> > -static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *=
chip)
> > +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *=
chip,
> > +				struct tpm2_auth *auth)
> >   {
> >   	struct crypto_kpp *kpp;
> >   	struct kpp_request *req;
> > @@ -543,7 +544,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf=
, struct tpm_chip *chip)
> >   	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
> >   	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
> >   	kpp_request_set_input(req, s, EC_PT_SZ*2);
> > -	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
> > +	sg_init_one(d, auth->salt, EC_PT_SZ);
> >   	kpp_request_set_output(req, d, EC_PT_SZ);
> >   	crypto_kpp_compute_shared_secret(req);
> >   	kpp_request_free(req);
> > @@ -554,8 +555,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf=
, struct tpm_chip *chip)
> >   	 * This works because KDFe fully consumes the secret before it
> >   	 * writes the salt
> >   	 */
> > -	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
> > -		  chip->auth->salt);
> > +	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
> >  =20
> >    out:
> >   	crypto_free_kpp(kpp);
> > @@ -854,6 +854,8 @@ int tpm_buf_check_hmac_response(struct tpm_chip *ch=
ip, struct tpm_buf *buf,
> >   			/* manually close the session if it wasn't consumed */
> >   			tpm2_flush_context(chip, auth->handle);
> >   		memzero_explicit(auth, sizeof(*auth));
> > +		kfree(auth);
> > +		chip->auth =3D NULL;
> >   	} else {
> >   		/* reset for next use  */
> >   		auth->session =3D TPM_HEADER_SIZE;
> > @@ -882,6 +884,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
> >  =20
> >   	tpm2_flush_context(chip, auth->handle);
> >   	memzero_explicit(auth, sizeof(*auth));
> > +	kfree(auth);
> > +	chip->auth =3D NULL;
> >   }
> >   EXPORT_SYMBOL(tpm2_end_auth_session);
> >  =20
> > @@ -970,25 +974,29 @@ static int tpm2_load_null(struct tpm_chip *chip, =
u32 *null_key)
> >    */
> >   int tpm2_start_auth_session(struct tpm_chip *chip)
> >   {
> > +	struct tpm2_auth *auth;
> >   	struct tpm_buf buf;
> > -	struct tpm2_auth *auth =3D chip->auth;
> > -	int rc;
> >   	u32 null_key;
> > +	int rc;
> >  =20
> > -	if (!auth) {
> > -		dev_warn_once(&chip->dev, "auth session is not active\n");
> > +	if (chip->auth) {
> > +		dev_warn_once(&chip->dev, "auth session is active\n");
> >   		return 0;
> >   	}
> >  =20
> > +	auth =3D kzalloc(sizeof(*auth), GFP_KERNEL);
> > +	if (!auth)
> > +		return -ENOMEM;
> > +
> >   	rc =3D tpm2_load_null(chip, &null_key);
> >   	if (rc)
> > -		goto out;
> > +		goto err;
> >  =20
> >   	auth->session =3D TPM_HEADER_SIZE;
> >  =20
> >   	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SE=
SS);
> >   	if (rc)
> > -		goto out;
> > +		goto err;
> >  =20
> >   	/* salt key handle */
> >   	tpm_buf_append_u32(&buf, null_key);
> > @@ -1000,7 +1008,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip=
)
> >   	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
> >  =20
> >   	/* append encrypted salt and squirrel away unencrypted in auth */
> > -	tpm_buf_append_salt(&buf, chip);
> > +	tpm_buf_append_salt(&buf, chip, auth);
> >   	/* session type (HMAC, audit or policy) */
> >   	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
> >  =20
> > @@ -1021,10 +1029,13 @@ int tpm2_start_auth_session(struct tpm_chip *ch=
ip)
> >  =20
> >   	tpm_buf_destroy(&buf);
> >  =20
> > -	if (rc)
> > -		goto out;
> > +	if (rc =3D=3D TPM2_RC_SUCCESS) {
> > +		chip->auth =3D auth;
> > +		return 0;
> > +	}
> >  =20
> > - out:
> > +err:
>
> like in many other cases before kfree(auth):
> memzero_explicit(auth, sizeof(*auth));
>
> With this:
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, or should we use kfree_sensitive()?

It has some additional functionality, which is missed now:

https://elixir.bootlin.com/linux/v6.11.5/source/mm/slab_common.c#L1339

I.e. kasan_unpoison().

BR, Jarkko

