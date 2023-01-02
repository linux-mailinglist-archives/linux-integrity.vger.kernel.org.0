Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2708C65B73F
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Jan 2023 21:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjABUpl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Jan 2023 15:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjABUpj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jan 2023 15:45:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652166258;
        Mon,  2 Jan 2023 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ejlIdJXYeoZP28gEN4XiJsWW1JI0RWVlmmFbAagiLr8=; b=Zh0O4kJThdX9L+WM8tXGxFJvyv
        rOO87L+qdrBbBaMIs361h5ZVLITnJ+kf70XEMbkpKkumRSwNQKZHtaX2XgNzNxuTPlsTyLdAk3oI8
        aF7KXbcW4Pa3VdNmi5zNqfmoBBmdF8aqvDqrOAFhISEft8jfW+uhyqBa6LmOeYIOoCGJ2g8IROm0g
        JgiNpw3wloozWvIRXZ5FwU8Znq03PVFcisVmyXjYZ2DLyHDI/v4EqPDUsHN2b9OSHU6kaXEV7NONc
        v4xsvPxM0gzj7XwDJ0zEu8MTzJKF7eGIlqKFxxaJGkkZFGw40nN4dV9byEaWX0ZyT9kVJv8tw0MET
        e+gBVdUA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCRgg-00EFad-Hi; Mon, 02 Jan 2023 20:45:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-security-module@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] KEYS: trusted: tpm2: use correct function name in kernel-doc
Date:   Mon,  2 Jan 2023 12:45:37 -0800
Message-Id: <20230102204537.4842-1-rdunlap@infradead.org>
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

Correct the function name in the kernel-doc notation to prevent
a kernel-doc warning:

security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting prototype for tpm_buf_append_auth(). Prototype was for tpm2_buf_append_auth() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/keys/trusted-keys/trusted_tpm2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -186,7 +186,7 @@ int tpm2_key_priv(void *context, size_t
 }
 
 /**
- * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
+ * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
  * @buf: an allocated tpm_buf instance
  * @session_handle: session handle
