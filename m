Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33136E6635
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Apr 2023 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjDRNo5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Apr 2023 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDRNom (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Apr 2023 09:44:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C84D325;
        Tue, 18 Apr 2023 06:44:35 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IDQEB5014851;
        Tue, 18 Apr 2023 13:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TEGBONkyuog+F35viyuYWUr10yzGVlxA8iH4QwsmVSU=;
 b=QsYDnL4lS3xM5aT8KiHJbr7kZOK1ahu1Y7J00QkOimGxoPN2GKRL6vr7K0ubEJeMSx2O
 nyqlOQIPaSIR55ZeeZ6p/nVHMuU+i1HBkeJ36vLadtvATdVxTpFDIugeZmVj0MNwudtR
 4lIZ79fXWbnxxh4fUyRNZQXaIYN7gszfl7Fdd1IbvXPbfuvpa+YIhO5gvumL/yIvFTh0
 rgX7qAmaVEzvrbiiAs0pKTGMwXaJQ8PYEBEmgHZoXzs84vBro2ISdfBWWwy4FL9k1aSE
 fbkPsE+H2yPCUAvzpX7KQYpTeozCJUC54+9nSZCFlm4EY/GYl+J5BV+7kNSVjKpKz8e3 xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1q529xx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 13:44:18 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33ICK4CU026346;
        Tue, 18 Apr 2023 13:44:17 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1q529xwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 13:44:17 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33ID0C8J003732;
        Tue, 18 Apr 2023 13:44:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pykj7weej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 13:44:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33IDiEDE33620586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 13:44:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3EF058063;
        Tue, 18 Apr 2023 13:44:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F86958066;
        Tue, 18 Apr 2023 13:44:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Apr 2023 13:44:13 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>
Subject: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly available
Date:   Tue, 18 Apr 2023 09:44:07 -0400
Message-Id: <20230418134409.177485-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418134409.177485-1-stefanb@linux.ibm.com>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i92gmyUBa8RFw3E1tvHzitilikJ19_tg
X-Proofpoint-ORIG-GUID: BumNmB7KdGlnfVAk3Q2It202VDnZXF5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_09,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Simplify tpm_read_log_of() by moving reusable parts of the code into
an inline function that makes it commonly available so it can be
used also for kexec support. Call the new of_tpm_get_sml_parameters()
function from the TPM Open Firmware driver.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Tested-by: Coiby Xu <coxu@redhat.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

---
v9:
 - Rebased on 6.3-rc7; call tpm_read_log_memory_region if -ENODEV returned

v7:
 - Added original comment back into inlined function

v4:
 - converted to inline function
---
 drivers/char/tpm/eventlog/of.c | 30 +++++-----------------------
 include/linux/tpm.h            | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index 930fe43d5daf..41688d9cbd3b 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -51,11 +51,10 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
 int tpm_read_log_of(struct tpm_chip *chip)
 {
 	struct device_node *np;
-	const u32 *sizep;
-	const u64 *basep;
 	struct tpm_bios_log *log;
 	u32 size;
 	u64 base;
+	int ret;
 
 	log = &chip->log;
 	if (chip->dev.parent && chip->dev.parent->of_node)
@@ -66,30 +65,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	if (of_property_read_bool(np, "powered-while-suspended"))
 		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
 
-	sizep = of_get_property(np, "linux,sml-size", NULL);
-	basep = of_get_property(np, "linux,sml-base", NULL);
-	if (sizep == NULL && basep == NULL)
+	ret = of_tpm_get_sml_parameters(np, &base, &size);
+	if (ret == -ENODEV)
 		return tpm_read_log_memory_region(chip);
-	if (sizep == NULL || basep == NULL)
-		return -EIO;
-
-	/*
-	 * For both vtpm/tpm, firmware has log addr and log size in big
-	 * endian format. But in case of vtpm, there is a method called
-	 * sml-handover which is run during kernel init even before
-	 * device tree is setup. This sml-handover function takes care
-	 * of endianness and writes to sml-base and sml-size in little
-	 * endian format. For this reason, vtpm doesn't need conversion
-	 * but physical tpm needs the conversion.
-	 */
-	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
-	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
-		size = be32_to_cpup((__force __be32 *)sizep);
-		base = be64_to_cpup((__force __be64 *)basep);
-	} else {
-		size = *sizep;
-		base = *basep;
-	}
+	if (ret < 0)
+		return ret;
 
 	if (size == 0) {
 		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4dc97b9f65fb..dd9a376a1dbb 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -461,4 +461,40 @@ static inline struct tpm_chip *tpm_default_chip(void)
 	return NULL;
 }
 #endif
+
+#ifdef CONFIG_OF
+static inline int of_tpm_get_sml_parameters(struct device_node *np,
+					    u64 *base, u32 *size)
+{
+	const u32 *sizep;
+	const u64 *basep;
+
+	sizep = of_get_property(np, "linux,sml-size", NULL);
+	basep = of_get_property(np, "linux,sml-base", NULL);
+	if (sizep == NULL && basep == NULL)
+		return -ENODEV;
+	if (sizep == NULL || basep == NULL)
+		return -EIO;
+
+	/*
+	 * For both vtpm/tpm, firmware has log addr and log size in big
+	 * endian format. But in case of vtpm, there is a method called
+	 * sml-handover which is run during kernel init even before
+	 * device tree is setup. This sml-handover function takes care
+	 * of endianness and writes to sml-base and sml-size in little
+	 * endian format. For this reason, vtpm doesn't need conversion
+	 * but physical tpm needs the conversion.
+	 */
+	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
+	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
+		*size = be32_to_cpup((__force __be32 *)sizep);
+		*base = be64_to_cpup((__force __be64 *)basep);
+	} else {
+		*size = *sizep;
+		*base = *basep;
+	}
+	return 0;
+}
+#endif
+
 #endif
-- 
2.38.1

