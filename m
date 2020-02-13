Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6596E15CC49
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 21:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgBMUXi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 15:23:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbgBMUXi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 15:23:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DKLcOA139557;
        Thu, 13 Feb 2020 15:23:33 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j86wp1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 15:23:33 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DKKRfR005228;
        Thu, 13 Feb 2020 20:23:32 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2y5bc0h3ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 20:23:32 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DKNV4411207330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 20:23:31 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91187112066;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79CB5112064;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 20:23:31 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 3/4] tpm: Implement tpm2_init to call when TPM_OPS_AUTO_STARTUP is not set
Date:   Thu, 13 Feb 2020 15:23:28 -0500
Message-Id: <20200213202329.898607-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_08:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement tpm2_init() that gets the TPM 2 timeouts and command durations
and command code attributes. This function is to be called in case the
TPM_OPS_AUTO_STARTUP flag is not set and therefore tpm2_auto_startup()
is not called.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  5 ++++-
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index a438b1206fcb..cca0e542172d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -371,8 +371,11 @@ int tpm_auto_startup(struct tpm_chip *chip)
 {
 	int rc;
 
-	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP))
+	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP)) {
+		if (chip->flags & TPM_CHIP_FLAG_TPM2)
+			return tpm2_init(chip);
 		return 0;
+	}
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_auto_startup(chip);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 5620747da0cf..895f8a1e17d2 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -222,6 +222,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
+int tpm2_init(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 13696deceae8..d5b4b0449c23 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -709,6 +709,20 @@ static int tpm2_startup(struct tpm_chip *chip)
 	return rc;
 }
 
+/**
+ * tpm2_init - Get timeouts and command code attributes
+ *             in case tpm2_auto_startup is not used.
+ * @chip: TPM chip to use
+ *
+ * Return 0 on success, < 0 in case of fatal error.
+ */
+int tpm2_init(struct tpm_chip *chip)
+{
+	tpm2_get_timeouts(chip);
+
+	return tpm2_get_cc_attrs_tbl(chip);
+}
+
 /**
  * tpm2_auto_startup - Perform the standard automatic TPM initialization
  *                     sequence
-- 
2.23.0

