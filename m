Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BC2760E4
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Sep 2020 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIWTUV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Sep 2020 15:20:21 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47374 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWTUU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Sep 2020 15:20:20 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id BF3E420B36E7;
        Wed, 23 Sep 2020 12:20:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF3E420B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600888820;
        bh=msIiW4AnSlFN198DxHsM0/k20Lg9ddIuwcYdunV1Csc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7RL+cJJpxVV/AF4UUNJvcJiibwinq+e4AdIbro/l70SzJ8ilEVriJlWR++7+6Dtr
         qagJZPU4s+bB8ndhibWdoJwooDaIRdh4+tM+dsymPoWroOA3XcVhOAjScdGjxpXMAN
         P/TKZdqRZ46Lb04mkQbRKAzBspH94cABUafIGPWc=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v4 2/6] IMA: conditionally allow empty rule data
Date:   Wed, 23 Sep 2020 12:20:07 -0700
Message-Id: <20200923192011.5293-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_match_rule_data() permits the func to pass empty func_data.
For instance, for the following func, the func_data keyrings= is
optional.
    measure func=KEY_CHECK keyrings=.ima

But a new func in future may want to constrain the func_data to
be non-empty.  ima_match_rule_data() should support this constraint
and it shouldn't be hard-coded in ima_match_rule_data().

Update ima_match_rule_data() to conditionally allow empty func_data
for the func that needs it.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 31a772d8a86b..8866e84d0062 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -456,6 +456,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  * @rule: IMA policy rule
  * @opt_list: rule data to match func_data against
  * @func_data: data to match against the measure rule data
+ * @allow_empty_opt_list: If true matches all func_data
  * @cred: a pointer to a credentials structure for user validation
  *
  * Returns true if func_data matches one in the rule, false otherwise.
@@ -463,6 +464,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 static bool ima_match_rule_data(struct ima_rule_entry *rule,
 				const struct ima_rule_opt_list *opt_list,
 				const char *func_data,
+				bool allow_empty_opt_list,
 				const struct cred *cred)
 {
 	bool matched = false;
@@ -472,7 +474,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 		return false;
 
 	if (!opt_list)
-		return true;
+		return allow_empty_opt_list;
 
 	if (!func_data)
 		return false;
@@ -509,7 +511,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if (func == KEY_CHECK) {
 		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
 		       ima_match_rule_data(rule, rule->keyrings, func_data,
-					   cred);
+					   true, cred);
 	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
-- 
2.17.1

