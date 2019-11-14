Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1935FBE20
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 04:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfKNDMK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 22:12:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48438 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfKNDMJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 22:12:09 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.159.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 38E2920B4903;
        Wed, 13 Nov 2019 19:12:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38E2920B4903
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573701129;
        bh=K/agi32Oac2t+Dh8q8GVUkQ2g0EOgg71DPIGb1PJ/fQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YlJt/Y+13ZQEMFS7ClYl9ALrQlo2sDWJNaIb9n5zLVpj1l42eP8rXbocg06qXY/xT
         uUpHccgeJNK4Vq/IA94K1a6hUDtDz+11u/lun35Kqus0i9HXZ9KoKuTglAL2jW5cVp
         K2Sq/kxcpTORwsDgFd2g5DoZiJ63CBttBpuNe0Ig=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/5] IMA: Add KEY_CHECK func to measure keys
Date:   Wed, 13 Nov 2019 19:11:58 -0800
Message-Id: <20191114031202.18012-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114031202.18012-1-nramas@linux.microsoft.com>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Measure keys loaded onto any keyring.

This patch defines a new IMA policy func namely KEY_CHECK to
measure keys. Updated ima_match_rules() to check for KEY_CHECK
and ima_parse_rule() to handle KEY_CHECK.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy | 7 ++++++-
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_policy.c  | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 29aaedf33246..3823c27894c5 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
-				[KEXEC_CMDLINE]
+				[KEXEC_CMDLINE] [KEY_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
@@ -113,3 +113,8 @@ Description:
 		Example of appraise rule allowing modsig appended signatures:
 
 			appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig
+
+		Example of measure rule using KEY_CHECK to measure all keys:
+
+			measure func=KEY_CHECK
+
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df4ca482fb53..fe6c698617bd 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -193,6 +193,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
 	hook(KEXEC_CMDLINE)		\
+	hook(KEY_CHECK)			\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f19a895ad7cd..1525a28fd705 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -373,7 +373,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEXEC_CMDLINE) {
+	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
 		if ((rule->flags & IMA_FUNC) && (rule->func == func))
 			return true;
 		return false;
@@ -997,6 +997,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = POLICY_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
 				entry->func = KEXEC_CMDLINE;
+			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
+				entry->func = KEY_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.17.1

