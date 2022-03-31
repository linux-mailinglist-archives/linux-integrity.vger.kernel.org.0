Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE24EDFBF
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Mar 2022 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiCaRg0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Mar 2022 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiCaRgV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Mar 2022 13:36:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D4C60CF3;
        Thu, 31 Mar 2022 10:34:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p10so371809lfa.12;
        Thu, 31 Mar 2022 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpzNliID3SJF8mkL/R1m7B3GbTTnCU3xmaYQk4hdJxg=;
        b=Pl95tPuGINI7Ed7WbqIptzsgtmRRQbUsGEtp9dMBKwEBSIwDIove4HWr5DpFu7vfXx
         oO2YFuze6ZGyVwAu2qcJ9fgrnv2zisG/87YCdBNaIiK0mIgvpJOvLxDReMSMWERJJGk5
         WwUk0GZdC75yn3t3TLAZn7qLQQ+ezDcmwD2Mk/FsMad7E8+DggD/NcDyIuszN00SmtWy
         5fcEGwsArRcMK00cwXnN9L/uY5KzUkBj5EF3WWw0jCK+HEuNabBOUJ7tru2XnGblfUUE
         Qw++XWD0i0qhhwsvzDQ/f2RNM9JxsvkZUIOjYFNCppPnNF90Ofgj5RC/wJW+phKS6NNJ
         lAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpzNliID3SJF8mkL/R1m7B3GbTTnCU3xmaYQk4hdJxg=;
        b=smuP6UeZgQHaqn+QqDVuLI9zgcTEiglSgpSpViEi+ppt6EGTYWar23lmAtfQA3qsct
         UlSzKJPUt3TdeUyFa5OUlkkOMD1LbH/6q99ZPUoj7s0h7RmTeTSLNBvGhsg7DZ3uIMAO
         Bezj5DXh1GDGTnF1k4Btqp6EI5Q0WXLcvb/GquJhqKw4G1AiZsxMYH5i8aFVnw+ZW+9o
         CdzTWDYQy9QsXvavMvqIYkwiwD2y4kQF0vehaehJ2wTwgcYxCLP/Ph+iap8nIJK0GmWK
         OdDafy1T7exAJqXFHcpJqWlKDDss6Hy7ZVnzelbtJCBAcf210Mdl0neWuKHMAOJ5I6wb
         Hhhg==
X-Gm-Message-State: AOAM5325IgqUZvQx3ixBpjrWj/K/odDRONbMgmW6qjAI1/Fcyzh1o4bL
        vAc5qNo2Oq7ctBzxVLltoFU=
X-Google-Smtp-Source: ABdhPJwvcR9wHiqOmhQFqud1XOa3bbZXUQW8k2EYkMf0A9J27rV9+c1UMmS4a0LkEtiixFx9fssazw==
X-Received: by 2002:a05:6512:3082:b0:44a:6dc3:3 with SMTP id z2-20020a056512308200b0044a6dc30003mr11237952lfd.663.1648748067209;
        Thu, 31 Mar 2022 10:34:27 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05651c168a00b00247fe29d83csm2746992ljb.73.2022.03.31.10.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:34:26 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/5] integrity: Remove redundant assignments
Date:   Thu, 31 Mar 2022 19:33:55 +0200
Message-Id: <20220331173358.40939-2-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331173358.40939-1-michalorzel.eng@gmail.com>
References: <20220331173358.40939-1-michalorzel.eng@gmail.com>
MIME-Version: 1.0
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

Get rid of redundant assignments which end up in values not being
read either because they are overwritten or the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 security/integrity/ima/ima_main.c   | 2 +-
 security/integrity/ima/ima_modsig.c | 2 +-
 security/integrity/ima/ima_policy.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3d3f8c5c502b..1aebf63ad7a6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -432,7 +432,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
 	struct ima_template_desc *template = NULL;
-	struct file *file = vma->vm_file;
+	struct file *file;
 	char filename[NAME_MAX];
 	char *pathbuf = NULL;
 	const char *pathname = NULL;
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index fb25723c65bc..2c9d451d6326 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -109,7 +109,7 @@ void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 		return;
 
 	/* Ask the PKCS7 code to calculate the file hash. */
-	rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
+	pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
 			      &modsig->digest_size, &modsig->hash_algo);
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index eea6e92500b8..c328c2266092 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -869,7 +869,7 @@ static int __init ima_init_arch_policy(void)
 		char rule[255];
 		int result;
 
-		result = strscpy(rule, *rules, sizeof(rule));
+		strscpy(rule, *rules, sizeof(rule));
 
 		INIT_LIST_HEAD(&arch_policy_entry[i].list);
 		result = ima_parse_rule(rule, &arch_policy_entry[i]);
-- 
2.25.1

