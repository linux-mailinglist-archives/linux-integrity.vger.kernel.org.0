Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B3D13D289
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2020 04:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAPDNr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 22:13:47 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39480 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAPDNr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 22:13:47 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9AB842008710;
        Wed, 15 Jan 2020 19:13:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AB842008710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579144426;
        bh=V3Ds4RpgBxSwsUsJpJvIRuEhKzlSSaeueHPFqpvVuyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qD2RbvB8PrVXz8ZIup03tpVcqZ62lIeoP3YA0CMdl0d9DH2DnPWS0bBCUb2UJf/og
         Rjg68tIQ5D7iriC25H5esuK0XaJqqpnexBjF9STs/C23xVPy2NrWGui6KxvftZNT5O
         HnWCdb6vRAfxxivGnlGemmfBxQ/sD3YCyzq3habU=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dvyukov@google.com,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, sashal@kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH] IMA: inconsistent lock state in ima_process_queued_keys
Date:   Wed, 15 Jan 2020 19:13:42 -0800
Message-Id: <20200116031342.3418-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_queued_keys() is called from a non-interrupt context, but
ima_process_queued_keys() may be called from both an interrupt
context (ima_timer_handler) and non-interrupt context
(ima_update_policy). Since the spinlock named ima_keys_lock is used
in both ima_queued_keys() and ima_process_queued_keys(),
irq version of the spinlock macros, spin_lock_irqsave() and
spin_unlock_irqrestore(), should be used[1].

This patch fixes the "inconsistent lock state" issue caused by
using the non-irq version of the spinlock macros in ima_queue_key()
and ima_process_queued_keys().

[1] Documentation/locking/spinlocks.rst

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: 8f5d2d06f217 ("IMA: Defined timer to free queued keys")
Fixes: 9fb38e76b5f1 ("IMA: Define workqueue for early boot key measurements")
---
 security/integrity/ima/ima_asymmetric_keys.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 61e478f9e819..381f51708e7b 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -103,17 +103,18 @@ static bool ima_queue_key(struct key *keyring, const void *payload,
 {
 	bool queued = false;
 	struct ima_key_entry *entry;
+	unsigned long flags;
 
 	entry = ima_alloc_key_entry(keyring, payload, payload_len);
 	if (!entry)
 		return false;
 
-	spin_lock(&ima_keys_lock);
+	spin_lock_irqsave(&ima_keys_lock, flags);
 	if (!ima_process_keys) {
 		list_add_tail(&entry->list, &ima_keys);
 		queued = true;
 	}
-	spin_unlock(&ima_keys_lock);
+	spin_unlock_irqrestore(&ima_keys_lock, flags);
 
 	if (!queued)
 		ima_free_key_entry(entry);
@@ -131,6 +132,7 @@ void ima_process_queued_keys(void)
 {
 	struct ima_key_entry *entry, *tmp;
 	bool process = false;
+	unsigned long flags;
 
 	if (ima_process_keys)
 		return;
@@ -141,12 +143,12 @@ void ima_process_queued_keys(void)
 	 * First one setting the ima_process_keys flag to true will
 	 * process the queued keys.
 	 */
-	spin_lock(&ima_keys_lock);
+	spin_lock_irqsave(&ima_keys_lock, flags);
 	if (!ima_process_keys) {
 		ima_process_keys = true;
 		process = true;
 	}
-	spin_unlock(&ima_keys_lock);
+	spin_unlock_irqrestore(&ima_keys_lock, flags);
 
 	if (!process)
 		return;
-- 
2.17.1

