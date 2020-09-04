Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA125D50E
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIDJaq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 05:30:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730078AbgIDJaQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 05:30:16 -0400
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 31B5E4725D0E12FA6592;
        Fri,  4 Sep 2020 10:30:15 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 4 Sep 2020 10:30:15 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 4 Sep 2020 11:30:13 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 05/12] evm: Load EVM key in ima_load_x509() to avoid appraisal
Date:   Fri, 4 Sep 2020 11:26:36 +0200
Message-ID: <20200904092643.20013-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
In-Reply-To: <20200904092339.19598-1-roberto.sassu@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Public keys do not need to be appraised by IMA as the restriction on the
IMA/EVM keyrings ensures that a key is loaded only if it is signed with a
key in the primary or secondary keyring.

However, when evm_load_x509() is loaded, appraisal is already enabled and
a valid IMA signature must be added to the EVM key to pass verification.

Since the restriction is applied on both IMA and EVM keyrings, it is safe
to disable appraisal also when the EVM key is loaded. This patch calls
evm_load_x509() inside ima_load_x509() if CONFIG_IMA_LOAD_X509 is defined.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/iint.c         | 2 ++
 security/integrity/ima/ima_init.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 1d20003243c3..7d08c31c612f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -200,7 +200,9 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 void __init integrity_load_keys(void)
 {
 	ima_load_x509();
+#ifndef CONFIG_IMA_LOAD_X509
 	evm_load_x509();
+#endif
 }
 
 static int __init integrity_fs_init(void)
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 4902fe7bd570..9d29a1680da8 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -106,6 +106,10 @@ void __init ima_load_x509(void)
 
 	ima_policy_flag &= ~unset_flags;
 	integrity_load_x509(INTEGRITY_KEYRING_IMA, CONFIG_IMA_X509_PATH);
+
+	/* load also EVM key to avoid appraisal */
+	evm_load_x509();
+
 	ima_policy_flag |= unset_flags;
 }
 #endif
-- 
2.27.GIT

