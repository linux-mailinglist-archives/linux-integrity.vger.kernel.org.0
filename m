Return-Path: <linux-integrity+bounces-9701-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AANyIaIxGmp+2AgAu9opvQ
	(envelope-from <linux-integrity+bounces-9701-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 30 May 2026 02:38:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AF60A349
	for <lists+linux-integrity@lfdr.de>; Sat, 30 May 2026 02:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C1AA300AB11
	for <lists+linux-integrity@lfdr.de>; Sat, 30 May 2026 00:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33051A5BAE;
	Sat, 30 May 2026 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ80oYQf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651B185B48;
	Sat, 30 May 2026 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101045; cv=none; b=lH+AOo0UIBegUvq+Aq86i+67K+a16bRn/uVSWmBhV2/J9zyUgRJ51g6ziJtyLdDprdXyMYm7Z3QKEV5ElDnsj6mkdeLS2w7pgqvGYlp6cIqsO/fn/Hz4bMJBLz8vXW3Dd7fZVZyo5Ohd8sQovZ7J5JL17Kwn09QtBtx1fzXnjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101045; c=relaxed/simple;
	bh=hf5vLWK44D61F4E5sJP0UG78k4AZAIR+Uwq9t7nH/fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4+1qcgbAzgg82iCNHQaB3mzO8VXpIMfaHpL9QkQeUPzoRRJ2pbff4mGb7piHqWsGA7SNRnjkflUGsjkjswQRB6okAu1Dzkg0rT+Sps/axYG/KM1QeAoxUOvGgCdA0KmL4Qr/k48DGq6lHaSgRqGgIItIzXooKWWfVlNxwZ/xFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ80oYQf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BECB21F00893;
	Sat, 30 May 2026 00:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101044;
	bh=6eI4zy4Tq766zXKoZs9XoR7a/knH/HX/boy0n1H0AOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iQ80oYQfARSQHoqXSPBGldklrCgaGUyCDgCZnKAO1puTJ4kQCnhVU4vZ+o0buzGrl
	 16g0/4fvolxEQWMgedD9TRFYhaM94+MnyG3zQgH1eDnH3VZqA0N2slY7fSdM05so+V
	 OUTlRfcyo6e5ZK7GwUF1zLK0Zhj3ak6Q7mqXyloQMym/Ex4mI4EvVA425PjLCDfEoH
	 ywt044WBwx7ep8Vh8ouChRLgfyrWxDugZLn6ptqOwxKlNwZFOxD18ifUN6UecNlAxh
	 xMhklPSV0MiaDInxxDa7bDUFnE54njc1bPolpKplyBGdpmhsGebtuS9LhUGwYmVPa9
	 MrCgPsA7ulGJA==
Date: Sat, 30 May 2026 03:30:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm2-sessions: wait for async KPP completion in
 tpm_buf_append_salt
Message-ID: <ahovsOJ6Vbdx_XEQ@kernel.org>
References: <20260527184655.1919993-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527184655.1919993-1-michael.bommarito@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9701-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: DA2AF60A349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 02:46:55PM -0400, Michael Bommarito wrote:
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> 
> Impact: on a kernel with an async ECDH KPP provider, any local user
> can reclaim the freed kpp_request slab slot and control the indirect
> call through req->base.complete. A reproducer is available on request.
> Filing publicly per security-bugs.rst guidance.

Please send the reproducer and .config although I think I grasped
what I need to put but just in case (if only for comparison).

> 
> Notes:
> 
>     Validation (QEMU x86_64, swtpm, async ecdh-nist-p256 stub backend):
>     
>     Stock kernel: the freed kpp_request is reclaimed by an unprivileged
>     heap spray; the deferred completion worker jumps to a controlled
>     address (RIP=0x41414141) via the overwritten req->base.complete
>     callback pointer. Reproduces on production-hardened allocator
>     configs (MEMCG, RANDOM_KMALLOC_CACHES, SLAB_FREELIST_HARDENED,
>     SLAB_FREELIST_RANDOM, INIT_ON_FREE).
>     
>     Patched kernel: crypto_wait_req() blocks until the async backend
>     completes; the worker observes a live request with the correct
>     crypto_req_done callback installed; kpp_request_free() runs only
>     after both operations finish. KASAN-clean across 50 entropy polls.
> 
>  drivers/char/tpm/tpm2-sessions.c | 36 ++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index c4da6fde748f4..a23cc3a540c55 100644
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
> @@ -520,13 +522,14 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
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
> +		rc = -EINVAL;
>  		goto out;
>  	}
>  	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
> @@ -535,11 +538,17 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
>  
>  	/* salt is now the public point of this private key */
>  	req = kpp_request_alloc(kpp, GFP_KERNEL);
> -	if (!req)
> +	if (!req) {
> +		rc = -ENOMEM;
>  		goto out;
> +	}
> +	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				 crypto_req_done, &wait);
>  	kpp_request_set_input(req, NULL, 0);
>  	kpp_request_set_output(req, s, EC_PT_SZ*2);
> -	crypto_kpp_generate_public_key(req);
> +	rc = crypto_wait_req(crypto_kpp_generate_public_key(req), &wait);
> +	if (rc)
> +		goto out_free_req;
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
> +		goto out_free_req;
>  
>  	/*
>  	 * pass the shared secret through KDFe for salt. Note salt
> @@ -562,8 +572,11 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
>  	 */
>  	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
>  
> - out:
> +out_free_req:
> +	kpp_request_free(req);
> +out:
>  	crypto_free_kpp(kpp);
> +	return rc;
>  }
>  
>  /**
> @@ -1018,7 +1031,12 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
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
> 

BR, Jarkko

