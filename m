Return-Path: <linux-integrity+bounces-6590-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A53AF6565
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 00:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F20E3A9EEC
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634B242D79;
	Wed,  2 Jul 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGwhfXMP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D51BA2E;
	Wed,  2 Jul 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495919; cv=none; b=czAwvVRdDUFOnKYoFHyLar2Zb9DdTqac+WoiTRkKdKcIMh8zIQBlsn5PzDU3Nb7ZZE+yzoIWkz5KM0IGxPB0tBQ6FXDqwPJNSoyjzhJOMgZC5wyASODVjx7LkKO119tfOw2ymST4XSVVAf+e/jTrjgYOjDdsr+cCQGk9371t9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495919; c=relaxed/simple;
	bh=M15wTBRDUxuzUSxsq10ndWKT/U/CMaX/pdQy2NUcoRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KefguDpd7a6lxHoIuVRvDSnFFwPE3hHfzXM3mYI5nYfeiQVLTxHwk08QLnBdbaSnK8iQ97hnVQrkYjF3xL/Q7kXNUkg3BlCMiPst/KwvDj26tyCPamDa9qPcbpE+oejio1ktsQ90PAD/LXfyKHA3rJ99RmHBPY+0HgdT1QgFHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGwhfXMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72E7C4CEE7;
	Wed,  2 Jul 2025 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495918;
	bh=M15wTBRDUxuzUSxsq10ndWKT/U/CMaX/pdQy2NUcoRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGwhfXMPR1PvpKgUQEecCWVX3ZSxSNI26yaRu8fUX0qOzfZhlnZ3Ti2OITm2qM2HU
	 GpjxFcDZVrrxFlzODXUqYgHWicnu5LTCx4f/+BDhaeXN8hWRRqLwVYIk2VzwJ93n6i
	 XaAVw6VJL9igfWcPTxADlhrL8VxigEgZz40eWHk242gW1jVSWukHhvy4sFM8eTU6HP
	 l1R5VnTpTOYpfd5pUCcTRg8NvVywZ4KExZf+QiaeouQMCDY2zudGIZKd8odAzHmpyo
	 zg1B05dH6Dr/tcl84LefShpkHhFtqFkHz49KeNAQEIB9ccmkh2RrSeo7yat8ZssEGv
	 KwGcm6bbtzr4g==
Date: Thu, 3 Jul 2025 01:38:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4] tpm: Managed allocations for tpm_buf instances
Message-ID: <aGW06nxmFXMYEyJ2@kernel.org>
References: <20250701145136.82726-1-jarkko@kernel.org>
 <29f206ec-1d9e-4c2f-b051-3af458173692@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f206ec-1d9e-4c2f-b051-3af458173692@linux.ibm.com>

On Tue, Jul 01, 2025 at 05:42:47PM -0400, Stefan Berger wrote:
> 
> 
> On 7/1/25 10:51 AM, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Repeal and replace tpm_buf_init() and tpm_buf_init_sized() with
> > tpm_buf_alloc(), which returns a buffer of  memory with the struct tpm_buf
> > header at the beginning of the returned buffer. This leaves 4090 bytes of
> > free space for the payload.
> > 
> > Given that kfree() is now the destructor for struct tpm_buf instances,
> > tpm_buf_destroy() becomes obsolete, and can be safely wiped of too.
> 
> s/of/off/  or s/wiped of/remove,/
> 
> > 
> > The actual gist is that now a tpm_buf can be now declared using
> 
> s/that now a/that a/
> 
> > __free(kfree) declared in linux/slab.h:
> > 
> > 	struct tpm_buf *buf __free(kfree) = NULL;
> > 
> > 	/* ... */
> > 
> > 	buf = tpm_buf_alloc();
> > 
> > Doing this has two-folded benefits:
> > 
> > 1. Yet to be discoverd memory leaks in the pre-existing code base.
> 
> -> discovered
> 
> 
> A couple of nits below and one stray 'return rc;' that should not be
> there...
> 
> > 2. Memory leaks concerning  new features and other contributions.
> > 
> > In addition, the barrier to contribute is lowered given that managing
> > memory is a factor easier.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 524d802ede26..86b961f4027b 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -165,14 +165,18 @@ struct tpm2_pcr_read_out {
> >   int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> >   		  struct tpm_digest *digest, u16 *digest_size_ptr)
> >   {
> > +	struct tpm_buf *buf __free(kfree) = NULL;
> >   	int i;
> >   	int rc;
> > -	struct tpm_buf buf;
> >   	struct tpm2_pcr_read_out *out;
> >   	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
> >   	u16 digest_size;
> >   	u16 expected_digest_size = 0;
> > +	buf = tpm_buf_alloc();
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> >   	if (pcr_idx >= TPM2_PLATFORM_PCR)
> >   		return -EINVAL;
> > @@ -187,23 +191,21 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> >   		expected_digest_size = chip->allocated_banks[i].digest_size;
> >   	}
> > -	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
> > -	if (rc)
> > -		return rc;
> > +	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
> >   	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
> > -	tpm_buf_append_u32(&buf, 1);
> > -	tpm_buf_append_u16(&buf, digest->alg_id);
> > -	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
> > -	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
> > +	tpm_buf_append_u32(buf, 1);
> > +	tpm_buf_append_u16(buf, digest->alg_id);
> > +	tpm_buf_append_u8(buf, TPM2_PCR_SELECT_MIN);
> > +	tpm_buf_append(buf, (const unsigned char *)pcr_select,
> >   		       sizeof(pcr_select));
> > -	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value");
> > +	rc = tpm_transmit_cmd(chip, buf, 0, "attempting to read a pcr value");
> >   	if (rc)
> >   		goto out;
> 
> nit: -> return rc; ?
> 
> > -	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
> > +	out = (struct tpm2_pcr_read_out *)&buf->data[TPM_HEADER_SIZE];
> >   	digest_size = be16_to_cpu(out->digest_size);
> >   	if (digest_size > sizeof(digest->digest) ||
> >   	    (!digest_size_ptr && digest_size != expected_digest_size)) {
> > @@ -216,7 +218,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> >   	memcpy(digest->digest, out->digest, digest_size);
> >   out:
> 
> probably can remove this label

yup, i agree

> 
> > -	tpm_buf_destroy(&buf);
> >   	return rc;
> >   }
> > @@ -574,8 +569,8 @@ struct tpm2_pcr_selection {
> >   ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> >   {
> > +	struct tpm_buf *buf __free(kfree) = NULL;
> >   	struct tpm2_pcr_selection pcr_selection;
> > -	struct tpm_buf buf;
> >   	void *marker;
> >   	void *end;
> >   	void *pcr_select_offset;
> > @@ -587,41 +582,39 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> >   	int rc;
> >   	int i = 0;
> > -	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> > -	if (rc)
> > -		return rc;
> > +	buf = tpm_buf_alloc();
> > +	if (!buf)
> > +		return -ENOMEM;
> > -	tpm_buf_append_u32(&buf, TPM2_CAP_PCRS);
> > -	tpm_buf_append_u32(&buf, 0);
> > -	tpm_buf_append_u32(&buf, 1);
> > +	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> > +	tpm_buf_append_u32(buf, TPM2_CAP_PCRS);
> > +	tpm_buf_append_u32(buf, 0);
> > +	tpm_buf_append_u32(buf, 1);
> > -	rc = tpm_transmit_cmd(chip, &buf, 9, "get tpm pcr allocation");
> > +	rc = tpm_transmit_cmd(chip, buf, 9, "get tpm pcr allocation");
> >   	if (rc)
> > -		goto out;
> > +		return rc;
> >   	nr_possible_banks = be32_to_cpup(
> > -		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
> > +		(__be32 *)&buf->data[TPM_HEADER_SIZE + 5]);
> >   	chip->allocated_banks = kcalloc(nr_possible_banks,
> >   					sizeof(*chip->allocated_banks),
> >   					GFP_KERNEL);
> > -	if (!chip->allocated_banks) {
> > -		rc = -ENOMEM;
> > -		goto out;
> > -	}
> > +	if (!chip->allocated_banks)
> > +		return -ENOMEM;
> > -	marker = &buf.data[TPM_HEADER_SIZE + 9];
> > +	marker = &buf->data[TPM_HEADER_SIZE + 9];
> > -	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
> > -	end = &buf.data[rsp_len];
> > +	rsp_len = be32_to_cpup((__be32 *)&buf->data[2]);
> > +	end = &buf->data[rsp_len];
> > +	return rc;
> 
> 
> this doesn't look right...

thanks for catching this!

> 
> 
> >   	for (i = 0; i < nr_possible_banks; i++) {
> >   		pcr_select_offset = marker +
> >   			offsetof(struct tpm2_pcr_selection, size_of_select);
> > -		if (pcr_select_offset >= end) {
> > -			rc = -EFAULT;
> > -			break;
> > -		}
> > +		if (pcr_select_offset >= end)
> > +			return -EFAULT;
> >   		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
> >   		hash_alg = be16_to_cpu(pcr_selection.hash_alg);
> > @@ -633,7 +626,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index 024be262702f..54bcd8d0621e 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -241,14 +241,23 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >   		      struct trusted_key_payload *payload,
> >   		      struct trusted_key_options *options)
> >   {
> > +	struct tpm_buf *buf __free(kfree) = NULL;
> > +	struct tpm_buf *sized __free(kfree) = NULL;
> 
> Revert order of the above two lines.
> 
> >   	off_t offset = TPM_HEADER_SIZE;
> > -	struct tpm_buf buf, sized;
> >   	int blob_len = 0;
> >   	u32 hash;
> >   	u32 flags;
> >   	int i;
> >   	int rc;
> > +	buf = tpm_buf_alloc();
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	sized = tpm_buf_alloc();
> > +	if (!sized)
> > +		return -ENOMEM;
> > +
> >   	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {>   		if
> (options->hash == tpm2_hash_map[i].crypto_id) {
> >   			hash = tpm2_hash_map[i].tpm_id;
> > @@ -270,89 +279,76 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >   	if (rc)
> >   		goto out_put;
> > -	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
> > -	if (rc) {
> > -		tpm2_end_auth_session(chip);
> > -		goto out_put;
> > -	}
> > -
> > -	rc = tpm_buf_init_sized(&sized);
> > -	if (rc) {
> > -		tpm_buf_destroy(&buf);
> > -		tpm2_end_auth_session(chip);
> > -		goto out_put;
> > -	}
> > -
> > -	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
> > -	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
> > +	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
> > +	tpm_buf_reset_sized(sized);
> > +	tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
> > +	tpm_buf_append_hmac_session(chip, buf, TPM2_SA_DECRYPT,
> >   				    options->keyauth, TPM_DIGEST_SIZE);
> >   	/* sensitive */
> > -	tpm_buf_append_u16(&sized, options->blobauth_len);
> > +	tpm_buf_append_u16(sized, options->blobauth_len);
> >   	if (options->blobauth_len)
> > -		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
> > +		tpm_buf_append(sized, options->blobauth, options->blobauth_len);
> > -	tpm_buf_append_u16(&sized, payload->key_len);
> > -	tpm_buf_append(&sized, payload->key, payload->key_len);
> > -	tpm_buf_append(&buf, sized.data, sized.length);
> > +	tpm_buf_append_u16(sized, payload->key_len);
> > +	tpm_buf_append(sized, payload->key, payload->key_len);
> > +	tpm_buf_append(buf, sized->data, sized->length);
> >   	/* public */
> > -	tpm_buf_reset_sized(&sized);
> > -	tpm_buf_append_u16(&sized, TPM_ALG_KEYEDHASH);
> > -	tpm_buf_append_u16(&sized, hash);
> > +	tpm_buf_reset_sized(sized);
> > +	tpm_buf_append_u16(sized, TPM_ALG_KEYEDHASH);
> > +	tpm_buf_append_u16(sized, hash);
> >   	/* key properties */
> >   	flags = 0;
> >   	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> >   	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
> > -	tpm_buf_append_u32(&sized, flags);
> > +	tpm_buf_append_u32(sized, flags);
> >   	/* policy */
> > -	tpm_buf_append_u16(&sized, options->policydigest_len);
> > +	tpm_buf_append_u16(sized, options->policydigest_len);
> >   	if (options->policydigest_len)
> > -		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
> > +		tpm_buf_append(sized, options->policydigest, options->policydigest_len);
> >   	/* public parameters */
> > -	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
> > -	tpm_buf_append_u16(&sized, 0);
> > +	tpm_buf_append_u16(sized, TPM_ALG_NULL);
> > +	tpm_buf_append_u16(sized, 0);
> > -	tpm_buf_append(&buf, sized.data, sized.length);
> > +	tpm_buf_append(buf, sized->data, sized->length);
> >   	/* outside info */
> > -	tpm_buf_append_u16(&buf, 0);
> > +	tpm_buf_append_u16(buf, 0);
> >   	/* creation PCR */
> > -	tpm_buf_append_u32(&buf, 0);
> > +	tpm_buf_append_u32(buf, 0);
> > -	if (buf.flags & TPM_BUF_OVERFLOW) {
> > +	if (buf->flags & TPM_BUF_OVERFLOW) {
> >   		rc = -E2BIG;
> >   		tpm2_end_auth_session(chip);
> >   		goto out;
> >   	}
> > -	tpm_buf_fill_hmac_session(chip, &buf);
> > -	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
> > -	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
> > +	tpm_buf_fill_hmac_session(chip, buf);
> > +	rc = tpm_transmit_cmd(chip, buf, 4, "sealing data");
> > +	rc = tpm_buf_check_hmac_response(chip, buf, rc);
> >   	if (rc)
> >   		goto out;
> > -	blob_len = tpm_buf_read_u32(&buf, &offset);
> > -	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
> > +	blob_len = tpm_buf_read_u32(buf, &offset);
> > +	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_BOUNDARY_ERROR) {
> >   		rc = -E2BIG;
> >   		goto out;
> >   	}
> > -	if (buf.length - offset < blob_len) {
> > +	if (buf->length - offset < blob_len) {
> >   		rc = -EFAULT;
> >   		goto out;
> >   	}
> > -	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
> > +	blob_len = tpm2_key_encode(payload, options, &buf->data[offset],
> > +				   blob_len);
> >   out:
> > -	tpm_buf_destroy(&sized);
> > -	tpm_buf_destroy(&buf);
> > -
> >   	if (rc > 0) {
> >   		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
> >   			rc = -EINVAL;


Thanks for the remarks.

BR, Jarkko

