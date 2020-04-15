Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC32C1AAE0F
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2020 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415820AbgDOQ0N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 12:26:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49230 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415801AbgDOQ0G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 12:26:06 -0400
Received: from dede-linux.corp.microsoft.com (unknown [131.107.147.242])
        by linux.microsoft.com (Postfix) with ESMTPSA id B1EE92074CC0;
        Wed, 15 Apr 2020 09:25:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1EE92074CC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586967958;
        bh=FoQEwrrWn/d3Fno/jqMS38zWmUVRke4mJOAaLbjRrY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyJ4LtL05RR5RRuLClgYEE6/yEwxIoknDGK9+Zzw2E4c2Xb3kaxGDr/fd81Cydtfr
         6DYL1plXSSvGQYnuUsKhbHl0+FwfUKrzGjrClNTKZ2pz3WFfvZCsXitn6YtN82jWD0
         fVoSfI6fOVH29aaH5rpX0n2+2Z/IC+5j+q1eLAI8=
From:   deven.desai@linux.microsoft.com
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [RFC PATCH v3 12/12] cleanup: uapi/linux/audit.h
Date:   Wed, 15 Apr 2020 09:25:50 -0700
Message-Id: <20200415162550.2324-13-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Deven Bowers <deven.desai@linux.microsoft.com>

Remove trailing whitespaces and align the integrity #defines in
linux/uapi/audit.h

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 include/uapi/linux/audit.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 4e0122a0ed0c..d642ade068b5 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -48,7 +48,7 @@
  * 2500 - 2999 future user space (maybe integrity labels and related events)
  *
  * Messages from 1000-1199 are bi-directional. 1200-1299 & 2100 - 2999 are
- * exclusively user space. 1300-2099 is kernel --> user space 
+ * exclusively user space. 1300-2099 is kernel --> user space
  * communication.
  */
 #define AUDIT_GET		1000	/* Get status */
@@ -78,7 +78,7 @@
 #define AUDIT_LAST_USER_MSG	1199
 #define AUDIT_FIRST_USER_MSG2	2100	/* More user space messages */
 #define AUDIT_LAST_USER_MSG2	2999
- 
+
 #define AUDIT_DAEMON_START      1200    /* Daemon startup record */
 #define AUDIT_DAEMON_END        1201    /* Daemon normal stop record */
 #define AUDIT_DAEMON_ABORT      1202    /* Daemon error stop record */
@@ -139,20 +139,20 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 
-#define AUDIT_FIRST_KERN_ANOM_MSG   1700
-#define AUDIT_LAST_KERN_ANOM_MSG    1799
-#define AUDIT_ANOM_PROMISCUOUS      1700 /* Device changed promiscuous mode */
-#define AUDIT_ANOM_ABEND            1701 /* Process ended abnormally */
-#define AUDIT_ANOM_LINK		    1702 /* Suspicious use of file links */
-#define AUDIT_ANOM_CREAT	    1703 /* Suspicious file creation */
-#define AUDIT_INTEGRITY_DATA	    1800 /* Data integrity verification */
-#define AUDIT_INTEGRITY_METADATA    1801 /* Metadata integrity verification */
-#define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
-#define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
-#define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
-#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
-#define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
-#define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
+#define AUDIT_FIRST_KERN_ANOM_MSG	1700
+#define AUDIT_LAST_KERN_ANOM_MSG	1799
+#define AUDIT_ANOM_PROMISCUOUS		1700 /* Device changed promiscuous mode */
+#define AUDIT_ANOM_ABEND		1701 /* Process ended abnormally */
+#define AUDIT_ANOM_LINK			1702 /* Suspicious use of file links */
+#define AUDIT_ANOM_CREAT		1703 /* Suspicious file creation */
+#define AUDIT_INTEGRITY_DATA		1800 /* Data integrity verification */
+#define AUDIT_INTEGRITY_METADATA	1801 /* Metadata integrity verification */
+#define AUDIT_INTEGRITY_STATUS		1802 /* Integrity enable status */
+#define AUDIT_INTEGRITY_HASH		1803 /* Integrity HASH type */
+#define AUDIT_INTEGRITY_PCR		1804 /* PCR invalidation msgs */
+#define AUDIT_INTEGRITY_RULE		1805 /* policy rule */
+#define AUDIT_INTEGRITY_EVM_XATTR	1806 /* New EVM-covered xattr */
+#define AUDIT_INTEGRITY_POLICY_RULE	1807 /* IMA policy rules */
 #define AUDIT_INTEGRITY_POLICY_LOAD	1808 /* IPE Policy Load */
 #define AUDIT_INTEGRITY_POLICY_ACTIVATE	1809 /* IPE Policy Activation */
 #define AUDIT_INTEGRITY_EVENT		1810 /* IPE Evaluation Event */
-- 
2.26.0

