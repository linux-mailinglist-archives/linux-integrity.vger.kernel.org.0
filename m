Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B745422118C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGOPtB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 11:49:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45920 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgGOPtA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 11:49:00 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5770B20B490C;
        Wed, 15 Jul 2020 08:48:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5770B20B490C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594828139;
        bh=OqDhaj3lxUF2+F+a7rlNEFcsWrZi5ztd9xoMLqCdtb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jM9NTkdTyQWFznJayggIeGGBa+zjV22gF5o6/bmBhW6Xjdz7XTlh2LW0Cut7ZjrFS
         s+KqN47ZmWY0pRc9VM0DdsznCv7kIvB/hbQ8tLXXUtzsn//ab49ep97k1JLp7FlCnU
         a51dnyEOXhwWu+m5MdcCLmwZSCn9MmSmMuY7s+oM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] LSM: Add security_state function pointer in lsm_info struct
Date:   Wed, 15 Jul 2020 08:48:51 -0700
Message-Id: <20200715154853.23374-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715154853.23374-1-nramas@linux.microsoft.com>
References: <20200715154853.23374-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The security modules that require their data to be measured using
the IMA subsystem need to define a function that the LSM can call
to trigger the measurement.

Add a function pointer field namely security_state in lsm_info structure.
Update LSM to call this security module function, if defined, to measure
the security module's data using the IMA subsystem.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/lsm_hooks.h |  3 +++
 security/security.c       | 48 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 95b7c1d32062..a688eb29e5d8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1591,6 +1591,9 @@ struct lsm_info {
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
 	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
+	int (*security_state)(void); /* Optional: for measuring the state
+				      * of the security module.
+				      */
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
diff --git a/security/security.c b/security/security.c
index 70a7ad357bc6..3fbabc2e6ddb 100644
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
+	if (!lsm->security_state)
+		return 0;
+
+	return lsm->security_state();
+}
+
+static void __init initialize_security_state_lsms(void)
+{
+	struct lsm_info **lsm;
+	int count = 0;
+	int inx;
+
+	for (lsm = ordered_lsms; *lsm; lsm++) {
+		if ((*lsm)->security_state)
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
+		if ((*lsm)->security_state) {
+			security_state_lsms[inx].security_state =
+				(*lsm)->security_state;
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

