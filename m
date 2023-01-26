Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB667D757
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 22:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjAZVI3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 16:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjAZVI0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 16:08:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6412B65367;
        Thu, 26 Jan 2023 13:08:22 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QJIbFW017731;
        Thu, 26 Jan 2023 21:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Wy5jGqa36Ei/jzaR8orKTioPfJB7/DMwnd5+9ENVdCo=;
 b=tdtMpEO7KLez33WvEOGHnfJ65kzdvK7AXKqQFpuuAsa0r1njwIHW0erqwU0EjugroPGw
 NZ9uyrW2gdYjuVMohc8QtUOcx24cA3g517A19/qXoZjsUoB4Tjubm5fARakrS+i1hs3t
 v9yZDgGgkmvLNUWS5AkUDjpzV6c61K/CGRz46Gu9/Np/MgatEjsr3/nipNKiQhDHwS0u
 FQscsHUnynW5lgcPg264yDMF61Z59lVnCN4nbwnQsU4roKLJOlnVhnuG2wygwSeGfdgL
 mHe7jAwCMsw3t9ocaoLUsQD+zu03mUpfKopT8Z+ATdos3k7/RpJeJKRrNYpg5xP8iRrb 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbu2jtbgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:08:18 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QL5i9N017326;
        Thu, 26 Jan 2023 21:08:17 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbu2jtbge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:08:17 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QK1GLK012685;
        Thu, 26 Jan 2023 21:08:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3n87p7yar1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:08:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QL8F3p26542554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:08:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36F9A58059;
        Thu, 26 Jan 2023 21:08:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 020925805F;
        Thu, 26 Jan 2023 21:08:14 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.3.213])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 21:08:13 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        stefanb@linux.ibm.com, eajames@linux.ibm.com
Subject: [PATCH v3 2/2] tpm: Add reserved memory event log
Date:   Thu, 26 Jan 2023 15:08:10 -0600
Message-Id: <20230126210810.881119-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230126210810.881119-1-eajames@linux.ibm.com>
References: <20230126210810.881119-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VHzkvyJ3c-j3u6p9mKvGRC0sFtdq8EkA
X-Proofpoint-ORIG-GUID: jw-LOoTPqCc19JY8vA4-3_SrxfArdeR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some platforms may desire to pass the event log up to Linux in the
form of a reserved memory region. In particular, this is desirable
for embedded systems or baseboard management controllers (BMCs)
booting with U-Boot. IBM OpenBMC BMCs will be the first user.
Add support for the reserved memory in the TPM core to find the
region and map it.

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

