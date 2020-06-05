Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D169E1EF1AB
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 08:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFEGyC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 02:54:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgFEGyB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 02:54:01 -0400
Received: from lhreml741-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F35C8D45AE4DD2AEB67E;
        Fri,  5 Jun 2020 07:53:59 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 5 Jun 2020 07:53:59 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 5 Jun 2020 08:53:58 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <syzkaller-bugs@googlegroups.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] ima: Directly free *entry in ima_alloc_init_template() if digests is NULL
Date:   Fri, 5 Jun 2020 08:50:28 +0200
Message-ID: <20200605065028.12464-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To support multiple template digests, the static array entry->digest has
been replaced with a dynamically allocated array in commit aa724fe18a8a
("ima: Switch to dynamically allocated buffer for template digests"). The
array is allocated in ima_alloc_init_template() and if the returned pointer
is NULL, ima_free_template_entry() is called.

However, (*entry)->template_desc is not yet initialized while it is used by
ima_free_template_entry(). This patch fixes the issue by directly freeing
*entry without calling ima_free_template_entry().

Fixes: aa724fe18a8a ("ima: Switch to dynamically allocated buffer for template digests")
Reported-by: syzbot+223310b454ba6b75974e@syzkaller.appspotmail.com
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 78e0b0a7723e..bf22de8b7ce0 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -55,8 +55,9 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 	digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
 			  sizeof(*digests), GFP_NOFS);
 	if (!digests) {
-		result = -ENOMEM;
-		goto out;
+		kfree(*entry);
+		*entry = NULL;
+		return -ENOMEM;
 	}
 
 	(*entry)->digests = digests;
-- 
2.17.1

