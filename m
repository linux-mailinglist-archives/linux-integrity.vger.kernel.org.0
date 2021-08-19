Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008DB3F1731
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhHSKVo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSKVn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 06:21:43 -0400
X-Greylist: delayed 254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Aug 2021 03:21:07 PDT
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7380DC061756;
        Thu, 19 Aug 2021 03:21:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 93EACAE0D6B;
        Thu, 19 Aug 2021 18:17:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vEz3jAI6unxM; Thu, 19 Aug 2021 18:16:53 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 9B21AAE0DCB;
        Thu, 19 Aug 2021 18:16:52 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong <liqiong@nfschina.com>
Subject: [PATCH] ima: fix infinite loop within "ima_match_policy" function.
Date:   Thu, 19 Aug 2021 18:15:29 +0800
Message-Id: <20210819101529.28001-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When "ima_match_policy" is looping while "ima_update_policy" changs
the variable "ima_rules", then "ima_match_policy" may can't exit loop,
and kernel keeps printf "rcu_sched detected stall on CPU ...".

It occurs at boot phase, systemd-services are being checked within
"ima_match_policy,at the same time, the variable "ima_rules"
is changed by a service.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 security/integrity/ima/ima_policy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd5d46e511f1..7e71e643457c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -217,6 +217,7 @@ static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
 static struct list_head *ima_rules = &ima_default_rules;
+static DECLARE_RWSEM(ima_rules_sem);
 
 static int ima_policy __initdata;
 
@@ -666,6 +667,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
 
+	down_read(&ima_rules_sem);
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, ima_rules, list) {
 
@@ -702,6 +704,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 			break;
 	}
 	rcu_read_unlock();
+	up_read(&ima_rules_sem);
 
 	return action;
 }
@@ -919,7 +922,9 @@ void ima_update_policy(void)
 
 	if (ima_rules != policy) {
 		ima_policy_flag = 0;
+		down_write(&ima_rules_sem);
 		ima_rules = policy;
+		up_write(&ima_rules_sem);
 
 		/*
 		 * IMA architecture specific policy rules are specified
-- 
2.11.0

