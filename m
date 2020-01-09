Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7960A135B0C
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jan 2020 15:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgAIOIo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jan 2020 09:08:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46971 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgAIOIo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jan 2020 09:08:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id m26so7322048ljc.13;
        Thu, 09 Jan 2020 06:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mcCdRiYgan4Ah7460AE2tlNezQkP70ughOkgnn2zWig=;
        b=dIa0ugsqbnth3pJ7h2R+Wyd9qyUA4mwxprIPL7wjM4eqH24lGTV8ZImNGEimn+1Bzf
         6Sb7E7xuhzxHU6Oybazayg6vYpMQCy28hcFBSFhXtleCwr3RKuPJ/pf+cG1WS7Hye1AE
         oajKWdLCFhUbcZPSRFw+NMAqP/VEoEhDsAwRH2ijoTApNn17F5NOuXxDn79jPc1+u8sg
         IuWYpjEdUFwKa/vLTQW1oRBC/7il6xnDbGc/xq1WVeH1bNEBz+Tz+tRNd7IubN0i046U
         ZPfX6CI4BX7UuWIEv/YueQ+qNFf0fYd4P3IV4urVkK7QV81PZRD4gBFaDqgML2uPnstj
         ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mcCdRiYgan4Ah7460AE2tlNezQkP70ughOkgnn2zWig=;
        b=NHAhQJ1dx1iddtIp9aiclJJ1dvKi5DLlwHu87G3LHcfRN46QeCTnQ5km0uSAJjFa8k
         U1BBJzJiQcaHYt0OSR5WW0yGXzIRI1M7SBtrJV0loezeyTVA7FGf4epGEYTtC8/vEKdc
         rscHGrFcCHgkzBgiH++eUmAuq3PagQPFmGeb8/bYAitvzoQngqF0fr0K+1Iqa7dPf5RK
         QWP3v0GLkP16s/Lg5mY2tfUvF0XiTPFZrddVSB/VKEw/6HTq7DudkvvOmGEeuqm2HTQx
         OA+RtYHMnEhk1XnW20ipaNOIz7w6yPzFtQyNIUt4amYZaZwdDyEW01+RHOgHs/eiPKtU
         vZtQ==
X-Gm-Message-State: APjAAAW1gDTBqTRMxIvDlw0/Lh63vEXo7dQh77VgMTVj3xLSAl/NlFOz
        O1uW8sdhqcirzdY/CzeuyCZDva0W
X-Google-Smtp-Source: APXvYqyeuBL5Nra50raH3DKQm7g83na+zG5fsaRSmjbf+EFpDs2xW71L8P3mh1I2Q7o5TKz/0xvF1g==
X-Received: by 2002:a2e:5357:: with SMTP id t23mr6727149ljd.227.1578578922047;
        Thu, 09 Jan 2020 06:08:42 -0800 (PST)
Received: from localhost.localdomain (mobile-user-c1d2e4-97.dhcp.inet.fi. [193.210.228.97])
        by smtp.gmail.com with ESMTPSA id n30sm3566499lfi.54.2020.01.09.06.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:08:41 -0800 (PST)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH] ima: ima/lsm policy rule loading logic bug fixes
Date:   Thu,  9 Jan 2020 16:08:21 +0200
Message-Id: <20200109140821.17902-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keep the ima policy rules around from the beginning even
if they appear invalid at the time of loading, as they
may become active after the lsm policy load. In other
words, now the lsm and the ima can be initialized in any
order and the handling logic is the same as with the lsm
rule reload event.

Patch also fixes the rule re-use during the lsm policy
reload and makes some prints a bit more human readable.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 security/integrity/ima/ima_policy.c | 44 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a4dde9d575b2..4022c7736fc3 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -265,7 +265,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 {
 	struct ima_rule_entry *nentry;
-	int i, result;
+	int i;
 
 	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
 	if (!nentry)
@@ -279,7 +279,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	memset(nentry->lsm, 0, FIELD_SIZEOF(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (!entry->lsm[i].rule)
+		if (!entry->lsm[i].args_p)
 			continue;
 
 		nentry->lsm[i].type = entry->lsm[i].type;
@@ -288,13 +288,13 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		if (!nentry->lsm[i].args_p)
 			goto out_err;
 
-		result = security_filter_rule_init(nentry->lsm[i].type,
-						   Audit_equal,
-						   nentry->lsm[i].args_p,
-						   &nentry->lsm[i].rule);
-		if (result == -EINVAL)
-			pr_warn("ima: rule for LSM \'%d\' is undefined\n",
-				entry->lsm[i].type);
+		security_filter_rule_init(nentry->lsm[i].type,
+					  Audit_equal,
+					  nentry->lsm[i].args_p,
+					  &nentry->lsm[i].rule);
+		if (!nentry->lsm[i].rule)
+			pr_warn("rule for LSM \'%s\' is undefined\n",
+				(char *)entry->lsm[i].args_p);
 	}
 	return nentry;
 
@@ -331,7 +331,9 @@ static void ima_lsm_update_rules(void)
 	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
 		needs_update = 0;
 		for (i = 0; i < MAX_LSM_RULES; i++) {
-			if (entry->lsm[i].rule) {
+			if (entry->lsm[i].args_p) {
+				pr_info("rule for LSM \'%s\' needs update\n",
+					(char *)entry->lsm[i].args_p);
 				needs_update = 1;
 				break;
 			}
@@ -341,8 +343,7 @@ static void ima_lsm_update_rules(void)
 
 		result = ima_lsm_update_rule(entry);
 		if (result) {
-			pr_err("ima: lsm rule update error %d\n",
-				result);
+			pr_err("lsm rule update error %d\n", result);
 			return;
 		}
 	}
@@ -865,8 +866,6 @@ static const match_table_t policy_tokens = {
 static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 			     substring_t *args, int lsm_rule, int audit_type)
 {
-	int result;
-
 	if (entry->lsm[lsm_rule].rule)
 		return -EINVAL;
 
@@ -875,16 +874,15 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 		return -ENOMEM;
 
 	entry->lsm[lsm_rule].type = audit_type;
-	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
-					   Audit_equal,
-					   entry->lsm[lsm_rule].args_p,
-					   &entry->lsm[lsm_rule].rule);
-	if (!entry->lsm[lsm_rule].rule) {
-		kfree(entry->lsm[lsm_rule].args_p);
-		return -EINVAL;
-	}
+	security_filter_rule_init(entry->lsm[lsm_rule].type,
+				  Audit_equal,
+				  entry->lsm[lsm_rule].args_p,
+				  &entry->lsm[lsm_rule].rule);
+	if (!entry->lsm[lsm_rule].rule)
+		pr_warn("rule for LSM \'%s\' is undefined\n",
+			(char *)entry->lsm[lsm_rule].args_p);
 
-	return result;
+	return 0;
 }
 
 static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
-- 
2.17.1

