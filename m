Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2465C3C5
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Jan 2023 17:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjACQUr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Jan 2023 11:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbjACQUa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jan 2023 11:20:30 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A4F58C;
        Tue,  3 Jan 2023 08:20:29 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303F0vMJ031306;
        Tue, 3 Jan 2023 16:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kcMCFZqix5oHLmpcalz5usfADuqOgIyWiV1vo6pPxJ0=;
 b=NsP2cCXbqaP7ex3x0GuQV+ypk72gd5kT5VPFEh5AXit91h/rbZzwekW1kriKOokKZw2K
 sN+/TP62roaMDiUZAIlomnkV7Djzn4YRwHpZ1MWJBFpCrnH35y8sR5OGS+Fg3ihGvTAY
 OYptB/XQg7stx7Mrqgm+ln5Mi9wyZAFjd2oO/e8fqjWR/ePqP/O/fp4l4H9BsPI6yv84
 JmVgBDTe7k/ZLeZbPWqSE9nxnEfATn13f13iNUlLDVi/qsmvAjpu7yOIwLC6O3+UgYD5
 a9ciy6f6sxPQoOKIoxs4KQ8SlSigXwsPBG0m1Y6BRdqVoZG6fqpstcGWF/7nBVXRvedD 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvh8phrdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:20:18 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 303GGhHt017826;
        Tue, 3 Jan 2023 16:20:17 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvh8phrdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:20:17 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303EwpeI026039;
        Tue, 3 Jan 2023 16:20:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3mtcq7fc10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:20:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303GKFhH19923700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 16:20:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40F2658065;
        Tue,  3 Jan 2023 16:20:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6694258067;
        Tue,  3 Jan 2023 16:20:14 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.211.96])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jan 2023 16:20:14 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, jarkko@kernel.org,
        peterhuewe@gmx.de, joel@jms.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] tpm: Add reserved memory event log
Date:   Tue,  3 Jan 2023 10:20:10 -0600
Message-Id: <20230103162010.381214-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vWnW_1v0opqqCYQIcVr5CjIxHBaAnkzQ
X-Proofpoint-ORIG-GUID: tHy89K9MSouH0iz10GQNBcqvGl3G93Vo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some platforms may desire to pass the event log up to linux in the
form of a reserved memory region. Add support for this in the TPM
core to find the reserved memory region and map it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/char/tpm/eventlog/of.c | 38 +++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm-chip.c    |  3 ++-
 include/linux/tpm.h            |  1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index a9ce66d09a75..0455d7f61c10 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -11,12 +11,48 @@
  */
 
 #include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/tpm_eventlog.h>
 
 #include "../tpm.h"
 #include "common.h"
 
+static int tpm_read_log_memory_region(struct tpm_chip *chip)
+{
+	struct device_node *node;
+	struct resource res;
+	int rc;
+
+	node = of_parse_phandle(chip->dev.parent->of_node, "memory-region", 0);
+	if (!node) {
+		dev_info(&chip->dev, "no phandle\n");
+		return -ENODEV;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+	of_node_put(node);
+	if (rc) {
+		dev_info(&chip->dev, "no mem\n");
+		return rc;
+	}
+
+	chip->log.bios_event_log = memremap(res.start, resource_size(&res), MEMREMAP_WB);
+	if (!chip->log.bios_event_log) {
+		dev_info(&chip->dev, "err memremap\n");
+		return -ENOMEM;
+	}
+
+	chip->log.release = memunmap;
+	chip->log.bios_event_log_end = chip->log.bios_event_log + resource_size(&res);
+
+	return chip->flags & TPM_CHIP_FLAG_TPM2 ? EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 :
+		EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+}
+
 int tpm_read_log_of(struct tpm_chip *chip)
 {
 	struct device_node *np;
@@ -38,7 +74,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	sizep = of_get_property(np, "linux,sml-size", NULL);
 	basep = of_get_property(np, "linux,sml-base", NULL);
 	if (sizep == NULL && basep == NULL)
-		return -ENODEV;
+		return tpm_read_log_memory_region(chip);
 	if (sizep == NULL || basep == NULL)
 		return -EIO;
 
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 741d8f3e8fb3..09ea8145d7c6 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -267,7 +267,7 @@ static void tpm_dev_release(struct device *dev)
 	idr_remove(&dev_nums_idr, chip->dev_num);
 	mutex_unlock(&idr_lock);
 
-	kfree(chip->log.bios_event_log);
+	chip->log.release(chip->log.bios_event_log);
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
 	kfree(chip->allocated_banks);
@@ -324,6 +324,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	init_rwsem(&chip->ops_sem);
 
 	chip->ops = ops;
+	chip->log.release = (void(*)(void *))kfree;
 
 	mutex_lock(&idr_lock);
 	rc = idr_alloc(&dev_nums_idr, NULL, 0, TPM_NUM_DEVICES, GFP_KERNEL);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dfeb25a0362d..f1c0b0eb20a5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -109,6 +109,7 @@ struct tpm_space {
 struct tpm_bios_log {
 	void *bios_event_log;
 	void *bios_event_log_end;
+	void (*release)(void *ptr);
 };
 
 struct tpm_chip_seqops {
-- 
2.31.1

