Return-Path: <linux-integrity+bounces-7709-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1CC90339
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DE974E1B22
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 21:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6631B83B;
	Thu, 27 Nov 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/zY11KA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38930AAB3;
	Thu, 27 Nov 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279712; cv=none; b=dJgou2h/0SjsMw85aW9pC+adJ1/Hw2R/mT2Ng0zE9k+RGdXCUlh+ScT58l1YStZlMcyIyg6S2DqbiqWLgrBUtHRvcmimWIoYBC8d4/GLyP/9j/rwJyovtUDxno8fjDYGS0fD0SPIyCe+H7bCbrdnGsqc2dvugXxZn9Aw1QxZOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279712; c=relaxed/simple;
	bh=x5IVYeyCJT+MJspL305CXeech68ZAZZvBLvSX33jO0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmknNsbRvXo23gVJtiPYVVJ9gXP9JmJJDvyLM9qVcMBOkl733oInYuM5+6k9Difb0h0FHXd4ioQvgQoq7NA02SWkEEU9acryY9TXC+QvgjMq3UrVkVDx0gO4L45VeojoPnaM19eBtRUF85EQj6ckvBYrUmK/MTyaESZxBGg1CUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/zY11KA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A56BC4CEF8;
	Thu, 27 Nov 2025 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764279712;
	bh=x5IVYeyCJT+MJspL305CXeech68ZAZZvBLvSX33jO0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/zY11KA5fMZ1J1CwhB2yVmyYM6Jail/7zSPgkJR+aXcIPyw78TsXDGPJoD71F8Uw
	 hGOEwCNE2nF07GYWVReIqgxDxvyR6qOVt9/u5uSsQhtz6OvKvR5Q2hD/p0zP1mlxDH
	 lxVmMbk01YYI0ZM6WjZ9CCBZuRlQGP56pAYF1qLRj4MZYmPxsJIuk1OZAf5aVb+Na/
	 R4WuifE3aPHGuA5QhBNxyWGLPADYBfj0+h1WKy4mlGoO2Cnxxv7K7dt0f6XlPoqKW5
	 GNIAH30OlUtGKgXF1ybgpS3DjHYh+gzYcmyTqe7C4EVsMQ+7yu0XhNdVFmATDtJar4
	 LwSj1AhhjNngw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	stable@vger.kernel.org,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/11] tpm: Cap the number of PCR banks
Date: Thu, 27 Nov 2025 23:41:26 +0200
Message-ID: <20251127214138.3760029-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127214138.3760029-1-jarkko@kernel.org>
References: <20251127214138.3760029-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

tpm2_get_pcr_allocation() does not cap any upper limit for the number of
banks. Cap the limit to eight banks so that out of bounds values coming
from external I/O cause on only limited harm.

Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: stable@vger.kernel.org # v5.10+
Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v8:
- Remove unrelated change of removing tpm1_get_pcr_allocation.
- Add the missing '\n' to the error message.
v7:
- In Ryzen desktop there is total three banks so yep, eight is probably
  much safer bet than four banks. Fixed the commit message as per remark
  from Jonathan:

  https://lore.kernel.org/linux-integrity/aPYg1N0TvrkG6AJI@earth.li/#t

  And with that added also reviewed-by.
v6
- No changes.
v5:
- No changes.
v4:
- Revert spurious changes from include/linux/tpm.h.
- Increase TPM2_MAX_BANKS to 8.
- Rename TPM2_MAX_BANKS as TPM2_MAX_PCR_BANKS for the sake of clarity.
v3:
- Wrote a more clear commit message.
- Fixed pr_err() message.
v2:
- A new patch.
---
 drivers/char/tpm/tpm1-cmd.c | 5 -----
 drivers/char/tpm/tpm2-cmd.c | 8 +++-----
 include/linux/tpm.h         | 8 +++++---
 3 files changed, 8 insertions(+), 13 deletions(-)

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
index 7d77f6fbc152..5b6ccf901623 100644
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
+		pr_err("tpm: out of bank capacity: %u > %u\n",
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
-- 
2.52.0


