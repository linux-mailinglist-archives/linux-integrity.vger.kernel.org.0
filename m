Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1F68BF5C
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBFOE0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBFOD6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:03:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BAC30C9;
        Mon,  6 Feb 2023 06:03:48 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqMwB025241;
        Mon, 6 Feb 2023 14:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=o3fYNBQPJUrJCd6qw1+ifUnhwmBbiT0XYzbqn9pYopg=;
 b=DBbUcAaRzkS1exPp34aYUf1QenCSLUgk3OLCr8jMfaJIinyxFAH4wtX+uem7Zfc+oxnv
 LL8HIwCorGUKL00ui7I/WKSAuToCTyUEqDjwusE6/aP5WU2dADZ1Lz7suDyMfCFYWiJu
 ubJd1FDjwkl3MBuXOLfbmsO8+/np3FFJz12TIF6oxz+xTmLl8uKJ+TJzbzd//qcrgYkq
 2kce0rhdxwKPXYHp4soBJplq1MFJc6ADiIDRQGWxGinErDqXNd0rnGVl4Jopv4+RE7MU
 NYVwh1bRouTvV+ZEpywNtmhI9tb+bxLwNgfTu/m/Pok2YXx0OJ00PCJyUIcawiAvu+FQ yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk06w5gdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:31 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DqOdV025643;
        Mon, 6 Feb 2023 14:03:30 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk06w5gch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:30 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CXiO1020140;
        Mon, 6 Feb 2023 14:03:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3nhf0730a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3SlL25887274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B34A258060;
        Mon,  6 Feb 2023 14:03:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECD515805B;
        Mon,  6 Feb 2023 14:03:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:25 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v15 13/26] userns: Add pointer to ima_namespace to user_namespace
Date:   Mon,  6 Feb 2023 09:02:40 -0500
Message-Id: <20230206140253.3755945-14-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _Bze_9jPbEdANiWwSJpMU57SbP25HscX
X-Proofpoint-ORIG-GUID: rceY3IM_rGV9g3xU4shI8bQVjlWjQ_6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=943 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a pointer to ima_namespace to the user_namespace and initialize
the init_user_ns with a pointer to init_ima_ns. We need a pointer from
the user namespace to its associated IMA namespace since IMA namespaces
are piggybacking on user namespaces.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

---
v13:
 - Added comment to ima_namespace pointer in user_namespace structure
   following Serge's suggestion

v11:
 - Added lost A-b from Christian back
 - Added sentence to patch description explaining why we need the pointer

v9:
 - Deferred implementation of ima_ns_from_user_ns() to later patch
---
 include/linux/ima.h            | 2 ++
 include/linux/user_namespace.h | 9 +++++++++
 kernel/user.c                  | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 5a0b2a285a18..2038e2e2a88d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -14,6 +14,8 @@
 #include <crypto/hash_info.h>
 struct linux_binprm;
 
+extern struct ima_namespace init_ima_ns;
+
 #ifdef CONFIG_IMA
 extern enum hash_algo ima_get_current_hash_algo(void);
 extern int ima_bprm_check(struct linux_binprm *bprm);
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 45f09bec02c4..c4b4f07b642e 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
 #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
 
 struct ucounts;
+struct ima_namespace;
 
 enum ucount_type {
 	UCOUNT_USER_NAMESPACES,
@@ -102,6 +103,14 @@ struct user_namespace {
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
 	long rlimit_max[UCOUNT_RLIMIT_COUNTS];
+#ifdef CONFIG_IMA_NS
+	/* Pointer to ima_ns which this user_ns created.  Can be null. IMA's
+	 * file access checks will walk the userns->parent chain and check
+	 * against all active ima_ns's. Note that when the user_ns is
+	 * freed, the ima_ns is guaranteed to be free-able.
+	 */
+	struct ima_namespace	*ima_ns;
+#endif
 } __randomize_layout;
 
 struct ucounts {
diff --git a/kernel/user.c b/kernel/user.c
index d667debeafd6..2c1419215ecc 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -19,6 +19,7 @@
 #include <linux/export.h>
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
+#include <linux/ima.h>
 
 /*
  * userns count is 1 for root user, 1 for init_uts_ns,
@@ -67,6 +68,9 @@ struct user_namespace init_user_ns = {
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
 #endif
+#ifdef CONFIG_IMA_NS
+	.ima_ns = &init_ima_ns,
+#endif
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
 
-- 
2.37.3

