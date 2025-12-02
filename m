Return-Path: <linux-integrity+bounces-7761-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2530BC9C317
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 17:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AF73A2F53
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120A29ACDB;
	Tue,  2 Dec 2025 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="iEbJzKZI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8EC28314E;
	Tue,  2 Dec 2025 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692806; cv=none; b=kletDtnXDe0NLfL7McsiOY0oz15gjtERWoOObI0hNk9YTYU9qqXGm2sSD3ejzkuYeLHdmGtPOMFLY4qHzz26us2wqyRSLqi+jM9x4Le6uJDCvDe2DMlQp+J3k8xAeCrvmxs+jsJ3Ijv+AGexTCRvf4MfgCfzCTYKiNLu8pNaads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692806; c=relaxed/simple;
	bh=Pjq2luBFLJQ256s/pu632w5Np4BqHbKrC2ffNq+qcHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s02YfZ9eQSyv54eKB8YQZ/n1cT+Q/v0z5IF+0PfbAS21hYGwJQr6DeAqjd5AZHsXMeSkTXSA+xrr+09Q4mmVEkFes35gBHnyq9x9wtguz7LveSw1WBF93IcM7MFItsvMqc3ji+GcwfOOuOqtNPcUjW9z+eH/HcX1owg3dcW5M7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=iEbJzKZI; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jBMTWCuoiw4oxP9HCtXxb7sCevYgLbvNQVB6qMzjqOA=; b=iEbJzKZIgKebsLPpO1X74eobwa
	mePuBWM1KSbT354vBqMSvZIgumuGLVR2iSPFf78TIvAYscC0c1mdfv8OI/Eas9Ee4rN9zYLgWh8pn
	24vj9T4zr9ZBg25ISgmZqJT2xe+FvckFCivvgoKW90Iz5WHWVPeoLM7tq2rsvarP7rDHrdraNDp2j
	8jHOUOzhq7hvqseyKJ9w6BeQ9H+r0dGc13AerfY1w81WT0VJ+Gp1xqWfJ3j5qIu1aXdxjUps5ROj0
	yI9gtoZ0moLihyubS+O0GaNe0VkILAlq+z79SOhvVygosa0SEH6x7+85sfbcPHlb6DGQYWSMV0a7K
	q72IXj9A==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vQTCb-00E20L-2X;
	Tue, 02 Dec 2025 16:26:09 +0000
Date: Tue, 2 Dec 2025 16:26:09 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>, stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] tpm2-sessions: address out-of-range indexing
Message-ID: <aS8TIeviaippVAha@earth.li>
References: <20251201193958.896358-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251201193958.896358-1-jarkko@kernel.org>

On Mon, Dec 01, 2025 at 09:39:58PM +0200, Jarkko Sakkinen wrote:
>'name_size' does not have any range checks, and it just directly indexes
>with TPM_ALG_ID, which could lead into memory corruption at worst.
>
>Address the issue by only processing known values and returning -EINVAL for
>unrecognized values.
>
>Make also 'tpm_buf_append_name' and 'tpm_buf_fill_hmac_session' fallible so
>that errors are detected before causing any spurious TPM traffic.
>
>End also the authorization session on failure in both of the functions, as
>the session state would be then by definition corrupted.
>
>Cc: stable@vger.kernel.org # v6.10+
>Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
>v3:
>- Add two missing 'tpm2_end_auth_session' calls to the fallback paths of
>  'tpm_buf_fill_hmac_session'.
>- Rewrote the commit message.
>- End authorization session on failure in 'tpm2_buf_append_name' and
>  'tpm_buf_fill_hmac_session'.
>v2:
>There was spurious extra field added to tpm2_hash by mistake.
>---
> drivers/char/tpm/tpm2-cmd.c               |  23 +++-
> drivers/char/tpm/tpm2-sessions.c          | 131 +++++++++++++++-------
> include/linux/tpm.h                       |   6 +-
> security/keys/trusted-keys/trusted_tpm2.c |  29 ++++-
> 4 files changed, 136 insertions(+), 53 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index 5b6ccf901623..4473b81122e8 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -187,7 +187,11 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> 	}
>
> 	if (!disable_pcr_integrity) {
>-		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
>+		rc = tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
>+		if (rc) {
>+			tpm_buf_destroy(&buf);
>+			return rc;
>+		}
> 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> 	} else {
> 		tpm_buf_append_handle(chip, &buf, pcr_idx);
>@@ -202,8 +206,14 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> 			       chip->allocated_banks[i].digest_size);
> 	}
>
>-	if (!disable_pcr_integrity)
>-		tpm_buf_fill_hmac_session(chip, &buf);
>+	if (!disable_pcr_integrity) {
>+		rc = tpm_buf_fill_hmac_session(chip, &buf);
>+		if (rc) {
>+			tpm_buf_destroy(&buf);
>+			return rc;
>+		}
>+	}
>+
> 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
> 	if (!disable_pcr_integrity)
> 		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
>@@ -261,7 +271,12 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> 						| TPM2_SA_CONTINUE_SESSION,
> 						NULL, 0);
> 		tpm_buf_append_u16(&buf, num_bytes);
>-		tpm_buf_fill_hmac_session(chip, &buf);
>+		err = tpm_buf_fill_hmac_session(chip, &buf);
>+		if (err) {
>+			tpm_buf_destroy(&buf);
>+			return err;
>+		}
>+
> 		err = tpm_transmit_cmd(chip, &buf,
> 				       offsetof(struct tpm2_get_random_out,
> 						buffer),
>diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
>index 6d03c224e6b2..33ad0d668e1a 100644
>--- a/drivers/char/tpm/tpm2-sessions.c
>+++ b/drivers/char/tpm/tpm2-sessions.c
>@@ -144,16 +144,24 @@ struct tpm2_auth {
> /*
>  * Name Size based on TPM algorithm (assumes no hash bigger than 255)
>  */
>-static u8 name_size(const u8 *name)
>+static int name_size(const u8 *name)
> {
>-	static u8 size_map[] = {
>-		[TPM_ALG_SHA1] = SHA1_DIGEST_SIZE,
>-		[TPM_ALG_SHA256] = SHA256_DIGEST_SIZE,
>-		[TPM_ALG_SHA384] = SHA384_DIGEST_SIZE,
>-		[TPM_ALG_SHA512] = SHA512_DIGEST_SIZE,
>-	};
>-	u16 alg = get_unaligned_be16(name);
>-	return size_map[alg] + 2;
>+	u16 hash_alg = get_unaligned_be16(name);
>+
>+	switch (hash_alg) {
>+	case TPM_ALG_SHA1:
>+		return SHA1_DIGEST_SIZE + 2;
>+	case TPM_ALG_SHA256:
>+		return SHA256_DIGEST_SIZE + 2;
>+	case TPM_ALG_SHA384:
>+		return SHA384_DIGEST_SIZE + 2;
>+	case TPM_ALG_SHA512:
>+		return SHA512_DIGEST_SIZE + 2;
>+	case TPM_ALG_SM3_256:
>+		return SM3256_DIGEST_SIZE + 2;
>+	}
>+

Can we/should we perhaps print a warning here if we don't know the 
algorithm?

>+	return -EINVAL;
> }
>
> static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
>@@ -161,6 +169,7 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
> 	struct tpm_header *head = (struct tpm_header *)buf->data;
> 	off_t offset = TPM_HEADER_SIZE;
> 	u32 tot_len = be32_to_cpu(head->length);
>+	int ret;
> 	u32 val;
>
> 	/* we're starting after the header so adjust the length */
>@@ -172,9 +181,15 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
> 		return -EINVAL;
> 	offset += val;
> 	/* name */
>+
> 	val = tpm_buf_read_u16(buf, &offset);
>-	if (val != name_size(&buf->data[offset]))
>+	ret = name_size(&buf->data[offset]);
>+	if (ret < 0)
>+		return ret;
>+
>+	if (val != ret)
> 		return -EINVAL;
>+
> 	memcpy(name, &buf->data[offset], val);
> 	/* forget the rest */
> 	return 0;
>@@ -221,46 +236,70 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
>  * As with most tpm_buf operations, success is assumed because failure
>  * will be caused by an incorrect programming model and indicated by a
>  * kernel message.
>+ *
>+ * Ends the authorization session on failure.
>  */
>-void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>-			 u32 handle, u8 *name)
>+int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>+			u32 handle, u8 *name)
> {
> #ifdef CONFIG_TCG_TPM2_HMAC
> 	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
> 	struct tpm2_auth *auth;
> 	int slot;
>+	int ret;
> #endif
>
> 	if (!tpm2_chip_auth(chip)) {
> 		tpm_buf_append_handle(chip, buf, handle);
>-		return;
>+		return 0;
> 	}
>
> #ifdef CONFIG_TCG_TPM2_HMAC
> 	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE) / 4;
> 	if (slot >= AUTH_MAX_NAMES) {
>-		dev_err(&chip->dev, "TPM: too many handles\n");
>-		return;
>+		dev_err(&chip->dev, "too many handles\n");
>+		ret = -EIO;
>+		goto err;
> 	}
> 	auth = chip->auth;
>-	WARN(auth->session != tpm_buf_length(buf),
>-	     "name added in wrong place\n");
>+	if (auth->session != tpm_buf_length(buf)) {
>+		dev_err(&chip->dev, "session state malformed");
>+		ret = -EIO;
>+		goto err;
>+	}
> 	tpm_buf_append_u32(buf, handle);
> 	auth->session += 4;
>
> 	if (mso == TPM2_MSO_PERSISTENT ||
> 	    mso == TPM2_MSO_VOLATILE ||
> 	    mso == TPM2_MSO_NVRAM) {
>-		if (!name)
>-			tpm2_read_public(chip, handle, auth->name[slot]);
>+		if (!name) {
>+			ret = tpm2_read_public(chip, handle, auth->name[slot]);
>+			if (ret)
>+				goto err;
>+		}
> 	} else {
>-		if (name)
>-			dev_err(&chip->dev, "TPM: Handle does not require name but one is specified\n");

We're dropping the error message here; is there a reason for that?

>+		if (name) {
>+			ret = -EIO;
>+			goto err;
>+		}
> 	}
>
> 	auth->name_h[slot] = handle;
>-	if (name)
>-		memcpy(auth->name[slot], name, name_size(name));
>+	if (name) {
>+		ret = name_size(name);
>+		if (ret < 0)
>+			goto err;
>+
>+		memcpy(auth->name[slot], name, ret);
>+	}
>+#endif
>+	return 0;
>+
>+#ifdef CONFIG_TCG_TPM2_HMAC
>+err:
>+	tpm2_end_auth_session(chip);
>+	return tpm_ret_to_err(ret);
> #endif
> }
> EXPORT_SYMBOL_GPL(tpm_buf_append_name);
>@@ -533,11 +572,9 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
>  * encryption key and encrypts the first parameter of the command
>  * buffer with it.
>  *
>- * As with most tpm_buf operations, success is assumed because failure
>- * will be caused by an incorrect programming model and indicated by a
>- * kernel message.
>+ * Ends the authorization session on failure.
>  */
>-void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
>+int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
> {
> 	u32 cc, handles, val;
> 	struct tpm2_auth *auth = chip->auth;
>@@ -549,9 +586,12 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
> 	u8 cphash[SHA256_DIGEST_SIZE];
> 	struct sha256_ctx sctx;
> 	struct hmac_sha256_ctx hctx;
>+	int ret;
>
>-	if (!auth)
>-		return;
>+	if (!auth) {
>+		ret = -EINVAL;
>+		goto err;
>+	}
>
> 	/* save the command code in BE format */
> 	auth->ordinal = head->ordinal;
>@@ -560,9 +600,10 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
>
> 	i = tpm2_find_cc(chip, cc);
> 	if (i < 0) {
>-		dev_err(&chip->dev, "Command 0x%x not found in TPM\n", cc);

Again, I think it's generally helpful to have the error message given 
that the return (EINVAL) does not help narrow down which value is bad.

>-		return;
>+		ret = -EINVAL;
>+		goto err;
> 	}
>+
> 	attrs = chip->cc_attrs_tbl[i];
>
> 	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
>@@ -576,9 +617,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
> 		u32 handle = tpm_buf_read_u32(buf, &offset_s);
>
> 		if (auth->name_h[i] != handle) {
>-			dev_err(&chip->dev, "TPM: handle %d wrong for name\n",
>-				  i);
>-			return;
>+			dev_err(&chip->dev, "invalid handle 0x%08x\n", handle);
>+			ret = -EINVAL;
>+			goto err;
> 		}
> 	}
> 	/* point offset_s to the start of the sessions */
>@@ -609,12 +650,14 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
> 		offset_s += len;
> 	}
> 	if (offset_s != offset_p) {
>-		dev_err(&chip->dev, "TPM session length is incorrect\n");
>-		return;
>+		dev_err(&chip->dev, "session length is incorrect\n");
>+		ret = -EINVAL;
>+		goto err;
> 	}
> 	if (!hmac) {
>-		dev_err(&chip->dev, "TPM could not find HMAC session\n");
>-		return;
>+		dev_err(&chip->dev, "could not find HMAC session\n");
>+		ret = -EINVAL;
>+		goto err;
> 	}
>
> 	/* encrypt before HMAC */
>@@ -646,8 +689,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
> 		if (mso == TPM2_MSO_PERSISTENT ||
> 		    mso == TPM2_MSO_VOLATILE ||
> 		    mso == TPM2_MSO_NVRAM) {
>-			sha256_update(&sctx, auth->name[i],
>-				      name_size(auth->name[i]));
>+			ret = name_size(auth->name[i]);
>+			if (ret < 0)
>+				goto err;
>+
>+			sha256_update(&sctx, auth->name[i], ret);
> 		} else {
> 			__be32 h = cpu_to_be32(auth->name_h[i]);
>
>@@ -668,6 +714,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
> 	hmac_sha256_update(&hctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
> 	hmac_sha256_update(&hctx, &auth->attrs, 1);
> 	hmac_sha256_final(&hctx, hmac);
>+	return 0;
>+
>+err:
>+	tpm2_end_auth_session(chip);
>+	return ret;
> }
> EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
>
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 0e9e043f728c..1a59f0190eb3 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -528,8 +528,8 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
> #endif
> }
>
>-void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>-			 u32 handle, u8 *name);
>+int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>+			u32 handle, u8 *name);
> void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> 				 u8 attributes, u8 *passphrase,
> 				 int passphraselen);
>@@ -562,7 +562,7 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
> #ifdef CONFIG_TCG_TPM2_HMAC
>
> int tpm2_start_auth_session(struct tpm_chip *chip);
>-void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
>+int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
> int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
> 				int rc);
> void tpm2_end_auth_session(struct tpm_chip *chip);
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index e165b117bbca..7672a4376dad 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -283,7 +283,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> 		goto out_put;
> 	}
>
>-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
>+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
>+	if (rc)
>+		goto out;
>+
> 	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
> 				    options->keyauth, TPM_DIGEST_SIZE);
>
>@@ -331,7 +334,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> 		goto out;
> 	}
>
>-	tpm_buf_fill_hmac_session(chip, &buf);
>+	rc = tpm_buf_fill_hmac_session(chip, &buf);
>+	if (rc)
>+		goto out;
>+
> 	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
> 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
> 	if (rc)
>@@ -438,7 +444,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 		return rc;
> 	}
>
>-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
>+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
>+	if (rc)
>+		goto out;
>+
> 	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
> 				    TPM_DIGEST_SIZE);
>
>@@ -450,7 +459,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 		goto out;
> 	}
>
>-	tpm_buf_fill_hmac_session(chip, &buf);
>+	rc = tpm_buf_fill_hmac_session(chip, &buf);
>+	if (rc)
>+		goto out;
>+
> 	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
> 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
> 	if (!rc)
>@@ -497,7 +509,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 		return rc;
> 	}
>
>-	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
>+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
>+	if (rc)
>+		goto out;
>
> 	if (!options->policyhandle) {
> 		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
>@@ -522,7 +536,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 						NULL, 0);
> 	}
>
>-	tpm_buf_fill_hmac_session(chip, &buf);
>+	rc = tpm_buf_fill_hmac_session(chip, &buf);
>+	if (rc)
>+		goto out;
>+
> 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
> 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
>
>-- 
>2.52.0
>

J.

-- 
Be Ye Not Lost Among Precepts of Order

