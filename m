Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758D41B22A9
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 11:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUJ0n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 05:26:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUJ0n (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 05:26:43 -0400
Received: from lhreml734-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 60B65544B3EF810A1305;
        Tue, 21 Apr 2020 10:26:41 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml734-chm.china.huawei.com (10.201.108.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 21 Apr 2020 10:26:41 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 21 Apr 2020 11:26:40 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] ima: Allow imasig requirement to be satisfied by EVM portable signatures
Date:   Tue, 21 Apr 2020 11:24:18 +0200
Message-ID: <20200421092418.25151-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

System administrators can require that all accessed files have a signature
by specifying appraise_type=imasig in a policy rule.

Currently, only IMA signatures satisfy this requirement. However, also EVM
portable signatures can satisfy it. Metadata, including security.ima, are
signed and cannot change.

This patch helps in the scenarios where system administrators want to
enforce this restriction but only EVM portable signatures are available.
The patch makes the following changes:

file xattr types:
security.ima: IMA_XATTR_DIGEST/IMA_XATTR_DIGEST_NG
security.evm: EVM_XATTR_PORTABLE_DIGSIG

execve(), mmap(), open() behavior (with appraise_type=imasig):
before: denied (file without IMA signature, imasig requirement not met)
after: allowed (file with EVM portable signature, imasig requirement met)

open(O_WRONLY) behavior (without appraise_type=imasig):
before: allowed (file without IMA signature, not immutable)
after: denied (file with EVM portable signature, immutable)

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_appraise.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a9649b04b9f1..69a6a958f811 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -219,12 +219,16 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 		hash_start = 1;
 		/* fall through */
 	case IMA_XATTR_DIGEST:
-		if (iint->flags & IMA_DIGSIG_REQUIRED) {
-			*cause = "IMA-signature-required";
-			*status = INTEGRITY_FAIL;
-			break;
+		if (*status != INTEGRITY_PASS_IMMUTABLE) {
+			if (iint->flags & IMA_DIGSIG_REQUIRED) {
+				*cause = "IMA-signature-required";
+				*status = INTEGRITY_FAIL;
+				break;
+			}
+			clear_bit(IMA_DIGSIG, &iint->atomic_flags);
+		} else {
+			set_bit(IMA_DIGSIG, &iint->atomic_flags);
 		}
-		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
 				iint->ima_hash->length)
 			/*
-- 
2.17.1

