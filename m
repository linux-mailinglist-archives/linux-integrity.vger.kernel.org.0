Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E669199D
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 09:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjBJIFB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 03:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjBJIEo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 03:04:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9408075D;
        Fri, 10 Feb 2023 00:04:35 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7sa6P025248;
        Fri, 10 Feb 2023 08:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EDMRb/pgprezJpuLp7eG9eI5mYQwAF6AHf8HSWqEV9Q=;
 b=NzCTP90nzoL25NNnl6cBTNDcaCOppRO23JFAcQi0ZGpHhwUkQg5UAuzQmLadNSZ9qlr0
 I9JWGjD/a06VkBPpilqkKiVopndqVS3+gd8UOeb0qXUOHV8rbSYa4Os050cbqNWyU+lm
 ShDN+1MlDgsDYnlWbpHU/BU4DjZ5WLYDPr5nEG82Y5d55A0/FrYnoSH8WRsS3wdvMxYw
 5YKTAM5iT+8BCtWNqPA3agD5Ojw3I5Leu04LkYd0XntfYCDxS5djrhiidXpybu9j4fEv
 zPTYTWplVOlywXX3Fb4mafEWfHxG3G1v0poofh3tJXMtOLHZV76+iP6D1LvxgRKPg8Lf ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhxxg9cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:27 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A7t9Gr026741;
        Fri, 10 Feb 2023 08:04:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnhxxg9aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7MeAI021050;
        Fri, 10 Feb 2023 08:04:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfq6cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A84Lak22807266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:04:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A38572004E;
        Fri, 10 Feb 2023 08:04:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DB9D20043;
        Fri, 10 Feb 2023 08:04:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 08:04:20 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2485C60954;
        Fri, 10 Feb 2023 19:04:15 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v6 11/26] powerpc/secvar: Allow backend to populate static list of variable names
Date:   Fri, 10 Feb 2023 19:03:46 +1100
Message-Id: <20230210080401.345462-12-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210080401.345462-1-ajd@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: axkixmmpmCaGdezZ4Ou-pn9Nvb4lpPWf
X-Proofpoint-GUID: RhdfuBOFXfIR0r-R08ZTvlQcLp6ErXIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, the list of variables is populated by calling
secvar_ops->get_next() repeatedly, which is explicitly modelled on the
OPAL API (including the keylen parameter).

For the upcoming PLPKS backend, we have a static list of variable names.
It is messy to fit that into get_next(), so instead, let the backend put
a NULL-terminated array of variable names into secvar_ops->var_names,
which will be used if get_next() is undefined.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

---

v3: New patch (ajd/mpe)

v6: Add newlines for better aesthetics (stefanb)
---
 arch/powerpc/include/asm/secvar.h  |  4 ++
 arch/powerpc/kernel/secvar-sysfs.c | 69 +++++++++++++++++++++---------
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
index 011a53a8076c..4828e0ab7e3c 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -21,6 +21,10 @@ struct secvar_operations {
 	ssize_t (*format)(char *buf, size_t bufsize);
 	int (*max_size)(u64 *max_size);
 	const struct attribute **config_attrs;
+
+	// NULL-terminated array of fixed variable names
+	// Only used if get_next() isn't provided
+	const char * const *var_names;
 };
 
 #ifdef CONFIG_PPC_SECURE_BOOT
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 7df32be86507..bfb19f22c6ba 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -157,9 +157,31 @@ static int secvar_sysfs_config(struct kobject *kobj)
 	return 0;
 }
 
-static int secvar_sysfs_load(void)
+static int add_var(const char *name)
 {
 	struct kobject *kobj;
+	int rc;
+
+	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+	if (!kobj)
+		return -ENOMEM;
+
+	kobject_init(kobj, &secvar_ktype);
+
+	rc = kobject_add(kobj, &secvar_kset->kobj, "%s", name);
+	if (rc) {
+		pr_warn("kobject_add error %d for attribute: %s\n", rc,
+			name);
+		kobject_put(kobj);
+		return rc;
+	}
+
+	kobject_uevent(kobj, KOBJ_ADD);
+	return 0;
+}
+
+static int secvar_sysfs_load(void)
+{
 	u64 namesize = 0;
 	char *name;
 	int rc;
@@ -179,31 +201,28 @@ static int secvar_sysfs_load(void)
 			break;
 		}
 
-		kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
-		if (!kobj) {
-			rc = -ENOMEM;
-			break;
-		}
-
-		kobject_init(kobj, &secvar_ktype);
-
-		rc = kobject_add(kobj, &secvar_kset->kobj, "%s", name);
-		if (rc) {
-			pr_warn("kobject_add error %d for attribute: %s\n", rc,
-				name);
-			kobject_put(kobj);
-			kobj = NULL;
-		}
-
-		if (kobj)
-			kobject_uevent(kobj, KOBJ_ADD);
-
+		rc = add_var(name);
 	} while (!rc);
 
 	kfree(name);
 	return rc;
 }
 
+static int secvar_sysfs_load_static(void)
+{
+	const char * const *name_ptr = secvar_ops->var_names;
+	int rc;
+
+	while (*name_ptr) {
+		rc = add_var(*name_ptr);
+		if (rc)
+			return rc;
+		name_ptr++;
+	}
+
+	return 0;
+}
+
 static int secvar_sysfs_init(void)
 {
 	int rc;
@@ -245,7 +264,15 @@ static int secvar_sysfs_init(void)
 		goto err;
 	}
 
-	secvar_sysfs_load();
+	if (secvar_ops->get_next)
+		rc = secvar_sysfs_load();
+	else
+		rc = secvar_sysfs_load_static();
+
+	if (rc) {
+		pr_err("Failed to create variable attributes\n");
+		goto err;
+	}
 
 	return 0;
 err:
-- 
2.39.1

