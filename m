Return-Path: <linux-integrity+bounces-3128-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB39593261F
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 14:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA891C219FA
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D2199E83;
	Tue, 16 Jul 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qusQUx39"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9B1CA9F;
	Tue, 16 Jul 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131437; cv=none; b=aGPEEde6z0NuX0mSG7sEqC2U61Z1Q9rF9R7/LVjUmz41pkU4IBwdePlocQD0hegTaenNNOw19XKbzy8kkvkOeD5u7CuT1YueUpyrEnckeniWGvilnavdE/HHNJ4CUg3KFLBSUYwiKdR/y1+hVXijPRZFMcQFGzyqAxedCcKiwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131437; c=relaxed/simple;
	bh=CEhChmNExFlWjpoTlqsZjg+P6U01v/5R13XBR7bKLkc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oT6+O7DSBvZ/oa1MJdCUYgKjyPP6XCZHGHvKwUq39CncPLwwXqdmlwH52WjOPwmVUHTI4QvkYpXYtuo9wCE5T+P+HzFvNcj1Z7EEoxiI5sI/6cXbZj2BDmxAWlNaO8UlMcGndwWQyhFnWBuzD2aZ+dj/cNo5yv9H/DJKw5PEAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qusQUx39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8EFC4AF10;
	Tue, 16 Jul 2024 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721131437;
	bh=CEhChmNExFlWjpoTlqsZjg+P6U01v/5R13XBR7bKLkc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qusQUx395YyCJGaOvfVW4cj2n3NjGPpYJvMK4bwlLaR9EE3ANR0Hf3+sz25dJGibL
	 M3xp5QnSpPpMmytzVck77P33oxgwEOQEDU7pWkR/9xkFufPoqnJ466akc/3HDNYqzA
	 hVN3hMslojmUTYnPAUjZv5umNLtbmOQPCpExotYFAQfOOybP0Aiuy/PjEc8HBSPPlG
	 kg0Th/EU2N3GDlopWTUObFB8MyJ1cFV6xeuzBdHJaSKvUb4O+mdlin0zZCW7wgxI8s
	 uwZU22CTjpkKXLBne6IbXAoyO1POI7oSl63B5Tnvsv6IQKW6JGsixyHBPFa6nYM+wa
	 hH5xmeF8Y5q7g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 15:03:54 +0300
Message-Id: <D2QY69RSKFCZ.3XQBFXTL69A@kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 6/6] KEYS: trusted: add support for TPM keys with signed
 policy
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-7-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524130459.21510-7-James.Bottomley@HansenPartnership.com>

On Fri May 24, 2024 at 4:04 PM EEST, James Bottomley wrote:
> Signed policy allows key policies to be modified after the TPM key is
> created, provided the new policy is signed with a private key whose
> public part is encoded into the initial policy.  How this works is
> described in
>
> https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
>
> Since this means that the key structure now contains public keys and
> signatures, the maximum blob size has to be expanded simply to
> accommodate a key with several policies.  The code assumes (as does
> all other signed policy engines) that the first policy is the most
> likely one to succeed, so it tries all the available signed policies
> in first to last order and loads the key when one of them succeeds.
>
> This code allows the kernel to process signed policy keys correctly,
> it does not allow the kernel to create them.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm2-sessions.c          |   6 +
>  include/keys/trusted-type.h               |   3 +-
>  include/linux/tpm.h                       |   6 +
>  security/keys/trusted-keys/tpm2-policy.c  | 473 ++++++++++++++++------
>  security/keys/trusted-keys/tpm2-policy.h  |  19 +-
>  security/keys/trusted-keys/tpm2key.asn1   |  12 +-
>  security/keys/trusted-keys/trusted_tpm2.c |  63 +--
>  7 files changed, 434 insertions(+), 148 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 63c175b2165c..c2b73283c46f 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1365,3 +1365,9 @@ int tpm2_sessions_init(struct tpm_chip *chip)
> =20
>  	return rc;
>  }
> +
> +struct crypto_shash *tpm2_get_policy_hash(struct tpm_chip *chip)
> +{
> +	return chip->auth->tfm;
> +}

Please open code.


> +EXPORT_SYMBOL(tpm2_get_policy_hash);
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 5d1d481a8a19..a6999800055e 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -19,11 +19,12 @@
> =20
>  #define MIN_KEY_SIZE			32
>  #define MAX_KEY_SIZE			128
> -#define MAX_BLOB_SIZE			512
> +#define MAX_BLOB_SIZE			4096
>  #define MAX_PCRINFO_SIZE		128
>  #define MAX_DIGEST_SIZE			64
> =20
>  #define TPM2_MAX_POLICIES		16
> +#define TPM2_MAX_AUTHS			8
> =20
>  struct trusted_key_payload {
>  	struct rcu_head rcu;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 894e51a7fe3a..09f14482675b 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -290,6 +290,8 @@ enum tpm2_command_codes {
>  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
>  	TPM2_CC_CONTEXT_SAVE	        =3D 0x0162,
>  	TPM2_CC_FLUSH_CONTEXT	        =3D 0x0165,
> +	TPM2_CC_LOAD_EXTERNAL		=3D 0x0167,
> +	TPM2_CC_POLICY_AUTHORIZE	=3D 0x016A,
>  	TPM2_CC_POLICY_AUTHVALUE	=3D 0x016B,
>  	TPM2_CC_POLICY_COUNTER_TIMER	=3D 0x016D,
>  	TPM2_CC_READ_PUBLIC		=3D 0x0173,
> @@ -299,14 +301,17 @@ enum tpm2_command_codes {
>  	TPM2_CC_GET_RANDOM	        =3D 0x017B,
>  	TPM2_CC_PCR_READ	        =3D 0x017E,
>  	TPM2_CC_POLICY_PCR		=3D 0x017F,
> +	TPM2_CC_POLICY_RESTART		=3D 0x0180,
>  	TPM2_CC_PCR_EXTEND	        =3D 0x0182,
>  	TPM2_CC_EVENT_SEQUENCE_COMPLETE =3D 0x0185,
>  	TPM2_CC_HASH_SEQUENCE_START     =3D 0x0186,
> +	TPM2_CC_POLICY_GET_DIGEST	=3D 0x0189,
>  	TPM2_CC_CREATE_LOADED           =3D 0x0191,
>  	TPM2_CC_LAST		        =3D 0x0193, /* Spec 1.36 */
>  };
> =20
>  enum tpm2_permanent_handles {
> +	TPM2_RH_OWNER		=3D 0x40000001,
>  	TPM2_RH_NULL		=3D 0x40000007,
>  	TPM2_RS_PW		=3D 0x40000009,
>  };
> @@ -578,6 +583,7 @@ static inline void tpm_buf_append_empty_auth(struct t=
pm_buf *buf, u32 handle)
> =20
>  int tpm2_start_auth_session(struct tpm_chip *chip);
>  int tpm2_start_policy_session(struct tpm_chip *chip, u32 *handle, u8 has=
h);
> +struct crypto_shash *tpm2_get_policy_hash(struct tpm_chip *chip);
>  void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  			 u32 handle, u8 *name);
>  void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *=
buf,
> diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/tru=
sted-keys/tpm2-policy.c
> index c0508cb95923..f9ee57fed8fe 100644
> --- a/security/keys/trusted-keys/tpm2-policy.c
> +++ b/security/keys/trusted-keys/tpm2-policy.c
> @@ -28,13 +28,28 @@ int tpm2_key_code(void *context, size_t hdrlen,
>  	u32 code =3D 0;
>  	const u8 *v =3D value;
>  	int i;
> +	u8 a =3D ctx->auth_policies;
> =20
>  	for (i =3D 0; i < vlen; i++) {
>  		code <<=3D 8;
>  		code |=3D v[i];
>  	}
> =20
> -	ctx->policy_code[ctx->policy_count] =3D code;
> +	ctx->policy_code[a][ctx->policy_count[a]] =3D code;
> +
> +	return 0;
> +}
> +
> +int tpm2_pol_seq(void *context, size_t hdrlen,
> +		 unsigned char tag,
> +		 const void *value, size_t vlen)
> +{
> +	struct tpm2_key_context *ctx =3D context;
> +
> +	ctx->auth_policies++;
> +
> +	if (ctx->auth_policies > TPM2_MAX_AUTHS)
> +		return -EINVAL;
> =20
>  	return 0;
>  }
> @@ -44,9 +59,15 @@ int tpm2_key_policy(void *context, size_t hdrlen,
>  		  const void *value, size_t vlen)
>  {
>  	struct tpm2_key_context *ctx =3D context;
> +	u8 a =3D ctx->auth_policies;
> +	u8 policy_count =3D ctx->policy_count[a]++;
> +
> +	if (policy_count >=3D TPM2_MAX_POLICIES)
> +		return -EINVAL;
> =20
> -	ctx->policies[ctx->policy_count] =3D value;
> -	ctx->policy_len[ctx->policy_count++] =3D vlen;
> +	ctx->policies[a][policy_count] =3D value;
> +	ctx->policy_len[a][policy_count] =3D vlen;
> +	ctx->policy_tot_len +=3D vlen;
> =20
>  	return 0;
>  }
> @@ -56,21 +77,24 @@ int tpm2_key_policy(void *context, size_t hdrlen,
>   */
>  static int tpm2_validate_policy(struct tpm2_policies *pols)
>  {
> -	int i;
> +	int i, j;
> =20
> -	if (pols->count =3D=3D 0)
> +	if (pols->auths =3D=3D 0)
>  		return 0;
> =20
> -	for (i =3D 0; i < pols->count; i++) {
> -		switch (pols->code[i]) {
> -		case TPM2_CC_POLICY_COUNTER_TIMER:
> -		case TPM2_CC_POLICY_PCR:
> -		case TPM2_CC_POLICY_AUTHVALUE:
> -			break;
> -		default:
> -			pr_info("tpm2 policy 0x%x is unsupported\n",
> -				pols->code[i]);
> +	for (i =3D 0; i < pols->auths; i++) {
> +		for (j =3D 0; j < pols->count[i]; j++) {
> +			switch (pols->code[i][j]) {
> +			case TPM2_CC_POLICY_COUNTER_TIMER:
> +			case TPM2_CC_POLICY_PCR:
> +			case TPM2_CC_POLICY_AUTHVALUE:
> +			case TPM2_CC_POLICY_AUTHORIZE:
> +				break;
> +			default:
> +				pr_info("tpm2 policy 0x%x is unsupported\n",
> +					pols->code[i][j]);
>  			return -EINVAL;
> +			}
>  		}
>  	}
> =20
> @@ -89,36 +113,35 @@ static int tpm2_validate_policy(struct tpm2_policies=
 *pols)
>  int tpm2_key_policy_process(struct tpm2_key_context *ctx,
>  			    struct trusted_key_payload *payload)
>  {
> -	int tot_len =3D 0;
>  	u8 *buf;
> -	int i, ret, len =3D 0;
> +	int i, j, ret, len =3D 0;
>  	struct tpm2_policies *pols;
>  	u16 name_alg;
> =20
> -	if (ctx->policy_count =3D=3D 0)
> +	if (ctx->policy_tot_len =3D=3D 0)
>  		return 0;
> =20
> -	for (i =3D 0; i < ctx->policy_count; i++)
> -		tot_len +=3D ctx->policy_len[i];
> -	tot_len +=3D sizeof(*pols);
> -
> -	pols =3D kmalloc(tot_len, GFP_KERNEL);
> +	pols =3D kmalloc(ctx->policy_tot_len + sizeof(*pols), GFP_KERNEL);
>  	if (!pols)
>  		return -ENOMEM;
> =20
>  	payload->policies =3D pols;
>  	buf =3D (u8 *)(pols + 1);
> =20
> -	for (i =3D 0; i < ctx->policy_count; i++) {
> -		pols->policies[i] =3D &buf[len];
> -		pols->len[i] =3D ctx->policy_len[i];
> -		pols->code[i] =3D ctx->policy_code[i];
> -		if (pols->len[i])
> -			memcpy(pols->policies[i], ctx->policies[i],
> -			       ctx->policy_len[i]);
> -		len +=3D ctx->policy_len[i];
> +	for (i =3D 0; i < ctx->auth_policies; i++) {
> +		for (j =3D 0; j < ctx->policy_count[i]; j++) {
> +			pols->policies[i][j] =3D &buf[len];
> +			pols->len[i][j] =3D ctx->policy_len[i][j];
> +			pols->code[i][j] =3D ctx->policy_code[i][j];
> +			if (pols->len[i][j])
> +				memcpy(pols->policies[i][j],
> +				       ctx->policies[i][j],
> +				       ctx->policy_len[i][j]);
> +			len +=3D ctx->policy_len[i][j];
> +		}
> +		pols->count[i] =3D ctx->policy_count[i];
>  	}
> -	pols->count =3D ctx->policy_count;
> +	pols->auths =3D ctx->auth_policies;
> =20
>  	ret =3D tpm2_validate_policy(pols);
>  	if (ret)
> @@ -148,7 +171,7 @@ int tpm2_key_policy_process(struct tpm2_key_context *=
ctx,
>  int tpm2_generate_policy_digest(struct tpm2_policies *pols,
>  				u32 hash, u8 *policydigest, u32 *plen)
>  {
> -	int i;
> +	int i, j;
>  	struct crypto_shash *tfm;
>  	int rc;
> =20
> @@ -174,45 +197,47 @@ int tpm2_generate_policy_digest(struct tpm2_policie=
s *pols,
>  	/* policy digests always start out all zeros */
>  	memset(policydigest, 0, rc);
> =20
> -	for (i =3D 0; i < pols->count; i++) {
> -		u8 *policy =3D pols->policies[i];
> -		int len =3D pols->len[i];
> -		u32 cmd =3D pols->code[i];
> -		u8 digest[MAX_DIGEST_SIZE];
> -		u8 code[4];
> -		SHASH_DESC_ON_STACK(sdesc, tfm);
> +	for (i =3D 0; i < pols->auths; i++) {
> +		for (j =3D 0; j < pols->count[i]; j++) {
> +			u8 *policy =3D pols->policies[i][j];
> +			int len =3D pols->len[i][j];
> +			u32 cmd =3D pols->code[i][j];
> +			u8 digest[MAX_DIGEST_SIZE];
> +			u8 code[4];
> +			SHASH_DESC_ON_STACK(sdesc, tfm);
> =20
> -		sdesc->tfm =3D tfm;
> -		rc =3D crypto_shash_init(sdesc);
> -		if (rc)
> -			goto err;
> +			sdesc->tfm =3D tfm;
> +			rc =3D crypto_shash_init(sdesc);
> +			if (rc)
> +				goto err;
> =20
> -		/* first hash the previous digest */
> -		crypto_shash_update(sdesc, policydigest, *plen);
> +			/* first hash the previous digest */
> +			crypto_shash_update(sdesc, policydigest, *plen);
> =20
> -		/* then hash the command code */
> -		put_unaligned_be32(cmd, code);
> -		crypto_shash_update(sdesc, code, 4);
> +			/* then hash the command code */
> +			put_unaligned_be32(cmd, code);
> +			crypto_shash_update(sdesc, code, 4);
> =20
> -		/* commands that need special handling */
> -		if (cmd =3D=3D TPM2_CC_POLICY_COUNTER_TIMER) {
> -			SHASH_DESC_ON_STACK(sdesc1, tfm);
> +			/* commands that need special handling */
> +			if (cmd =3D=3D TPM2_CC_POLICY_COUNTER_TIMER) {
> +				SHASH_DESC_ON_STACK(sdesc1, tfm);
> =20
> -			sdesc1->tfm =3D tfm;
> +				sdesc1->tfm =3D tfm;
> =20
> -			/* counter timer policies are double hashed */
> -			crypto_shash_digest(sdesc1, policy, len,
> -					    digest);
> -			policy =3D digest;
> -			len =3D *plen;
> -		}
> +				/* counter timer policies are double hashed */
> +				crypto_shash_digest(sdesc1, policy, len,
> +						    digest);
> +				policy =3D digest;
> +				len =3D *plen;
> +			}
> =20
> -		if (len)
> -			crypto_shash_update(sdesc, policy, len);
> +			if (len)
> +				crypto_shash_update(sdesc, policy, len);
> =20
> -		/* now output the intermediate to the policydigest */
> -		crypto_shash_final(sdesc, policydigest);
> +			/* now output the intermediate to the policydigest */
> +			crypto_shash_final(sdesc, policydigest);
> =20
> +		}
>  	}
>  	rc =3D 0;
> =20
> @@ -228,41 +253,45 @@ int tpm2_encode_policy(struct tpm2_policies *pols, =
u8 **data, u32 *len)
>  	u8 *work =3D buf + SCRATCH_SIZE;
>  	u8 *ptr;
>  	u8 *end_work =3D work + SCRATCH_SIZE;
> -	int i, ret;
> +	int i, j, ret;
> =20
>  	if (!buf)
>  		return -ENOMEM;
> =20
> -	for (i =3D 0; i < pols->count; i++) {
> -		u8 *seq, *tag;
> -		u32 cmd =3D pols->code[i];
> +	for (i =3D 0; i < pols->auths; i++) {
> +		for (j =3D 0; j < pols->count[i]; j++) {
> +			u8 *seq, *tag;
> +			u32 cmd =3D pols->code[i][j];
> =20
> -		if (WARN(work - buf + 14 + pols->len[i] > 2 * SCRATCH_SIZE,
> -			 "BUG: scratch buffer is too small"))
> -			return -EINVAL;
> +			if (WARN(work - buf + 14 + pols->len[i][j] >
> +				 2 * SCRATCH_SIZE,
> +				 "BUG: scratch buffer is too small"))
> +				return -EINVAL;
> =20
> -		work =3D asn1_encode_sequence(work, end_work, NULL, -1);
> -		seq =3D work;
> +			work =3D asn1_encode_sequence(work, end_work, NULL, -1);
> +			seq =3D work;
> =20
> -		work =3D asn1_encode_tag(work, end_work, 0, NULL, -1);
> -		tag =3D work;
> +			work =3D asn1_encode_tag(work, end_work, 0, NULL, -1);
> +			tag =3D work;
> =20
> -		work =3D asn1_encode_integer(work, end_work, cmd);
> -		asn1_encode_tag(tag, end_work, 0, NULL, work - tag);
> +			work =3D asn1_encode_integer(work, end_work, cmd);
> +			asn1_encode_tag(tag, end_work, 0, NULL, work - tag);
> =20
> -		work =3D asn1_encode_tag(work, end_work, 1, NULL, -1);
> -		tag =3D work;
> +			work =3D asn1_encode_tag(work, end_work, 1, NULL, -1);
> +			tag =3D work;
> =20
> -		work =3D asn1_encode_octet_string(work, end_work,
> -						pols->policies[i],
> -						pols->len[i]);
> +			work =3D asn1_encode_octet_string(work, end_work,
> +							pols->policies[i][j],
> +							pols->len[i][j]);
> =20
> -		asn1_encode_tag(tag, end_work, 1, NULL, work - tag);
> +			asn1_encode_tag(tag, end_work, 1, NULL, work - tag);
> =20
> -		seq =3D asn1_encode_sequence(seq, end_work, NULL, work - seq);
> -		if (IS_ERR(seq)) {
> -			ret =3D PTR_ERR(seq);
> -			goto err;
> +			seq =3D asn1_encode_sequence(seq, end_work, NULL,
> +						   work - seq);
> +			if (IS_ERR(seq)) {
> +				ret =3D PTR_ERR(seq);
> +				goto err;
> +			}
>  		}
>  	}
>  	ptr =3D asn1_encode_sequence(buf, buf + SCRATCH_SIZE, buf + PAGE_SIZE,
> @@ -282,18 +311,131 @@ int tpm2_encode_policy(struct tpm2_policies *pols,=
 u8 **data, u32 *len)
>  	return ret;
>  }
> =20
> -int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies =
*pols)
> +static int tpm2_policy_restart(struct tpm_chip *chip, u32 handle)
>  {
> -	int i, rc;
> -	u32 handle;
> -	const char *failure;
> +	struct tpm_buf buf;
> +	int rc;
> =20
> -	rc =3D tpm2_start_policy_session(chip, &handle, pols->hash);
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_POLICY_RESTART);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_append_u32(&buf, handle);
> +
> +	rc =3D tpm_transmit_cmd(chip, &buf, 0, "restarting policy");
> +	tpm_buf_destroy(&buf);
> +	if (rc) {
> +		pr_notice("TPM policy restart failed, rc=3D%d\n", rc);
> +		return -EPERM;
> +	}
> +	return 0;
> +}
> +
> +static int tpm2_policy_gettkhash(struct tpm_chip *chip, u8 *pubkey, u8 *=
nonce,
> +				 u8 *signature, int siglen,
> +				 u32 handle, u8 **hash, u8 **name,
> +				 u8 **ticket)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +	int len;
> +	u32 sigkey;
> +	off_t offset;
> +	SHASH_DESC_ON_STACK(sdesc, tpm2_get_policy_hash(chip));
> +
> +	sdesc->tfm =3D tpm2_get_policy_hash(chip);
> +
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_POLICY_GET_DIGES=
T);
>  	if (rc)
>  		return rc;
> =20
> -	for (i =3D 0; i < pols->count; i++) {
> -		u32 cmd =3D pols->code[i];
> +	tpm_buf_append_u32(&buf, handle);
> +
> +	rc =3D tpm_transmit_cmd(chip, &buf, 0, "getting policy hash");
> +	if (rc)
> +		goto out;
> +	len =3D get_unaligned_be16(&buf.data[TPM_HEADER_SIZE]) + 2;
> +	rc =3D -ENOMEM;
> +	*hash =3D kmalloc(len, GFP_KERNEL);
> +	if (!*hash)
> +		goto out;
> +	memcpy(*hash, &buf.data[TPM_HEADER_SIZE], len);
> +
> +	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_LOAD_EXTERNAL);
> +
> +	/* empty sensitive */
> +	tpm_buf_append_u16(&buf, 0);
> +	/* TPM2B_PUBLIC */
> +	len =3D get_unaligned_be16(pubkey) + 2;
> +	tpm_buf_append(&buf, pubkey, len);
> +	/* hierarchy (use null because never a password) */
> +	tpm_buf_append_u32(&buf, TPM2_RH_OWNER);
> +
> +	rc =3D tpm_transmit_cmd(chip, &buf, 4, "loading external key");
> +	if (rc)
> +		goto out;
> +
> +	offset =3D TPM_HEADER_SIZE;
> +	sigkey =3D tpm_buf_read_u32(&buf, &offset);
> +	len =3D get_unaligned_be16(&buf.data[offset]) + 2;
> +	*name =3D kmalloc(len, GFP_KERNEL);
> +	if (!*name) {
> +		tpm2_flush_context(chip, sigkey);
> +		rc =3D -ENOMEM;
> +		goto out;
> +	}
> +	memcpy(*name, &buf.data[offset], len);
> +
> +	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_VERIFY_SIGNATURE);
> +	/* handle of public key to verify with */
> +	tpm_buf_append_u32(&buf, sigkey);
> +	/* digest hash(policy||nonce) */
> +	len =3D get_unaligned_be16(*hash);
> +	tpm_buf_append_u16(&buf, len);
> +	/* now compute the signed data which is hash(policy||nonce) */
> +	crypto_shash_init(sdesc);
> +	len =3D get_unaligned_be16(*hash); /* better be the tfm hash size */
> +	crypto_shash_update(sdesc, *hash + 2, len);
> +	len =3D get_unaligned_be16(nonce);
> +	crypto_shash_update(sdesc, nonce + 2, len);
> +	crypto_shash_final(sdesc, &buf.data[buf.length]);
> +	buf.length +=3D len;
> +	/* signature */
> +	tpm_buf_append(&buf, signature, siglen);
> +
> +	rc =3D tpm_transmit_cmd(chip, &buf, 4, "verifying signature");
> +	tpm2_flush_context(chip, sigkey);
> +	if (rc)
> +		goto out;
> +
> +	len =3D tpm_buf_length(&buf) - TPM_HEADER_SIZE;
> +	*ticket =3D kmalloc(len, GFP_KERNEL);
> +	if (!*ticket) {
> +		rc =3D -ENOMEM;
> +		goto out;
> +	}
> +	memcpy(*ticket, &buf.data[TPM_HEADER_SIZE], len);
> +
> + out:
> +	if (rc) {
> +		kfree(*hash);
> +		*hash =3D NULL;
> +		kfree(*name);
> +		*name =3D NULL;
> +	}
> +	tpm_buf_destroy(&buf);
> +	return rc;
> +}
> +
> +
> +static int tpm2_try_policy(struct tpm_chip *chip, struct tpm2_policies *=
pols,
> +			   u32 handle, int p)
> +{
> +	int i, rc;
> +	const char *failure;
> +
> +	for (i =3D 0; i < pols->count[p]; i++) {
> +		u32 cmd =3D pols->code[p][i];
>  		struct tpm_buf buf;
> =20
>  		rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, cmd);
> @@ -311,10 +453,11 @@ int tpm2_get_policy_session(struct tpm_chip *chip, =
struct tpm2_policies *pols)
>  			 * policy command
>  			 */
>  			tpm_buf_append_u16(&buf, pols->hash_size);
> -			tpm_buf_append(&buf, pols->policies[i] + pols->len[i] -
> +			tpm_buf_append(&buf, pols->policies[p][i]
> +				       + pols->len[p][i] -
>  				       pols->hash_size, pols->hash_size);
> -			tpm_buf_append(&buf, pols->policies[i],
> -				       pols->len[i] - pols->hash_size);
> +			tpm_buf_append(&buf, pols->policies[p][i],
> +				       pols->len[p][i] - pols->hash_size);
>  			break;
> =20
>  		case TPM2_CC_POLICY_COUNTER_TIMER: {
> @@ -324,26 +467,82 @@ int tpm2_get_policy_session(struct tpm_chip *chip, =
struct tpm2_policies *pols)
>  			 * respectively.  The rest is operandB which
>  			 * must be zero padded in a hash digest
>  			 */
> -			u16 opb_len =3D pols->len[i] - 4;
> +			u16 opb_len =3D pols->len[p][i] - 4;
> =20
>  			if (opb_len > pols->hash_size)
>  				return -EINVAL;
> =20
>  			tpm_buf_append_u16(&buf, opb_len);
> -			tpm_buf_append(&buf, pols->policies[i], opb_len);
> +			tpm_buf_append(&buf, pols->policies[p][i], opb_len);
> =20
>  			/* offset and operand*/
> -			tpm_buf_append(&buf, pols->policies[i] + opb_len, 4);
> +			tpm_buf_append(&buf, pols->policies[p][i] + opb_len, 4);
>  			failure =3D "Counter Timer";
> =20
>  			break;
>  		}
> +		case TPM2_CC_POLICY_AUTHORIZE: {
> +			u8 *pubkey =3D pols->policies[p][i];
> +			u8 *nonce;
> +			u8 *signature;
> +			u8 *ticket =3D NULL;
> +			u8 *hash =3D NULL;
> +			u8 *name =3D NULL;
> +			int len, siglen;
> +			const int maxlen =3D pols->len[p][i];
> +
> +			if (i =3D=3D 0)
> +				/*
> +				 * If this is the first policy then skip
> +				 * because we should already have executed
> +				 * a successful PolicyAuthorize before getting
> +				 * here
> +				 */
> +				continue;
> +
> +			len =3D get_unaligned_be16(pubkey);
> +			if (len + 2 > maxlen) {
> +				failure =3D "malformed policy";
> +				break;
> +			}
> +			nonce =3D pubkey + len + 2;
> +			len =3D get_unaligned_be16(nonce);
> +			if (len + 2 > maxlen) {
> +				failure =3D "malformed policy";
> +				break;
> +			}
> +			signature =3D nonce + len + 2;
> +			siglen =3D pubkey + maxlen - signature;
> +			failure =3D "policy authorize";
> +			rc =3D tpm2_policy_gettkhash(chip, pubkey, nonce,
> +						   signature, siglen,
> +						   handle, &hash,
> +						   &name, &ticket);
> +			if (rc)
> +				break;
> +			len =3D get_unaligned_be16(hash);
> +			tpm_buf_append(&buf, hash, len + 2);
> +			kfree(hash);
> +
> +			len =3D get_unaligned_be16(nonce);
> +			tpm_buf_append(&buf, nonce, len + 2);
> +
> +			len =3D get_unaligned_be16(name);
> +			tpm_buf_append(&buf, name, len + 2);
> +			kfree(name);
> +
> +			len =3D get_unaligned_be16(ticket + 6) + 8;
> +			tpm_buf_append(&buf, ticket, len);
> +			kfree(ticket);
> +
> +			break;
> +		}
> =20
>  		default:
>  			failure =3D "unknown policy";
> -			if (pols->len[i])
> -				tpm_buf_append(&buf, pols->policies[i],
> -					       pols->len[i]);
> +			if (pols->len[p][i])
> +				tpm_buf_append(&buf, pols->policies[p][i],
> +					       pols->len[p][i]);
> =20
>  			break;
>  		}
> @@ -353,14 +552,62 @@ int tpm2_get_policy_session(struct tpm_chip *chip, =
struct tpm2_policies *pols)
>  		if (rc) {
>  			pr_notice("TPM policy %s failed, rc=3D%d\n",
>  				  failure, rc);
> -			tpm2_end_auth_session(chip);
> -			return -EPERM;
> +			return rc;
>  		}
>  	}
> -
>  	return 0;
>  }
> =20
> +int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies =
*pols)
> +{
> +	int rc;
> +	u32 handle;
> +
> +	if (pols->code[0][0] =3D=3D TPM2_CC_POLICY_AUTHORIZE &&
> +	    pols->auths =3D=3D 1) {
> +		pr_notice("TPM Key requires signed policies but has none\n");
> +		return -EINVAL;
> +	}
> +
> +	rc =3D tpm2_start_policy_session(chip, &handle, pols->hash);
> +	if (rc)
> +		return rc;
> +
> +	if (pols->code[0][0] =3D=3D TPM2_CC_POLICY_AUTHORIZE) {
> +		int p;
> +
> +		for (p =3D 1; p < pols->auths; p++) {
> +			if (p !=3D 1) {
> +				/* restart policy if looping */
> +				rc =3D tpm2_policy_restart(chip, handle);
> +				if (rc)
> +					goto out;
> +			}
> +
> +			rc =3D tpm2_try_policy(chip, pols, handle, p);
> +			if (rc) {
> +				pr_notice("TPM signed policy %d failed\n", p);
> +			} else {
> +				pr_notice("TPM signed policy %d succeeded\n",
> +					  p);
> +				break;
> +			}
> +		}
> +		if (rc)
> +			/* no signed policies succeeded */
> +			goto out;
> +	}
> +
> +	rc =3D tpm2_try_policy(chip, pols, handle, 0);
> + out:
> +	if (rc) {
> +		rc =3D -EPERM;
> +		tpm2_end_auth_session(chip);
> +	}
> +
> +	return rc;
> +}
> +
>  int tpm2_parse_policies(struct tpm2_policies **ppols, char *str)
>  {
>  	struct tpm2_policies *pols;
> @@ -379,22 +626,22 @@ int tpm2_parse_policies(struct tpm2_policies **ppol=
s, char *str)
>  		if (*p =3D=3D '\0' || *p =3D=3D '\n')
>  			continue;
> =20
> -		pols->len[i] =3D strlen(p)/2;
> -		if (pols->len[i] > left) {
> +		pols->len[0][i] =3D strlen(p)/2;
> +		if (pols->len[0][i] > left) {
>  			res =3D -E2BIG;
>  			goto err;
>  		}
> =20
> -		res =3D hex2bin(ptr, p, pols->len[i]);
> +		res =3D hex2bin(ptr, p, pols->len[0][i]);
>  		if (res)
>  			goto err;
> =20
>  		/* get command code and skip past */
> -		pols->code[i] =3D get_unaligned_be32(ptr);
> -		pols->policies[i] =3D ptr + 4;
> -		ptr +=3D pols->len[i];
> -		left -=3D pols->len[i];
> -		pols->len[i] -=3D 4;
> +		pols->code[0][i] =3D get_unaligned_be32(ptr);
> +		pols->policies[0][i] =3D ptr + 4;
> +		ptr +=3D pols->len[0][i];
> +		left -=3D pols->len[0][i];
> +		pols->len[0][i] -=3D 4;
> =20
>  		/*
>  		 * FIXME: this does leave the code embedded in dead
> @@ -404,7 +651,7 @@ int tpm2_parse_policies(struct tpm2_policies **ppols,=
 char *str)
>  		i++;
>  	}
> =20
> -	pols->count =3D i;
> +	pols->count[0] =3D i;
>  	*ppols =3D pols;
> =20
>  	return 0;
> diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/tru=
sted-keys/tpm2-policy.h
> index 8ddf235b3fec..da0ab99078b8 100644
> --- a/security/keys/trusted-keys/tpm2-policy.h
> +++ b/security/keys/trusted-keys/tpm2-policy.h
> @@ -6,17 +6,20 @@ struct tpm2_key_context {
>  	u32 pub_len;
>  	const u8 *priv;
>  	u32 priv_len;
> -	const u8 *policies[TPM2_MAX_POLICIES];
> -	u32 policy_code[TPM2_MAX_POLICIES];
> -	u16 policy_len[TPM2_MAX_POLICIES];
> -	u8 policy_count;
> +	const u8 *policies[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
> +	u32 policy_code[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
> +	u16 policy_len[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
> +	u8 policy_count[TPM2_MAX_AUTHS];
> +	u8 auth_policies;
> +	int policy_tot_len;
>  };
> =20
>  struct tpm2_policies {
> -	u32 code[TPM2_MAX_POLICIES];
> -	u8 *policies[TPM2_MAX_POLICIES];
> -	u16 len[TPM2_MAX_POLICIES];
> -	u8 count;
> +	u32 code[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
> +	u8 *policies[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
> +	u16 len[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
> +	u8 count[TPM2_MAX_AUTHS];
> +	u8 auths;
>  	int hash;		/* crypto not TPM hash algorithm */
>  	u16 hash_size;
>  };
> diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trus=
ted-keys/tpm2key.asn1
> index 1684bd8f725e..c5a68b3e354f 100644
> --- a/security/keys/trusted-keys/tpm2key.asn1
> +++ b/security/keys/trusted-keys/tpm2key.asn1
> @@ -5,12 +5,13 @@
>  ---       However, the Linux asn.1 parser doesn't understand
>  ---       [2] EXPLICIT SEQUENCE OF OPTIONAL
>  ---       So there's an extra intermediate TPMPolicySequence
> ----       definition to work around this
> +---       and TPMAuthPolicySequence definitions to work around this
> =20
>  TPMKey ::=3D SEQUENCE {
>  	type		OBJECT IDENTIFIER ({tpm2_key_type}),
>  	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> -	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL,
> +	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL ({tpm2_pol_seq}),
> +	authPolicy	[3] EXPLICIT TPMAuthPolicySequence OPTIONAL,
>  	parent		INTEGER ({tpm2_key_parent}),
>  	pubkey		OCTET STRING ({tpm2_key_pub}),
>  	privkey		OCTET STRING ({tpm2_key_priv})
> @@ -22,3 +23,10 @@ TPMPolicy ::=3D SEQUENCE {
>  	commandCode		[0] EXPLICIT INTEGER ({tpm2_key_code}),
>  	commandPolicy		[1] EXPLICIT OCTET STRING ({tpm2_key_policy})
>  	}
> +
> +TPMAuthPolicySequence ::=3D SEQUENCE OF TPMAuthPolicy ({tpm2_pol_seq})
> +
> +TPMAuthPolicy ::=3D SEQUENCE {
> +	name		[0] EXPLICIT UTF8String OPTIONAL,
> +	policy		[1] EXPLICIT TPMPolicySequence
> +	}
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index 64c922bbc36c..e2d937e44274 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -98,38 +98,45 @@ static int tpm2_key_decode(struct trusted_key_payload=
 *payload,
>  			   u8 **buf)
>  {
>  	int ret;
> -	struct tpm2_key_context ctx;
> +	struct tpm2_key_context *ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	u8 *blob;
> =20
> -	memset(&ctx, 0, sizeof(ctx));
> +	if (!ctx)
> +		return -ENOMEM;
> =20
> -	ret =3D asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
> +	ret =3D asn1_ber_decoder(&tpm2key_decoder, ctx, payload->blob,
>  			       payload->blob_len);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
> =20
> -	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> -		return -EINVAL;
> +	if (ctx->priv_len + ctx->pub_len > MAX_BLOB_SIZE) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> =20
> -	blob =3D kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> -	if (!blob)
> -		return -ENOMEM;
> +	blob =3D kmalloc(ctx->priv_len + ctx->pub_len + 4, GFP_KERNEL);
> +	if (!blob) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> =20
> -	ret =3D tpm2_key_policy_process(&ctx, payload);
> +	ret =3D tpm2_key_policy_process(ctx, payload);
>  	if (ret) {
>  		kfree(blob);
> -		return ret;
> +		goto out;
>  	}
> =20
>  	*buf =3D blob;
> -	options->keyhandle =3D ctx.parent;
> +	options->keyhandle =3D ctx->parent;
> =20
> -	memcpy(blob, ctx.priv, ctx.priv_len);
> -	blob +=3D ctx.priv_len;
> +	memcpy(blob, ctx->priv, ctx->priv_len);
> +	blob +=3D ctx->priv_len;
> =20
> -	memcpy(blob, ctx.pub, ctx.pub_len);
> +	memcpy(blob, ctx->pub, ctx->pub_len);
> =20
> -	return 0;
> + out:
> +	kfree(ctx);
> +	return ret;
>  }
> =20
>  int tpm2_key_parent(void *context, size_t hdrlen,
> @@ -264,7 +271,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		pols =3D kmalloc(POLICY_SIZE, GFP_KERNEL);
>  		if (!pols)
>  			return -ENOMEM;
> -		pols->count =3D 0;
> +		pols->count[0] =3D 0;
> +		pols->auths =3D 1;
>  		payload->policies =3D pols;
>  		scratch =3D (u8 *)(pols + 1);
>  	}
> @@ -275,10 +283,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		/* 4 array len */
>  		const int len =3D 4 + options->pcrinfo_len;
> =20
> -		i =3D pols->count++;
> -		pols->len[i] =3D len;
> -		pols->policies[i] =3D scratch;
> -		pols->code[i] =3D TPM2_CC_POLICY_PCR;
> +		i =3D pols->count[0]++;
> +		pols->len[0][i] =3D len;
> +		pols->policies[0][i] =3D scratch;
> +		pols->code[0][i] =3D TPM2_CC_POLICY_PCR;
> =20
>  		/* only a single TPMS_PCR_SELECTION */
>  		put_unaligned_be32(1, &scratch[0]);
> @@ -300,11 +308,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		int i;
> =20
>  		pols =3D payload->policies;
> -		i =3D pols->count++;
> +		i =3D pols->count[0]++;
> =20
>  		/* the TPM2_PolicyPassword command has no payload */
> -		pols->len[i] =3D 0;
> -		pols->code[i] =3D TPM2_CC_POLICY_AUTHVALUE;
> +		pols->len[0][i] =3D 0;
> +		pols->code[0][i] =3D TPM2_CC_POLICY_AUTHVALUE;
>  	}
> =20
>  	if (payload->policies) {
> @@ -685,6 +693,13 @@ int __weak tpm2_key_code(void *context, size_t hdrle=
n,
>  	return -EINVAL;
>  }
> =20
> +int __weak tpm2_pol_seq(void *context, size_t hdrlen,
> +			unsigned char tag,
> +			const void *value, size_t vlen)
> +{
> +	return -EINVAL;
> +}
> +
>  int __weak tpm2_key_policy(void *context, size_t hdrlen,
>  		  unsigned char tag,
>  		  const void *value, size_t vlen)

BR, Jarkko

