Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0138820BCB8
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgFZWjh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:39:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37808 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgFZWje (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:34 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C0F4A20B4905;
        Fri, 26 Jun 2020 15:39:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0F4A20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211173;
        bh=MNYV62VxHGPBvdC3jd7a3aa0rJsIPisLZWq2XIgStSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lSxdc4Ro05Xoqs25RSxd+xCJxSmaWQdWNTZ7r9KgBg9Hc886B4bZarIJq7tmBu9eU
         Lz1NcXBHNX+lWHWbvP8xG/wB8cprMk7RHrjCFkt+soUies0J86wxNaeLZGnjutn6/n
         xQKdJb/N+IW+shxO+A5fPFm+9D3Z+g67hQPyNDwQ=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 02/11] ima: Free the entire rule when deleting a list of rules
Date:   Fri, 26 Jun 2020 17:38:51 -0500
Message-Id: <20200626223900.253615-3-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Create a function, ima_free_rule(), to free all memory associated with
an ima_rule_entry. Use the new function to fix memory leaks of allocated
ima_rule_entry members, such as .fsname and .keyrings, when deleting a
list of rules.

Make the existing ima_lsm_free_rule() function specific to the LSM
audit rule array of an ima_rule_entry and require that callers make an
additional call to kfree to free the ima_rule_entry itself.

This fixes a memory leak seen when loading by a valid rule that contains
an additional piece of allocated memory, such as an fsname, followed by
an invalid rule that triggers a policy load failure:

 # echo -e "dont_measure fsname=securityfs\nbad syntax" > \
    /sys/kernel/security/ima/policy
 -bash: echo: write error: Invalid argument
 # echo scan > /sys/kernel/debug/kmemleak
 # cat /sys/kernel/debug/kmemleak
 unreferenced object 0xffff9bab67ca12c0 (size 16):
   comm "bash", pid 684, jiffies 4295212803 (age 252.344s)
   hex dump (first 16 bytes):
     73 65 63 75 72 69 74 79 66 73 00 6b 6b 6b 6b a5  securityfs.kkkk.
   backtrace:
     [<00000000adc80b1b>] kstrdup+0x2e/0x60
     [<00000000d504cb0d>] ima_parse_add_rule+0x7d4/0x1020
     [<00000000444825ac>] ima_write_policy+0xab/0x1d0
     [<000000002b7f0d6c>] vfs_write+0xde/0x1d0
     [<0000000096feedcf>] ksys_write+0x68/0xe0
     [<0000000052b544a2>] do_syscall_64+0x56/0xa0
     [<000000007ead1ba7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: f1b08bbcbdaf ("ima: define a new policy condition based on the filesystem name")
Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v2
  - Collapsed patch #2 from v1 of this series, into this patch. This
    patch now introduces ima_free_rule().
  - Existing callers of ima_lsm_free_rule() are doing so to free rules
    after a successful or failed ima_lsm_copy_rule() and those callers
    continue to directly call ima_lsm_copy_rule() rather than doing
    explicit reference ownership and calling ima_free_rule().
  - The kfree(entry) of ima_lsm_free_rule() was removed from that
    function to make it focused on freeing the LSM references. Direct
    callers of ima_lsm_free_rule() must now call kfree(entry) after
    ima_lsm_free_rule().
  - A comment was added in ima_lsm_update_rule() to clarify why
    ima_free_rule() isn't being used.

 security/integrity/ima/ima_policy.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d7c268c2b0ce..bf00b966e87f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -261,6 +261,21 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 		security_filter_rule_free(entry->lsm[i].rule);
 		kfree(entry->lsm[i].args_p);
 	}
+}
+
+static void ima_free_rule(struct ima_rule_entry *entry)
+{
+	if (!entry)
+		return;
+
+	/*
+	 * entry->template->fields may be allocated in ima_parse_rule() but that
+	 * reference is owned by the corresponding ima_template_desc element in
+	 * the defined_templates list and cannot be freed here
+	 */
+	kfree(entry->fsname);
+	kfree(entry->keyrings);
+	ima_lsm_free_rule(entry);
 	kfree(entry);
 }
 
@@ -302,6 +317,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 out_err:
 	ima_lsm_free_rule(nentry);
+	kfree(nentry);
 	return NULL;
 }
 
@@ -315,7 +331,14 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 
 	list_replace_rcu(&entry->list, &nentry->list);
 	synchronize_rcu();
+	/*
+	 * ima_lsm_copy_rule() shallow copied all references, except for the
+	 * LSM references, from entry to nentry so we only want to free the LSM
+	 * references and the entry itself. All other memory refrences will now
+	 * be owned by nentry.
+	 */
 	ima_lsm_free_rule(entry);
+	kfree(entry);
 
 	return 0;
 }
@@ -1402,15 +1425,11 @@ ssize_t ima_parse_add_rule(char *rule)
 void ima_delete_rules(void)
 {
 	struct ima_rule_entry *entry, *tmp;
-	int i;
 
 	temp_ima_appraise = 0;
 	list_for_each_entry_safe(entry, tmp, &ima_temp_rules, list) {
-		for (i = 0; i < MAX_LSM_RULES; i++)
-			kfree(entry->lsm[i].args_p);
-
 		list_del(&entry->list);
-		kfree(entry);
+		ima_free_rule(entry);
 	}
 }
 
-- 
2.25.1

