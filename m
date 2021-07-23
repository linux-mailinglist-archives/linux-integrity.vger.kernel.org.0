Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C3A3D3712
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhGWIM7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 04:12:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3460 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhGWIM5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 04:12:57 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWND044n8z6G9Dc;
        Fri, 23 Jul 2021 16:44:32 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 10:53:29 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <prsriva02@gmail.com>,
        <tusharsu@linux.microsoft.com>, <nramas@linux.microsoft.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 1/3] ima: Introduce ima_get_current_hash_algo()
Date:   Fri, 23 Jul 2021 10:53:02 +0200
Message-ID: <20210723085304.1760138-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723085304.1760138-1-roberto.sassu@huawei.com>
References: <20210723085304.1760138-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Buffer measurements, unlike file measurements, are not accessible after the
measurement is done, as buffers are not suitable for use with the
integrity_iint_cache structure (there is no index, for files it is the
inode number). In the subsequent patches, the measurement (digest) will be
returned directly by the functions that perform the buffer measurement,
ima_measure_critical_data() and process_buffer_measurement().

A caller of those functions also needs to know the algorithm used to
calculate the digest. Instead of adding the algorithm as a new parameter to
the functions, this patch provides it separately with the new function
ima_get_current_hash_algo().

Since the hash algorithm does not change after the IMA setup phase, there
is no risk of races (obtaining a digest calculated with a different
algorithm than the one returned).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h               | 7 +++++++
 security/integrity/ima/ima_main.c | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 61d5723ec303..81e830d01ced 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,9 +11,11 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <crypto/hash_info.h>
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
+extern enum hash_algo ima_get_current_hash_algo(void);
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
@@ -64,6 +66,11 @@ static inline const char * const *arch_get_ima_policy(void)
 #endif
 
 #else
+static inline enum hash_algo ima_get_current_hash_algo(void)
+{
+	return HASH_ALGO__LAST;
+}
+
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 287b90509006..8ef1fa357e0c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -76,6 +76,11 @@ static int __init hash_setup(char *str)
 }
 __setup("ima_hash=", hash_setup);
 
+enum hash_algo ima_get_current_hash_algo(void)
+{
+	return ima_hash_algo;
+}
+
 /* Prevent mmap'ing a file execute that is already mmap'ed write */
 static int mmap_violation_check(enum ima_hooks func, struct file *file,
 				char **pathbuf, const char **pathname,
-- 
2.25.1

