Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D305ACDFC
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Sep 2022 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiIEIpz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Sep 2022 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiIEIpy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Sep 2022 04:45:54 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B024330D;
        Mon,  5 Sep 2022 01:45:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VOP0IXE_1662367547;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VOP0IXE_1662367547)
          by smtp.aliyun-inc.com;
          Mon, 05 Sep 2022 16:45:48 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] security: Fix some kernel-doc comments
Date:   Mon,  5 Sep 2022 16:45:46 +0800
Message-Id: <20220905084546.21692-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix some kernel-doc comments:
1.Remove the description of @inode in evm_read_protected_xattrs();
2.Add the description of @iint in integrity_status();
3.Add the description of @mnt_userns and @attr in evm_inode_setattr().

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2054
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/integrity/evm/evm_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 23d484e05e6f..2172fe46e907 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -318,7 +318,6 @@ int evm_protected_xattr_if_enabled(const char *req_xattr_name)
 /**
  * evm_read_protected_xattrs - read EVM protected xattr names, lengths, values
  * @dentry: dentry of the read xattrs
- * @inode: inode of the read xattrs
  * @buffer: buffer xattr names, lengths or values are copied to
  * @buffer_size: size of buffer
  * @type: n: names, l: lengths, v: values
@@ -390,6 +389,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
  * @xattr_name: requested xattr
  * @xattr_value: requested xattr value
  * @xattr_value_len: requested xattr value length
+ * @iint: integrity data associated with an inode
  *
  * Calculate the HMAC for the given dentry and verify it against the stored
  * security.evm xattr. For performance, use the xattr value and length
@@ -776,7 +776,9 @@ static int evm_attr_change(struct user_namespace *mnt_userns,
 
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
+ * @mnt_userns: user namespace of the idmapped mount
  * @dentry: pointer to the affected dentry
+ * @attr: new inode attributes
  *
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
-- 
2.20.1.7.g153144c

