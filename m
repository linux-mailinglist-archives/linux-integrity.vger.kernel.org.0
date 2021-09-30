Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB341D93A
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350695AbhI3L6n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 07:58:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3901 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350600AbhI3L6m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 07:58:42 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKs8W5mVPz67vP9;
        Thu, 30 Sep 2021 19:53:47 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 13:56:58 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 6/7] ima: Skip measurement of files found in DIGLIM hash table
Date:   Thu, 30 Sep 2021 13:55:32 +0200
Message-ID: <20210930115533.878169-7-roberto.sassu@huawei.com>
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

Skip a file measurement if the IMA policy allows the usage of DIGLIM with
the use_diglim directive, if the content or metadata digests were found in
the DIGLIM hash table and if at least one of the digest lists containing
the found digest has the action COMPACT_ACTION_IMA_MEASURED set.

Since the usage of the use_diglim directive requires to specify a different
PCR than the default one, this avoids confusion with the standard IMA
measurement list where if a file is missing it means that it was not
accessed.

The new meaning of measurements done with the use_diglim directive is that
if a file is missing, it was not accessed or it was accessed, was found in
the DIGLIM hash table, and the measurement of at least one digest list
containing its content or metadata digest is in the measurement list.

Files not found in the DIGLIM hash table or files whose content or metadata
digest was not measured will still appear in the measurement list.

Given that with the new behavior it cannot be determined whether a file was
accessed or not, remote verifiers must assume the worst case where every
file, whose content or metadata digest is in a measured digest list, was
accessed. With this assumption, it is safe to assume the measurement list
generated with the new behavior as complete.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 84ccb76f6c3c..7add0e70f67a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -442,6 +442,15 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (must_appraise)
 		if (rc && (ima_appraise & IMA_APPRAISE_ENFORCE))
 			action &= ~(IMA_MEASURE | IMA_AUDIT);
+	/* Use DIGLIM method for measurement if enabled in the policy. */
+	if (action & IMA_MEASURE && (iint->flags & IMA_USE_DIGLIM_MEASURE)) {
+		if (file_actions & (1 << COMPACT_ACTION_IMA_MEASURED) ||
+		    metadata_actions & (1 << COMPACT_ACTION_IMA_MEASURED)) {
+			iint->flags |= IMA_MEASURED;
+			iint->measured_pcrs |= (0x1 << pcr);
+			action &= ~IMA_MEASURE;
+		}
+	}
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
-- 
2.32.0

