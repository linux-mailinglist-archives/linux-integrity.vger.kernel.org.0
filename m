Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A23BBC7E
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGEL7s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 07:59:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3363 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGEL7s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 07:59:48 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJP9H6rq4z6FC66;
        Mon,  5 Jul 2021 19:49:07 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 13:57:09 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <tusharsu@linux.microsoft.com>, <nramas@linux.microsoft.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] ima: Support euid keyword for buffer measurement
Date:   Mon, 5 Jul 2021 13:56:50 +0200
Message-ID: <20210705115650.3373599-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch makes the 'euid' keyword available for buffer measurement rules,
in the same way as for other rules. Currently, there is only support for
the 'uid' keyword.

With this change, buffer measurement (or non-measurement) can depend also
on the process effective UID.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_policy.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd5d46e511f1..fdaa030fb04b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -480,6 +480,16 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
 		return false;
 
+	if (rule->flags & IMA_EUID) {
+		if (has_capability_noaudit(current, CAP_SETUID)) {
+			if (!rule->uid_op(cred->euid, rule->uid)
+			    && !rule->uid_op(cred->suid, rule->uid)
+			    && !rule->uid_op(cred->uid, rule->uid))
+				return false;
+		} else if (!rule->uid_op(cred->euid, rule->uid))
+			return false;
+	}
+
 	switch (rule->func) {
 	case KEY_CHECK:
 		if (!rule->keyrings)
@@ -1153,7 +1163,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->action & ~(MEASURE | DONT_MEASURE))
 			return false;
 
-		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_EUID | IMA_PCR |
 				     IMA_LABEL))
 			return false;
 
-- 
2.25.1

