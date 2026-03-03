Return-Path: <linux-integrity+bounces-8882-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOvNCZ5Wp2lsgwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8882-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:46:06 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0EA1F7B48
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5F4306F38F
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2026 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E26436DA05;
	Tue,  3 Mar 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnyD+SAb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBA3932C6;
	Tue,  3 Mar 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574362; cv=none; b=MOaQ5fwdIX2Dv7rScZj3WuTIBE1VR+YMqYafiTNzLWXtXVevgcKRA67aXvdOk22SlD3NfWXlycG2soSgtQTU8TiZToiEdl//Fk8VOIFg9FFQ+o+vh8xto9LFxLu1jgcSc033gJ+b49d+QRLmhXCgEMXkU7ZW6CqtuJmrUs1owVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574362; c=relaxed/simple;
	bh=ZUC5pigP5XERr6y4e6113CRI/mzxlGd7LwupcGxz9V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBUfSgepXuV/aLWAOH23DIBe9sMnVEPIweux9KhELrHNiapPHGK5+lLlYDMQwZygCMOrDzcp4ZNXmIhpAt9Bvw80EvmaVJOHrcw7mXJdLloDBi1Fx2/v0+sKJEZfTOKFrem5UgQhgqJlpsEsg78tY+baG/JAK8F/rTthczz2LYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnyD+SAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F34C116C6;
	Tue,  3 Mar 2026 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574362;
	bh=ZUC5pigP5XERr6y4e6113CRI/mzxlGd7LwupcGxz9V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnyD+SAbwhlfAmQ027+PH6LoqCqbZGgEIE+oCXhYRlGk5kbH4xaAmk5OvT73YU29I
	 uVe6lLIGw2sxsMCx+5APeODD8Jt6D96Jj/cchwSKgra8g2TbHTg1mpkmh8VzvIGlBG
	 PoLyymvx1O4JUoaMeu71UEb1U4H1b1i0gN9kknEuoAz36i3Ry53N61HqcSu/p1uzlX
	 uoa8cmreH6xlrmnjuQ7Limg6baOk/xSeA9kEHpxd6tFbCk04T9fah+qvG60gMEtmgG
	 POumA3EA54OSJnwZDjFW48YY3xQ668SrP3wGU+9jR+xwFuxj38/YAdMrk0U7lzUPcW
	 x11BUAOWOvsSw==
Date: Tue, 3 Mar 2026 23:45:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, nayna@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/2] keys/trusted_keys: move TPM-specific fields into
 trusted_tpm_options
Message-ID: <aadWlarKWxU10ryf@kernel.org>
References: <20260220183426.80446-1-ssrish@linux.ibm.com>
 <20260220183426.80446-3-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220183426.80446-3-ssrish@linux.ibm.com>
X-Rspamd-Queue-Id: 7B0EA1F7B48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-8882-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:04:26AM +0530, Srish Srinivasan wrote:
> The trusted_key_options struct contains TPM-specific fields (keyhandle,
> keyauth, blobauth_len, blobauth, pcrinfo_len, pcrinfo, pcrlock, hash,
> policydigest_len, policydigest, and policyhandle). This leads to the
> accumulation of backend-specific fields in the generic options structure.
> 
> Define trusted_tpm_options structure and move the TPM-specific fields
> there. Store a pointer to trusted_tpm_options in trusted_key_options's
> private.
> 
> No functional change intended.
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/keys/trusted-type.h               | 11 ---
>  include/keys/trusted_tpm.h                | 14 ++++
>  security/keys/trusted-keys/trusted_tpm1.c | 95 ++++++++++++++---------
>  security/keys/trusted-keys/trusted_tpm2.c | 51 ++++++------
>  4 files changed, 102 insertions(+), 69 deletions(-)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 03527162613f..b80f250305b8 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -39,17 +39,6 @@ struct trusted_key_payload {
>  
>  struct trusted_key_options {
>  	uint16_t keytype;
> -	uint32_t keyhandle;
> -	unsigned char keyauth[TPM_DIGEST_SIZE];
> -	uint32_t blobauth_len;
> -	unsigned char blobauth[TPM_DIGEST_SIZE];
> -	uint32_t pcrinfo_len;
> -	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
> -	int pcrlock;
> -	uint32_t hash;
> -	uint32_t policydigest_len;
> -	unsigned char policydigest[MAX_DIGEST_SIZE];
> -	uint32_t policyhandle;
>  	void *private;
>  };
>  
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index 0fadc6a4f166..355ebd36cbfd 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -7,6 +7,20 @@
>  
>  extern struct trusted_key_ops trusted_key_tpm_ops;
>  
> +struct trusted_tpm_options {
> +	uint32_t keyhandle;
> +	unsigned char keyauth[TPM_DIGEST_SIZE];
> +	uint32_t blobauth_len;
> +	unsigned char blobauth[TPM_DIGEST_SIZE];
> +	uint32_t pcrinfo_len;
> +	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
> +	int pcrlock;
> +	uint32_t hash;
> +	uint32_t policydigest_len;
> +	unsigned char policydigest[MAX_DIGEST_SIZE];
> +	uint32_t policyhandle;
> +};
> +
>  int tpm2_seal_trusted(struct tpm_chip *chip,
>  		      struct trusted_key_payload *payload,
>  		      struct trusted_key_options *options);
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 216caef97ffc..741b1d47d9f8 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -48,12 +48,14 @@ enum {
>  
>  static inline void dump_options(struct trusted_key_options *o)
>  {
> +	struct trusted_tpm_options *private = o->private;
> +
>  	pr_debug("sealing key type %d\n", o->keytype);
> -	pr_debug("sealing key handle %0X\n", o->keyhandle);
> -	pr_debug("pcrlock %d\n", o->pcrlock);
> -	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
> +	pr_debug("sealing key handle %0X\n", private->keyhandle);
> +	pr_debug("pcrlock %d\n", private->pcrlock);
> +	pr_debug("pcrinfo %d\n", private->pcrinfo_len);
>  	print_hex_dump(KERN_DEBUG, "pcrinfo ", DUMP_PREFIX_NONE,
> -		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> +		       16, 1, private->pcrinfo, private->pcrinfo_len, 0);
>  }
>  
>  static inline void dump_sess(struct osapsess *s)
> @@ -609,6 +611,7 @@ static int tpm_unseal(struct tpm_buf *tb,
>  static int key_seal(struct trusted_key_payload *p,
>  		    struct trusted_key_options *o)
>  {
> +	struct trusted_tpm_options *private = o->private;
>  	struct tpm_buf tb;
>  	int ret;
>  
> @@ -619,9 +622,10 @@ static int key_seal(struct trusted_key_payload *p,
>  	/* include migratable flag at end of sealed key */
>  	p->key[p->key_len] = p->migratable;
>  
> -	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
> +	ret = tpm_seal(&tb, o->keytype, private->keyhandle, private->keyauth,
>  		       p->key, p->key_len + 1, p->blob, &p->blob_len,
> -		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
> +		       private->blobauth, private->pcrinfo,
> +		       private->pcrinfo_len);
>  	if (ret < 0)
>  		pr_info("srkseal failed (%d)\n", ret);
>  
> @@ -635,6 +639,7 @@ static int key_seal(struct trusted_key_payload *p,
>  static int key_unseal(struct trusted_key_payload *p,
>  		      struct trusted_key_options *o)
>  {
> +	struct trusted_tpm_options *private = o->private;
>  	struct tpm_buf tb;
>  	int ret;
>  
> @@ -642,8 +647,8 @@ static int key_unseal(struct trusted_key_payload *p,
>  	if (ret)
>  		return ret;
>  
> -	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
> -			 o->blobauth, p->key, &p->key_len);
> +	ret = tpm_unseal(&tb, private->keyhandle, private->keyauth, p->blob,
> +			 p->blob_len, private->blobauth, p->key, &p->key_len);
>  	if (ret < 0)
>  		pr_info("srkunseal failed (%d)\n", ret);
>  	else
> @@ -680,6 +685,7 @@ static const match_table_t key_tokens = {
>  static int getoptions(char *c, struct trusted_key_payload *pay,
>  		      struct trusted_key_options *opt)
>  {
> +	struct trusted_tpm_options *private = opt->private;
>  	substring_t args[MAX_OPT_ARGS];
>  	char *p = c;
>  	int token;
> @@ -695,7 +701,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> -	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
> +	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>  
>  	if (!c)
>  		return 0;
> @@ -709,11 +715,11 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  
>  		switch (token) {
>  		case Opt_pcrinfo:
> -			opt->pcrinfo_len = strlen(args[0].from) / 2;
> -			if (opt->pcrinfo_len > MAX_PCRINFO_SIZE)
> +			private->pcrinfo_len = strlen(args[0].from) / 2;
> +			if (private->pcrinfo_len > MAX_PCRINFO_SIZE)
>  				return -EINVAL;
> -			res = hex2bin(opt->pcrinfo, args[0].from,
> -				      opt->pcrinfo_len);
> +			res = hex2bin(private->pcrinfo, args[0].from,
> +				      private->pcrinfo_len);
>  			if (res < 0)
>  				return -EINVAL;
>  			break;
> @@ -722,12 +728,12 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			if (res < 0)
>  				return -EINVAL;
>  			opt->keytype = SEAL_keytype;
> -			opt->keyhandle = handle;
> +			private->keyhandle = handle;
>  			break;
>  		case Opt_keyauth:
>  			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
>  				return -EINVAL;
> -			res = hex2bin(opt->keyauth, args[0].from,
> +			res = hex2bin(private->keyauth, args[0].from,
>  				      SHA1_DIGEST_SIZE);
>  			if (res < 0)
>  				return -EINVAL;
> @@ -738,21 +744,23 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			 * hex strings.  TPM 2.0 authorizations are simple
>  			 * passwords (although it can take a hash as well)
>  			 */
> -			opt->blobauth_len = strlen(args[0].from);
> +			private->blobauth_len = strlen(args[0].from);
>  
> -			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> -				res = hex2bin(opt->blobauth, args[0].from,
> +			if (private->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> +				res = hex2bin(private->blobauth, args[0].from,
>  					      TPM_DIGEST_SIZE);
>  				if (res < 0)
>  					return -EINVAL;
>  
> -				opt->blobauth_len = TPM_DIGEST_SIZE;
> +				private->blobauth_len = TPM_DIGEST_SIZE;
>  				break;
>  			}
>  
> -			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
> -				memcpy(opt->blobauth, args[0].from,
> -				       opt->blobauth_len);
> +			if (tpm2 &&
> +			    private->blobauth_len <=
> +			    sizeof(private->blobauth)) {
> +				memcpy(private->blobauth, args[0].from,
> +				       private->blobauth_len);
>  				break;
>  			}
>  
> @@ -770,14 +778,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			res = kstrtoul(args[0].from, 10, &lock);
>  			if (res < 0)
>  				return -EINVAL;
> -			opt->pcrlock = lock;
> +			private->pcrlock = lock;
>  			break;
>  		case Opt_hash:
>  			if (test_bit(Opt_policydigest, &token_mask))
>  				return -EINVAL;
>  			for (i = 0; i < HASH_ALGO__LAST; i++) {
>  				if (!strcmp(args[0].from, hash_algo_name[i])) {
> -					opt->hash = i;
> +					private->hash = i;
>  					break;
>  				}
>  			}
> @@ -789,14 +797,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			}
>  			break;
>  		case Opt_policydigest:
> -			digest_len = hash_digest_size[opt->hash];
> +			digest_len = hash_digest_size[private->hash];
>  			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
>  				return -EINVAL;
> -			res = hex2bin(opt->policydigest, args[0].from,
> +			res = hex2bin(private->policydigest, args[0].from,
>  				      digest_len);
>  			if (res < 0)
>  				return -EINVAL;
> -			opt->policydigest_len = digest_len;
> +			private->policydigest_len = digest_len;
>  			break;
>  		case Opt_policyhandle:
>  			if (!tpm2)
> @@ -804,7 +812,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			res = kstrtoul(args[0].from, 16, &handle);
>  			if (res < 0)
>  				return -EINVAL;
> -			opt->policyhandle = handle;
> +			private->policyhandle = handle;
>  			break;
>  		default:
>  			return -EINVAL;
> @@ -815,6 +823,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  
>  static struct trusted_key_options *trusted_options_alloc(void)
>  {
> +	struct trusted_tpm_options *private;
>  	struct trusted_key_options *options;
>  	int tpm2;
>  
> @@ -827,14 +836,23 @@ static struct trusted_key_options *trusted_options_alloc(void)
>  		/* set any non-zero defaults */
>  		options->keytype = SRK_keytype;
>  
> -		if (!tpm2)
> -			options->keyhandle = SRKHANDLE;
> +		private = kzalloc(sizeof(*private), GFP_KERNEL);
> +		if (!private) {
> +			kfree_sensitive(options);
> +			options = NULL;
> +		} else {
> +			if (!tpm2)
> +				private->keyhandle = SRKHANDLE;
> +
> +			options->private = private;
> +		}
>  	}
>  	return options;
>  }
>  
>  static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>  {
> +	struct trusted_tpm_options *private = NULL;
>  	struct trusted_key_options *options = NULL;
>  	int ret = 0;
>  	int tpm2;
> @@ -852,7 +870,8 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>  		goto out;
>  	dump_options(options);
>  
> -	if (!options->keyhandle && !tpm2) {
> +	private = options->private;
> +	if (!private->keyhandle && !tpm2) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -866,20 +885,22 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>  		goto out;
>  	}
>  
> -	if (options->pcrlock) {
> -		ret = pcrlock(options->pcrlock);
> +	if (private->pcrlock) {
> +		ret = pcrlock(private->pcrlock);
>  		if (ret < 0) {
>  			pr_info("pcrlock failed (%d)\n", ret);
>  			goto out;
>  		}
>  	}
>  out:
> +	kfree_sensitive(options->private);
>  	kfree_sensitive(options);
>  	return ret;
>  }
>  
>  static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  {
> +	struct trusted_tpm_options *private = NULL;
>  	struct trusted_key_options *options = NULL;
>  	int ret = 0;
>  	int tpm2;
> @@ -897,7 +918,8 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  		goto out;
>  	dump_options(options);
>  
> -	if (!options->keyhandle && !tpm2) {
> +	private = options->private;
> +	if (!private->keyhandle && !tpm2) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -909,14 +931,15 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  	if (ret < 0)
>  		pr_info("key_unseal failed (%d)\n", ret);
>  
> -	if (options->pcrlock) {
> -		ret = pcrlock(options->pcrlock);
> +	if (private->pcrlock) {
> +		ret = pcrlock(private->pcrlock);
>  		if (ret < 0) {
>  			pr_info("pcrlock failed (%d)\n", ret);
>  			goto out;
>  		}
>  	}
>  out:
> +	kfree_sensitive(options->private);
>  	kfree_sensitive(options);
>  	return ret;
>  }
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 6340823f8b53..94e01249b921 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -24,6 +24,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 *src, u32 len)
>  {
> +	struct trusted_tpm_options *private = options->private;
>  	const int SCRATCH_SIZE = PAGE_SIZE;
>  	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>  	u8 *work = scratch, *work1;
> @@ -46,7 +47,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	work = asn1_encode_oid(work, end_work, tpm2key_oid,
>  			       asn1_oid_len(tpm2key_oid));
>  
> -	if (options->blobauth_len == 0) {
> +	if (private->blobauth_len == 0) {
>  		unsigned char bool[3], *w = bool;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> @@ -69,7 +70,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  		goto err;
>  	}
>  
> -	work = asn1_encode_integer(work, end_work, options->keyhandle);
> +	work = asn1_encode_integer(work, end_work, private->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
>  	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
>  
> @@ -102,6 +103,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 **buf)
>  {
> +	struct trusted_tpm_options *private = options->private;
>  	int ret;
>  	struct tpm2_key_context ctx;
>  	u8 *blob;
> @@ -121,7 +123,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>  		return -ENOMEM;
>  
>  	*buf = blob;
> -	options->keyhandle = ctx.parent;
> +	private->keyhandle = ctx.parent;
>  
>  	memcpy(blob, ctx.priv, ctx.priv_len);
>  	blob += ctx.priv_len;
> @@ -233,6 +235,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		      struct trusted_key_payload *payload,
>  		      struct trusted_key_options *options)
>  {
> +	struct trusted_tpm_options *private = options->private;
>  	off_t offset = TPM_HEADER_SIZE;
>  	struct tpm_buf buf, sized;
>  	int blob_len = 0;
> @@ -240,11 +243,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	u32 flags;
>  	int rc;
>  
> -	hash = tpm2_find_hash_alg(options->hash);
> +	hash = tpm2_find_hash_alg(private->hash);
>  	if (hash < 0)
>  		return hash;
>  
> -	if (!options->keyhandle)
> +	if (!private->keyhandle)
>  		return -EINVAL;
>  
>  	rc = tpm_try_get_ops(chip);
> @@ -268,18 +271,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		goto out_put;
>  	}
>  
> -	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
> +	rc = tpm_buf_append_name(chip, &buf, private->keyhandle, NULL);
>  	if (rc)
>  		goto out;
>  
>  	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
> -				    options->keyauth, TPM_DIGEST_SIZE);
> +				    private->keyauth, TPM_DIGEST_SIZE);
>  
>  	/* sensitive */
> -	tpm_buf_append_u16(&sized, options->blobauth_len);
> +	tpm_buf_append_u16(&sized, private->blobauth_len);
>  
> -	if (options->blobauth_len)
> -		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
> +	if (private->blobauth_len)
> +		tpm_buf_append(&sized, private->blobauth,
> +			       private->blobauth_len);
>  
>  	tpm_buf_append_u16(&sized, payload->key_len);
>  	tpm_buf_append(&sized, payload->key, payload->key_len);
> @@ -292,14 +296,15 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  
>  	/* key properties */
>  	flags = 0;
> -	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> +	flags |= private->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
>  	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
>  	tpm_buf_append_u32(&sized, flags);
>  
>  	/* policy */
> -	tpm_buf_append_u16(&sized, options->policydigest_len);
> -	if (options->policydigest_len)
> -		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
> +	tpm_buf_append_u16(&sized, private->policydigest_len);
> +	if (private->policydigest_len)
> +		tpm_buf_append(&sized, private->policydigest,
> +			       private->policydigest_len);
>  
>  	/* public parameters */
>  	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
> @@ -373,6 +378,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  			 u32 *blob_handle)
>  {
>  	u8 *blob_ref __free(kfree) = NULL;
> +	struct trusted_tpm_options *private = options->private;
>  	struct tpm_buf buf;
>  	unsigned int private_len;
>  	unsigned int public_len;
> @@ -392,7 +398,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	}
>  
>  	/* new format carries keyhandle but old format doesn't */
> -	if (!options->keyhandle)
> +	if (!private->keyhandle)
>  		return -EINVAL;
>  
>  	/* must be big enough for at least the two be16 size counts */
> @@ -433,11 +439,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  		return rc;
>  	}
>  
> -	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
> +	rc = tpm_buf_append_name(chip, &buf, private->keyhandle, NULL);
>  	if (rc)
>  		goto out;
>  
> -	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
> +	tpm_buf_append_hmac_session(chip, &buf, 0, private->keyauth,
>  				    TPM_DIGEST_SIZE);
>  
>  	tpm_buf_append(&buf, blob, blob_len);
> @@ -481,6 +487,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  			   struct trusted_key_options *options,
>  			   u32 blob_handle)
>  {
> +	struct trusted_tpm_options *private = options->private;
>  	struct tpm_header *head;
>  	struct tpm_buf buf;
>  	u16 data_len;
> @@ -502,10 +509,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  	if (rc)
>  		goto out;
>  
> -	if (!options->policyhandle) {
> +	if (!private->policyhandle) {
>  		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
> -					    options->blobauth,
> -					    options->blobauth_len);
> +					    private->blobauth,
> +					    private->blobauth_len);
>  	} else {
>  		/*
>  		 * FIXME: The policy session was generated outside the
> @@ -518,9 +525,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  		 * could repeat our actions with the exfiltrated
>  		 * password.
>  		 */
> -		tpm2_buf_append_auth(&buf, options->policyhandle,
> +		tpm2_buf_append_auth(&buf, private->policyhandle,
>  				     NULL /* nonce */, 0, 0,
> -				     options->blobauth, options->blobauth_len);
> +				     private->blobauth, private->blobauth_len);
>  		if (tpm2_chip_auth(chip)) {
>  			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
>  		} else  {
> -- 
> 2.43.0
> 

Applied.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

