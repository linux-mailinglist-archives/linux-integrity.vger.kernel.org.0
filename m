Return-Path: <linux-integrity+bounces-9638-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFU4ONRREGrgWAYAu9opvQ
	(envelope-from <linux-integrity+bounces-9638-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 14:53:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F17575B48AA
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CF0307BD2F
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445F738F227;
	Fri, 22 May 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGs5GBE7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332B38BF7A;
	Fri, 22 May 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453709; cv=none; b=CykM3VGUgdVOxJ+nxa+WAHDwfzO0YLBxlEw/nJHODGDtJxbfjdqt9qgcAdbygdFSQuXyLwZAHBFGc9r3LairfnG5E97iKxDlByMiGwvAQW6B59fb2MqwwnY4pDGJqlHcTS7q/if7UAiz+MIsKsfk0e4BuoUPix8zbRmqGYUyaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453709; c=relaxed/simple;
	bh=x47ljkOxFIh1Jfa4BoY2SZbIHtcuPuTW5LRk3qTl7xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVuTnnk+UWBgz6xZ2ZjQ1XSa/QKz95YYjXwe2F0ILkyffLliF5hi3UvPBRUtO/Yt6T0opoMWWZyk8a+lo1qJEflyyG/O/vQpp4d7LiWeL7KSd9XvqIeHCbTJRHKoPIG44RvpHplCOCQ3ri6jwV4yoM89DGK/w8+yitgXgsoBwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGs5GBE7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3BD111F000E9;
	Fri, 22 May 2026 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453706;
	bh=Pv+nKBPyDfhckwETZuEhITJI/tHi6FTtzucfMfPeMCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cGs5GBE7R6PkkUrWnw1+z3qw5mct3wl7wwb3h6dGvGsf56dpyxImMmnQkNFuHjBGC
	 jjp4n7PLJfXtFPe3zQ0YXt8+IS4stNvd7q68RSayWYefJwCrYKZhbDm8fP1q/X7bNA
	 98tuZsRQjsvDlRPSQIK5s3iXqP7N0JdL7G0vnPDPypI0ABjcR9yQ7JumD5qIBWuTNI
	 XrzKV0xMxLiH6PLbNEcIUHOcmii/Y+EErq0e5RFkL9tcVyndUTItyZYfSuneCZz2Cg
	 Fw3AEgyT9aSiIoe1JKF0fKw14+U7m8YFJaDj/K/HMHYQKEKH20ciH6gR8b5vQVQ3Wr
	 cJvJnkwNZjIeg==
Date: Fri, 22 May 2026 15:41:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, stefanb@linux.ibm.com,
	zohar@linux.ibm.com, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] keys/trusted_keys: move TPM-specific fields into
 trusted_tpm_options
Message-ID: <ahBPB0UQx5KUg2rW@kernel.org>
References: <20260522081637.189546-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522081637.189546-1-ssrish@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9638-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F17575B48AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 01:46:37PM +0530, Srish Srinivasan wrote:
> The trusted_key_options struct contains TPM-specific fields (keyhandle,
> keyauth, blobauth_len, blobauth, pcrinfo_len, pcrinfo, pcrlock, hash,
> policydigest_len, policydigest, and policyhandle). This leads to the
> accumulation of backend-specific fields in the generic options structure.
> 
> Define a trusted_tpm_options structure and move the TPM-specific fields
> there. Store a pointer to trusted_tpm_options in trusted_key_options's
> private.
> 
> No functional change intended.
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

I'm supporting this change yes but before spreading tpm_buf all over the
place I'd like to get this merged:

https://lore.kernel.org/linux-integrity/20260522013555.1063716-1-jarkko@kernel.org/T/#u

It'd need tested-by's most importantly. There's another patch shoe-horning
buffers a bit upgrading tpm_buf so I thought now would be good tiem to
get this finally applied.

Possible merge conflicts for +1 change of this should be fairly trivial.

BR, Jarkko

> This patch depends on 9ec4175a30eb ("KEYS: trusted: Debugging as a
> feature"), which is in linux-tpmdd/master but not yet in mainline.
> 
> Please apply on top of linux-tpmdd/master.
> 
> base-commit: 67657fb65aa9f2d7dd46235246b1677792bd103e
> 
> Changelog:
>  v3:
>   - Exclude the preparatory clean up patch as the problem has been addressed
>     in commit 9ec4175a30eb ("KEYS: trusted: Debugging as a feature")
> 
>  v2:
>   - Exclude the bug-fix patch as it has already been applied to 6.19-rc7
>   - Rename instances of trusted_tpm_options from tpm_opts to private
>   - Use pr_debug and KERN_DEBUG for logging debug messages (preparatory clean
>     up patch)
>   - Address other minor comments from Jarkko
> 
>  include/keys/trusted-type.h               | 11 ---
>  include/keys/trusted_tpm.h                | 14 ++++
>  security/keys/trusted-keys/trusted_tpm1.c | 95 ++++++++++++++---------
>  security/keys/trusted-keys/trusted_tpm2.c | 51 ++++++------
>  4 files changed, 102 insertions(+), 69 deletions(-)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 9f9940482da4..3db61b57cf73 100644
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
> index 13513819991e..21360a41d290 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -49,15 +49,17 @@ enum {
>  #ifdef CONFIG_TRUSTED_KEYS_DEBUG
>  static inline void dump_options(struct trusted_key_options *o)
>  {
> +	struct trusted_tpm_options *private = o->private;
> +
>  	if (!trusted_debug)
>  		return;
>  
>  	pr_debug("sealing key type %d\n", o->keytype);
> -	pr_debug("sealing key handle %0X\n", o->keyhandle);
> -	pr_debug("pcrlock %d\n", o->pcrlock);
> -	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
> +	pr_debug("sealing key handle %0X\n", private->keyhandle);
> +	pr_debug("pcrlock %d\n", private->pcrlock);
> +	pr_debug("pcrinfo %d\n", private->pcrinfo_len);
>  	print_hex_dump_debug("pcrinfo ", DUMP_PREFIX_NONE,
> -			     16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> +			     16, 1, private->pcrinfo, private->pcrinfo_len, 0);
>  }
>  
>  static inline void dump_sess(struct osapsess *s)
> @@ -631,6 +633,7 @@ static int tpm_unseal(struct tpm_buf *tb,
>  static int key_seal(struct trusted_key_payload *p,
>  		    struct trusted_key_options *o)
>  {
> +	struct trusted_tpm_options *private = o->private;
>  	struct tpm_buf tb;
>  	int ret;
>  
> @@ -641,9 +644,10 @@ static int key_seal(struct trusted_key_payload *p,
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
> @@ -657,6 +661,7 @@ static int key_seal(struct trusted_key_payload *p,
>  static int key_unseal(struct trusted_key_payload *p,
>  		      struct trusted_key_options *o)
>  {
> +	struct trusted_tpm_options *private = o->private;
>  	struct tpm_buf tb;
>  	int ret;
>  
> @@ -664,8 +669,8 @@ static int key_unseal(struct trusted_key_payload *p,
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
> @@ -702,6 +707,7 @@ static const match_table_t key_tokens = {
>  static int getoptions(char *c, struct trusted_key_payload *pay,
>  		      struct trusted_key_options *opt)
>  {
> +	struct trusted_tpm_options *private = opt->private;
>  	substring_t args[MAX_OPT_ARGS];
>  	char *p = c;
>  	int token;
> @@ -717,7 +723,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  	if (tpm2 < 0)
>  		return tpm2;
>  
> -	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
> +	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>  
>  	if (!c)
>  		return 0;
> @@ -731,11 +737,11 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
> @@ -744,12 +750,12 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
> @@ -760,21 +766,23 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
> @@ -792,14 +800,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
> @@ -811,14 +819,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
> @@ -826,7 +834,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  			res = kstrtoul(args[0].from, 16, &handle);
>  			if (res < 0)
>  				return -EINVAL;
> -			opt->policyhandle = handle;
> +			private->policyhandle = handle;
>  			break;
>  		default:
>  			return -EINVAL;
> @@ -837,6 +845,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  
>  static struct trusted_key_options *trusted_options_alloc(void)
>  {
> +	struct trusted_tpm_options *private;
>  	struct trusted_key_options *options;
>  	int tpm2;
>  
> @@ -849,14 +858,23 @@ static struct trusted_key_options *trusted_options_alloc(void)
>  		/* set any non-zero defaults */
>  		options->keytype = SRK_keytype;
>  
> -		if (!tpm2)
> -			options->keyhandle = SRKHANDLE;
> +		private = kzalloc_obj(*private);
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
> @@ -874,7 +892,8 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>  		goto out;
>  	dump_options(options);
>  
> -	if (!options->keyhandle && !tpm2) {
> +	private = options->private;
> +	if (!private->keyhandle && !tpm2) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -888,20 +907,22 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
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
> @@ -919,7 +940,8 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  		goto out;
>  	dump_options(options);
>  
> -	if (!options->keyhandle && !tpm2) {
> +	private = options->private;
> +	if (!private->keyhandle && !tpm2) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -931,14 +953,15 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
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
> 
> -- 
> 2.51.0
> 

