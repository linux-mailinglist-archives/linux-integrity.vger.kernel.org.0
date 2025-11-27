Return-Path: <linux-integrity+bounces-7706-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FAEC8FF0A
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 19:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34C304E2E24
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1975B2EF66A;
	Thu, 27 Nov 2025 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgfmC+hk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153279C8;
	Thu, 27 Nov 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764269532; cv=none; b=nqDBKld5gK4Nt8zJ6Tc4jnaFc2y4TAr29G6igqJy5odNwbZuqBMJb68B4XQsimg5xOVGcj0YEaH2AhXAtxD38fwbTc45LpCbtLk52FzNJ8fnd5TwcZttoTRT8fZNSn6h6BUYj3Ho9YK5qrWPtQEsBcuoFb6phnrzROk4BJC5j/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764269532; c=relaxed/simple;
	bh=q1e2k3uCojRRD3R6kVKdfXaCW7LNQMZVBtBJtxJTO1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2MCtSVtdYGAst9je4O0ech/TFCVhWAERtq9gmLgaqE1vqtOJRcnvG1VWc13qd0HAum0QIEOljs5xn61cDExyqBnp3CTEs3Z4aZjbj3LcHtof684vwH/gOeIdnsUz6vweNYlYX+xfG8TE59D3vtS5rVYc+e2PJ6I88+1PiuSYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgfmC+hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2927C4CEF8;
	Thu, 27 Nov 2025 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764269531;
	bh=q1e2k3uCojRRD3R6kVKdfXaCW7LNQMZVBtBJtxJTO1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgfmC+hkmhfQowoD8leqCiiyxjh3ljM14SDmai9zgyT6Fhqe1JWcg4ny0HxnjODem
	 rfwWw2V5dASeCgSwwwhOsjDpb82gw3SS7QKUySQrd3CCp0N34IonuB/lZNhXJE6MYt
	 0sVy1gd/WEXWQILUrKyNbl6l8JY1WjQFBUTZnLHVYq5Ib1V7C/PT0zZZ53ASbcBsWt
	 NDjX6brW/995hCzMG30ihFtBBiFhYF0ho9XX+DiOy764LXj+nCytKNzHyCqnfV8Mip
	 Vqp0bOJp5eaKLRXTYXjtEPAKMpsf+iAaaqGSswm7yYrT5hlyArRifbHnz5aJVu0oOe
	 cIFUi7o3kZKRw==
Date: Thu, 27 Nov 2025 20:52:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/11] tpm: Cap the number of PCR banks
Message-ID: <aSid1oEcDY9mzwq4@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
 <20251127135445.2141241-2-jarkko@kernel.org>
 <69de8fea4851ef378613e66685c3c34c43d71f05.camel@huaweicloud.com>
 <aSiG7l_1E12r_56c@kernel.org>
 <a6e73690e73b7a3e190719d179dbc73b93d1c1f1.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6e73690e73b7a3e190719d179dbc73b93d1c1f1.camel@huaweicloud.com>

On Thu, Nov 27, 2025 at 06:17:42PM +0100, Roberto Sassu wrote:
> On Thu, 2025-11-27 at 19:14 +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 27, 2025 at 05:09:38PM +0100, Roberto Sassu wrote:
> > > On Thu, 2025-11-27 at 15:54 +0200, Jarkko Sakkinen wrote:
> > > > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > > > 
> > > > tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> > > > banks. Cap the limit to eight banks so that out of bounds values coming
> > > > from external I/O cause on only limited harm.
> > > > 
> > > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Sorry, I realized that you are expecting me to review.
> > > 
> > > I have a couple of questions:
> > > - Could you explain better how out of bounds would occur, since one
> > >   could check the number of PCR banks?
> > > - Is dynamic allocation that bad? And if yes, why?
> > > - Couldn't you just check that the number of available PCR banks is 
> > >   below the threshold you like and keep dynamic allocation?
> > > - Is removing tpm1_get_pcr_allocation() improving code readability?
> > 
> > nr_possible_banks is read from external source i.e., neither kernel nor
> > CPU fully control its value. This causes *uncontrolled* dynamic
> > allocation. Thus, it must be capped to some value.
> 
> Sure, I'm fine with capping. Isn't that enough?

It makes sense to make the whole memory allocation then infallible,
especially since it does not have much effect on diff. And it has
not significant effect on memory usage either.

But I do see one completely spurious and actually unintended change 
that I spotted: tpm1_get_pcr_allocation. It there's no intention
doing this it has just carried over the series.

I reverted that part, which make it look like a proper bug fix:

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 11088bda4e68..6849f216ba0b 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -799,11 +799,6 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
  */
 int tpm1_get_pcr_allocation(struct tpm_chip *chip)
 {
-	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
-					GFP_KERNEL);
-	if (!chip->allocated_banks)
-		return -ENOMEM;
-
 	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
 	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
 	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7d77f6fbc152..97501c567c34 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)

 	nr_possible_banks = be32_to_cpup(
 		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
-
-	chip->allocated_banks = kcalloc(nr_possible_banks,
-					sizeof(*chip->allocated_banks),
-					GFP_KERNEL);
-	if (!chip->allocated_banks) {
+	if (nr_possible_banks > TPM2_MAX_PCR_BANKS) {
+		pr_err("tpm: unexpected number of banks: %u > %u",
+		       nr_possible_banks, TPM2_MAX_PCR_BANKS);
 		rc = -ENOMEM;
 		goto out;
 	}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dc0338a783f3..eb0ff071bcae 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -26,7 +26,9 @@
 #include <crypto/aes.h>

 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
+
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+#define TPM2_MAX_PCR_BANKS	8

 struct tpm_chip;
 struct trusted_key_payload;
@@ -68,7 +70,7 @@ enum tpm2_curves {

 struct tpm_digest {
 	u16 alg_id;
-	u8 digest[TPM_MAX_DIGEST_SIZE];
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
 } __packed;

 struct tpm_bank_info {
@@ -189,7 +191,7 @@ struct tpm_chip {
 	unsigned int groups_cnt;

 	u32 nr_allocated_banks;
-	struct tpm_bank_info *allocated_banks;
+	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];


> 
> Thanks
> 
> Roberto
> 
> > > Thanks
> > > 
> > > Roberto
> > 
> > BR, Jarkko
> 

BR, Jarkko

