Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD012EA8A7
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 02:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJaBTf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Oct 2019 21:19:35 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34474 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfJaBTS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:18 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id AD5CB20B4907;
        Wed, 30 Oct 2019 18:19:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD5CB20B4907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572484757;
        bh=jKCw7ecMxlLW55Hvso0B/oH0r+YVuf8aJi5MmMxfj2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUXZUoJjd42BGBah7hX3+OiQqMXaK/ioKWbjLZ/T0RhMvbNAF1+pu0kiECQZLqQrK
         Nfc9DmX+tUqIBddrPT4Hx5TwXWaEEBdZvGjK0wIPw11s9Wcgiq6n/SBk4lBjLpO4LT
         9T0vn+kFkE4cOK/h5OcXQrebaxOEiTvlrYl/Ig9o=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Subject: [PATCH v3 7/9] KEYS: Queue key for measurement if IMA is not yet initialized. Measure queued keys when IMA initialization is completed
Date:   Wed, 30 Oct 2019 18:19:08 -0700
Message-Id: <20191031011910.2574-8-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys need to be queued when the IMA hook to measure keys is called before
IMA is initialized. Keys queued for measurement need to be processed when
IMA initialization is completed.

This patch adds the call to queue and de-queue keys for measurement.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_init.c | 7 ++++++-
 security/integrity/ima/ima_main.c | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..91eaa5f2d008 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -131,5 +131,10 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
-	return ima_fs_init();
+	rc = ima_fs_init();
+	if (rc != 0)
+		return rc;
+
+	ima_measure_queued_keys();
+	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index bd835ec89ead..2ad05563542c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -732,6 +732,11 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (key->type != &key_type_asymmetric)
 		return;
 
+	if (!ima_policy_flag) {
+		ima_queue_key_for_measurement(keyring, key);
+		return;
+	}
+
 	pk = key->payload.data[asym_crypto];
 	process_buffer_measurement(pk->key, pk->keylen,
 				   keyring->description,
-- 
2.17.1

