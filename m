Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330F508A29
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379392AbiDTOLX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379352AbiDTOKM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A736443D4;
        Wed, 20 Apr 2022 07:07:18 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KCoZDk016139;
        Wed, 20 Apr 2022 14:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wG14up6uDiKD17zVyASMKcL1BDI39dq01BmhLVv40iw=;
 b=W+m4O1iYs2+kClHmAeo4NOXfXLLnN8dDEnOrzIJe/cwxbvm5lZIjCbrc7neGXPS3wWaI
 yq/OnlqbYN7aKUyTGmJUJeYNhVL8jRAbk00MD92uj8uCgLUtUKNPTiMLEVl0WA/GUz7N
 i6JxKmN9XqQqO6sEy3v7dNrnC7Do3NR3okfWNFboEsVtqzVJ0L99sF+9A0hR16Hwai7K
 2VLo1S3079pfp3dsHONkjVSkjEW/KQmKQxGOaolFLHFEYEoVnXTJcu9j0AkPSEf5ei+D
 TMYKIoXHoESwOdiQ2GGqq8uuYBVT1YQncDxxFjYuTI11DTmirJAryplSZYBMR5jQ7MXH jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjjhf1naf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:44 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KE0KCl020390;
        Wed, 20 Apr 2022 14:06:44 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjjhf1na0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:44 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE3GIv006666;
        Wed, 20 Apr 2022 14:06:43 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3fg2xw1aq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:43 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6gMs27984190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:42 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B595FAE060;
        Wed, 20 Apr 2022 14:06:42 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98A45AE05F;
        Wed, 20 Apr 2022 14:06:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 14:06:42 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v12 13/26] userns: Add pointer to ima_namespace to user_namespace
Date:   Wed, 20 Apr 2022 10:06:20 -0400
Message-Id: <20220420140633.753772-14-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lGWtZ_Dy9Tk7Q4i4quMm3QOh-gf2nNJP
X-Proofpoint-GUID: 276NmWyTiCKwc8SfOr5sjlUyc40Dp1QF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_03,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v11:
 - Added lost A-b from Christian back
 - Added sentence to patch description explaining why we need the pointer

v9:
 - Deferred implementation of ima_ns_from_user_ns() to later patch
---
 include/linux/ima.h            | 2 ++
 include/linux/user_namespace.h | 4 ++++
 kernel/user.c                  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 426b1744215e..fcb60a44e05f 100644
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
2.34.1

