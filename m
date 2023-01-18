Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F16713F3
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 07:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjARGZb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 01:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjARGWK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 01:22:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BED4DCF2;
        Tue, 17 Jan 2023 22:11:26 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I3X6BB013875;
        Wed, 18 Jan 2023 06:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KlS74nmS3Ezx0I+6lcH/jklJldEAqLLDt8jDZ9l6P9Y=;
 b=A2kOQcO+0lG+W7t5Qpi4jA4qtwduph2Zc0Kt+cDBuNH00XALzNX8+fCRix7kD761Ms79
 bdDR1gdiFNrnXAtqTfVGkBW3AmC97mxMwyIirDtz3lvqLACLJq/VLAsLrfyA5z3yBez6
 wL2fvJbjfJqg4WkCbzk7+32uMWtFXdWAAT0AUS9I9/adAOPYOlMXBdfqLhJb15q8fKrn
 9VZKUyD08Uwb/6yvpR6/yo8xYY/kGvTJ4+/hx5xJsIE0JgMs/hRJM1OJkF+o0hyHJjxA
 TrSochxD3f7IdRkIZqk3N+7DoY3ErMc4sxTRxra/EwYmcUmKu8PW8iYAPv+i+a1Du91m Wg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n68ycaq5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:17 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HAM9oW028810;
        Wed, 18 Jan 2023 06:11:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n3m16bh3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BD6R47382876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 513E42004E;
        Wed, 18 Jan 2023 06:11:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C93DD20040;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 516EF6060A;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 09/24] powerpc/secvar: Warn when PAGE_SIZE is smaller than max object size
Date:   Wed, 18 Jan 2023 17:10:34 +1100
Message-Id: <20230118061049.1006141-10-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fVyGledytYs5sCx6nVUetw8ke1ngkkir
X-Proofpoint-ORIG-GUID: fVyGledytYs5sCx6nVUetw8ke1ngkkir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
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

Due to sysfs constraints, when writing to a variable, we can only handle
writes of up to PAGE_SIZE.

It's possible that the maximum object size is larger than PAGE_SIZE, in
which case, print a warning on boot so that the user is aware.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>

---

v3: New patch (ajd)
---
 arch/powerpc/kernel/secvar-sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index d9352d4be87b..68fb0b857442 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -217,6 +217,7 @@ static int secvar_sysfs_load_static(void)
 
 static int secvar_sysfs_init(void)
 {
+	u64 max_size;
 	int rc;
 
 	if (!secvar_ops) {
@@ -266,6 +267,14 @@ static int secvar_sysfs_init(void)
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
2.39.0

