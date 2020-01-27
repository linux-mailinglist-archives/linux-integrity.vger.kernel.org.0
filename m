Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7ED14A89B
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 18:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgA0RGZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 12:06:25 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2302 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbgA0RGZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:06:25 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5258FA187E27F3DCACAC;
        Mon, 27 Jan 2020 17:06:24 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 27 Jan 2020 17:06:14 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>,
        <james.bottomley@hansenpartnership.com>,
        <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 2/8] ima: evaluate error in init_ima()
Date:   Mon, 27 Jan 2020 18:04:37 +0100
Message-ID: <20200127170443.21538-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127170443.21538-1-roberto.sassu@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Evaluate error in init_ima() before register_blocking_lsm_notifier() and
return if not zero.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9fe949c6a530..2f95b133f246 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -791,6 +791,9 @@ static int __init init_ima(void)
 		error = ima_init();
 	}
 
+	if (error)
+		return error;
+
 	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
-- 
2.17.1

