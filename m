Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5F65B48
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfGKQNy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 12:13:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727612AbfGKQNy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 12:13:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BGDdWH037434
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 12:13:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tp7dyk3tn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 12:13:52 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 11 Jul 2019 17:13:50 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Jul 2019 17:13:46 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6BGDWXS31523146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 16:13:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D3F11C05C;
        Thu, 11 Jul 2019 16:13:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BA7711C04A;
        Thu, 11 Jul 2019 16:13:42 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.41.99.131])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jul 2019 16:13:42 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v3] tpm: tpm_ibm_vtpm: Fix unallocated banks
Date:   Thu, 11 Jul 2019 12:13:35 -0400
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071116-0020-0000-0000-00000352D9C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071116-0021-0000-0000-000021A694B3
Message-Id: <1562861615-11391-1-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110183
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The nr_allocated_banks and allocated banks are initialized as part of
tpm_chip_register. Currently, this is done as part of auto startup
function. However, some drivers, like the ibm vtpm driver, do not run
auto startup during initialization. This results in uninitialized memory
issue and causes a kernel panic during boot.

This patch moves the pcr allocation outside the auto startup function
into tpm_chip_register. This ensures that allocated banks are initialized
in any case.

Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
PCR read")
Reported-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Michal Suchánek <msuchanek@suse.de>
---
Changelog:
v3:
* Includes Stefan's feedback correctly:
  * Fixed handling of rc > 0 error
* Includes Jarkko's feedback related to comment and the function.

v2:
* Includes Jarkko's feedbacks
  * fixes the function name to tpm_get_pcr_allocation()
  * adds new function tpm1_get_pcr_allocation()
  * updates patch summary line
  * fixes alignment
  * adds Reported-by: Michal Suchanek <msuchanek@suse.de>
* Includes Stefan's feedbacks
  * Fixes overwriting of return code
  * Fixes misplacing of tpm_chip_stop()
* Adds Reviewed-by, Tested-by

 drivers/char/tpm/tpm-chip.c | 20 ++++++++++++++++++++
 drivers/char/tpm/tpm.h      |  2 ++
 drivers/char/tpm/tpm1-cmd.c | 36 ++++++++++++++++++++++++------------
 drivers/char/tpm/tpm2-cmd.c |  6 +-----
 4 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8804c9e916fd..5a0396d6560d 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -550,6 +550,20 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
 	return hwrng_register(&chip->hwrng);
 }
 
+static int tpm_get_pcr_allocation(struct tpm_chip *chip)
+{
+	int rc;
+
+	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
+	     tpm2_get_pcr_allocation(chip) :
+	     tpm1_get_pcr_allocation(chip);
+
+	if (rc > 0)
+		return -ENODEV;
+
+	return rc;
+}
+
 /*
  * tpm_chip_register() - create a character device for the TPM chip
  * @chip: TPM chip to use.
@@ -569,6 +583,12 @@ int tpm_chip_register(struct tpm_chip *chip)
 	if (rc)
 		return rc;
 	rc = tpm_auto_startup(chip);
+	if (rc) {
+		tpm_chip_stop(chip);
+		return rc;
+	}
+
+	rc = tpm_get_pcr_allocation(chip);
 	tpm_chip_stop(chip);
 	if (rc)
 		return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2cce072f25b5..d571df3694c3 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -399,6 +399,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
 int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
+int tpm1_get_pcr_allocation(struct tpm_chip *chip);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
@@ -454,6 +455,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
+ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 85dcf2654d11..260a3917f0fe 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -696,18 +696,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
-	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
-					GFP_KERNEL);
-	if (!chip->allocated_banks) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
-	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
-	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
-	chip->nr_allocated_banks = 1;
-
 	return rc;
 out:
 	if (rc > 0)
@@ -776,3 +764,27 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 	return rc;
 }
 
+/**
+ * tpm1_get_pcr_allocation() - initialize the allocated bank
+ * @chip: TPM chip to use.
+ *
+ * The function initializes the SHA1 allocated bank to extend PCR
+ *
+ * Return:
+ * * 0 on success,
+ * * < 0 on error.
+ */
+int tpm1_get_pcr_allocation(struct tpm_chip *chip)
+{
+	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
+					GFP_KERNEL);
+	if (!chip->allocated_banks)
+		return -ENOMEM;
+
+	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
+	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
+	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
+	chip->nr_allocated_banks = 1;
+
+	return 0;
+}
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e74c5b7b64bf..b4384d0e3741 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -841,7 +841,7 @@ struct tpm2_pcr_selection {
 	u8  pcr_select[3];
 } __packed;
 
-static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
+ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 {
 	struct tpm2_pcr_selection pcr_selection;
 	struct tpm_buf buf;
@@ -1041,10 +1041,6 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 			goto out;
 	}
 
-	rc = tpm2_get_pcr_allocation(chip);
-	if (rc)
-		goto out;
-
 	rc = tpm2_get_cc_attrs_tbl(chip);
 
 out:
-- 
2.20.1

