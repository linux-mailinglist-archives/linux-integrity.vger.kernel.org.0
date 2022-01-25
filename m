Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE849BEF6
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 23:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiAYWro (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 17:47:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234215AbiAYWr2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:28 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PLfeJp031655;
        Tue, 25 Jan 2022 22:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QyPScA20Bh1zljbHYtY9GeWirSRDvpTCapiCqMkxoFY=;
 b=ANAIlirYz6xZYP8dvVH/bzcYlMA9E7QDOP2eny5qZHxJMPipCgpWXc4MjcGu425/Q+p5
 OIbkf4206QekIVLuNT74zm57DqDzUvcNho2BWz0dTALT+r4gajCqwCKFl7UIs8CaxUq1
 r4HBRkuZBy+VIY2b8DaL7+LPjV17OCVDc8T/BsR2wdTY81YllfepXG5LAFe+wOmKIZCM
 qj5AstcJBKYlFAuEE9PLXd+a1YGi0V0xbs/juEmbvNWgVJxJ5/SdgHKp7m4tWFUSthdc
 4ti1xm/v+atAeqPSPpFWa2X4ZEgICqH/sP3EB6X48VQF6p96QH3y+KuTCRNQXI6SsOn/ lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtsbch54a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMX9f3037081;
        Tue, 25 Jan 2022 22:47:03 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtsbch53y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:03 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PMhbI8027114;
        Tue, 25 Jan 2022 22:47:02 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 3dr9jb6drw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMkwQ032768426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:46:58 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A931AC05B;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55157AC067;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v9 14/23] userns: Add pointer to ima_namespace to user_namespace
Date:   Tue, 25 Jan 2022 17:46:36 -0500
Message-Id: <20220125224645.79319-15-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9eWkUen3sPqdcrE4Of2-EUpfGECFwUB3
X-Proofpoint-ORIG-GUID: 4omr4UhEtaWNOx4SMMcTypm8c0g2Bbx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Add a pointer to ima_namespace to the user_namespace and initialize
the init_user_ns with a pointer to init_ima_ns.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v9:
 - Deferred implementation of ima_ns_from_user_ns() to later patch
---
 include/linux/ima.h            | 2 ++
 include/linux/user_namespace.h | 4 ++++
 kernel/user.c                  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b6ab66a546ae..0cf2a80c8b35 100644
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
index 33a4240e6a6f..019e8cf7b633 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
 #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
 
 struct ucounts;
+struct ima_namespace;
 
 enum ucount_type {
 	UCOUNT_USER_NAMESPACES,
@@ -99,6 +100,9 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+#ifdef CONFIG_IMA_NS
+	struct ima_namespace	*ima_ns;
+#endif
 } __randomize_layout;
 
 struct ucounts {
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539..e5d1f4b9b8ba 100644
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
2.31.1

