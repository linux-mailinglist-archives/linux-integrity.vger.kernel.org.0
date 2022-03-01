Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9F4C8B41
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Mar 2022 13:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiCAMIR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Mar 2022 07:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiCAMIR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Mar 2022 07:08:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D892E1BE9D;
        Tue,  1 Mar 2022 04:07:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so20136234wrg.11;
        Tue, 01 Mar 2022 04:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hSCwK5xS8mlQDgYKMAx0VBG8XXlCG6EJdzqrXuBG+YQ=;
        b=PpIqQKZ/2cNpIDY6gBqHhJnRr265H0PDVQynomcMHlTr8MsfRqVJqI2q7fFxPqx+jk
         yD9E3CnSgSUgB6+WYe5d4PMZG/SZhYkwSFAV5ZDa81V+sMuo2PS4m130jA0ho6Cn163k
         F87UvbKWCHi9DDRimZOlxMQopfOeMis2dq/2HLkqxgVJR2vCIUnL2tFk9D840vMpT2XN
         yi7h/zb7UkrNeoGmxhGCdptDY7X452KHD6msiDrQ7e85MnA67pRcgpd3V2LtW6WDlhK5
         zxlpPZ81ImFOlWyrh2WMVKGXfupAmMfgICFs9YVG6ZSpIk7gkA+yVFVMokP1P0GB4dat
         YzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hSCwK5xS8mlQDgYKMAx0VBG8XXlCG6EJdzqrXuBG+YQ=;
        b=2vnozjfBVkKY9BNCJw39bidc0BL8ogLlIuxZggYpvuK1RekxIRuk9ZqoXF/6l7hH+k
         vIzXXcZqsUqkOMGvJTm7Dhp2xqBLR0WbhroumGvQRbQBFK8IefXcO9f0JcKgrUJZ7M0y
         /8RLm7Gekf4iL70QuXl9SmPJDtn/yO4mi583V1soxhW84h3JbHsyrLjlpk3WV9gvVZ3A
         HuHhjAhlhm8bPU6Fbg6BYHlsqCDUR5ekDJ5JDyyOHFb/PKoTZhVUh4fznlQwO/wZfxCq
         vHwrcQFrM4RJyuC+McpHGZdRr0pllmT+Tf7bbj4WheqfGexNqAYw0BMmizCi6NHJ9w0y
         DpLg==
X-Gm-Message-State: AOAM531nDWp07cmp+Ou5NLf3vK4zvYxfO/eDx0afwzMS6sVfy5EDaIbQ
        9apl6EFcfRRtGUdqgmCdSfs=
X-Google-Smtp-Source: ABdhPJy5w8b76F7DObiS0Zj5X/X3oN+Cn8tf+9SnqcR5dCpBJywM51JSJ2UGavHd5lzX1XYQiGhoSQ==
X-Received: by 2002:a05:6000:114b:b0:1ed:c1d5:95a8 with SMTP id d11-20020a056000114b00b001edc1d595a8mr18938705wrx.539.1646136454271;
        Tue, 01 Mar 2022 04:07:34 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b001edc2966dd4sm13256718wrx.47.2022.03.01.04.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 04:07:33 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] ima: remove redundant initialization of pointer 'file'.
Date:   Tue,  1 Mar 2022 12:07:32 +0000
Message-Id: <20220301120732.670168-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The pointer 'file' is being initialized with a value that is never read,
it is being re-assigned the same value later on closer to where it is
being first used. The initialization is redundant and can be removed.

Cleans up clang scan build warning:
security/integrity/ima/ima_main.c:434:15: warning: Value stored to 'file'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c6412dec3810..41b91a0bc8dc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -431,7 +431,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
 	struct ima_template_desc *template = NULL;
-	struct file *file = vma->vm_file;
+	struct file *file;
 	char filename[NAME_MAX];
 	char *pathbuf = NULL;
 	const char *pathname = NULL;
-- 
2.34.1

