Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5361F8057
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jun 2020 04:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFMC0q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 22:26:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49296 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgFMC0q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 22:26:46 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D8C3F20B4780;
        Fri, 12 Jun 2020 19:26:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8C3F20B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592015206;
        bh=1sFLZ18KHk3JRrd3Sy5zC2Y1jaoDS0PRcDBfjFq7cNs=;
        h=From:To:Cc:Subject:Date:From;
        b=XY8wyhfCYYm1icyQl4vBc+9LLhPwRxojQCgP+JZhVKywbPZ/w1D5dFx753FXKThjW
         FHZVGkhLxQAhdNw5W2zgIoTBUWdUDQ1j/XdeI65fLr7Sv0lS0k2nJP/GfwlkgEEdpr
         zjQZT1RKaYAF1io50KZvoFVMjb208tGp6LyZP97A=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] integrity: Add result field in audit message
Date:   Fri, 12 Jun 2020 19:26:32 -0700
Message-Id: <20200613022633.3129-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Result code is not included in the audit messages logged by
the integrity subsystem. Add "result" field in the audit messages
logged by the integrity subsystem and set the value to the result code
passed to integrity_audit_msg() in the "result" parameter.

Sample audit message:

[    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate cause=alloc_entry comm="swapper/0" name="boot_aggregate" res=0 result=-12

[    8.085456] audit: type=1802 audit(1592005947.297:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=policy_update cause=completed comm="systemd" res=1 result=0

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Steve Grubb <sgrubb@redhat.com>
---
 security/integrity/integrity_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 5109173839cc..84002d3d5a95 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -53,6 +53,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
 	}
-	audit_log_format(ab, " res=%d", !result);
+	audit_log_format(ab, " res=%d result=%d", !result, result);
 	audit_log_end(ab);
 }
-- 
2.27.0

