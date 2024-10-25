Return-Path: <linux-integrity+bounces-3912-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333619B060E
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F821F2252F
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05746212198;
	Fri, 25 Oct 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYosZLMz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C321218A;
	Fri, 25 Oct 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867528; cv=none; b=pJKE0ewPj56kRlZx+7KWX1S+k/tY8E4x44AGZMZ0zD41CkdKIAnmj3pJYOyEZZ3QxXw2lfR4/n9iMyJIvd3gx3kXmBYj7PB9mexHyyVDwMf97zFUKjea5c2kMFYC8DP1mk9PtxPlplHRZuPSdrtrBkAhtmCv4KicXxTpvvAV7PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867528; c=relaxed/simple;
	bh=ysppTu5mWCPLNFr19X3D1ebFpzQRxs2LQ0FjU/PhG0A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uDkIIr/xR5ztDP5y7LmmMsMEnGqwMtw0N0Y1okjy1k86P3cMQ1ucMqVivDHuzY1iHMGAgQMPa9Q5+jygGmmolCon+RWytl2KpA39+Wn12aSN43MzoNKEQq1P3lbJxXYQu6uAyxUR6gtDyfLJfu26xU0jJzJPaLHpQWb1f2XmVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYosZLMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F46EC4CEC3;
	Fri, 25 Oct 2024 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729867526;
	bh=ysppTu5mWCPLNFr19X3D1ebFpzQRxs2LQ0FjU/PhG0A=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=OYosZLMzA81g9Vzc2XLu6HsXq9ZvG+EP5EjkfSR2JdFOdzpRtDPGNTieQSVSpQoqI
	 LhGKBJq5qBSg7WRlTI0D6940fjpDvmTarolOEMtTvk7Hw5Fgg+ityOnFVa+QCEWHRy
	 F6EymOvpdn7qIxXSjQiXHIikkAuMiqovTC33fXGCnwPGgMwkMF3OZat1dk1Y1IExWm
	 VzyN3yySroCizuzc4k+B3vKnA8BipeGgLKCsxcg1Y4992eyDn9t6ZST1fA+Se32SeR
	 FW1OkLLF6a3cuMOdmio3wW9eqaEe5icahMEgWwO6uGcgY1lf9Uhv2appxgfXeJuI3l
	 wKxx2pM+P2zZw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Oct 2024 17:45:22 +0300
Message-Id: <D54YUWTQNJK0.1NUJJJF6FA8C@kernel.org>
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
 <D5401CDJGBUG.1588B09HN21YS@kernel.org>
 <01edff76-2a66-4543-b1bf-4dc33d46c741@linux.ibm.com>
In-Reply-To: <01edff76-2a66-4543-b1bf-4dc33d46c741@linux.ibm.com>

On Thu Oct 24, 2024 at 3:59 PM EEST, Stefan Berger wrote:
>
>
> On 10/24/24 7:28 AM, Jarkko Sakkinen wrote:
> > On Wed Oct 23, 2024 at 10:15 PM EEST, Stefan Berger wrote:
> >>
> >>
> >> On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
> >>> Move allocation of chip->auth to tpm2_start_auth_session() so that th=
e
> >>> field can be used as flag to tell whether auth session is active or n=
ot.
> >>>
> >>> Cc: stable@vger.kernel.org # v6.10+
> >>> Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>> ---
> >>> v5:
> >>> - No changes.
> >>> v4:
> >>> - Change to bug.
> >>> v3:
> >>> - No changes.
> >>> v2:
> >>> - A new patch.
> >>> ---
> >>>    drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++++---------=
----
> >>>    1 file changed, 25 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2=
-sessions.c
> >>> index 78c650ce4c9f..6e52785de9fd 100644
> >>> --- a/drivers/char/tpm/tpm2-sessions.c
> >>> +++ b/drivers/char/tpm/tpm2-sessions.c
> >>> @@ -484,7 +484,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char =
*str, u8 *pt_u, u8 *pt_v,
> >>>    	sha256_final(&sctx, out);
> >>>    }
> >>>   =20
> >>> -static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip=
 *chip)
> >>> +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip=
 *chip,
> >>> +				struct tpm2_auth *auth)
> >>>    {
> >>>    	struct crypto_kpp *kpp;
> >>>    	struct kpp_request *req;
> >>> @@ -543,7 +544,7 @@ static void tpm_buf_append_salt(struct tpm_buf *b=
uf, struct tpm_chip *chip)
> >>>    	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
> >>>    	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
> >>>    	kpp_request_set_input(req, s, EC_PT_SZ*2);
> >>> -	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
> >>> +	sg_init_one(d, auth->salt, EC_PT_SZ);
> >>>    	kpp_request_set_output(req, d, EC_PT_SZ);
> >>>    	crypto_kpp_compute_shared_secret(req);
> >>>    	kpp_request_free(req);
> >>> @@ -554,8 +555,7 @@ static void tpm_buf_append_salt(struct tpm_buf *b=
uf, struct tpm_chip *chip)
> >>>    	 * This works because KDFe fully consumes the secret before it
> >>>    	 * writes the salt
> >>>    	 */
> >>> -	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
> >>> -		  chip->auth->salt);
> >>> +	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt)=
;
> >>>   =20
> >>>     out:
> >>>    	crypto_free_kpp(kpp);
> >>> @@ -854,6 +854,8 @@ int tpm_buf_check_hmac_response(struct tpm_chip *=
chip, struct tpm_buf *buf,
> >>>    			/* manually close the session if it wasn't consumed */
> >>>    			tpm2_flush_context(chip, auth->handle);
> >>>    		memzero_explicit(auth, sizeof(*auth));
> >>> +		kfree(auth);
> >>> +		chip->auth =3D NULL;
> >>>    	} else {
> >>>    		/* reset for next use  */
> >>>    		auth->session =3D TPM_HEADER_SIZE;
> >>> @@ -882,6 +884,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
> >>>   =20
> >>>    	tpm2_flush_context(chip, auth->handle);
> >>>    	memzero_explicit(auth, sizeof(*auth));
> >>> +	kfree(auth);
> >>> +	chip->auth =3D NULL;
> >>>    }
> >>>    EXPORT_SYMBOL(tpm2_end_auth_session);
> >>>   =20
> >>> @@ -970,25 +974,29 @@ static int tpm2_load_null(struct tpm_chip *chip=
, u32 *null_key)
> >>>     */
> >>>    int tpm2_start_auth_session(struct tpm_chip *chip)
> >>>    {
> >>> +	struct tpm2_auth *auth;
> >>>    	struct tpm_buf buf;
> >>> -	struct tpm2_auth *auth =3D chip->auth;
> >>> -	int rc;
> >>>    	u32 null_key;
> >>> +	int rc;
> >>>   =20
> >>> -	if (!auth) {
> >>> -		dev_warn_once(&chip->dev, "auth session is not active\n");
> >>> +	if (chip->auth) {
> >>> +		dev_warn_once(&chip->dev, "auth session is active\n");
> >>>    		return 0;
> >>>    	}
> >>>   =20
> >>> +	auth =3D kzalloc(sizeof(*auth), GFP_KERNEL);
> >>> +	if (!auth)
> >>> +		return -ENOMEM;
> >>> +
> >>>    	rc =3D tpm2_load_null(chip, &null_key);
> >>>    	if (rc)
> >>> -		goto out;
> >>> +		goto err;
> >>>   =20
> >>>    	auth->session =3D TPM_HEADER_SIZE;
> >>>   =20
> >>>    	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH=
_SESS);
> >>>    	if (rc)
> >>> -		goto out;
> >>> +		goto err;
> >>>   =20
> >>>    	/* salt key handle */
> >>>    	tpm_buf_append_u32(&buf, null_key);
> >>> @@ -1000,7 +1008,7 @@ int tpm2_start_auth_session(struct tpm_chip *ch=
ip)
> >>>    	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
> >>>   =20
> >>>    	/* append encrypted salt and squirrel away unencrypted in auth */
> >>> -	tpm_buf_append_salt(&buf, chip);
> >>> +	tpm_buf_append_salt(&buf, chip, auth);
> >>>    	/* session type (HMAC, audit or policy) */
> >>>    	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
> >>>   =20
> >>> @@ -1021,10 +1029,13 @@ int tpm2_start_auth_session(struct tpm_chip *=
chip)
> >>>   =20
> >>>    	tpm_buf_destroy(&buf);
> >>>   =20
> >>> -	if (rc)
> >>> -		goto out;
> >>> +	if (rc =3D=3D TPM2_RC_SUCCESS) {
> >>> +		chip->auth =3D auth;
> >>> +		return 0;
> >>> +	}
> >>>   =20
> >>> - out:
> >>> +err:
> >>
> >> like in many other cases before kfree(auth):
> >> memzero_explicit(auth, sizeof(*auth));
> >>
> >> With this:
> >>
> >> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >=20
> > Thanks, or should we use kfree_sensitive()?
> >=20
> > It has some additional functionality, which is missed now:
> >=20
> > https://elixir.bootlin.com/linux/v6.11.5/source/mm/slab_common.c#L1339
> >=20
> > I.e. kasan_unpoison().
>
> And change the other ones that use memzero_explicit()?

Yeah, might be a good idea too. Don't invent your own "safe primitives"
sounds like a good idea to me at least...

>
> >=20
> > BR, Jarkko
> >=20

BR, Jarkko

