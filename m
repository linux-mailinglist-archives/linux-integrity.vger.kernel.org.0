Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2347B13689A
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jan 2020 08:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAJH4R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jan 2020 02:56:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41046 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgAJH4R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jan 2020 02:56:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so1124929ljc.8;
        Thu, 09 Jan 2020 23:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=biGBmUqZgjd3xw38mtDIl68wlZERVjBt+Lolzy4x8lE=;
        b=oGWtHAm+dAKl3DZ6sJxZTHYxD1Ys8xb+OTQQpbV3ljcw4cVZEQ035c2Zwjg2m68A9a
         YrgNe02jqWVLMjUXQjkbr8Asxrk/yZrQ9gsePs7kZElSiTv9380CB7ubcM23vgLfAk6/
         PMci5JPsh8starVwkA/1XLetKbIgbMti0NapOl1NklRaS84V5cfCo6EKdkG5GLjRORPg
         wpD/NHDAJGisnYs3/bBsL0LtysRaSKy6l2LQbF/6AzNxb03kJ+5siSSTiv7Ouifm0EhG
         TS1D0Aa4KbwC6CFUCIZFlbxgrX370DTqRBvpkF1XMXrBoDbyRzlIdf1TkxsvF632efkB
         a2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=biGBmUqZgjd3xw38mtDIl68wlZERVjBt+Lolzy4x8lE=;
        b=B6dNDjVdpAFBTQ5W6hMS2Wfv/KAeidv+zTzEEx4xc2jvN+clh0Ztj6HyhdyPw9T73y
         WJkhI+3LHuxkxaywz9VlOnl1uOgEk9DtUznIn3//YlpcbI3jE2L8sCTZxnjSJtEycO+s
         8x/jxAjuI3BBwFlXbIX/mZ1CZcuKXvlWFEsQ2GewdSt7kFTVp9rRuF5STLUSEc7ydhPD
         BNZkOxf+Va7Zm5+pgJuAtv5E6GYqK47E2GFnoXNt8v4hzZZ6rz41begQrXE1UrArCRIZ
         3w+c2T+UWYtfWeES4ChT0+lgMvpj8Kf2intc0R9NZdKQ/3z2UaHsEA+IY1xbRa4642Rw
         rVrQ==
X-Gm-Message-State: APjAAAX8qiouEfmS+SQiEtoNPXtk875HuuuVUMCiOKNHvfMk8jhLaZ5s
        SM0EQNR9Zo91o2kf76SRCM6EsoS/
X-Google-Smtp-Source: APXvYqztpatzJO4I0SB83g8LTl3qOWYf/7n7Cwel3UiKD8t61nzZqR9tZSjnYtTTutwKK8RyV6tS6g==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr1688961ljj.157.1578642973987;
        Thu, 09 Jan 2020 23:56:13 -0800 (PST)
Received: from localhost.localdomain (mobile-user-c1d2e4-97.dhcp.inet.fi. [193.210.228.97])
        by smtp.gmail.com with ESMTPSA id b1sm635265ljp.72.2020.01.09.23.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 23:56:13 -0800 (PST)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH v2] ima: ima/lsm policy rule loading logic bug fixes
Date:   Fri, 10 Jan 2020 09:55:31 +0200
Message-Id: <20200110075531.25140-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keep the ima policy rules around from the beginning even if they appear
invalid at the time of loading, as they may become active after the lsm
policy load. In other words, now the lsm and the ima can be initialized
in any order and the handling logic is the same as with the lsm rule
reload event. With these changes, there is no need to defer loading a
custom IMA policy, based on LSM rules, until after the LSM policy has
been initialized.

Patch also fixes the rule re-use during the lsm policy reload and makes
some prints a bit more human readable.

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Cc: Casey Schaufler <casey@schaufler-ca.com>
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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

