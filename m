Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075B920BCB6
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFZWjd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:39:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37788 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgFZWjc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:32 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1F04020B4904;
        Fri, 26 Jun 2020 15:39:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F04020B4904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211171;
        bh=/fXCtimfsO5yJFCIUd284uYnqZ76Dz3IDTmbuYiAJNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXnwtulzDNqU/pVA+HTNv/CBFpfczEL+jCCVzeDihk/mCb/xqi2QWyx8wba+1j/DK
         UQkxvlHJYH+NAu9AUH+X+62ZwedXDH+9KDuyzI0dD6Ia1KQ8eUomGRiyNofX/cdcYV
         tDC++6weEFbFLtjFzFSBgMIxjAdcnZjlNMIk8E3A=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2 01/11] ima: Have the LSM free its audit rule
Date:   Fri, 26 Jun 2020 17:38:50 -0500
Message-Id: <20200626223900.253615-2-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ask the LSM to free its audit rule rather than directly calling kfree().
Both AppArmor and SELinux do additional work in their audit_rule_free()
hooks. Fix memory leaks by allowing the LSMs to perform necessary work.

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Janne Karhunen <janne.karhunen@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---

* v2
  - Fixed build warning by dropping the 'return -EINVAL' from
    the stubbed out security_filter_rule_free() since it has a void
    return type
  - Added Mimi's Reviewed-by
  - Developed a follow-on patch to rename security_filter_rule_*()
    functions, to address Casey's request, but I'll submit it
    independently of this patch series since it is somewhat unrelated

 security/integrity/ima/ima.h        | 5 +++++
 security/integrity/ima/ima_policy.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4515975cc540..59ec28f5c117 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -420,6 +420,7 @@ static inline void ima_free_modsig(struct modsig *modsig)
 #ifdef CONFIG_IMA_LSM_RULES
 
 #define security_filter_rule_init security_audit_rule_init
+#define security_filter_rule_free security_audit_rule_free
 #define security_filter_rule_match security_audit_rule_match
 
 #else
@@ -430,6 +431,10 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
+static inline void security_filter_rule_free(void *lsmrule)
+{
+}
+
 static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
 					     void *lsmrule)
 {
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 66aa3e17a888..d7c268c2b0ce 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -258,7 +258,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 	int i;
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		kfree(entry->lsm[i].rule);
+		security_filter_rule_free(entry->lsm[i].rule);
 		kfree(entry->lsm[i].args_p);
 	}
 	kfree(entry);
-- 
2.25.1

