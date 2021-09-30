Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4390441D92C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350640AbhI3L5d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 07:57:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3898 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350600AbhI3L5b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 07:57:31 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKs7q02VQz67MlK;
        Thu, 30 Sep 2021 19:53:11 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 13:55:46 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 4/7] ima: Query file digest and retrieve info from its digest lists
Date:   Thu, 30 Sep 2021 13:55:30 +0200
Message-ID: <20210930115533.878169-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210930115533.878169-1-roberto.sassu@huawei.com>
References: <20210930115533.878169-1-roberto.sassu@huawei.com>
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

If a file is going to be measured or appraised, and the use_diglim keyword
has been added to the matching rule, query the calculated file digest with
DIGLIM and retrieve some information: the actions (logical OR) done on the
digest lists containing that digest; modifiers (logical OR) associated to
the type.

Retrieved actions and modifiers will be then processed by the corresponding
IMA submodules.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cde2e1c2a6be..550805b79984 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -21,6 +21,7 @@
 #include <linux/tpm.h>
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
+#include <linux/diglim.h>
 
 #include "../integrity.h"
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index fe1f4ef1bb9d..b32c4f8d19ea 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -198,6 +198,20 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
+static void diglim_file_digest_lookup(struct file *file,
+				      struct integrity_iint_cache *iint,
+				      int action, u16 *modifiers, u8 *actions)
+{
+	if ((file->f_mode & FMODE_CREATED) && !i_size_read(file_inode(file)))
+		return;
+
+	if (!(iint->flags & IMA_COLLECTED))
+		return;
+
+	diglim_digest_get_info(iint->ima_hash->digest, iint->ima_hash->algo,
+			       COMPACT_FILE, modifiers, actions);
+}
+
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
@@ -209,6 +223,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
 	u64 action;
+	u16 file_modifiers = 0;
+	u8 file_actions = 0;
 	int rc = 0, must_appraise = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	struct evm_ima_xattr_data *xattr_value = NULL;
@@ -344,6 +360,11 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
+	if (iint->flags & IMA_USE_DIGLIM_MEASURE ||
+	    iint->flags & IMA_USE_DIGLIM_APPRAISE)
+		diglim_file_digest_lookup(file, iint, action, &file_modifiers,
+					  &file_actions);
+
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
-- 
2.32.0

