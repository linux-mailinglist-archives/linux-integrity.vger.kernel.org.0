Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 580D3F1E11
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 20:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfKFTB1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 14:01:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36128 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbfKFTB1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:01:27 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7E2A82010C18;
        Wed,  6 Nov 2019 11:01:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E2A82010C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573066886;
        bh=fjc1SDZ6eAyerupfns9th1oRdeR4c1j0/l98r7qhoWI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IYQfPpBxfFCmXMbhSh7x03hOIBgGLnV2WV8Bb94KUj/gJab9+0p32BILkWBdNZscL
         u44Maavjs7FLkS3j7zTfE0wnqbT15F5seP9GmE7MnDZPfbb3fIRGOFN0tOQU9OgS/N
         JMsRdnR1UP3OdLm5I6Rz2OrlUbZKGLHKpB3k0DEc=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on key create or update
Date:   Wed,  6 Nov 2019 11:01:07 -0800
Message-Id: <20191106190116.2578-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Asymmetric keys used for verifying file signatures or certificates
are currently not included in the IMA measurement list.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure asymmetric keys.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..a0e233afe876 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -721,6 +721,22 @@ void ima_kexec_cmdline(const void *buf, int size)
 					   KEXEC_CMDLINE, 0);
 }
 
+/**
+ * ima_post_key_create_or_update - measure asymmetric keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   unsigned long flags, bool create)
+{
+	if ((keyring != NULL) && (key != NULL))
+		return;
+}
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.17.1

