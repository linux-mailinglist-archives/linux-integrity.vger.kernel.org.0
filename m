Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395CD25E212
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 21:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIDTlY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 15:41:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727995AbgIDTlV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 15:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599248480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVRPKhuJMAmDmKem2C3GSgT3lk7ReRE/AfXa4Qh7ZFw=;
        b=JDo+NWqOOE9vx3ROyWWdYe0xXKdT1ZcZO2Jv+4KVUXrWkCH0Ai0ggAG+Tc83T7ethkOsQT
        8GhDof0hgj4tEYcg4wQlliD/spBH/4ZlCSmKG/XJJFXkNkIkpz2qV2RpalWW8u6XUUVivq
        8U6CFCA/Ous9Sfr/MaDH5ZIMQ47qNZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-1OnbtpRZPc6NBPW4AQgWHg-1; Fri, 04 Sep 2020 15:41:18 -0400
X-MC-Unique: 1OnbtpRZPc6NBPW4AQgWHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4335D8015FA;
        Fri,  4 Sep 2020 19:41:17 +0000 (UTC)
Received: from localhost (ovpn-116-173.gru2.redhat.com [10.97.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4A4B74E33;
        Fri,  4 Sep 2020 19:41:13 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 2/4] integrity: invalid kernel parameters feedback
Date:   Fri,  4 Sep 2020 16:40:58 -0300
Message-Id: <20200904194100.761848-3-bmeneg@redhat.com>
In-Reply-To: <20200904194100.761848-1-bmeneg@redhat.com>
References: <20200904194100.761848-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Don't silently ignore unknown or invalid ima_{policy,appraise,hash} and evm
kernel boot command line options.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
Changelog:
v2: update commit message (Mimi)

 security/integrity/evm/evm_main.c     |  3 +++
 security/integrity/ima/ima_appraise.c |  2 ++
 security/integrity/ima/ima_main.c     | 13 +++++++++----
 security/integrity/ima/ima_policy.c   |  2 ++
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 0d36259b690d..6ae00fee1d34 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -59,6 +59,9 @@ static int __init evm_set_fixmode(char *str)
 {
 	if (strncmp(str, "fix", 3) == 0)
 		evm_fixmode = 1;
+	else
+		pr_err("invalid \"%s\" mode", str);
+
 	return 0;
 }
 __setup("evm=", evm_set_fixmode);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 580b771e3458..2193b51c2743 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -33,6 +33,8 @@ static int __init default_appraise_setup(char *str)
 		ima_appraise = IMA_APPRAISE_FIX;
 	else if (strncmp(str, "enforce", 7) == 0)
 		ima_appraise = IMA_APPRAISE_ENFORCE;
+	else
+		pr_err("invalid \"%s\" appraise option", str);
 #endif
 	return 1;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8a91711ca79b..2b22932b140d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -50,18 +50,23 @@ static int __init hash_setup(char *str)
 		return 1;
 
 	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
-		if (strncmp(str, "sha1", 4) == 0)
+		if (strncmp(str, "sha1", 4) == 0) {
 			ima_hash_algo = HASH_ALGO_SHA1;
-		else if (strncmp(str, "md5", 3) == 0)
+		} else if (strncmp(str, "md5", 3) == 0) {
 			ima_hash_algo = HASH_ALGO_MD5;
-		else
+		} else {
+			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",
+				str, IMA_TEMPLATE_IMA_NAME);
 			return 1;
+		}
 		goto out;
 	}
 
 	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
-	if (i < 0)
+	if (i < 0) {
+		pr_err("invalid hash algorithm \"%s\"", str);
 		return 1;
+	}
 
 	ima_hash_algo = i;
 out:
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 07f033634b27..880d10887de8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -240,6 +240,8 @@ static int __init policy_setup(char *str)
 			ima_use_secure_boot = true;
 		else if (strcmp(p, "fail_securely") == 0)
 			ima_fail_unverifiable_sigs = true;
+		else
+			pr_err("policy \"%s\" not found", p);
 	}
 
 	return 1;
-- 
2.26.2

