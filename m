Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535AEF1E1C
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 20:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfKFTCD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 14:02:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36136 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732217AbfKFTB1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:01:27 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id A63CF20B4902;
        Wed,  6 Nov 2019 11:01:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A63CF20B4902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573066886;
        bh=emQkMogDPg+7vZ3mbA++3IrBI+JG/p38LRyTUkrJ4qw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JRWAv8jY0lkvRKSxRG0bkY8whJhlPyPo/gc5HddtERuoEfQ9x15MTs0QxvR9oMD3d
         EhvM9F14J3BHtK890ZG87YQUwDc11huOBlzAwURe/bXzC97l6JSerE+lhuUVRo9pti
         Sh2WbaoVCxs8rOrpBHomgCpnPdvx7hWd4Z0v4+dg=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] IMA: Added KEYRING_CHECK func in IMA policy to measure keys
Date:   Wed,  6 Nov 2019 11:01:08 -0800
Message-Id: <20191106190116.2578-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA policy needs to support a func to enable measurement of
asymmetric keys.

This patch defines a new IMA policy func namely KEYRING_CHECK to
measure asymmetric keys.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy | 6 ++++++
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_policy.c  | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 29aaedf33246..341df49b5ad1 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -30,6 +30,7 @@ Description:
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE]
+				[KEYRING_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
@@ -113,3 +114,8 @@ Description:
 		Example of appraise rule allowing modsig appended signatures:
 
 			appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig
+
+		Example of measure rule using KEYRING_CHECK to measure
+		all keys:
+
+			measure func=KEYRING_CHECK
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df4ca482fb53..7f23405b2718 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -193,6 +193,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
 	hook(KEXEC_CMDLINE)		\
+	hook(KEYRING_CHECK)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f19a895ad7cd..4344b7354fc5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -373,7 +373,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEXEC_CMDLINE) {
+	if ((func == KEXEC_CMDLINE) || (func == KEYRING_CHECK)) {
 		if ((rule->flags & IMA_FUNC) && (rule->func == func))
 			return true;
 		return false;
-- 
2.17.1

