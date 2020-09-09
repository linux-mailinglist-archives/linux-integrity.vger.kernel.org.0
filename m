Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABEA263678
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Sep 2020 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIITJQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Sep 2020 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITJO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Sep 2020 15:09:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71111C061573;
        Wed,  9 Sep 2020 12:09:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so3491692wmm.2;
        Wed, 09 Sep 2020 12:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3CtnsHu1kocc8uwLlDaSSxN5AfuSpASFecFNMuqKHqI=;
        b=Xr0TqVWcl1f3bR1fLi1bK3iFtjf3T3nwYBn4qS4SvMW9SkenRS+jnybhPFvwb/APP+
         gwGqheFmi7Vh0WPGI5P1tU9VsnUhGiTLp43Tdpp0mURPswE6QMyo8EDUqY7SEZeHRUtY
         MWnFxi87H6ZmNyNPr5+f+V8G945Rdq7eCNTi5p/e23unmdflSx3oyQoJv60527Ek7cgr
         DkHiYLHXx9+PHRuuPUdTpZj+l0vxMI5k8lEAEST88k7TdG0tA2N/02CnGqJw8JtSwUOY
         3U3C18G17PCheM/Hl+KiTPOZIy7VjWFXGDsov1cJm+5ZHrDfeBKbnmtdmleL08wggObM
         XCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3CtnsHu1kocc8uwLlDaSSxN5AfuSpASFecFNMuqKHqI=;
        b=VTCn+glHkT7t+a5qCwfBN3RNoKh6yD/l4D3oM80NsRkyuqUKmT2kv46M7IfIlXRyVp
         4AAfcouI6dsJmqER+3W2N9wHQxqV0qAYs7RNBXAFVsHwwwgcA0sKmx6i9tr7TuOLSixy
         qbkSO0Au0lLy9hgaFURIJXlU1oupDF+R0SSfT8extf3+ltESEMOhxo/qEb/nLeHCfTvP
         pB//BnhuyeJXKljG8VraGhoWrGSa17/3rLV0IV390kisRUQy07RkovdUwxpm8Hh6U3Jo
         RMHgXCz4mRU/Bj5nhGXRjib1fhaeavLeAQP1qUn/ru/rSyZZUCLyGWITAnU87Rk6O9Sq
         zfXg==
X-Gm-Message-State: AOAM5305ipTVxQCNtEmS5DUsN32xHARnXY2rO9kgvsHB7JiyPWuMP9yr
        HIRZoIKRXzyukUaIdvKKNB0=
X-Google-Smtp-Source: ABdhPJyOefeiMFkPtAS+u9KKFh1ftgY9to3EIPbs6NcaiNIlTcgWE17qOnji0DYHm6wmjlL1VvK4vg==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr4673591wml.12.1599678551993;
        Wed, 09 Sep 2020 12:09:11 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id b187sm93304wmb.8.2020.09.09.12.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:09:11 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Use kmemdup rather than kmalloc+memcpy
Date:   Wed,  9 Sep 2020 20:09:06 +0100
Message-Id: <20200909190907.164013-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 security/integrity/ima/ima_policy.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b4de33074b37..1de3140b334f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -284,15 +284,14 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	struct ima_rule_entry *nentry;
 	int i;
 
-	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
-	if (!nentry)
-		return NULL;
-
 	/*
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	memcpy(nentry, entry, sizeof(*nentry));
+	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
+	if (!nentry)
+		return NULL;
+
 	memset(nentry->lsm, 0, sizeof_field(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-- 
2.28.0

