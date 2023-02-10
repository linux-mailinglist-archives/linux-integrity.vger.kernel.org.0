Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5569198F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 09:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjBJIEn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 03:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBJIEk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 03:04:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ACC80743;
        Fri, 10 Feb 2023 00:04:34 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7g06w032350;
        Fri, 10 Feb 2023 08:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lVDlf1e+lx1SSxxJwdaT++MHU+m9OBvqLvOYomLLXnI=;
 b=qAyNpXtFLNoYT4BZ7Z2dWOkej0sPLibXyxO2kPeeJslK0C47Te0gfJJt0GiETYzfBaqH
 NG1zVQSQGg/KJjK1FggaI0QMAXZ36jdppkGg1tjOhJskev2DykqSWtc0M+qn73+4zmlP
 ebcn0OGlkZS1wFkfWi+L5JRqMd3xsCHQ65nHPCCw7fDaeU+hKNNdYfUPzdePfFJvWu7/
 5k+3pwQJtlFuJhAJTaKTcUGxriqVTQbST/raxA7t2YnNAyZCoxqR+thJYN3inGjBnlp4
 Kdps7EPLwSS29z4NnqyhMwiFNBPn6P+Zt07aKIHK/Vcuo05r1rutIZQWbx0Q2m6ibQwY ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhrurjhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:26 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A7hPfW003092;
        Fri, 10 Feb 2023 08:04:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhrurjg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A6KKja021016;
        Fri, 10 Feb 2023 08:04:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfq6cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A84LSI45744464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:04:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E3522004D;
        Fri, 10 Feb 2023 08:04:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2898D20043;
        Fri, 10 Feb 2023 08:04:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 08:04:20 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E97FF60806;
        Fri, 10 Feb 2023 19:04:14 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v6 07/26] powerpc/secvar: Handle format string in the consumer
Date:   Fri, 10 Feb 2023 19:03:42 +1100
Message-Id: <20230210080401.345462-8-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210080401.345462-1-ajd@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ffV_nczeSdFFWv6uQJ4V5UbcF2fRwaVf
X-Proofpoint-GUID: f6b-MNv51pVKIx49_EGS9sTcKM6BiJrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

The code that handles the format string in secvar-sysfs.c is entirely
OPAL specific, so create a new "format" op in secvar_operations to make
the secvar code more generic.  No functional change.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

---

v2: Use sysfs_emit() instead of sprintf() (gregkh)

v3: Enforce format string size limit (ruscur)

v4: Pass the buffer size as an argument, not using a macro (stefanb,
    npiggin)

    Fix error reporting (npiggin)
---
 arch/powerpc/include/asm/secvar.h            |  1 +
 arch/powerpc/kernel/secvar-sysfs.c           | 27 +++++++-------------
 arch/powerpc/platforms/powernv/opal-secvar.c | 25 ++++++++++++++++++
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
index a2b5f2203dc5..1a2c696a48ad 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -17,6 +17,7 @@ struct secvar_operations {
 	int (*get)(const char *key, u64 key_len, u8 *data, u64 *data_size);
 	int (*get_next)(const char *key, u64 *key_len, u64 keybufsize);
 	int (*set)(const char *key, u64 key_len, u8 *data, u64 data_size);
+	ssize_t (*format)(char *buf, size_t bufsize);
 };
 
 #ifdef CONFIG_PPC_SECURE_BOOT
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index b786d1005027..e4661559c855 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -21,26 +21,17 @@ static struct kset *secvar_kset;
 static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
-	ssize_t rc = 0;
-	struct device_node *node;
-	const char *format;
-
-	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
-	if (!of_device_is_available(node)) {
-		rc = -ENODEV;
-		goto out;
-	}
+	char tmp[32];
+	ssize_t len = secvar_ops->format(tmp, sizeof(tmp));
 
-	rc = of_property_read_string(node, "format", &format);
-	if (rc)
-		goto out;
+	if (len > 0)
+		return sysfs_emit(buf, "%s\n", tmp);
+	else if (len < 0)
+		pr_err("Error %zd reading format string\n", len);
+	else
+		pr_err("Got empty format string from backend\n");
 
-	rc = sysfs_emit(buf, "%s\n", format);
-
-out:
-	of_node_put(node);
-
-	return rc;
+	return -EIO;
 }
 
 
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
index 4c0a3b030fe0..e33bb703ecbc 100644
--- a/arch/powerpc/platforms/powernv/opal-secvar.c
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -98,10 +98,35 @@ static int opal_set_variable(const char *key, u64 ksize, u8 *data, u64 dsize)
 	return opal_status_to_err(rc);
 }
 
+static ssize_t opal_secvar_format(char *buf, size_t bufsize)
+{
+	ssize_t rc = 0;
+	struct device_node *node;
+	const char *format;
+
+	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
+	if (!of_device_is_available(node)) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	rc = of_property_read_string(node, "format", &format);
+	if (rc)
+		goto out;
+
+	rc = snprintf(buf, bufsize, "%s", format);
+
+out:
+	of_node_put(node);
+
+	return rc;
+}
+
 static const struct secvar_operations opal_secvar_ops = {
 	.get = opal_get_variable,
 	.get_next = opal_get_next_variable,
 	.set = opal_set_variable,
+	.format = opal_secvar_format,
 };
 
 static int opal_secvar_probe(struct platform_device *pdev)
-- 
2.39.1

