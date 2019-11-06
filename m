Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771EDF1DF1
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfKFTB3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 14:01:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36196 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbfKFTB2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:01:28 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id C61CA20B4909;
        Wed,  6 Nov 2019 11:01:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C61CA20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573066887;
        bh=oyyg5Mcb7als6eY3sgazWcDSLsuJqSo0c/tbzPXjc9Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FAm5ugWGaYN/UX7WRUU0u48rXuwnzHSiAB0TXS0vGC2aGPSZ+3mbEjHJfSk6DGquz
         jf3PeHW9docxUpxbnGkXf7aJ/wUX2/J1xDsim5lFm02yJ1BjpYsrtUnM8Qo6vmUvNM
         +NSS/Mx1/FiTrSwsxHx+m4ea7hwTz8/VxT5Y4/HY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/10] IMA: Call queue and dequeue functions to measure keys
Date:   Wed,  6 Nov 2019 11:01:15 -0800
Message-Id: <20191106190116.2578-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys should be queued for measurement if IMA is not yet initialized.
Keys queued for measurement, if any, need to be processed when IMA
initialization is completed.

This patch updates the IMA hook for key_create_or_update 
to call ima_queue_or_process_key_for_measurement() and
adds the call to process queued keys upon IMA initialization
completion.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_init.c | 1 +
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a810af6df587..74817a9f78e5 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -137,6 +137,7 @@ int __init ima_init(void)
 		return rc;
 
 	ima_initialized = true;
+	ima_measure_queued_keys();
 
 	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 56540357c854..8733990867f2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -757,7 +757,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   unsigned long flags, bool create)
 {
 	if ((keyring != NULL) && (key != NULL))
-		return;
+		ima_queue_or_process_key_for_measurement(keyring, key);
 }
 
 static int __init init_ima(void)
-- 
2.17.1

