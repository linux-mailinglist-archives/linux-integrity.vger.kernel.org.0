Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33938A072
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhETI77 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 04:59:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3090 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhETI75 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 04:59:57 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fm3Qc38Hgz6dtFd;
        Thu, 20 May 2021 16:52:24 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:58:34 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 7/7] evm: Don't return an error in evm_write_xattrs() if audit is not enabled
Date:   Thu, 20 May 2021 10:57:01 +0200
Message-ID: <20210520085701.465369-8-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520085701.465369-1-roberto.sassu@huawei.com>
References: <20210520085701.465369-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch avoids that evm_write_xattrs() returns an error when audit is
not enabled. The ab variable can be NULL and still be passed to the other
audit_log_() functions, as those functions do not include any instruction.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_secfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index ec3ed75a347d..07e263ae13e0 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -196,7 +196,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL,
 			     AUDIT_INTEGRITY_EVM_XATTR);
-	if (!ab)
+	if (!ab && IS_ENABLED(CONFIG_AUDIT))
 		return -ENOMEM;
 
 	xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
-- 
2.25.1

