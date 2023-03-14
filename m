Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C943A6B9DD5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 19:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCNSF2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCNSF1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 14:05:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739DAA702;
        Tue, 14 Mar 2023 11:05:24 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d36so21121717lfv.8;
        Tue, 14 Mar 2023 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678817123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+SJo7YeDndJJb9FcmfHJ+g0nvcfZuSS+pxPPhUkPAU=;
        b=UGnWP9EmS66UCtKniWs1Hw5mCG0uydsiW4xUKvCUMnps5+8A3rLtdYnI9LBz/EHvKG
         ON9M+56cNm+oTlDzbQfTfG+hN8OKOYclhTdCNKhhkNXZ+yGE86ResfD2UCtdJic+6RDz
         rlkEt1hGzzClX4bLKtoQJRSH+Id1X3Wcg/tcxl6lW3eRBY7aReFUaVPKLcDk0h4Z8D28
         owpkxXUoldWNG8uaF1ZgSXe2Zbs1vVlpZYoUPXAPtVvW5j7Rc3TUakFVo32A3Cn5/nbW
         zVU+8a3nGx+U9S0045wub3gCM4SNH+sPTqw2Ef31UauC5bLLbmeRT6Qu200DC1xBPpJJ
         RjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678817123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+SJo7YeDndJJb9FcmfHJ+g0nvcfZuSS+pxPPhUkPAU=;
        b=pFQzPHO7GrWKgCfXXx0BR3wFaMR3SP3IOdwwmt82DX/LfI0wLS3sPaq25VxChCvor8
         v1EoNDV0iMQKeaA+TJ5U/T4JdJz2370rmOwsWrd2IV0VLOIw33CH1mnumsqLo7vKnutL
         tK5bA7MxoX2M/wOd7CUA5URkhK+/A7S64j7ebwHt6szsChKVj9fLvYEgyMj+msHXFeWw
         AhnHwzd2stfxAFbgc0IL3GSuXVkPv+cnDb80GOQbkKUawfmjd7/Ah4kq4mg0u2Q6FezH
         wlfIl9gxgpKtd0MAbqppEyCk0+d9PMgCoLEH4cGKZQXJYxgBnZDMaFqxmvn1cy0xMrbj
         lzcw==
X-Gm-Message-State: AO0yUKVdHDKj60jKeYLo14yIHeHiKhmSKpwdj3eUKVA0EzqQnsJgdf0x
        wcpXIkzfQ+6CsdkEp3WSsCTq6jbpxsDcakPu
X-Google-Smtp-Source: AK7set9ldhL13HwpN98o3SKvC2f9q0OhO5BPfCWqgY9EUa/hdg84oFxwbxUXj+YyZstEjC1wl6kFSg==
X-Received: by 2002:ac2:4a83:0:b0:4e8:4a21:9ca2 with SMTP id l3-20020ac24a83000000b004e84a219ca2mr1016760lfp.3.1678817123008;
        Tue, 14 Mar 2023 11:05:23 -0700 (PDT)
Received: from roman-MRC-WX0.. ([2a00:1370:819a:3aea:9345:682:eb4a:aa71])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25614000000b004dc83d04840sm482915lfd.79.2023.03.14.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:05:22 -0700 (PDT)
From:   Roman Danilov <romanosauce57@gmail.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roman Danilov <romanosauce57@gmail.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        GUO Zihua <guozihua@huawei.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] ima: Fix potential NULL pointer access in ima_match_rules()
Date:   Tue, 14 Mar 2023 21:03:08 +0300
Message-Id: <20230314180308.17909-1-romanosauce57@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In ima_match_rules(), when ima_lsm_copy_rule() fails, NULL pointer
is assigned to lsm_rule. After that, in the next step of the loop
NULL pointer is dereferenced in lsm_rule->lsm[i].rule.

As far as ima_match_rules() is not designed to return error code,
add __GFP_NOFAIL to make sure memory allocation succeeds.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
Signed-off-by: Roman Danilov <romanosauce57@gmail.com>
Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 security/integrity/ima/ima_policy.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3ca8b7348c2e..1b6bfcbcdeac 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -401,7 +401,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	kfree(entry);
 }
 
-static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
+static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry,
+						gfp_t gfp)
 {
 	struct ima_rule_entry *nentry;
 	int i;
@@ -410,7 +411,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), gfp);
 	if (!nentry)
 		return NULL;
 
@@ -438,7 +439,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 	int i;
 	struct ima_rule_entry *nentry;
 
-	nentry = ima_lsm_copy_rule(entry);
+	nentry = ima_lsm_copy_rule(entry, GFP_KERNEL);
 	if (!nentry)
 		return -ENOMEM;
 
@@ -664,11 +665,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		}
 
 		if (rc == -ESTALE && !rule_reinitialized) {
-			lsm_rule = ima_lsm_copy_rule(rule);
-			if (lsm_rule) {
-				rule_reinitialized = true;
-				goto retry;
-			}
+			lsm_rule = ima_lsm_copy_rule(rule,
+						     GFP_KERNEL | __GFP_NOFAIL);
+			rule_reinitialized = true;
+			goto retry;
 		}
 		if (!rc) {
 			result = false;
-- 
2.34.1

