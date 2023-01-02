Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06165B73B
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Jan 2023 21:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjABUp3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Jan 2023 15:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjABUp2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jan 2023 15:45:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA687625E;
        Mon,  2 Jan 2023 12:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j48yPVZNZykOfBtnBZN/w6IQQSUbkxhAZzjH5nmdOpY=; b=aeWYW+F3K9FQy03p5UI3TDc5Ss
        dJFiz6pnXVT7kJFWdiwxEt0y+Hz/UQv7430l1a0sXgBglwRYVmghVvoroHWC3QQ6SxIcYzBckA2/q
        IKctPVK+25pvR062VL2DqKOrV4uk0TikGiWSVSKBwKwzj57Ie0L/OWjs/XJ5wScGjIaZcaljtYDr/
        +5LblBfnDZA0pPG8DJ+aMTsv+W3tyKkJX8KPAMXbWhXTBE8JK2gmOSNiQ2HBXw7x00FgguQpi+JF4
        JofKcwyeCMTZyS5AY4FsDB9pUdnhmP9Ejw9Y9+AjqLjlh0SjeXTOKwhfPy/G0Hhrk2Q93UIa4LcBk
        cGIOEF7A==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCRgT-00EFZ2-TP; Mon, 02 Jan 2023 20:45:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-security-module@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] ima: fix ima_delete_rules() kernel-doc warning
Date:   Mon,  2 Jan 2023 12:45:25 -0800
Message-Id: <20230102204525.4399-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use correct kernel-doc syntax in the function description to
prevent a kernel-doc warning:

security/integrity/ima/ima_policy.c:1964: warning: expecting prototype for ima_delete_rules() called to cleanup invalid in(). Prototype was for ima_delete_rules() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/integrity/ima/ima_policy.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1955,7 +1955,8 @@ ssize_t ima_parse_add_rule(char *rule)
 }
 
 /**
- * ima_delete_rules() called to cleanup invalid in-flight policy.
+ * ima_delete_rules() - called to cleanup invalid in-flight policy.
+ *
  * We don't need locking as we operate on the temp list, which is
  * different from the active one.  There is also only one user of
  * ima_delete_rules() at a time.
