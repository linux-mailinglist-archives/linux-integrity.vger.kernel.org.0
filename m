Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48009F1E08
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 20:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfKFTBs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 14:01:48 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36184 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbfKFTB2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:01:28 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 76F7820B4907;
        Wed,  6 Nov 2019 11:01:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76F7820B4907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573066887;
        bh=vzYPZl2IGof7+mAg55CncHBag4fIUbnnADY8hCvLvn0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sZ9Gms1Y/cRhVwtVw52cvtghfyKsKsh5QJAGFfeC9JYRs+tP/rItB0miMZ3rOQqg+
         IdUT0d/T3wrymsjo4NjVwS+8woW8+0vpFxqxt2bLYP2cZyZjvc4m7l/w+vx5b/PgKH
         m4Ys7vBSJmQYm7OOppi9WofAi0Y8igsOMhHihcH4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/10] IMA: Added a boolean flag to track IMA initialization status
Date:   Wed,  6 Nov 2019 11:01:13 -0800
Message-Id: <20191106190116.2578-8-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA initialization status need to be checked before attempting to
determine the action (measure, appraise, etc.) and any related options
specified in the IMA policy.

This patch defines a flag namely ima_initialized to track
IMA initialization status.

ima_policy_flag cannot be relied upon for knowing IMA initialization
status because ima_policy_flag will be set to 0 when either IMA
is not initialized or the IMA policy itself is empty.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h      | 1 +
 security/integrity/ima/ima_init.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f15199f7ff2a..6a86daa62c5b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -52,6 +52,7 @@ extern int ima_policy_flag;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
+extern bool ima_initialized;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..a810af6df587 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -23,6 +23,7 @@
 /* name for boot aggregate entry */
 static const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
+bool ima_initialized;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -131,5 +132,11 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
-	return ima_fs_init();
+	rc = ima_fs_init();
+	if (rc != 0)
+		return rc;
+
+	ima_initialized = true;
+
+	return 0;
 }
-- 
2.17.1

