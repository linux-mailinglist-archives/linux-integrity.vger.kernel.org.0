Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312A6713FC
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 07:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjARG01 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 01:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjARGV7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 01:21:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3CD4DBDE;
        Tue, 17 Jan 2023 22:11:24 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I4gSQl029762;
        Wed, 18 Jan 2023 06:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JfBITR2ZTvNGGVcMLga9xRX0KrOMIU4bb//V61PbJuU=;
 b=IS3AXq0Qc5kFuDx0xDyf3DdlSlW2CyBbzZLchP6Wi37rEUhV6dC1YJ8urfylVWYTmO2q
 x0qvqULj3VTiouplY6Bos+Xx8vhxtWfdqsCzRg80LydMc9hbukW8i2/8t6iFmdXLA2xl
 ab2vew2PHQVAFltBhE8B1DQXApslzLNpwcqcnQTqkkV+FitJr6Lrr8EG/cCzjRmtNvye
 AAF6PlOxBL70g9M/U27X3wu5Fg+g69S2ZQ+JpXNw0lFZpTqP4q5a/bodEOUjirdd2n/L
 xfpp2V3Q0o88jg+WnGx+d7iO7PdfqtY6OrSl0TE4wpWmIOppRRomd3sBNJyYA+9re+01 mA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n66eydfxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:15 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HD6s2L002145;
        Wed, 18 Jan 2023 06:11:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n3m16kgr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BAGk30278078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B97C2004D;
        Wed, 18 Jan 2023 06:11:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F8EC20043;
        Wed, 18 Jan 2023 06:11:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:10 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2D06E6016D;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 03/24] powerpc/secvar: Use sysfs_emit() instead of sprintf()
Date:   Wed, 18 Jan 2023 17:10:28 +1100
Message-Id: <20230118061049.1006141-4-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KeADZMoxl-mHng3KHI5g5sCVYiOdIC1q
X-Proofpoint-GUID: KeADZMoxl-mHng3KHI5g5sCVYiOdIC1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=860 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

The secvar format string and object size sysfs files are both ASCII
text, and should use sysfs_emit().  No functional change.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v2: New patch (gregkh)
---
 arch/powerpc/kernel/secvar-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 001cdbcdb9d2..462cacc0ca60 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -35,7 +35,7 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 	if (rc)
 		goto out;
 
-	rc = sprintf(buf, "%s\n", format);
+	rc = sysfs_emit(buf, "%s\n", format);
 
 out:
 	of_node_put(node);
@@ -57,7 +57,7 @@ static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return rc;
 	}
 
-	return sprintf(buf, "%llu\n", dsize);
+	return sysfs_emit(buf, "%llu\n", dsize);
 }
 
 static ssize_t data_read(struct file *filep, struct kobject *kobj,
-- 
2.39.0

