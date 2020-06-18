Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD09D1FFD2E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 23:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgFRVKR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 17:10:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52548 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFRVKR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 17:10:17 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id EDA5E207564C;
        Thu, 18 Jun 2020 14:10:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDA5E207564C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592514616;
        bh=YiCRzEtMqOMRGhK1JB6+uXhuvSs5ixeHO99z/YzrCNw=;
        h=From:To:Cc:Subject:Date:From;
        b=b30qOhfFRkmUxWYXsp0tCg1xNoai+tuzhcElGnk6aQqF+sHXn8o9cTZ3DOKkg2yAO
         nCwRPVzwRoHnBYW3E5flVBJUOwZ+1JrMzNU5fwjf0CB0m9smLxLpMKgSkKF7pk8Cv1
         12u0C4+Wu/QLKVuHjPBdpSB4IYsxlYm7AINMH764=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] integrity: Add errno field in audit message
Date:   Thu, 18 Jun 2020 14:10:11 -0700
Message-Id: <20200618211012.2823-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Error code is not included in the audit messages logged by
the integrity subsystem.

Define a new function integrity_audit_message() that takes error code
in the "errno" parameter. Add "errno" field in the audit messages logged
by the integrity subsystem and set the value passed in the "errno"
parameter.

[    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=measuring_key cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0 errno=-12

[    7.987647] audit: type=1802 audit(1592506283.312:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=policy_update cause=completed comm="systemd" res=1 errno=0

[    8.019432] audit: type=1804 audit(1592506283.344:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=measuring_kexec_cmdline cause=hashing_error comm="systemd" name="kexec-cmdline" res=0 errno=-22

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Steve Grubb <sgrubb@redhat.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/integrity.h       | 13 +++++++++++++
 security/integrity/integrity_audit.c | 11 ++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 16c1894c29bb..413c803c5208 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -239,6 +239,11 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const unsigned char *fname, const char *op,
 			 const char *cause, int result, int info);
 
+void integrity_audit_message(int audit_msgno, struct inode *inode,
+			     const unsigned char *fname, const char *op,
+			     const char *cause, int result, int info,
+			     int errno);
+
 static inline struct audit_buffer *
 integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 {
@@ -253,6 +258,14 @@ static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 {
 }
 
+static inline void integrity_audit_message(int audit_msgno,
+					   struct inode *inode,
+					   const unsigned char *fname,
+					   const char *op, const char *cause,
+					   int result, int info, int errno)
+{
+}
+
 static inline struct audit_buffer *
 integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 {
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 5109173839cc..f25e7df099c8 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -28,6 +28,15 @@ __setup("integrity_audit=", integrity_audit_setup);
 void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const unsigned char *fname, const char *op,
 			 const char *cause, int result, int audit_info)
+{
+	integrity_audit_message(audit_msgno, inode, fname, op, cause,
+				result, audit_info, 0);
+}
+
+void integrity_audit_message(int audit_msgno, struct inode *inode,
+			     const unsigned char *fname, const char *op,
+			     const char *cause, int result, int audit_info,
+			     int errno)
 {
 	struct audit_buffer *ab;
 	char name[TASK_COMM_LEN];
@@ -53,6 +62,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
 	}
-	audit_log_format(ab, " res=%d", !result);
+	audit_log_format(ab, " res=%d errno=%d", !result, errno);
 	audit_log_end(ab);
 }
-- 
2.27.0

