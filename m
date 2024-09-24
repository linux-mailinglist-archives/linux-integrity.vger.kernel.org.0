Return-Path: <linux-integrity+bounces-3673-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD969846CD
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6EB1F23D68
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC731A7AE7;
	Tue, 24 Sep 2024 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YXq4bgsf";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YXq4bgsf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD941A3A9C;
	Tue, 24 Sep 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184817; cv=none; b=ChFqNckVqQ9eiPzJGVXk9jC+DJ3Tqi051eS66Lz9ELzYnq2cwW0Bgw58thKdCpPri0w7o0w08twbJRQfk53LM2Wf+pGrQqnIBhC4QR8T4HI7GQ4VxcfAVBKwtNtim7kCVvb1Vcm9RcAhl5DnvvKBG4BAxER5av5N1OYzqjlOEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184817; c=relaxed/simple;
	bh=mbGoAUpUUbUuilJ7AHRgBLUhYKSQwMRi4QXDEsoCvWE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvtsIJ8pD4A4OoJA5p9lwgcU0ANxPDH1fbRPk8qK8TKlFZTJoBAVJ5Ln4ebf5MTp4Fl6veUCRiPlyFojGY4nd5CdfX/WM90OXYfhZcdLgBhj6Ip5tF5VOjJxsrsQKn6vL5Dba8ISHPxJ6HydQ5CPtTOCG61vPhwU2Xin6IYRYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=YXq4bgsf; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=YXq4bgsf; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727184814;
	bh=mbGoAUpUUbUuilJ7AHRgBLUhYKSQwMRi4QXDEsoCvWE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=YXq4bgsfhiTv/+ZDRCzpsvzBc8wrG08EWnvUwJjnorIY5EJlvt+caHDGpAK4L2YB0
	 ZBYk4lIGHPSZIJDGLM/xrA6pqkDSFO/OxilWunN2XcWxlUlseFGCrbdhIGLlaZ127D
	 SWUJ1Z4qgyKp69mun4HqVklP/TWFmg4Z1DNRgqLM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 59D611287B39;
	Tue, 24 Sep 2024 09:33:34 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 3yan6ws8wMA7; Tue, 24 Sep 2024 09:33:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727184814;
	bh=mbGoAUpUUbUuilJ7AHRgBLUhYKSQwMRi4QXDEsoCvWE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=YXq4bgsfhiTv/+ZDRCzpsvzBc8wrG08EWnvUwJjnorIY5EJlvt+caHDGpAK4L2YB0
	 ZBYk4lIGHPSZIJDGLM/xrA6pqkDSFO/OxilWunN2XcWxlUlseFGCrbdhIGLlaZ127D
	 SWUJ1Z4qgyKp69mun4HqVklP/TWFmg4Z1DNRgqLM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D45051285D46;
	Tue, 24 Sep 2024 09:33:32 -0400 (EDT)
Message-ID: <12e17497239dd9b47059b03a0273e2d995371278.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 4/5] tpm: Allocate chip->auth in
 tpm2_start_auth_session()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, mapengyu@gmail.com, stable@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2024 09:33:30 -0400
In-Reply-To: <20240921120811.1264985-5-jarkko@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <20240921120811.1264985-5-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> Move allocation of chip->auth to tpm2_start_auth_session() so that
> the field can be used as flag to tell whether auth session is active
> or not.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v5:
> - No changes.
> v4:
> - Change to bug.
> v3:
> - No changes.
> v2:
> - A new patch.
> ---
>  drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++++-----------
> --
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c
> b/drivers/char/tpm/tpm2-sessions.c
> index 1aef5b1f9c90..a8d3d5d52178 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -484,7 +484,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char
> *str, u8 *pt_u, u8 *pt_v,
>         sha256_final(&sctx, out);
>  }
>  
> -static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip
> *chip)
> +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip
> *chip,
> +                               struct tpm2_auth *auth)

This addition of auth as an argument is a bit unnecessary.  You can set
chip->auth before calling this and it will all function.  Since there's
no error leg in tpm2_start_auth_session unless the session creation
itself fails and the guarantee of the ops lock is single threading this
chip->auth can be nulled again in that error leg.

If you want to keep the flow proposed in the patch, the change from how
it works now to how it works with this patch needs documenting in the
change log

>  {
>         struct crypto_kpp *kpp;
>         struct kpp_request *req;
> @@ -543,7 +544,7 @@ static void tpm_buf_append_salt(struct tpm_buf
> *buf, struct tpm_chip *chip)
>         sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
>         sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
>         kpp_request_set_input(req, s, EC_PT_SZ*2);
> -       sg_init_one(d, chip->auth->salt, EC_PT_SZ);
> +       sg_init_one(d, auth->salt, EC_PT_SZ);
>         kpp_request_set_output(req, d, EC_PT_SZ);
>         crypto_kpp_compute_shared_secret(req);
>         kpp_request_free(req);
> @@ -554,8 +555,7 @@ static void tpm_buf_append_salt(struct tpm_buf
> *buf, struct tpm_chip *chip)
>          * This works because KDFe fully consumes the secret before
> it
>          * writes the salt
>          */
> -       tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
> -                 chip->auth->salt);
> +       tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth-
> >salt);
>  
>   out:
>         crypto_free_kpp(kpp);
> @@ -854,6 +854,8 @@ int tpm_buf_check_hmac_response(struct tpm_chip
> *chip, struct tpm_buf *buf,
>                         /* manually close the session if it wasn't
> consumed */
>                         tpm2_flush_context(chip, auth->handle);
>                 memzero_explicit(auth, sizeof(*auth));
> +               kfree(auth);
> +               chip->auth = NULL;
>         } else {
>                 /* reset for next use  */
>                 auth->session = TPM_HEADER_SIZE;
> @@ -882,6 +884,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
>  
>         tpm2_flush_context(chip, auth->handle);
>         memzero_explicit(auth, sizeof(*auth));
> +       kfree(auth);
> +       chip->auth = NULL;
>  }
>  EXPORT_SYMBOL(tpm2_end_auth_session);
>  
> @@ -970,25 +974,29 @@ static int tpm2_load_null(struct tpm_chip
> *chip, u32 *null_key)
>   */
>  int tpm2_start_auth_session(struct tpm_chip *chip)
>  {
> +       struct tpm2_auth *auth;
>         struct tpm_buf buf;
> -       struct tpm2_auth *auth = chip->auth;
> -       int rc;
>         u32 null_key;
> +       int rc;
>  
> -       if (!auth) {
> -               dev_warn_once(&chip->dev, "auth session is not
> active\n");
> +       if (chip->auth) {
> +               dev_warn_once(&chip->dev, "auth session is
> active\n");
>                 return 0;
>         }
>  
> +       auth = kzalloc(sizeof(*auth), GFP_KERNEL);
> +       if (!auth)
> +               return -ENOMEM;
> +
>         rc = tpm2_load_null(chip, &null_key);
>         if (rc)
> -               goto out;
> +               goto err;
>  
>         auth->session = TPM_HEADER_SIZE;
>  
>         rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS,
> TPM2_CC_START_AUTH_SESS);
>         if (rc)
> -               goto out;
> +               goto err;
>  
>         /* salt key handle */
>         tpm_buf_append_u32(&buf, null_key);
> @@ -1000,7 +1008,7 @@ int tpm2_start_auth_session(struct tpm_chip
> *chip)
>         tpm_buf_append(&buf, auth->our_nonce, sizeof(auth-
> >our_nonce));
>  
>         /* append encrypted salt and squirrel away unencrypted in
> auth */
> -       tpm_buf_append_salt(&buf, chip);
> +       tpm_buf_append_salt(&buf, chip, auth);
>         /* session type (HMAC, audit or policy) */
>         tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
>  
> @@ -1021,10 +1029,13 @@ int tpm2_start_auth_session(struct tpm_chip
> *chip)
>  
>         tpm_buf_destroy(&buf);
>  
> -       if (rc)
> -               goto out;
> +       if (rc == TPM2_RC_SUCCESS) {
> +               chip->auth = auth;
> +               return 0;
> +       }
>  
> - out:
> +err:
> +       kfree(auth);
>         return rc;
>  }
>  EXPORT_SYMBOL(tpm2_start_auth_session);
> @@ -1371,10 +1382,6 @@ int tpm2_sessions_init(struct tpm_chip *chip)
>         if (rc)
>                 return rc;
>  
> -       chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
> -       if (!chip->auth)
> -               return -ENOMEM;
> -
>         return rc;
>  }
>  #endif /* CONFIG_TCG_TPM2_HMAC */

Other than the comment above

Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>


