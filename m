Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D131316F09B
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 21:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgBYUxS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 15:53:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728367AbgBYUxS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 15:53:18 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PKp1je139582;
        Tue, 25 Feb 2020 15:53:12 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yaygqchea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 15:53:12 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01PKghdX024778;
        Tue, 25 Feb 2020 20:53:11 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 2yaux6q32d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 20:53:11 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PKrA6E52101510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 20:53:10 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01207136053;
        Tue, 25 Feb 2020 20:53:10 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BAA413604F;
        Tue, 25 Feb 2020 20:53:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 20:53:09 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 3/4] tpm: Implement tpm2_init_commands to use in non-auto startup case
Date:   Tue, 25 Feb 2020 15:53:04 -0500
Message-Id: <20200225205305.3948001-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225205305.3948001-1-stefanb@linux.vnet.ibm.com>
References: <20200225205305.3948001-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_08:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

The IBM vTPM device driver will not use TPM_OPS_AUTO_STARTUP since we
assume the firmware has initialized the TPM 2 and TPM2_Startup() need
not be sent. Therefore, tpm2_auto_startup() will not be called. To cover
the tpm_chip's initialization of timeouts, command durations, and
command attributes we implement tpm2_init_commands() function that will
be called instead of tpm2_auto_startup().

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  5 ++++-
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index a438b1206fcb..30d80b94db33 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -371,8 +371,11 @@ int tpm_auto_startup(struct tpm_chip *chip)
 {
 	int rc;
 
-	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP))
+	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP)) {
+		if (chip->flags & TPM_CHIP_FLAG_TPM2)
+			return tpm2_init_commands(chip);
 		return 0;
+	}
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_auto_startup(chip);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 5620747da0cf..30da942d714a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -222,6 +222,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
+int tpm2_init_commands(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 13696deceae8..2d0c5a3b65c0 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -709,6 +709,20 @@ static int tpm2_startup(struct tpm_chip *chip)
 	return rc;
 }
 
+/**
+ * tpm2_init_commands - Get timeouts, durations and command code attributes
+ *                      in case tpm2_auto_startup is not used.
+ * @chip: TPM chip to use
+ *
+ * Return 0 on success, < 0 in case of fatal error.
+ */
+int tpm2_init_commands(struct tpm_chip *chip)
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

