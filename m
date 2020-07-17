Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C386A22464D
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jul 2020 00:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGQW20 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 18:28:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46056 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgGQW20 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 18:28:26 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0870920B490D;
        Fri, 17 Jul 2020 15:28:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0870920B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595024905;
        bh=IdQSrPA8ty21hAGthr+LlcK7k1tepvn9UlOK08+4/Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+RNQ9DjFg302EnaTWPLdcf3JXEfSbkdWIONz1UOoB1n5ib/WysXq062Vib+Pwwql
         IDhocOQQ842tF7tqJi/Rldjxz/KCmTzamnBV+GVPW9Xs7lij6SIlnpvvnDsz11/lck
         ihWY6m2NAIqA5AvYWJxcsj7Vnt3HqUUwQ0pqyv8s=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] LSM: Add security_measure_data in lsm_info struct
Date:   Fri, 17 Jul 2020 15:28:17 -0700
Message-Id: <20200717222819.26198-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717222819.26198-1-nramas@linux.microsoft.com>
References: <20200717222819.26198-1-nramas@linux.microsoft.com>
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
index 95b7c1d32062..17afdf319c55 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1591,6 +1591,9 @@ struct lsm_info {
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
 	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
+	void (*security_measure_data)(void); /* Optional: for measuring
+					      * security module data.
+					      */
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
diff --git a/security/security.c b/security/security.c
index 70a7ad357bc6..88ce1b780ffd 100644
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
 
+static void measure_security_state(struct lsm_info *lsm)
+{
+	if (!lsm->security_measure_data)
+		return;
+
+	lsm->security_measure_data();
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

