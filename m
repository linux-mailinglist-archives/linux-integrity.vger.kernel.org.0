Return-Path: <linux-integrity+bounces-9703-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MZslDE1yHGr3NwkAu9opvQ
	(envelope-from <linux-integrity+bounces-9703-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 31 May 2026 19:39:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEDD617586
	for <lists+linux-integrity@lfdr.de>; Sun, 31 May 2026 19:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AD030180B0
	for <lists+linux-integrity@lfdr.de>; Sun, 31 May 2026 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39154377EB8;
	Sun, 31 May 2026 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRvc+fzc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0229ACDD;
	Sun, 31 May 2026 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780249162; cv=none; b=TC0AUhQ9KTu9EkgTC2NsPRoOh1EntWo6AggAttriC5iyMdjrzIno0gtRpqjqSxNpab17WVBxbTq0HhserdgNpTnFVmDHkK6m+Eye+xazTgL37eH+XYONW+/YrXT/eAAP+hPlIyReboatgqfoaPxBTrlNGzHRmDYYf4HD8DZnqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780249162; c=relaxed/simple;
	bh=Jni+SIUdjAT/ui0T/efHGFzu/GDzaRS/idRb6Nhfnk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPCNSockKCMm1mnxR7+vG8xovuCR5lj51gfdeLcWS8azmU7efrbGtFElRX/v/D3l6oV8SF3qw0C98DIuzomRIEjxBokFWJik6GHDcL69EeX+GDzb5nbQ+RRzhObI1SO1WmHdNvik5w4Czw6fFgl/EC+vWPrD0t9Jl0SxRhlKNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRvc+fzc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 27F4B1F00893;
	Sun, 31 May 2026 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780249160;
	bh=1KQsIhLtxvDj0ZoZo9GMnO3LWk6oBsL3W3d3mVE8gYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PRvc+fzcvEnpl7ukGAVroZDG5EUWl03qbOArcePeyZZEQqtklcmjjC8fQ8p4/11pU
	 e0VcXmCUTP366SbyFJuqd5CO5A5GLzlNY0TvZPUJBUOMYiY4KX4ecMQ/TIVRjQ3wFg
	 e978qG0JNTJj3Ocmi0QqdwU2m/bimUiV2mK0dHKoXZHMNYV3M3zCUKegEu1dePdwMg
	 AF8p86IkwPJmr3x3ne0FoT3qERgvmhvYtCLSq+rOKs5mfuil41NpitANusvqYnfxAk
	 yB9bJsqdsF+D3gEqUyJhWGsbt3H9ZL6ABo4t/XJUxu1KuLpd6LvdzpFdSIaSlCkqvG
	 cFXl4MlJpmqYw==
Date: Sun, 31 May 2026 20:39:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: tpm2-sessions: wait for async KPP completion in
 tpm_buf_append_salt
Message-ID: <ahxyRdpJhEsWc3kQ@kernel.org>
References: <20260531124428.2304629-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531124428.2304629-1-michael.bommarito@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9703-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,hansenpartnership.com,gondor.apana.org.au,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7AEDD617586
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 08:44:28AM -0400, Michael Bommarito wrote:
> tpm_buf_append_salt() in drivers/char/tpm/tpm2-sessions.c calls
> crypto_kpp_generate_public_key() and crypto_kpp_compute_shared_secret()
> without installing a completion callback, discards both return values,
> and immediately frees the kpp_request via kpp_request_free(). When the
> resolved ecdh-nist-p256 KPP backend is asynchronous (atmel-ecc, HPRE,
> keembay-ocs), either operation returns -EINPROGRESS and the deferred
> completion worker dereferences the freed request.
> 
> The path fires automatically from the hwrng_fillfn kernel thread via
> tpm_get_random -> tpm2_get_random -> tpm2_start_auth_session ->
> tpm_buf_append_salt on every entropy poll, without any userland action.
> 
> Install crypto_req_done as the completion callback, wrap both KPP
> operations in crypto_wait_req(), and propagate errors to the caller.
> The wait is a no-op for synchronous backends.
> 
> Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> Cc: stable@vger.kernel.org # v6.10+
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> v2: restructure the error cleanup into an explicit success return plus
>     err_free_req/err_free_kpp labels, per review. No functional change.
> 
> Validation (QEMU x86_64, swtpm, async ecdh-nist-p256 stub backend):
>   Unpatched, the deferred completion worker dereferences the freed
>   kpp_request: KASAN slab-use-after-free with the allocation and free
>   stacks both in tpm_buf_append_salt(), reached from
>   tpm2_start_auth_session -> tpm2_get_random -> hwrng_fillfn with no
>   userland action, then a NULL completion-pointer oops. Patched, the
>   same setup is KASAN-clean across repeated entropy polls: the worker
>   observes a live request and the free runs only after both KPP
>   operations complete. With no accelerator present, the synchronous
>   generic backend establishes sessions unchanged.
> 
>  drivers/char/tpm/tpm2-sessions.c | 45 ++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index c4da6fde748f4..f44646b26b192 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -489,15 +489,17 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
>  	sha256_final(&sctx, out);
>  }
>  
> -static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
> -				struct tpm2_auth *auth)
> +static int tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
> +			       struct tpm2_auth *auth)
>  {
>  	struct crypto_kpp *kpp;
>  	struct kpp_request *req;
> +	DECLARE_CRYPTO_WAIT(wait);
>  	struct scatterlist s[2], d[1];
>  	struct ecdh p = {0};
>  	u8 encoded_key[EC_PT_SZ], *x, *y;
>  	unsigned int buf_len;
> +	int rc;
>  
>  	/* secret is two sized points */
>  	tpm_buf_append_u16(buf, (EC_PT_SZ + 2)*2);
> @@ -520,14 +522,15 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
>  	kpp = crypto_alloc_kpp("ecdh-nist-p256", CRYPTO_ALG_INTERNAL, 0);
>  	if (IS_ERR(kpp)) {
>  		dev_err(&chip->dev, "crypto ecdh allocation failed\n");
> -		return;
> +		return PTR_ERR(kpp);
>  	}
>  
>  	buf_len = crypto_ecdh_key_len(&p);
>  	if (sizeof(encoded_key) < buf_len) {
>  		dev_err(&chip->dev, "salt buffer too small needs %d\n",
>  			buf_len);
> -		goto out;
> +		rc = -EINVAL;
> +		goto err_free_kpp;
>  	}
>  	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
>  	/* this generates a random private key */
> @@ -535,11 +538,17 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
>  
>  	/* salt is now the public point of this private key */
>  	req = kpp_request_alloc(kpp, GFP_KERNEL);
> -	if (!req)
> -		goto out;
> +	if (!req) {
> +		rc = -ENOMEM;
> +		goto err_free_kpp;
> +	}
> +	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				 crypto_req_done, &wait);
>  	kpp_request_set_input(req, NULL, 0);
>  	kpp_request_set_output(req, s, EC_PT_SZ*2);
> -	crypto_kpp_generate_public_key(req);
> +	rc = crypto_wait_req(crypto_kpp_generate_public_key(req), &wait);
> +	if (rc)
> +		goto err_free_req;
>  	/*
>  	 * we're not done: now we have to compute the shared secret
>  	 * which is our private key multiplied by the tpm_key public
> @@ -551,8 +560,9 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
>  	kpp_request_set_input(req, s, EC_PT_SZ*2);
>  	sg_init_one(d, auth->salt, EC_PT_SZ);
>  	kpp_request_set_output(req, d, EC_PT_SZ);
> -	crypto_kpp_compute_shared_secret(req);
> -	kpp_request_free(req);
> +	rc = crypto_wait_req(crypto_kpp_compute_shared_secret(req), &wait);
> +	if (rc)
> +		goto err_free_req;
>  
>  	/*
>  	 * pass the shared secret through KDFe for salt. Note salt
> @@ -562,8 +572,16 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
>  	 */
>  	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
>  
> - out:
> +	kpp_request_free(req);
>  	crypto_free_kpp(kpp);
> +	return 0;
> +
> +err_free_req:
> +	kpp_request_free(req);
> +
> +err_free_kpp:
> +	crypto_free_kpp(kpp);
> +	return rc;
>  }
>  
>  /**
> @@ -1018,7 +1036,12 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
>  
>  	/* append encrypted salt and squirrel away unencrypted in auth */
> -	tpm_buf_append_salt(&buf, chip, auth);
> +	rc = tpm_buf_append_salt(&buf, chip, auth);
> +	if (rc) {
> +		tpm2_flush_context(chip, null_key);
> +		tpm_buf_destroy(&buf);
> +		goto out;
> +	}
>  	/* session type (HMAC, audit or policy) */
>  	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
>  
> -- 
> 2.53.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you. I'll apply this shortly.

BR, Jarkko

