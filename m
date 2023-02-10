Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682FC691994
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 09:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjBJIEq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 03:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjBJIEn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 03:04:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F7180747;
        Fri, 10 Feb 2023 00:04:35 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A80Zqi002110;
        Fri, 10 Feb 2023 08:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Mz/m+UoRYuFUUZb89gu8Ix2Q3YtcIMhHY1JJ5tirGWA=;
 b=VQIcTGBoC5IbxuhCNmLkQ+mXsppMaf6LhUBULr8krLcOS3RZyMhaR+rnqdm/szXq0bn2
 vkt1cGBxSEM7FJlcxnUrlrSxmv55iGjgwlWZs6aFD8OSEjkTorSfPSbVsJMqk9OOEeAZ
 Vbo2C54UbAVmPkPT0eZzXjitc1HhfH05F9q+Bm/904bEOf+bottSDXXPklIvXUWDGLRK
 XfUdTv1+mQZkqZpYJRlEFiGU3s8DjuwbVLRIw1nOSndD5mYXfiXrZXOl+kAtg8hx5pM6
 6xbxyhILssIGX4+rEYFGxOPVPV9jXAJ3SYNa07qG6fHxwhOfTEYsRzAadecElkgaYpHv zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnj1r032p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:27 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A84Qib019162;
        Fri, 10 Feb 2023 08:04:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnj1r031k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A6RrxE024301;
        Fri, 10 Feb 2023 08:04:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06y5wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 08:04:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A84LqX22151532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:04:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 300162004B;
        Fri, 10 Feb 2023 08:04:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0B6A2005A;
        Fri, 10 Feb 2023 08:04:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 08:04:20 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 306B960808;
        Fri, 10 Feb 2023 19:04:15 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v6 12/26] powerpc/secvar: Warn when PAGE_SIZE is smaller than max object size
Date:   Fri, 10 Feb 2023 19:03:47 +1100
Message-Id: <20230210080401.345462-13-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210080401.345462-1-ajd@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bze12ioFa_dsPXoIwHM4yk8Kvs1Yh8E9
X-Proofpoint-GUID: 1KMOS7QICOR-9IXt1WIRysRbF76ibUU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Due to sysfs constraints, when writing to a variable, we can only handle
writes of up to PAGE_SIZE.

It's possible that the maximum object size is larger than PAGE_SIZE, in
which case, print a warning on boot so that the user is aware.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

---

v3: New patch (ajd)
---
 arch/powerpc/kernel/secvar-sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index bfb19f22c6ba..6ba23b2bb9da 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -225,6 +225,7 @@ static int secvar_sysfs_load_static(void)
 
 static int secvar_sysfs_init(void)
 {
+	u64 max_size;
 	int rc;
 
 	if (!secvar_ops) {
@@ -274,6 +275,14 @@ static int secvar_sysfs_init(void)
 		goto err;
 	}
 
+	// Due to sysfs limitations, we will only ever get a write buffer of
+	// up to 1 page in size. Print a warning if this is potentially going
+	// to cause problems, so that the user is aware.
+	secvar_ops->max_size(&max_size);
+	if (max_size > PAGE_SIZE)
+		pr_warn_ratelimited("PAGE_SIZE (%lu) is smaller than maximum object size (%llu), writes are limited to PAGE_SIZE\n",
+				    PAGE_SIZE, max_size);
+
 	return 0;
 err:
 	kobject_put(secvar_kobj);
-- 
2.39.1

