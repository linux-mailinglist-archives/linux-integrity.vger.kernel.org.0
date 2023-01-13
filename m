Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB95669D6D
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jan 2023 17:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAMQRv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Jan 2023 11:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjAMQRV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Jan 2023 11:17:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280C8CD2C;
        Fri, 13 Jan 2023 08:10:36 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DEdU6h011808;
        Fri, 13 Jan 2023 16:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MCA785kWBXhTrXwJ6eVYTY5/yNgfBkb57o0LJH0dY9A=;
 b=nxGRs6vflBgqeafYJe0QVHV5KyuYMagBZec0Tvo+RctM9oY3Z58UhupTZpSxIp7sLte1
 CIWQK5n4QQ3yoOBk7FaEVnOCeEIRS80gFMtTmIVUK1MDizrloRUqFcrllAOASAPGFgdl
 L08ZoDHiNgsCQtiz49iv+RyKaW0xAL/rKAvKoLo9qDu3EEUarms40iz2hrgtrrkmoeIE
 ia5KJMK0q3GLfNS9aim9a/R34992HbNKHYy5fcKhdFE9FmYee/D69Q7hiwf08YGMMJZ8
 W53BIrIauokylBeQ0s39OzB1Jww4cWzyNROb8gpwwX6QWnyGMV2SO524gWrfNA4jiPm3 gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n38uh2vwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:28 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30DEhFnR021842;
        Fri, 13 Jan 2023 16:10:28 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n38uh2vvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:28 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30DDYKrO019012;
        Fri, 13 Jan 2023 16:10:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3n1knv8jvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30DGAQ2G56361366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 16:10:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E40B958061;
        Fri, 13 Jan 2023 16:10:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E997D58045;
        Fri, 13 Jan 2023 16:10:24 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.137.189])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jan 2023 16:10:24 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, jarkko@kernel.org,
        peterhuewe@gmx.de, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 1/2] tpm: Use managed allocation for bios event log
Date:   Fri, 13 Jan 2023 10:10:16 -0600
Message-Id: <20230113161017.1079299-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230113161017.1079299-1-eajames@linux.ibm.com>
References: <20230113161017.1079299-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v9EIH36wdkK4rvURnBuFOuV6IArU728m
X-Proofpoint-ORIG-GUID: JtZJf8Qb-xRXW1AQKjLBjQGQVRw7F6wn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since the bios event log is freed in the device release function,
let devres handle the deallocation. This will allow other memory
allocation/mapping functions to be used for the bios event log.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/char/tpm/eventlog/acpi.c |  5 +++--
 drivers/char/tpm/eventlog/efi.c  | 13 +++++++------
 drivers/char/tpm/eventlog/of.c   |  3 ++-
 drivers/char/tpm/tpm-chip.c      |  1 -
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 0913d3eb8d51..40360e599bc3 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -14,6 +14,7 @@
  * Access to the event log extended by the TCG BIOS of PC platform
  */
 
+#include <linux/device.h>
 #include <linux/seq_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
@@ -135,7 +136,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmalloc(len, GFP_KERNEL);
+	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
@@ -160,7 +161,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	return format;
 
 err:
-	kfree(log->bios_event_log);
+	devm_kfree(&chip->dev, log->bios_event_log);
 	log->bios_event_log = NULL;
 	return ret;
 }
diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index e6cb9d525e30..4e9d7c2bf32e 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -6,6 +6,7 @@
  *      Thiebaud Weksteen <tweek@google.com>
  */
 
+#include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/tpm_eventlog.h>
 
@@ -55,7 +56,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
+	log->bios_event_log = devm_kmemdup(&chip->dev, log_tbl->log, log_size, GFP_KERNEL);
 	if (!log->bios_event_log) {
 		ret = -ENOMEM;
 		goto out;
@@ -76,7 +77,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 			     MEMREMAP_WB);
 	if (!final_tbl) {
 		pr_err("Could not map UEFI TPM final log\n");
-		kfree(log->bios_event_log);
+		devm_kfree(&chip->dev, log->bios_event_log);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -91,11 +92,11 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	 * Allocate memory for the 'combined log' where we will append the
 	 * 'final events log' to.
 	 */
-	tmp = krealloc(log->bios_event_log,
-		       log_size + final_events_log_size,
-		       GFP_KERNEL);
+	tmp = devm_krealloc(&chip->dev, log->bios_event_log,
+			    log_size + final_events_log_size,
+			    GFP_KERNEL);
 	if (!tmp) {
-		kfree(log->bios_event_log);
+		devm_kfree(&chip->dev, log->bios_event_log);
 		ret = -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index a9ce66d09a75..741ab2204b11 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -10,6 +10,7 @@
  * Read the event log created by the firmware on PPC64
  */
 
+#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/tpm_eventlog.h>
@@ -65,7 +66,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
+	log->bios_event_log = devm_kmemdup(&chip->dev, __va(base), size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 741d8f3e8fb3..b99f55f2d4fd 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -267,7 +267,6 @@ static void tpm_dev_release(struct device *dev)
 	idr_remove(&dev_nums_idr, chip->dev_num);
 	mutex_unlock(&idr_lock);
 
-	kfree(chip->log.bios_event_log);
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
 	kfree(chip->allocated_banks);
-- 
2.31.1

