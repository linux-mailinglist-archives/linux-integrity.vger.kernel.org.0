Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD620BCBA
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgFZWjh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:39:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37820 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgFZWjf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:35 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A51820B4901;
        Fri, 26 Jun 2020 15:39:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A51820B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211175;
        bh=wb2RijhIAB6vGdBMZgiQYqvgUSu/Ak6GRz9I3YnxR8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIiQu+gsLcJEteLDZJ/8tuACF4ht6M7nWC9s484gDmnJvgaGL0wOxRisJPrZEuJcQ
         jQN5MJxnVvIbazBzwF1dHG/uvK9RLFApoB2G886oB88hbRg0r+t1pxANkPZD86KmQK
         lVaoJMyPTcqDLeXB7HDW6I8XzUwGR9GuHhJAEwKk=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 03/11] ima: Free the entire rule if it fails to parse
Date:   Fri, 26 Jun 2020 17:38:52 -0500
Message-Id: <20200626223900.253615-4-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use ima_free_rule() to fix memory leaks of allocated ima_rule_entry
members, such as .fsname and .keyrings, when an error is encountered
during rule parsing.

Set the args_p pointer to NULL after freeing it in the error path of
ima_lsm_rule_init() so that it isn't freed twice.

This fixes a memory leak seen when loading an rule that contains an
additional piece of allocated memory, such as an fsname, followed by an
invalid conditional:

 # echo "measure fsname=tmpfs bad=cond" > /sys/kernel/security/ima/policy
 -bash: echo: write error: Invalid argument
 # echo scan > /sys/kernel/debug/kmemleak
 # cat /sys/kernel/debug/kmemleak
 unreferenced object 0xffff98e7e4ece6c0 (size 8):
   comm "bash", pid 672, jiffies 4294791843 (age 21.855s)
   hex dump (first 8 bytes):
     74 6d 70 66 73 00 6b a5                          tmpfs.k.
   backtrace:
     [<00000000abab7413>] kstrdup+0x2e/0x60
     [<00000000f11ede32>] ima_parse_add_rule+0x7d4/0x1020
     [<00000000f883dd7a>] ima_write_policy+0xab/0x1d0
     [<00000000b17cf753>] vfs_write+0xde/0x1d0
     [<00000000b8ddfdea>] ksys_write+0x68/0xe0
     [<00000000b8e21e87>] do_syscall_64+0x56/0xa0
     [<0000000089ea7b98>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: f1b08bbcbdaf ("ima: define a new policy condition based on the filesystem name")
Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v2
  - No change

 security/integrity/ima/ima_policy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index bf00b966e87f..e458cd47c099 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -913,6 +913,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 
 		if (ima_rules == &ima_default_rules) {
 			kfree(entry->lsm[lsm_rule].args_p);
+			entry->lsm[lsm_rule].args_p = NULL;
 			result = -EINVAL;
 		} else
 			result = 0;
@@ -1404,7 +1405,7 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	result = ima_parse_rule(p, entry);
 	if (result) {
-		kfree(entry);
+		ima_free_rule(entry);
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
 				    NULL, op, "invalid-policy", result,
 				    audit_info);
-- 
2.25.1

