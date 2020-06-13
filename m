Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561001F806E
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jun 2020 04:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFMCl6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 22:41:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54118 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgFMClh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 22:41:37 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C47BB20B4782;
        Fri, 12 Jun 2020 19:41:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C47BB20B4782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592016097;
        bh=F0KUrRtb3r8N9EtpYLjSg6CNnVGLSPMem/gwYtUR/WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2gr/iG2sDvLPc/au9Hl+dRZpsiOGNRoPgChg3DgH5M9LMgbYfilZPeZEcM4JpVZ6
         /iz8aU+FgTF+u7tCebedOxCYTqJJtxLshjrkxpKEJ0TPmw0xae3bllzXw2gHUG9xKM
         uGAJ7iahyFf+mawyGmdkyNeaPH9Bo/2RK5mRSF+0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] LSM: Add security_state function pointer in lsm_info struct
Date:   Fri, 12 Jun 2020 19:41:28 -0700
Message-Id: <20200613024130.3356-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613024130.3356-1-nramas@linux.microsoft.com>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The security modules that require their data to be measured need to
define a function that the LSM can call to gather the data.

Add a function pointer field namely security_state in lsm_info structure.
Update LSM to call this security module function, if defined, to gather
data and measure it by calling the IMA hook ima_lsm_state().

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/lsm_hooks.h |  2 ++
 security/security.c       | 60 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3e62dab77699..da248c3fd4ac 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1568,6 +1568,8 @@ struct lsm_info {
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
 	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
+	int (*security_state)(char **lsm_name, void **state,
+			      int *state_len); /*Optional */
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
diff --git a/security/security.c b/security/security.c
index e0290b7e6a08..a6e2d1cd95af 100644
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
@@ -235,6 +238,57 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
+static int measure_security_state(struct lsm_info *lsm)
+{
+	char *lsm_name = NULL;
+	void *state = NULL;
+	int state_len = 0;
+	int rc;
+
+	if (!lsm->security_state)
+		return 0;
+
+	rc = lsm->security_state(&lsm_name, &state, &state_len);
+	if ((rc == 0) && (state_len > 0)) {
+		ima_lsm_state(lsm_name, state, state_len);
+		kfree(state);
+		kfree(lsm_name);
+	}
+
+	return rc;
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
@@ -352,8 +406,12 @@ static void __init ordered_lsm_init(void)
 
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

