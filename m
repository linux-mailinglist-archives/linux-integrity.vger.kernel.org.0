Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72D192DE7
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCYQNi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 12:13:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727600AbgCYQNi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 12:13:38 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id DA8992CFA7F3ED2B89C1;
        Wed, 25 Mar 2020 16:13:36 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Mar 2020 16:13:27 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.struczynski@huawei.com>,
        <silviu.vlasceanu@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/5] ima: Fix ima digest hash table key calculation
Date:   Wed, 25 Mar 2020 17:11:14 +0100
Message-ID: <20200325161116.7082-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325161116.7082-1-roberto.sassu@huawei.com>
References: <20200325161116.7082-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Function hash_long() accepts unsigned long, while currently only one byte
is passed from ima_hash_key(), which calculates a key for ima_htable. Use
more bytes to avoid frequent collisions.

Length of the buffer is not explicitly passed as a function parameter,
because this function expects a digest whose length is greater than the
size of unsigned long.

Cc: stable@vger.kernel.org
Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 64317d95363e..cf0022c2bc14 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -177,7 +177,7 @@ extern struct ima_h_table ima_htable;
 
 static inline unsigned long ima_hash_key(u8 *digest)
 {
-	return hash_long(*digest, IMA_HASH_BITS);
+	return hash_long(*((unsigned long *)digest), IMA_HASH_BITS);
 }
 
 #define __ima_hooks(hook)		\
-- 
2.17.1

