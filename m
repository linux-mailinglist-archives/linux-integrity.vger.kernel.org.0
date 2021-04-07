Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F973560E5
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 03:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbhDGBpb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 21:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhDGBpa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 21:45:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F07C06174A;
        Tue,  6 Apr 2021 18:45:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c17so11757042pfn.6;
        Tue, 06 Apr 2021 18:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKBesTcPJy3Nw7YSl4x2NMzjY0EW4bPgGn6LOTRbyPk=;
        b=HYJEIaHAiegMN+TIpdTxePgMwrqnwQHP8kpKS+i5jXK80fhXQjgS3RvHMJZEbnJbH4
         ECU+kec1GaCnvfWAX4t0DpxfFaPD3IZXcCSNYPf2hcq473Ihq0fs2WdThHRQ17A6xo38
         dU4L7fhAupQvAp+LiZC9wlsUmaxzs5HJ0yJxavg4RDtT/22UaYyRQ4nSMzp45Zf7NtJ4
         sqU1vuQTDHDUUNj5kvK6vwRu/27xwIF4w+DNHAQtKTKWVEhvXJNCBL19T4LAormzb59S
         VlzgoXdtj3DMg7ZUY6g7ZovpqJ9P0abU4f5kUrUOs97ORVEYKOXR1IjsNqPBFGivv9QG
         swFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKBesTcPJy3Nw7YSl4x2NMzjY0EW4bPgGn6LOTRbyPk=;
        b=SzcD/w4z16tkBDgfajg7OxQHj87EARJo/O1bOWq8h4qv9FZpn6O63PlwtlfV1I1ZXO
         fMp/qeuqPHDRhcrMLSOnDEBDISoOyXkbdwgSS3x1L7lA21S8ZfFE5PtjmuFCeO1NbgEK
         Ox1OjvKrsOseFF1AqGjIP67a2bflhl1L6NuARGPCKMKcQe67cmi6skJ4vm9fYDGi41Or
         7tyQ00n5PCjyGXW+S/irKcJnCdaaDCQGWyfYfnNuZVJuqFe1R1uBgvwEfNG0bm9E2jp/
         XAgEsCkMiwfMzqJtZa90u8te1bXgAiN2SYXhs9ZaV9Q4A9bbRU+t+FsP5UvQKPTXjzps
         6N6g==
X-Gm-Message-State: AOAM5307bBu0aDYSeUG5l/fmiqoQsjfAY9nuaaFXIIu5YgvKJB9pUSf7
        tJ2HsMBdjJ1huDA+zF6pMlI=
X-Google-Smtp-Source: ABdhPJyrKngUjFqVVmGTbyoTS+gNL4pRLPk2KHS7900U5GDnupo5TgUowSauLbtdx9H3pOyTojXe3g==
X-Received: by 2002:a63:e242:: with SMTP id y2mr1013789pgj.298.1617759921737;
        Tue, 06 Apr 2021 18:45:21 -0700 (PDT)
Received: from localhost.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id y8sm19821701pfp.140.2021.04.06.18.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 18:45:21 -0700 (PDT)
From:   Jiele Zhao <unclexiaole@gmail.com>
To:     zohar@linux.ibm.com
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jiele Zhao <unclexiaole@gmail.com>
Subject: [PATCH v2] integrity: Add declarations to init_once void arguments.
Date:   Wed,  7 Apr 2021 01:44:38 +0000
Message-Id: <20210407014438.39516-1-unclexiaole@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

init_once is a callback to kmem_cache_create. The parameter
type of this function is void *, so it's better to give a
explicit cast here.

Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
---
 security/integrity/iint.c         | 2 +-
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 0ba01847e836..fca8a9409e4a 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -160,7 +160,7 @@ void integrity_inode_free(struct inode *inode)
 
 static void init_once(void *foo)
 {
-	struct integrity_iint_cache *iint = foo;
+	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
 
 	memset(iint, 0, sizeof(*iint));
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9ef748ea829f..03bef720ab44 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -482,7 +482,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
 }
 
 /**
- * ima_path_check - based on policy, collect/store measurement.
+ * ima_file_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
  * @mask: contains MAY_READ, MAY_WRITE, MAY_EXEC or MAY_APPEND
  *
-- 
2.25.1

