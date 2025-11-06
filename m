Return-Path: <linux-integrity+bounces-7592-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7EC3D092
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 19:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26563B1009
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 18:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09033890E;
	Thu,  6 Nov 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NLyOj7Gv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD82BDC0F;
	Thu,  6 Nov 2025 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452869; cv=none; b=cI6wdCDDiDijNSk+GdqmU7aTMCkHhwG36WBXIltxQGMquZ4Da1UxIvsJ4dNX8Q4lp7IT8rggkoZv+0xB4TyKWPnjCuMsya//QMlP/M34qIFQRAHhUkj7UUpNrCI5gA4p6R5laXCNC9sWSgFAxk305OUgZdMRWTAjnX8JZj/bJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452869; c=relaxed/simple;
	bh=Rs4HASYrAM0Sf7zNBPlpju2YJ9ioL7sAJ0GlirFMSrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlHM6QSbvQv43HJ6MPX2bhIuqRD1VRV/ANXPZwL5G9Hef+h7aV+z21UK8JQtklnuCoYII4T61bdOnY7dN7bgOY/7DxdSjaq8LuLno1xkz1SyyO4NkxAnwlDQpNL1W87nClXks00MXW088dPrIK5IDouMhGMmurv8zkSNqRZ0w1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NLyOj7Gv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net (unknown [4.246.87.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id B1A8E20120A5;
	Thu,  6 Nov 2025 10:14:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1A8E20120A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762452866;
	bh=9ZHZH/SSPIW0xIopmwQGpZjmTHcbniRM491Ohy99j0c=;
	h=From:To:Cc:Subject:Date:From;
	b=NLyOj7Gvf+HUSccF07urcdnhkmmsT8LFVBiEVQbP2kscLDD7R4elb2M/0kIsN+rZz
	 91iH/jdMZHIzTBFoRdDrtL4iuIrPedkii8jiTJJy7PTt2PkhrgN78gv/tPEIl6sDZ4
	 /HscuoIbiFTJn3uIoiU2i8jhjff/z68wdvL4WyZs=
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	code@tyhicks.com
Cc: Tahera Fahimi <taherafahimi@linux.microsoft.com>
Subject: [Patch V1] ima: avoid duplicate policy rules insertions
Date: Thu,  6 Nov 2025 18:14:04 +0000
Message-ID: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent redundant IMA policy rules by checking for duplicates before insertion. This ensures that
rules are not re-added when userspace is restarted (using systemd-soft-reboot) without a full system
reboot. ima_rule_exists() detects duplicates in both temporary and active rule lists.

Signed-off-by: Tahera Fahimi <taherafahimi@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 157 +++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 164d62832f8ec..3dd902101dbda 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1953,6 +1953,153 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	return result;
 }
 
+static bool template_has_field(const char *field_id, const struct ima_template_desc *template2)
+{
+	int j;
+
+	for (int j = 0; j < template2->num_fields; j++)
+		if (strcmp(field_id, template2->fields[j]->field_id) == 0)
+			return true;
+
+	return false;
+}
+
+static bool keyring_has_item(const char *item, const struct ima_rule_opt_list *keyrings)
+{
+	int j;
+
+	for (j = 0; j < keyrings->count; j++) {
+		if (strcmp(item, keyrings->items[j]) == 0)
+			return true;
+	}
+	return false;
+}
+
+static bool labels_has_item(const char *item, const struct ima_rule_opt_list *labels)
+{
+	int j;
+
+	for (j = 0; j < labels->count; j++) {
+		if (strcmp(item, labels->items[j]) == 0)
+			return true;
+	}
+	return false;
+}
+
+static bool ima_rules_equal(const struct ima_rule_entry *rule1, const struct ima_rule_entry *rule2)
+{
+	int i;
+
+	if (rule1->flags != rule2->flags)
+		return false;
+
+	if (rule1->action != rule2->action)
+		return false;
+
+	if (((rule1->flags & IMA_FUNC) && rule1->func != rule2->func) ||
+	    ((rule1->flags & (IMA_MASK | IMA_INMASK)) && rule1->mask != rule2->mask) ||
+	    ((rule1->flags & IMA_FSMAGIC) && rule1->fsmagic != rule2->fsmagic) ||
+	    ((rule1->flags & IMA_FSUUID) && !uuid_equal(&rule1->fsuuid, &rule2->fsuuid)) ||
+	    ((rule1->flags & IMA_UID) && !uid_eq(rule1->uid, rule2->uid)) ||
+	    ((rule1->flags & IMA_GID) && !gid_eq(rule1->gid, rule2->gid)) ||
+	    ((rule1->flags & IMA_FOWNER) && !uid_eq(rule1->fowner, rule2->fowner)) ||
+	    ((rule1->flags & IMA_FGROUP) && !gid_eq(rule1->fgroup, rule2->fgroup)) ||
+	    ((rule1->flags & IMA_FSNAME) && (strcmp(rule1->fsname, rule2->fsname) != 0)) ||
+	    ((rule1->flags & IMA_PCR) && rule1->pcr != rule2->pcr) ||
+	    ((rule1->flags & IMA_VALIDATE_ALGOS) &&
+	      rule1->allowed_algos != rule2->allowed_algos) ||
+	    ((rule1->flags & IMA_EUID) && !uid_eq(rule1->uid, rule2->uid)) ||
+	    ((rule1->flags & IMA_EGID) && !gid_eq(rule1->gid, rule2->gid)))
+		return false;
+
+	if (!rule1->template && !rule2->template) {
+		;
+	} else if (!rule1->template || !rule2->template) {
+		return false;
+	} else if (rule1->template->num_fields != rule2->template->num_fields) {
+		return false;
+	} else if (rule1->template->num_fields != 0) {
+		for (i = 0; i < rule1->template->num_fields; i++) {
+			if (!template_has_field(rule1->template->fields[i]->field_id,
+						rule2->template))
+				return false;
+		}
+	}
+
+	if (rule1->flags & IMA_KEYRINGS) {
+		if (!rule1->keyrings && !rule2->keyrings) {
+			;
+		} else if (!rule1->keyrings || !rule2->keyrings) {
+			return false;
+		} else if (rule1->keyrings->count != rule2->keyrings->count) {
+			return false;
+		} else if (rule1->keyrings->count != 0) {
+			for (i = 0; i < rule1->keyrings->count; i++) {
+				if (!keyring_has_item(rule1->keyrings->items[i], rule2->keyrings))
+					return false;
+			}
+		}
+	}
+
+	if (rule1->flags & IMA_LABEL) {
+		if (!rule1->label && !rule2->label) {
+			;
+		} else if (!rule1->label || !rule2->label) {
+			return false;
+		} else if (rule1->label->count != rule2->label->count) {
+			return false;
+		} else if (rule1->label->count != 0) {
+			for (i = 0; i < rule1->label->count; i++) {
+				if (!labels_has_item(rule1->label->items[i], rule2->label))
+					return false;
+			}
+		}
+	}
+
+	for (i = 0; i < MAX_LSM_RULES; i++) {
+		if (!rule1->lsm[i].rule && !rule2->lsm[i].rule)
+			continue;
+
+		if (!rule1->lsm[i].rule || !rule2->lsm[i].rule)
+			return false;
+
+		if (strcmp(rule1->lsm[i].args_p, rule2->lsm[i].args_p) != 0)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * ima_rule_exists - check if a rule already exists in the policy
+ *
+ * Checking both the active policy and the temporary rules list.
+ */
+static bool ima_rule_exists(struct ima_rule_entry *new_rule)
+{
+	struct ima_rule_entry *entry;
+	struct list_head *ima_rules_tmp;
+
+	if (!list_empty(&ima_temp_rules)) {
+		list_for_each_entry(entry, &ima_temp_rules, list) {
+			if (ima_rules_equal(entry, new_rule))
+				return true;
+		}
+	}
+
+	rcu_read_lock();
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
+		if (ima_rules_equal(entry, new_rule)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 /**
  * ima_parse_add_rule - add a rule to ima_policy_rules
  * @rule: ima measurement policy rule
@@ -1993,7 +2140,15 @@ ssize_t ima_parse_add_rule(char *rule)
 		return result;
 	}
 
-	list_add_tail(&entry->list, &ima_temp_rules);
+	if (!ima_rule_exists(entry)) {
+		list_add_tail(&entry->list, &ima_temp_rules);
+	} else {
+		result = -EEXIST;
+		ima_free_rule(entry);
+		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
+				    NULL, op, "duplicate-policy", result,
+				    audit_info);
+	}
 
 	return len;
 }
-- 
2.43.0


