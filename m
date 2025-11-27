Return-Path: <linux-integrity+bounces-7705-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79849C8FBFF
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EFC3A9048
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63D2ED848;
	Thu, 27 Nov 2025 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="agMNamLv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891232D6E5C;
	Thu, 27 Nov 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265575; cv=none; b=Rvoyf5KUNmpJ1IEtePhXQrj8ZmThu3P5mSj0zu4ldaT6BaFwyDgNK2yuCySdrCZTmOgYRRK4d5TTNSwq2RlJKoIu87N5i8UUg2ARj03btX1+iWFPXKWWcqptKaGFyuaXK/lcb1D2hMyt6R0mT6vTr5Z3FJl5WxYUKQJY8wVvrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265575; c=relaxed/simple;
	bh=I447F3im92CkiC4QnAuGz/QXkpu56lpsbIDxx+gs1so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee4gIEeuDD37ffHGeLb9zTOoTlyyUdMsFHMyN9gff95uS05QJGl/ex9NjsZJQezMpRowyF7ZNeIKkU7Xrh3wm5yqAOwGv5aoBTTinopb2sSJFix0Xfj/hfAdWnYvOBgEvWh3CGc/eo0xWSsouLzmcqcLwnDFM5bB+XlwLXQ96f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=agMNamLv; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QrKycfT9IfRwE/BOnl/WKSFo6N/MNlM3l+vogwvl0FQ=; b=agMNamLvk284WO4eJj5MpOF3EV
	Wy18iThzqhanalbLfI5nMdWP2DkyomLLtARvOpBnH1XJvN/X5Vlz5MIaJx6f2nMd/Mn9JEOdqNCx5
	8XWRsacaS+GGHXMt2gV8J0r8BWbY4vSzJonT0wYizLee5XA6ibIKJUadYymGnaWJRB9FMieki7w50
	m+UVn7Si27h1/3d9dUFqrkPpKYETfX12d4vRfAfKZzvUS4TzYaQ7EavcBMxX76llhVlQQws3iHpfl
	SP1xienMbRMmSxO0mNDt2OKwt31eb8HAuEOZR8Y0iK0GdGwTbsRT+c6QBLdnCetdhwh5Pid+6B2Kn
	U2NTXvHg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vOg43-003SKZ-2s;
	Thu, 27 Nov 2025 17:45:55 +0000
Date: Thu, 27 Nov 2025 17:45:55 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
	Stefano Garzarella <sgarzare@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 03/11] KEYS: trusted: remove redundant instance of
 tpm2_hash_map
Message-ID: <aSiOU7G1DEf-5-1a@earth.li>
References: <20251127135445.2141241-1-jarkko@kernel.org>
 <20251127135445.2141241-4-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251127135445.2141241-4-jarkko@kernel.org>

On Thu, Nov 27, 2025 at 03:54:35PM +0200, Jarkko Sakkinen wrote:
>Trusted keys duplicates tpm2_hash_map from TPM driver internals. Implement
>and export `tpm2_find_hash_alg()` in order to address this glitch, and
>replace redundant code block with a call this new function.
>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
>v7:
>- A new patch.
>---
> drivers/char/tpm/tpm2-cmd.c               | 19 +++++++++++++++--
> include/linux/tpm.h                       |  7 ++-----
> security/keys/trusted-keys/trusted_tpm2.c | 25 +++++------------------
> 3 files changed, 24 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index 97501c567c34..1393bfbeca64 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -18,7 +18,10 @@ static bool disable_pcr_integrity;
> module_param(disable_pcr_integrity, bool, 0444);
> MODULE_PARM_DESC(disable_pcr_integrity, "Disable integrity protection of TPM2_PCR_Extend");
>
>-static struct tpm2_hash tpm2_hash_map[] = {
>+static struct {
>+	unsigned int crypto_id;
>+	unsigned int alg_id;
>+} tpm2_hash_map[] = {
> 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
>@@ -26,6 +29,18 @@ static struct tpm2_hash tpm2_hash_map[] = {
> 	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> };
>
>+int tpm2_find_hash_alg(unsigned int crypto_id)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++)
>+		if (crypto_id == tpm2_hash_map[i].crypto_id)
>+			return tpm2_hash_map[i].alg_id;
>+
>+	return -EINVAL;
>+}
>+EXPORT_SYMBOL_GPL(tpm2_find_hash_alg);
>+
> int tpm2_get_timeouts(struct tpm_chip *chip)
> {
> 	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
>@@ -490,7 +505,7 @@ static int tpm2_init_bank_info(struct tpm_chip *chip, u32 bank_index)
> 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> 		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
>
>-		if (bank->alg_id != tpm2_hash_map[i].tpm_id)
>+		if (bank->alg_id != tpm2_hash_map[i].alg_id)
> 			continue;
>
> 		bank->digest_size = hash_digest_size[crypto_algo];
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 0e9e043f728c..e5fc7b73de2d 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -410,11 +410,6 @@ enum tpm2_session_attributes {
> 	TPM2_SA_AUDIT			= BIT(7),
> };
>
>-struct tpm2_hash {
>-	unsigned int crypto_id;
>-	unsigned int tpm_id;
>-};
>-
> int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
> void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
> int tpm_buf_init_sized(struct tpm_buf *buf);
>@@ -465,6 +460,7 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
>
> #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
>
>+unsigned int tpm2_alg_to_crypto_id(unsigned int alg_id);
> extern int tpm_is_tpm2(struct tpm_chip *chip);
> extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
> extern void tpm_put_ops(struct tpm_chip *chip);

This looks like an errant chunk? I can't see tpm2_alg_to_crypto_id 
defined or used?

>@@ -477,6 +473,7 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
> extern struct tpm_chip *tpm_default_chip(void);
> void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
>+int tpm2_find_hash_alg(unsigned int crypto_id);
>
> static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
> {
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index 024be262702f..3205732fb4b7 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -18,14 +18,6 @@
>
> #include "tpm2key.asn1.h"
>
>-static struct tpm2_hash tpm2_hash_map[] = {
>-	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
>-	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
>-	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
>-	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
>-	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
>-};
>-
> static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
>
> static int tpm2_key_encode(struct trusted_key_payload *payload,
>@@ -244,24 +236,17 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> 	off_t offset = TPM_HEADER_SIZE;
> 	struct tpm_buf buf, sized;
> 	int blob_len = 0;
>-	u32 hash;
>+	int hash;
> 	u32 flags;
>-	int i;
> 	int rc;
>
>-	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
>-		if (options->hash == tpm2_hash_map[i].crypto_id) {
>-			hash = tpm2_hash_map[i].tpm_id;
>-			break;
>-		}
>-	}
>-
>-	if (i == ARRAY_SIZE(tpm2_hash_map))
>-		return -EINVAL;
>-
> 	if (!options->keyhandle)
> 		return -EINVAL;
>
>+	hash = tpm2_find_hash_alg(options->hash);
>+	if (hash)
>+		return hash;
>+
> 	rc = tpm_try_get_ops(chip);
> 	if (rc)
> 		return rc;
>-- 
>2.52.0

J.

-- 
Design a system any fool can use, and only a fool will want to use it.

