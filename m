Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684FF45CF64
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Nov 2021 22:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbhKXVrd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Nov 2021 16:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbhKXVrd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Nov 2021 16:47:33 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40678C061574;
        Wed, 24 Nov 2021 13:44:23 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id o14so2957845plg.5;
        Wed, 24 Nov 2021 13:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cbxeQe9IOGfRcMrLQ1X4Diu81lxRjy6qER2GwCOwFqk=;
        b=RGlmfQVZNhpsn0iBjBcYZKeVrLpLqhk77PpxJDXjp7o/up7YSVn1Bcr14V4ZIwcMw9
         C9lTJblRYqQvMvu6d323zMcpU+PJxRReAPHpZhzLGSRDj4WLrG15lSrT/3wTMOwx8x6z
         luqV29ErhYxC5+vG7VEPiKOL1u4AQ0PJPcAOL7h3R/OR5641dqkX9pZk6iXIsMi7pnCP
         uaLe7eeuPOt4W4VLbPnSN2+fL3Rt3XsVam4BAPnrzExWzyZ6BD01yJFcyy9mXoT8O0+r
         ulUK5gcNLm52kHTwP0dhfn6Fbxb8mVVnSuy0U1TrrRoMvRs3P19G/WZt1l2Yc6F359h8
         iv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cbxeQe9IOGfRcMrLQ1X4Diu81lxRjy6qER2GwCOwFqk=;
        b=jjTtBwIb5yHk3iQe/5AA3YHqEKo+NxSBqC+MI7jkzNo1WAP9qia+03YRcxaF7uEu+D
         j3HAAOPQIo91DVbQuR2DlpoGYZfMCj0Pg/ckr76ylnmV/K2287rWNSa0H0FTNQPk5GWo
         Oh1/MKAOa58QHYJ0MDWVrJeGa8KhL/2Le9Co3zyBbf+PtOPrthpC3jiKldOzZMMnznSe
         scMXKmPnXBULqq133kl/rCWKnSHWLgSH8a5BeM8yX/Er3EgFRS7KmaDg2ItSlWk6b2F9
         FHL6yhj7Y1pjll4DH70AbwnXlmFv4qTcVwFfg+THdWXBu+MWXG+X3hbBxEyXvy1hQqAg
         l87A==
X-Gm-Message-State: AOAM533aA+8bLsBsqjywEXs7sEp5F83ABsiMJOL71jn9V/UPLyr3yEcu
        uByxgJ8i7B7yuwQR8DEYxiE=
X-Google-Smtp-Source: ABdhPJwspzn6OjVhQrDJxQROOcb64WWIm1SdFXc3B22xN1pMbCkuP5shXyotxxBK4n+tgapJ1huaAg==
X-Received: by 2002:a17:902:aa86:b0:145:90c:f4aa with SMTP id d6-20020a170902aa8600b00145090cf4aamr23046406plr.79.1637790262816;
        Wed, 24 Nov 2021 13:44:22 -0800 (PST)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id z4sm667920pfg.101.2021.11.24.13.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 13:44:22 -0800 (PST)
Date:   Wed, 24 Nov 2021 21:44:18 +0000
From:   Austin Kim <austindh.kim@gmail.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Fix trivial typos in the comments
Message-ID: <20211124214418.GA1094@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are a few minor typos in the comments. Fix these.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 security/integrity/ima/ima_api.c          | 2 +-
 security/integrity/ima/ima_main.c         | 2 +-
 security/integrity/ima/ima_policy.c       | 2 +-
 security/integrity/ima/ima_template_lib.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index a64fb0130b01..5b220a2fe573 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -238,7 +238,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		goto out;
 
 	/*
-	 * Dectecting file change is based on i_version. On filesystems
+	 * Detecting file change is based on i_version. On filesystems
 	 * which do not support i_version, support is limited to an initial
 	 * measurement/appraisal/audit.
 	 */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8c6e4514d494..8ed6da428328 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -764,7 +764,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  *	      call to ima_post_load_data().
  *
  * Callers of this LSM hook can not measure, appraise, or audit the
- * data provided by userspace.  Enforce policy rules requring a file
+ * data provided by userspace.  Enforce policy rules requiring a file
  * signature (eg. kexec'ed kernel image).
  *
  * For permission return 0, otherwise return -EACCES.
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 320ca80aacab..ad7e19208a69 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -429,7 +429,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 	/*
 	 * ima_lsm_copy_rule() shallow copied all references, except for the
 	 * LSM references, from entry to nentry so we only want to free the LSM
-	 * references and the entry itself. All other memory refrences will now
+	 * references and the entry itself. All other memory references will now
 	 * be owned by nentry.
 	 */
 	ima_lsm_free_rule(entry);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index ca017cae73eb..5a5d462ab36d 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -272,7 +272,7 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
 	 * digest formats:
 	 *  - DATA_FMT_DIGEST: digest
 	 *  - DATA_FMT_DIGEST_WITH_ALGO: [<hash algo>] + ':' + '\0' + digest,
-	 *    where <hash algo> is provided if the hash algoritm is not
+	 *    where <hash algo> is provided if the hash algorithm is not
 	 *    SHA1 or MD5
 	 */
 	u8 buffer[CRYPTO_MAX_ALG_NAME + 2 + IMA_MAX_DIGEST_SIZE] = { 0 };
-- 
2.20.1

