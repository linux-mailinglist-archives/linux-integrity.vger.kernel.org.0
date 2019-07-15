Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F046839C
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 08:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfGOGjs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 02:39:48 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:3089 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfGOGjs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 02:39:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TWv-.yB_1563172778;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TWv-.yB_1563172778)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Jul 2019 14:39:46 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Subject: [PATCH] ima: Remove needless securityfs_remove() calls
Date:   Mon, 15 Jul 2019 14:39:38 +0800
Message-Id: <1563172778-37226-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Function securityfs_remove() is called when securityfs_create_file
failed, this is needless. And dentry ima_policy is removed after ima_dir
is illogical.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 security/integrity/ima/ima_fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2000e8d..9c60ddc 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -501,6 +501,5 @@ int __init ima_fs_init(void)
 	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
 	return -1;
 }
-- 
1.8.3.1

