Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768C165CC36
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 04:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjADDmE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Jan 2023 22:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjADDmD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jan 2023 22:42:03 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB27678
        for <linux-integrity@vger.kernel.org>; Tue,  3 Jan 2023 19:42:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so48698581lfv.2
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jan 2023 19:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0Z9P5zAl8OMVW0iNoSbJoRO8gW6HoM/PUn42UgSrQU=;
        b=ecPK2dNgDdt6UAwTIszHkWH2ig/5+MsB5C0VshWk1nLizcH0kEqDd21t9UVEZwLDvM
         6F8FyO42Fy/p1hEIC2z6+NTMvbzul8n+U70Yd4dUZwNfMYfBKVmBHJNXt+TgATcMrKXA
         R7luMzd95y7NtRXs21VQPpdPG+NjlhUTEHW+xN8Agc7NuYPWmSpfBMzOJz33q9f8v+Hi
         h1bmvXRV759ga0b+ZnyhCcC9/3PfMPdO71Kkiq+YNkVpFPDJOUp/ScNvflJfJsDdU45p
         alXt6QJV3bTxt4jwdXiGz9PngBZzrh7/YC5GNhnJDY0cCzbHQggCABUHTA/uOo2wGke3
         4RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0Z9P5zAl8OMVW0iNoSbJoRO8gW6HoM/PUn42UgSrQU=;
        b=ZAiJhUeY6s2NnSyG3rsa6VFHcBlzgCIuB6qqAVkSZY4q6Mb+VuyCNeyRi9VGrfFYas
         /IFj7eboDwgweCP2WipsEVvqbuGHtmkCUTCf9YW5cFwAW7hMrRmzSgsscY7UvdDiFGA0
         +RxcVDTfDYhJoVY6QcMuUnXYkCQEg3U38RbrGu3QJ5KNBfoao5whnPKH4vD/94tWNDr7
         NpMjHU40I5yrCwBWmebuxAADsn7ytXY5q8Oj6lU+GXTFewIk6RwyaseMKkS6TdjvbzFi
         ItOf5WA0dbuEn3EtrAa474PrMyJ5fFFb08cbrrytkZG4hxHmVY9XGmliBJMA4ajs6qIK
         fz1Q==
X-Gm-Message-State: AFqh2ko/6Qc2bgZXmFyVx3AVH8Exv8K0B3oGSizBeIbKOpsDlC6Id/b1
        sQ327LH+nYmv0ZHndcPXmQB+6g==
X-Google-Smtp-Source: AMrXdXuzUvRj8L8bHlwyCor4UJUQ9mtURazlh2thLXW7r0/nCbOxEInB079cGisW4pF1tvDeEFn2EA==
X-Received: by 2002:a05:6512:10c3:b0:4b6:e64c:aec6 with SMTP id k3-20020a05651210c300b004b6e64caec6mr15613053lfg.63.1672803720794;
        Tue, 03 Jan 2023 19:42:00 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id v24-20020a05651203b800b004b4e6dab30esm5009037lfp.222.2023.01.03.19.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 19:42:00 -0800 (PST)
Date:   Wed, 4 Jan 2023 03:41:56 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, revest@google.com,
        kpsingh@google.com, roberto.sassu@huawei.com
Subject: [PATCH] ima: return IMA digest value only when IMA_COLLECTED flag is
 set
Message-ID: <Y7T1hEhIL5TEmLEN@google.com>
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

The IMA_COLLECTED flag indicates whether the IMA subsystem has
successfully collected a measurement for a given file object. Ensure
that we return the respective digest value stored within the iint
entry only when this flag has been set.

Failing to check for the presence of this flag exposes consumers of
this IMA API to receive potentially undesired IMA digest values when
an erroneous condition has been experienced in some of the lower level
IMA API code.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b1ae0f2751f1..1d40cdfa23d5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -563,7 +563,7 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 	 * ima_file_hash can be called when ima_collect_measurement has still
 	 * not been called, we might not always have a hash.
 	 */
-	if (!iint->ima_hash) {
+	if (!iint->ima_hash || !(iint->flags & IMA_COLLECTED)) {
 		mutex_unlock(&iint->mutex);
 		return -EOPNOTSUPP;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

/M
