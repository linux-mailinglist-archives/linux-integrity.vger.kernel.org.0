Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDF6713F9
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 07:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjARG0O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 01:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjARGWH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 01:22:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365804DCEF;
        Tue, 17 Jan 2023 22:11:26 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I3XHBn014174;
        Wed, 18 Jan 2023 06:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N7HGyx4b1gCBsq4x5Z+3hfZRJYp+aSxT5gUkrccymoQ=;
 b=kAigaI/FqUy6KsdCL2DhGUI3ixv9oNCZtAwESvmm1hyQn1Ad3vBfMR26orISpDiouWit
 hAt35mX6SkrzIXckJ5qrN3pYWQp6eKnn4ynQVQMTPSOpiz0FFxe9Eg4XrykuWCZTVaSR
 uVovhYSG1579+SkfGFVG2WS3Ze3pORVogtfZqNKW3EXFpHwYBeOD0O2QEXVmLqXB2e51
 0jUx14IIhU72mLol5QbvPlTb0Dp4zcQsxoOWFLMVnde/nKa3Cu4ftc89LfQqzfJHPhZ1
 3Y3UZV19sn0KALNtwbn4FrJPAl/J277Qy7QASnEzusitKuaVpsIjSLihmOGHg3cPOkNf 0w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n68ycaq55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HMbatS006324;
        Wed, 18 Jan 2023 06:11:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfmtke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BCtF52756816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDB7E2004B;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6247C20049;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 440AF605AB;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 06/24] powerpc/secvar: Clean up init error messages
Date:   Wed, 18 Jan 2023 17:10:31 +1100
Message-Id: <20230118061049.1006141-7-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AoWWh6DHMsT9RbLMOeVTIb64cAusFruu
X-Proofpoint-ORIG-GUID: AoWWh6DHMsT9RbLMOeVTIb64cAusFruu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=861 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301180051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove unnecessary prefixes from error messages in secvar_sysfs_init()
(the file defines pr_fmt, so putting "secvar:" in every message is
unnecessary). Make capitalisation and punctuation more consistent.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>

---

v3: New patch (ajd)
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 031ef37bca99..9f0e49bf3903 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -190,13 +190,13 @@ static int secvar_sysfs_init(void)
 	int rc;
 
 	if (!secvar_ops) {
-		pr_warn("secvar: failed to retrieve secvar operations.\n");
+		pr_warn("Failed to retrieve secvar operations\n");
 		return -ENODEV;
 	}
 
 	secvar_kobj = kobject_create_and_add("secvar", firmware_kobj);
 	if (!secvar_kobj) {
-		pr_err("secvar: Failed to create firmware kobj\n");
+		pr_err("Failed to create firmware kobj\n");
 		return -ENOMEM;
 	}
 
@@ -208,7 +208,7 @@ static int secvar_sysfs_init(void)
 
 	secvar_kset = kset_create_and_add("vars", NULL, secvar_kobj);
 	if (!secvar_kset) {
-		pr_err("secvar: sysfs kobject registration failed.\n");
+		pr_err("sysfs kobject registration failed\n");
 		kobject_put(secvar_kobj);
 		return -ENOMEM;
 	}
-- 
2.39.0

