Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699771F5F04
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 02:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgFKAEG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Jun 2020 20:04:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52018 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgFKAEG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jun 2020 20:04:06 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 48C3620B4778;
        Wed, 10 Jun 2020 17:04:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48C3620B4778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591833845;
        bh=Jg1D9fyRRgF71SKb0UGGuUXLQN77lsoxtU1UUIl2BWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XrTM444nDjhTHOBImXLhSueVbU2Wzy4Ggy0tUSa/Jo4xjTjBuw0H3D1bFzMevPYbU
         OrcfT6jIOtz1sIQuPPiRIvAZOGdsi22R19zyQrl5PIjqzyxVOswrslcVD607ykDXWt
         Hrrsyo/cjwNW2cjMPHGKazsHroclASjfTipPXb3A=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] integrity: Add errno field in audit message
Date:   Wed, 10 Jun 2020 17:03:59 -0700
Message-Id: <20200611000400.3771-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Error code is not included in the audit messages logged by
the integrity subsystem. Add a new field namely "errno" in
the audit message and set the value to the error code passed
to integrity_audit_msg() in the "result" parameter.

Sample audit message:

[    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate cause=alloc_entry errno=-12 comm="swapper/0" name="boot_aggregate" res=0

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Steve Grubb <sgrubb@redhat.com>
---
 security/integrity/integrity_audit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 5109173839cc..8cbf415bb977 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -42,7 +42,8 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			 audit_get_sessionid(current));
 	audit_log_task_context(ab);
-	audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
+	audit_log_format(ab, " op=%s cause=%s errno=%d comm=",
+			 op, cause, result);
 	audit_log_untrustedstring(ab, get_task_comm(name, current));
 	if (fname) {
 		audit_log_format(ab, " name=");
-- 
2.27.0

