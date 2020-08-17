Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE0E24792A
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgHQVwy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727931AbgHQVwx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597701171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srs1y+j1kl1pQztDqt8jA3bnaiDQ/OGv3Q3z1R5jaEI=;
        b=NUlu741tlaaZBxQ/BfhcmsYk2KnIqnUYeWU5/EGK19/mid9QGrGBHxaWx+m/2LsMOto2Sw
        AdbTMHr8W3eOeuzxpj+Tlwpg0XliyLAnG0z/KYbNerH8DexlFSGgmWHU0fp4cagXDaY/Lr
        s30zu+yQ0HWaWEKU04qoIGCgiO1JlUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-oJsKJaGYOKaxaD2siTW8QA-1; Mon, 17 Aug 2020 17:52:49 -0400
X-MC-Unique: oJsKJaGYOKaxaD2siTW8QA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DE43425CC;
        Mon, 17 Aug 2020 21:52:48 +0000 (UTC)
Received: from localhost (ovpn-116-138.gru2.redhat.com [10.97.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66D8565C74;
        Mon, 17 Aug 2020 21:52:45 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 2/4] integrity: invalid kernel parameters feedback
Date:   Mon, 17 Aug 2020 18:52:31 -0300
Message-Id: <20200817215233.95319-3-bmeneg@redhat.com>
In-Reply-To: <20200817215233.95319-1-bmeneg@redhat.com>
References: <20200817215233.95319-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prompt a message to kmsg in case the user entered any invalid option to some
of the ima_{policy,appraise,hash} and evm kernel parameters. It's already
done for ima_template.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
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

