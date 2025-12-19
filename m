Return-Path: <linux-integrity+bounces-8118-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13BCCF276
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 10:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41AF13038F48
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3B2820AC;
	Fri, 19 Dec 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="fFc14KzO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACC2D1914;
	Fri, 19 Dec 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136732; cv=none; b=MxOmpDkvjKW9GG5gRG5QCXF6tEmS4qjQlLs8GWDiGDr9LapeHHAsjSDlM0ayJczZ2mqM1sU2PezBdu17c+lavMU7MhR7z7ItZ/KFa1YDa9OEdCvw/4O/mQ/njybduatiPIGxyB4lTsEbgOE3NuUfyuykMUvSno07lg/s2F5yt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136732; c=relaxed/simple;
	bh=xC/6nDi0AkRFTeJmzaaR8UocFoB+waWVhJidMRjJZgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8u6UsnUkWrZ+T6z62xU2trBRTvjlvfe/I/n9tfP5v0Rgs9lyrkIofa2XV1+lqifjJ+qC+/TmHlzryvvXyrAe07bBqVcXCr89Xtme/El6UfbGUEk9kQATqjV3V6y00nfs/mkZ1d33x02j2m2SgkdjaSZZ5FSllA2ovdk+R4m2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=fFc14KzO; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZVX1yxlirPOx+c8T4LygoqEHC+5AB40jquLHhJDGoCg=; b=fFc14KzOgfqOG939bHVZdx3kig
	eggHitiuc2jdXjTlca0PoIcDxbrRZxgy0AzhjSeaV6YvimVGElpWtHtjszVC31V8WHjfaSfb7am2L
	TN4EiwXPw4H/E+LQibVkkj45B3eJzOusW9zM+FhUPOJ/reelH3D0GYHvkRu1oCVc/U8oqBvugyfS2
	+RSvATNyAzpzgiqkWTBaPHXxpC0aGtTyRijz1Ifng+z5XcNKQLf8PkBbGuq+iiuD9QnpN2Da1spcv
	WvuC/LZ4ECAxFisv3wqtJtT7eU1GyJZCcHhuj7U/Py8uMQK4ex7T7geRZObHJf5CzPNu1Zkwq41N3
	VT/YvPYg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vWWqA-00Eiye-1X;
	Fri, 19 Dec 2025 09:32:02 +0000
Date: Fri, 19 Dec 2025 09:32:02 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v8 05/12] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Message-ID: <aUUbkosWlOjZ48YP@earth.li>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-6-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251216092147.2326606-6-jarkko@kernel.org>

On Tue, Dec 16, 2025 at 11:21:39AM +0200, Jarkko Sakkinen wrote:
>Define TPM2_NAME_MAX_SIZE, which describes the maximum size for hashes
>encoded as TPMT_HA, which the prime identifier used for persistent and
>transient keys in TPM2 protocol.
>
>Set its value to 'SHA512_DIGEST_SIZE + 2', as SHA512 has the largest
>digest size of the algorithms in TCG algorithm repository.
>
>In additionl, rename TPM2_NAME_SIZE as TPM2_NULL_NAME_SIZE in order to
>avoid any possible confusion.

One minor capitalisation nit, otherwise:

Reviewed-by: Jonathan McDowell <noodles@meta.com>

>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
>v6:
>- Rewrote the commit message.
>v2:
>- Rename TPM2_NAME_SIZE as TPM2_NULL_NAME_SIZE.
>---
> drivers/char/tpm/tpm-sysfs.c     |  2 +-
> drivers/char/tpm/tpm2-sessions.c |  2 +-
> include/linux/tpm.h              | 37 +++++++++++++++++++++-----------
> 3 files changed, 27 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>index 94231f052ea7..4a6a27ee295d 100644
>--- a/drivers/char/tpm/tpm-sysfs.c
>+++ b/drivers/char/tpm/tpm-sysfs.c
>@@ -314,7 +314,7 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
> 			      char *buf)
> {
> 	struct tpm_chip *chip = to_tpm_chip(dev);
>-	int size = TPM2_NAME_SIZE;
>+	int size = TPM2_NULL_NAME_SIZE;
>
> 	bin2hex(buf, chip->null_key_name, size);
> 	size *= 2;
>diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
>index 4149379665c4..525b8622d1c3 100644
>--- a/drivers/char/tpm/tpm2-sessions.c
>+++ b/drivers/char/tpm/tpm2-sessions.c
>@@ -137,7 +137,7 @@ struct tpm2_auth {
> 	 * we must compute and remember
> 	 */
> 	u32 name_h[AUTH_MAX_NAMES];
>-	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
>+	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
> };
>
> #ifdef CONFIG_TCG_TPM2_HMAC
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 202da079d500..e10f2096eae7 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -27,9 +27,33 @@
>
> #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
>
>+/*
>+ * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
>+ */
> #define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
>+
>+/*
>+ * A TPM name digest i.e., TPMT_HA, is a concatenation of TPM_ALG_ID of the
>+ * name algorithm and hash of TPMT_PUBLIC.
>+ */
>+#define TPM2_MAX_NAME_SIZE	(TPM2_MAX_DIGEST_SIZE + 2)
>+
>+/*
>+ * The maximum number of PCR banks.
>+ */
> #define TPM2_MAX_PCR_BANKS	8
>
>+/*
>+ * fixed define for the size of a name.  This is actually HASHALG size

"Fixed define".

>+ * plus 2, so 32 for SHA256
>+ */
>+#define TPM2_NULL_NAME_SIZE	34
>+
>+/*
>+ * The maximum size for an object context
>+ */
>+#define TPM2_MAX_CONTEXT_SIZE	4096
>+
> struct tpm_chip;
> struct trusted_key_payload;
> struct trusted_key_options;
>@@ -139,17 +163,6 @@ struct tpm_chip_seqops {
> /* fixed define for the curve we use which is NIST_P256 */
> #define EC_PT_SZ	32
>
>-/*
>- * fixed define for the size of a name.  This is actually HASHALG size
>- * plus 2, so 32 for SHA256
>- */
>-#define TPM2_NAME_SIZE	34
>-
>-/*
>- * The maximum size for an object context
>- */
>-#define TPM2_MAX_CONTEXT_SIZE 4096
>-
> struct tpm_chip {
> 	struct device dev;
> 	struct device devs;
>@@ -211,7 +224,7 @@ struct tpm_chip {
> 	/* saved context for NULL seed */
> 	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
> 	 /* name of NULL seed */
>-	u8 null_key_name[TPM2_NAME_SIZE];
>+	u8 null_key_name[TPM2_NULL_NAME_SIZE];
> 	u8 null_ec_key_x[EC_PT_SZ];
> 	u8 null_ec_key_y[EC_PT_SZ];
> 	struct tpm2_auth *auth;
>-- 
>2.39.5
>
>

J.

-- 
Why do I get the feeling I'm going to regret this?
This .sig brought to you by the letter S and the number 50
Product of the Republic of HuggieTag

