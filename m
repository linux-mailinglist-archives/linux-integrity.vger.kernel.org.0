Return-Path: <linux-integrity+bounces-7734-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A2C917E8
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 10:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294383A8614
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A6302CDC;
	Fri, 28 Nov 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="GTgNNcLe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EE17736;
	Fri, 28 Nov 2025 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323099; cv=none; b=W7s1WWXsp3hgV3AW9VvUZ0iAf7MP70CQOkFJLqGMLmxtDP6HNHQ+wFBYFvgZgYx3tCSZwosDG2Hf/e2GWyeRYpA7JDHD8bvhvdKrfMztpBF26+qDhPzQcHMcHVFjwYb5b4Jd+lbM66lIbvqdCJavntmwOhP46bpRLJysHJ+hI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323099; c=relaxed/simple;
	bh=oC6vyIsI+W/xXOBsy9FLVP9iGnfADrvC3JaB1+wfgVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku4U7cyvB8CEHeRq6y4Gm+ptIffHRdFJDuAvKjEEggIFlWRBR8MyiZWnYJJ9w4p8YraibFFUwef4BIt2xPKzigh5LZrX197vMAYJcHCrGqgV9+BK53ClCJ0Uk4bhQc3zXgAKopFMof6O248CyyFVpUd1OsNi4NRAv+Esu+WVQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=GTgNNcLe; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DsDz+4XYke85unOw/PommzhvKZvdbMz/WrAoo0TX6Fo=; b=GTgNNcLe2Y8Duaoeca11ALLojL
	KCM9pjiI6KEJS/Umw11nLrBFpTIf9pGEKlGnaLfYTMIdpCuVjBB5M6yAECG3UrnlMe1y2U3IMu9z1
	lGIiS/6CZjjlCN+jmawHAfYoeUM/V05J7YrpedhveN3LfvU1vPBpevBlRvWkw0CtDBWlCs2z8Ek/t
	KubNB1nXTl+p4+NVKsF2i5RR+9zWUPc3zWuWA0gPPneOB+djv52H2atNdQc5by4UlYZEjJ1Qwolzc
	fKonI7u5wmJkjOcldCb7KTcvCX+6W2CWj5m7Hm6FNhhBy8dkLZb8iHNmP3dZsNKhi723E+8bNv57A
	KGhIRULA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vOv1t-007T0x-0J;
	Fri, 28 Nov 2025 09:44:41 +0000
Date: Fri, 28 Nov 2025 09:44:41 +0000
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
Subject: Re: [PATCH v9 3/8] KEYS: trusted: Replace a redundant instance of
 tpm2_hash_map
Message-ID: <aSlvCROaUqwZ244Z@earth.li>
References: <20251128025402.4147024-1-jarkko@kernel.org>
 <20251128025402.4147024-4-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251128025402.4147024-4-jarkko@kernel.org>

On Fri, Nov 28, 2025 at 04:53:55AM +0200, Jarkko Sakkinen wrote:
>'trusted_tpm2' duplicates 'tpm2_hash_map' originally part of the TPN
>driver, which is suboptimal.
>
>Implement and export `tpm2_find_hash_alg()` in the driver, and substitute
>the redundant code in 'trusted_tpm2' with a call to the new function.
>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Jonathan McDowell <noodles@meta.com>

>---
>v9:
>- Improved the commit message a bit.
>v8:
>- Remove spurious tpm2_alg_to_crypto_id.
>- Check return value of tpm2_find_hash_alg correctly in trusted_tpm2.c
>  i.e, fail on "hash_alg < 0". Trusted keys were tested but I had my
>  test harness misconfigured. I bisected the failure to this patch.
>- The diff was not exactly minimal. Further optimize it.
>v7:
>- A new patch.
>---
> drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++++-
> include/linux/tpm.h                       |  1 +
> security/keys/trusted-keys/trusted_tpm2.c | 23 ++++-------------------
> 3 files changed, 18 insertions(+), 20 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index e298194883e8..a121c518ff6f 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -18,7 +18,7 @@ static bool disable_pcr_integrity;
> module_param(disable_pcr_integrity, bool, 0444);
> MODULE_PARM_DESC(disable_pcr_integrity, "Disable integrity protection of TPM2_PCR_Extend");
>
>-static struct tpm2_hash tpm2_hash_map[] = {
>+struct tpm2_hash tpm2_hash_map[] = {
> 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
>@@ -26,6 +26,18 @@ static struct tpm2_hash tpm2_hash_map[] = {
> 	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> };
>
>+int tpm2_find_hash_alg(unsigned int crypto_id)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++)
>+		if (crypto_id == tpm2_hash_map[i].crypto_id)
>+			return tpm2_hash_map[i].tpm_id;
>+
>+	return -EINVAL;
>+}
>+EXPORT_SYMBOL_GPL(tpm2_find_hash_alg);
>+
> int tpm2_get_timeouts(struct tpm_chip *chip)
> {
> 	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 973458a38250..cbd3a70c0378 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -477,6 +477,7 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
> extern struct tpm_chip *tpm_default_chip(void);
> void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
>+int tpm2_find_hash_alg(unsigned int crypto_id);
>
> static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
> {
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index c414a7006d78..4467e880ebd5 100644
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
>@@ -244,20 +236,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
>+	hash = tpm2_find_hash_alg(options->hash);
>+	if (hash < 0)
>+		return hash;
>
> 	if (!options->keyhandle)
> 		return -EINVAL;
>-- 
>2.52.0
>

J.

-- 
I am afraid of the dark.
This .sig brought to you by the letter O and the number  5
Product of the Republic of HuggieTag

