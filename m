Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8491FF8B5
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbgFRQHs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 12:07:48 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728008AbgFRQHm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 12:07:42 -0400
Received: from lhreml720-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 24093DC22CC506F26122;
        Thu, 18 Jun 2020 17:07:40 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml720-chm.china.huawei.com (10.201.108.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 17:07:39 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 18:07:38 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 08/11] ima: Allow imasig requirement to be satisfied by EVM portable signatures
Date:   Thu, 18 Jun 2020 18:04:55 +0200
Message-ID: <20200618160458.1579-8-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618160329.1263-2-roberto.sassu@huawei.com>
References: <20200618160329.1263-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

System administrators can require that all accessed files have a signature
by specifying appraise_type=imasig in a policy rule.

Currently, only IMA signatures satisfy this requirement. IMA signatures
ensure data source authentication for file content and prevent any change.
EVM signatures instead ensure data source authentication for file metadata.
Given that the digest or signature of the file content must be included in
the metadata, EVM signatures provide at least the same guarantees of IMA
signatures.

This patch lets systems protected with EVM signatures pass appraisal
verification if the appraise_type=imasig requirement is specified in the
policy. This facilitates deployment in the scenarios where only EVM
signatures are available.

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

In addition, similarly to IMA signatures, this patch temporarily allows
new files without or with incomplete metadata to be opened so that content
can be written.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_appraise.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 21bda264fc30..9505bb390d90 100644
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
@@ -394,6 +398,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 		cause = "missing-HMAC";
 		goto out;
 	case INTEGRITY_FAIL_IMMUTABLE:
+		set_bit(IMA_DIGSIG, &iint->atomic_flags);
+		fallthrough;
 	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
 		cause = "invalid-HMAC";
 		goto out;
@@ -437,9 +443,9 @@ int ima_appraise_measurement(enum ima_hooks func,
 				status = INTEGRITY_PASS;
 		}
 
-		/* Permit new files with file signatures, but without data. */
+		/* Permit new files marked as immutable, but without data. */
 		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
-		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
+		    test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
 			status = INTEGRITY_PASS;
 		}
 
-- 
2.17.1

