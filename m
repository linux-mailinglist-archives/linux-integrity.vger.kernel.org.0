Return-Path: <linux-integrity+bounces-7505-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73CBF0E88
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 13:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E5D3B8308
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D71303C93;
	Mon, 20 Oct 2025 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="xQKNCw6s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A732FB63F;
	Mon, 20 Oct 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960739; cv=none; b=hLYQ5AI1EuKORkM5CE9WjeGs2DDOrN+qJ9iTIx3/clklznl2VC+7/C7C0QB6ofVWst8/xXq+MUSUDZywzXFaInYYeGuu7QSP3fS4BzZWzXx7Nq2yEKIur6hGxDZwVs+OtjTgvL5QhjAHf3nBZai9YtA6N53ZP4QsoqNg3lsvkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960739; c=relaxed/simple;
	bh=4W6J1MPQuj1MIvZTZKDBDx6aXipi5cHm5dRE8cZm92k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf8psoDPYI3rd8QOWrhG+VcIhnRxhk/QAXOXOAnyzKnlHRyQz2Do6PjLFSAD8Z7mKfUTvXBlPdwzXJfIdss9nNUeFcFjTfdNngxig7VcDz/7/yMqmFfi6b56E2Poc30erm3amaPtj3ncW6n5mvfAdNsCzt9i8R2NfGHrvSBE6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=xQKNCw6s; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4BaQz2iEXCbt+8iv9GBaDt4b6GbSPbbkwBwSUhK1Fqc=; b=xQKNCw6svMd0TUflIFY/a/6kL2
	7IeUJl2cR5GR/ZV+iuBCqyFjow/uOH+WiN5bdrHnMgTVwoW3N5nZJx7G1HqjRj6Bw+FdEbEpR8q+K
	ByQDrzFQEaHTbmFcyoN1o96MMLlJjMcCy8Qk373D8gmO+EF5KDxoyZUfg4+LdYWeiejCaQIGkSlsW
	VzLmtjiAbGCU6+q/twXcjALkqSC2KwX0sO8JEFQisYF86sLqc1DTOU/MvjP1y6IDtQPxtlmAa1ACU
	EnOVLBzP/uJ5d7Ws/z2WkeUC8HwCZC4MkxFux2KOeibSQO8vFFP1ryo4CGXDHv3dM2hdATsjCYZIG
	+WHsEGUA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vAoKK-001PRv-07;
	Mon, 20 Oct 2025 12:45:24 +0100
Date: Mon, 20 Oct 2025 12:45:24 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyring@vger.kernel.org,
	dpsmith@apertussolutions.com, ross.philipson@oracle.com,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] tpm: Cap the number of PCR banks
Message-ID: <aPYg1N0TvrkG6AJI@earth.li>
References: <20251018111725.3116386-1-jarkko@kernel.org>
 <20251018111725.3116386-2-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251018111725.3116386-2-jarkko@kernel.org>

On Sat, Oct 18, 2025 at 02:17:16PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>tpm2_get_pcr_allocation() does not cap any upper limit for the number of
>banks. Cap the limit to four banks so that out of bounds values coming
>from external I/O cause on only limited harm.

Comment no longer matches code - we cap at 8. With the comment fixed:

Reviewed-By: Jonathan McDowell <noodles@meta.com>

>Cc: Roberto Sassu <roberto.sassu@huawei.com>
>Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v6
>- No changes.
>v5:
>- No changes.
>v4:
>- Revert spurious changes from include/linux/tpm.h.
>- Increase TPM2_MAX_BANKS to 8.
>- Rename TPM2_MAX_BANKS as TPM2_MAX_PCR_BANKS for the sake of clarity.
>v3:
>- Wrote a more clear commit message.
>- Fixed pr_err() message.
>v2:
>- A new patch.
>---
> drivers/char/tpm/tpm-chip.c | 13 +++++++++----
> drivers/char/tpm/tpm.h      |  1 -
> drivers/char/tpm/tpm1-cmd.c | 25 -------------------------
> drivers/char/tpm/tpm2-cmd.c |  8 +++-----
> include/linux/tpm.h         |  8 +++++---
> 5 files changed, 17 insertions(+), 38 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>index e25daf2396d3..6cb25862688f 100644
>--- a/drivers/char/tpm/tpm-chip.c
>+++ b/drivers/char/tpm/tpm-chip.c
>@@ -559,14 +559,19 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>
> static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> {
>-	int rc;
>+	int rc = 0;
>
> 	if (tpm_is_firmware_upgrade(chip))
> 		return 0;
>
>-	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
>-	     tpm2_get_pcr_allocation(chip) :
>-	     tpm1_get_pcr_allocation(chip);
>+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
>+		chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
>+		chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
>+		chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
>+		chip->nr_allocated_banks = 1;
>+	} else {
>+		rc = tpm2_get_pcr_allocation(chip);
>+	}
>
> 	if (rc > 0)
> 		return -ENODEV;
>diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>index 2726bd38e5ac..a37712c02e44 100644
>--- a/drivers/char/tpm/tpm.h
>+++ b/drivers/char/tpm/tpm.h
>@@ -252,7 +252,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
> ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
> 		    const char *desc, size_t min_cap_length);
> int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
>-int tpm1_get_pcr_allocation(struct tpm_chip *chip);
> unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> int tpm_pm_suspend(struct device *dev);
> int tpm_pm_resume(struct device *dev);
>diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>index cf64c7385105..5c49bdff33de 100644
>--- a/drivers/char/tpm/tpm1-cmd.c
>+++ b/drivers/char/tpm/tpm1-cmd.c
>@@ -786,28 +786,3 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
>
> 	return rc;
> }
>-
>-/**
>- * tpm1_get_pcr_allocation() - initialize the allocated bank
>- * @chip: TPM chip to use.
>- *
>- * The function initializes the SHA1 allocated bank to extend PCR
>- *
>- * Return:
>- * * 0 on success,
>- * * < 0 on error.
>- */
>-int tpm1_get_pcr_allocation(struct tpm_chip *chip)
>-{
>-	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
>-					GFP_KERNEL);
>-	if (!chip->allocated_banks)
>-		return -ENOMEM;
>-
>-	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
>-	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
>-	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
>-	chip->nr_allocated_banks = 1;
>-
>-	return 0;
>-}
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index 7d77f6fbc152..97501c567c34 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>
> 	nr_possible_banks = be32_to_cpup(
> 		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
>-
>-	chip->allocated_banks = kcalloc(nr_possible_banks,
>-					sizeof(*chip->allocated_banks),
>-					GFP_KERNEL);
>-	if (!chip->allocated_banks) {
>+	if (nr_possible_banks > TPM2_MAX_PCR_BANKS) {
>+		pr_err("tpm: unexpected number of banks: %u > %u",
>+		       nr_possible_banks, TPM2_MAX_PCR_BANKS);
> 		rc = -ENOMEM;
> 		goto out;
> 	}
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index dc0338a783f3..eb0ff071bcae 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -26,7 +26,9 @@
> #include <crypto/aes.h>
>
> #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
>-#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
>+
>+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
>+#define TPM2_MAX_PCR_BANKS	8
>
> struct tpm_chip;
> struct trusted_key_payload;
>@@ -68,7 +70,7 @@ enum tpm2_curves {
>
> struct tpm_digest {
> 	u16 alg_id;
>-	u8 digest[TPM_MAX_DIGEST_SIZE];
>+	u8 digest[TPM2_MAX_DIGEST_SIZE];
> } __packed;
>
> struct tpm_bank_info {
>@@ -189,7 +191,7 @@ struct tpm_chip {
> 	unsigned int groups_cnt;
>
> 	u32 nr_allocated_banks;
>-	struct tpm_bank_info *allocated_banks;
>+	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
> #ifdef CONFIG_ACPI
> 	acpi_handle acpi_dev_handle;
> 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
>-- 
>2.39.5

J.

-- 
Is it real, or is it Mimozine?
This .sig brought to you by the letter N and the number  9
Product of the Republic of HuggieTag

