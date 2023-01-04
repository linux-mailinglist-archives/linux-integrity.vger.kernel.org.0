Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3625C65CC35
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 04:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjADDl4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Jan 2023 22:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjADDlz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jan 2023 22:41:55 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACF57678
        for <linux-integrity@vger.kernel.org>; Tue,  3 Jan 2023 19:41:53 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id q2so34233785ljp.6
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jan 2023 19:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XR38m6wRuoFurmyv4e2Bdb3xHZPRylEfyg8XCP3krPg=;
        b=Dx5JpE+afrRYQbHWSnj05LbgcLO5gLVpIdWv9tucJuWzgCwKHRJhVmQ4DNAe5j1Xqz
         0WSGn53tEr6zZXRk9psMDIWoqsBAbffrexT1mPpPw5h53eXE9UP+UBjOhXuikPbb2rcS
         HpOHisnvrQRMlOJgGUZPOQyz1rRfZwgGE0P3Kj1n2ev9EVV08pfNYINbT69xt+OZ2T0T
         y4DMPgM7twFLCpiHU7DNCaFsSrGbwWxW0/StwAXe3kWD5UisP72TP7gJ4qupQxb/i8kL
         2b5j5XjhVN5Mfkky71guYV1LGna1zyFmgXMugHzimuk8CC+kbW7btXglVBAUso8MCPlR
         Gc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XR38m6wRuoFurmyv4e2Bdb3xHZPRylEfyg8XCP3krPg=;
        b=r9fTVZEgohV02kzPeBR7sA3WS7ySu5fkBm2MYZ6YuzR5zWKBUdNIORjKKUI3PmfiqE
         y27GG2BWn/tsNo6s8HttseBkiLrj6tRVjv1cm42PSCIvTmweA8Y/m1H5R/PUjiwre0oP
         K9XLYqSya0Nb17V79XHtCK2C2Y365QmXc9941SJBOIV8kFpoFMdXwPJlDOrm0kbpmRqL
         XPWIRIarh6vWqWUeQdCRyn+i9oteoD+Tj0mmY31MbpR08Fw+qFCR+wwjgSwcwquI7GOt
         0aMM0tmzbj4ICH3Wse2nTpv4Hj+tauc6ZOAi8P+FM95F2+AfA44lf0KtYG4LM9qYgzh3
         HdzQ==
X-Gm-Message-State: AFqh2kqGvhhDPp7K2OpbBQWUkfqutvjxUqdWhEPKsj+rugAZrGczPib8
        9g8svvzCnIbRmlnXMPG6/W7UxQ==
X-Google-Smtp-Source: AMrXdXubQAi7y62wTodP2qSo9tgZBBDIJ7beKjH90j+b9sQYf4T19xSsN2BcyQR3B6AVOLzLZm+ndA==
X-Received: by 2002:a2e:86c6:0:b0:27f:b68e:8e9d with SMTP id n6-20020a2e86c6000000b0027fb68e8e9dmr9413760ljj.19.1672803711271;
        Tue, 03 Jan 2023 19:41:51 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id u8-20020a2eb808000000b0027fdfe3b85fsm1169111ljo.109.2023.01.03.19.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 19:41:50 -0800 (PST)
Date:   Wed, 4 Jan 2023 03:41:44 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org
Subject: [PATCH] ima: fix error handling logic when file measurement failed
Message-ID: <Y7T1eAAVXoZ70MPM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Restore the error handling logic so that when file measurement fails,
the respective iint entry is not left with the digest data being
populated with zeroes.

Fixes: 54f03916fb89 ("ima: permit fsverity's file digests in the IMA measurement list")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 security/integrity/ima/ima_api.c  | 2 +-
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c1e76282b5ee..1e3a7a4f8833 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -292,7 +292,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		result = ima_calc_file_hash(file, &hash.hdr);
 	}
 
-	if (result == -ENOMEM)
+	if (result && result != -EBADF && result != -EINVAL)
 		goto out;
 
 	length = sizeof(hash.hdr) + hash.hdr.length;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 377300973e6c..b1ae0f2751f1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -337,7 +337,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
 	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
-	if (rc == -ENOMEM)
+	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
-- 
2.39.0.314.g84b9a713c41-goog

/M
