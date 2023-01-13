Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31409669D6C
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jan 2023 17:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjAMQRt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Jan 2023 11:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjAMQRS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Jan 2023 11:17:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8F96139;
        Fri, 13 Jan 2023 08:10:35 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DFgS2k029121;
        Fri, 13 Jan 2023 16:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ln93bccdgNzFEICgGiX/7Ramezk+x3HjkrqS2NuE3WU=;
 b=k9rr3l4icRSIXPa+1MPmP1osmVr37wrOBCyoa8FBOrgBFwEnwpuKmNqzv6t9YMjUr7je
 3wY85f4rqV/WPsQf+CBv1ZMGwEo0h4Eb9XyAffaenVdxWpBvqo+Jx4uUHcTChjlO4ss4
 SCMoehemR6ax/T/zjdbDSVxDksAd5+nMRAAhfmSE022P+mDIrzEUPJNtZoUSOhvTFjDs
 q1y1EmvL9bO3JzfdVk/XQ+41wIojTgxMqwrRikLJ2KQoUsKmbRD2QP0Ea7TW+OFrTfrt
 OVM2S5JytvueTR+8J+BCrfFrr0Ej3Azl2JywZnpXEdweP7MiQxPhJ/8wU7hVgnoY8N5U CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n3a60gp9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:33 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30DFl63j024687;
        Fri, 13 Jan 2023 16:10:32 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n3a60gp8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:32 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30DEh0Lj014476;
        Fri, 13 Jan 2023 16:10:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3n1kv5mmus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:10:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30DGAT1K9175726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 16:10:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FFCA58054;
        Fri, 13 Jan 2023 16:10:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 146C358045;
        Fri, 13 Jan 2023 16:10:27 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.137.189])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jan 2023 16:10:26 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, jarkko@kernel.org,
        peterhuewe@gmx.de, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 2/2] tpm: Add reserved memory event log
Date:   Fri, 13 Jan 2023 10:10:17 -0600
Message-Id: <20230113161017.1079299-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230113161017.1079299-1-eajames@linux.ibm.com>
References: <20230113161017.1079299-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9p6qPd3AXBWLpQhChDZQnHeCN1hJKZr2
X-Proofpoint-GUID: 6nsl0VfiKurJL0GwwHUe7wccLZp6ptzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index 741ab2204b11..c815cadf00a4 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -12,12 +12,48 @@
 
 #include <linux/device.h>
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
+	chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
+						 MEMREMAP_WB);
+	if (!chip->log.bios_event_log) {
+		dev_info(&chip->dev, "err memremap\n");
+		return -ENOMEM;
+	}
+
+	chip->log.bios_event_log_end = chip->log.bios_event_log + resource_size(&res);
+
+	return chip->flags & TPM_CHIP_FLAG_TPM2 ? EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 :
+		EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+}
+
 int tpm_read_log_of(struct tpm_chip *chip)
 {
 	struct device_node *np;
@@ -39,7 +75,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	sizep = of_get_property(np, "linux,sml-size", NULL);
 	basep = of_get_property(np, "linux,sml-base", NULL);
 	if (sizep == NULL && basep == NULL)
-		return -ENODEV;
+		return tpm_read_log_memory_region(chip);
 	if (sizep == NULL || basep == NULL)
 		return -EIO;
 
-- 
2.31.1

