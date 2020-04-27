Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9C81BA141
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2020 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgD0Kbo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Apr 2020 06:31:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbgD0Kbn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Apr 2020 06:31:43 -0400
Received: from lhreml725-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 459A0124F449A199D767;
        Mon, 27 Apr 2020 11:31:42 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml725-chm.china.huawei.com (10.201.108.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 27 Apr 2020 11:31:42 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 27 Apr 2020 12:31:41 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <rgoldwyn@suse.de>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        <krzysztof.struczynski@huawei.com>
Subject: [PATCH v2 4/6] ima: Remove redundant policy rule set in add_rules()
Date:   Mon, 27 Apr 2020 12:28:58 +0200
Message-ID: <20200427102900.18887-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427102900.18887-1-roberto.sassu@huawei.com>
References: <20200427102900.18887-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Function ima_appraise_flag() returns the flag to be set in
temp_ima_appraise depending on the hook identifier passed as an argument.
It is not necessary to set the flag again for the POLICY_CHECK hook.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima_policy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c334e0dc6083..ea9b991f0232 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -643,11 +643,8 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 
 			list_add_tail(&entry->list, &ima_policy_rules);
 		}
-		if (entries[i].action == APPRAISE) {
+		if (entries[i].action == APPRAISE)
 			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
-			if (entries[i].func == POLICY_CHECK)
-				temp_ima_appraise |= IMA_APPRAISE_POLICY;
-		}
 	}
 }
 
-- 
2.17.1

