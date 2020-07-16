Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48069222A4A
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgGPRoQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 13:44:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54484 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgGPRoE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 13:44:04 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8BA4920B490D;
        Thu, 16 Jul 2020 10:44:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BA4920B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594921443;
        bh=RWokx6Gd27oCAJ3WfeSZo3rN7tWPRY28o2No3gTEX3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2kfrWmU7YIfIqlbgLC/mi8r0ZWO2GiMiSjgSWF43XfOjVpq2lG7EXeViNital8Ba
         frJZ9rLF8E0IBRk9rJWbjQLzV5PIjL8EvwOYxywk2PiskVEa8NBn9UKmK+dGbdLmyn
         Rauqdot2l24h+eHytODFuglMFpsm9DGTt1szL3Gc=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] LSM: Add security_measure_data in lsm_info struct
Date:   Thu, 16 Jul 2020 10:43:49 -0700
Message-Id: <20200716174351.20128-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716174351.20128-1-nramas@linux.microsoft.com>
References: <20200716174351.20128-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The security modules that require their data to be measured using
the IMA subsystem need to define a function that the LSM can call
to trigger the measurement.

Add a function pointer field namely security_measure_data in lsm_info
structure. Update LSM to call this security module function, if defined,
to measure the security module's data using the IMA subsystem.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/lsm_hooks.h |  3 +++
 security/security.c       | 48 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 95b7c1d32062..56f0e524838c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1591,6 +1591,9 @@ struct lsm_info {
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
 	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
+	int (*security_measure_data)(void); /* Optional: for measuring
+					     * security module data.
+					     */
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
diff --git a/security/security.c b/security/security.c
index 70a7ad357bc6..1afa2aebc3ac 100644
--- a/security/security.c
+++ b/security/security.c
@@ -86,6 +86,9 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 static __initdata struct lsm_info **ordered_lsms;
 static __initdata struct lsm_info *exclusive;
 
+static struct lsm_info *security_state_lsms;
+static int security_state_lsms_count;
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -235,6 +238,45 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
+static int measure_security_state(struct lsm_info *lsm)
+{
+	if (!lsm->security_measure_data)
+		return 0;
+
+	return lsm->security_measure_data();
+}
+
+static void __init initialize_security_state_lsms(void)
+{
+	struct lsm_info **lsm;
+	int count = 0;
+	int inx;
+
+	for (lsm = ordered_lsms; *lsm; lsm++) {
+		if ((*lsm)->security_measure_data)
+			count++;
+	}
+
+	if (count == 0)
+		return;
+
+	security_state_lsms = kcalloc(count, sizeof(struct lsm_info),
+				      GFP_KERNEL);
+	if (!security_state_lsms)
+		return;
+
+	inx = 0;
+	for (lsm = ordered_lsms; *lsm; lsm++) {
+		if ((*lsm)->security_measure_data) {
+			security_state_lsms[inx].security_measure_data =
+				(*lsm)->security_measure_data;
+			inx++;
+		}
+	}
+
+	security_state_lsms_count = count;
+}
+
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
@@ -352,8 +394,12 @@ static void __init ordered_lsm_init(void)
 
 	lsm_early_cred((struct cred *) current->cred);
 	lsm_early_task(current);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	for (lsm = ordered_lsms; *lsm; lsm++) {
 		initialize_lsm(*lsm);
+		measure_security_state(*lsm);
+	}
+
+	initialize_security_state_lsms();
 
 	kfree(ordered_lsms);
 }
-- 
2.27.0

