Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34110A832
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 02:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK0B5F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Nov 2019 20:57:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54464 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfK0B5E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Nov 2019 20:57:04 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 159EA20B4900;
        Tue, 26 Nov 2019 17:57:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 159EA20B4900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574819824;
        bh=L4puKXt7OmrSagN42Huxd1vQTKOco/JYM8kKj45zf2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMYoQG9WHtZ0hB4PRgf16yChjYX6bz917ovKRu85etAEK6XZJrjmYdxMQJDaDpbeO
         s5DlDbrk9i/kYlif26j/bZGCL+Virqw6BU/JNT8NyUYVxj9Rn5UVWhpQwDrBOySbfw
         WpR6FZoP2BXNT2PnfTBfCQPEzjePqMruGkBvLb3E=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v9 2/6] IMA: Add KEY_CHECK func to measure keys
Date:   Tue, 26 Nov 2019 17:56:50 -0800
Message-Id: <20191127015654.3744-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127015654.3744-1-nramas@linux.microsoft.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
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
 Documentation/ABI/testing/ima_policy | 6 +++++-
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_policy.c  | 4 +++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 29aaedf33246..066d32797500 100644
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
@@ -113,3 +113,7 @@ Description:
 		Example of appraise rule allowing modsig appended signatures:
 
 			appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig
+
+		Example of measure rule using KEY_CHECK to measure all keys:
+
+			measure func=KEY_CHECK
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

