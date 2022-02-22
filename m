Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8BB4C0402
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Feb 2022 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiBVVpv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Feb 2022 16:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiBVVpv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Feb 2022 16:45:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1774C3C21;
        Tue, 22 Feb 2022 13:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=X/fCeEGE5dLzxBEqkKnk5/DMs8wiBbMxj32CoUOVL6k=; b=Ue4PuIli6voMrbrIqsbqv19UOh
        qUzMtx4H9Djv4Qxv7kQQ7fnQxc31zKKxr1Hfo6fhmb6pSoFCjNSe/8UHclsc8sXtvkxJ/k3DcibGa
        9gycXO+qC3spzY1F7TQbgk0kyuvaTVJXn1AGWNQAfzUGR6i4DnnRubz3OK8GW0Su5VTfESPZBgC4Y
        9QAFdpudH9V57ZFBgJuU80d0Exgj9aerhAPv9xHZRdanekEAPea3FBWe/q4t5b0wKHFgGGHvQQmmw
        AeE196bt7qOAvdY+rMwyQSXPjMPY/45CRi7SUxhsZK0O1TWAv/yrFU2JK6fI/29LNxAuUHVat4G63
        QlDVLnyg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMcyF-00BhQy-Jc; Tue, 22 Feb 2022 21:45:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-security-module@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Mimi Zohar <zohar@us.ibm.com>, linux-integrity@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] EVM: fix the evm= __setup handler return value
Date:   Tue, 22 Feb 2022 13:45:18 -0800
Message-Id: <20220222214518.9316-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

__setup() handlers should return 1 if the parameter is handled.
Returning 0 causes the entire string to be added to init's
environment strings (limited to 32 strings), unnecessarily polluting it.

Using the documented string "evm=fix" causes an Unknown parameter message:
  Unknown kernel command line parameters
  "BOOT_IMAGE=/boot/bzImage-517rc5 evm=fix", will be passed to user space.

and that string is added to init's environment string space:
  Run /sbin/init as init process
    with arguments:
     /sbin/init
    with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc5
     evm=fix

With this change, using "evm=fix" acts as expected and an invalid
option ("evm=evm") causes a warning to be printed:
  evm: invalid "evm" mode
but init's environment is not polluted with this string, as expected.

Fixes: 7102ebcd65c1 ("evm: permit only valid security.evm xattrs to be updated")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Mimi Zohar <zohar@us.ibm.com>
Cc: linux-integrity@vger.kernel.org
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/integrity/evm/evm_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-517-rc5.orig/security/integrity/evm/evm_main.c
+++ lnx-517-rc5/security/integrity/evm/evm_main.c
@@ -86,7 +86,7 @@ static int __init evm_set_fixmode(char *
 	else
 		pr_err("invalid \"%s\" mode", str);
 
-	return 0;
+	return 1;
 }
 __setup("evm=", evm_set_fixmode);
 
