Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01D250AB6
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 23:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHXVVU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 17:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXVVT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 17:21:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A4AC061574;
        Mon, 24 Aug 2020 14:21:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so10546069wrh.10;
        Mon, 24 Aug 2020 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEVH3KeEKImpzoTD8sOJ0HUqoecJmgA9xUt/L5UEv9Q=;
        b=TJ7V62ZVq7GSWFy91CFPG7K6Qardtn7N0bIo9gS78kvC3AFAdgFN9k3zz09WVjfBwA
         m6r+rwMdRJbnx2Cc5Jjw33IhpnhcVOLbb019l2IvUiI52dP4MZwbxnTsGf9O6jSZCH95
         ao8eR1r9eXOf/uEsI+FjiOFGApD0DOBtSrvyviLhRYqdoxZT+CO7wark/zlqaqMOqoVG
         3M7QA1cai3VKb36artZbp+GXnOHZJX0mObM0keyAcNcRsFMFpy7Xu901zQSPPgs2Y2qr
         NMMhiSAunMG9ND1lhDX+XqV43wr71tvqcpNXZ/JQEzHUfa4Ix11Bc4006iuOTagl2/rj
         Epng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEVH3KeEKImpzoTD8sOJ0HUqoecJmgA9xUt/L5UEv9Q=;
        b=gSOsKqRyOXa2mE8ZgYUaavv5e0iCeav5vUqq8X3lC3rBjbwt6M/PK8v29sDv2Fmpjo
         OqQ2/PSu/JYfNT+tH4xncQsBRqhXjvi3ebyktK2TVgZXWIlKDptcxsyGiW6OiYG4A0PP
         hI+eALcR/wkavpBOlEk94DuWZg+N6aNaCFHBCw3l+0xbAQTO4skl7KoWcA4yY5aUAPs2
         E/zucZmeXuEAo4wSiRn6IhxYh3wi7uwNu78RGihXsp7tGry85MUCChE8rholdPMXlnqO
         GhE9joIyz7A0GJHgMXTH52kUrOc9wWHOCmrO4rzTWuQP8+emV0Z9diBeIH75qUhEO5tS
         Lv6Q==
X-Gm-Message-State: AOAM533yHjSMHqWDL7P35RkYM9Lr4RG5JbamudTcCsDkGpFUk6e54/sH
        eBRF4CKSrXkLtnh1da5w6KCkJpir0odQ3ZU3
X-Google-Smtp-Source: ABdhPJwucY1j3myAwja5npvITAje1Z6NxRhzDiiW8NUuHhAtd5JRGj7sqdyXBpWsann3oSjfzMGafw==
X-Received: by 2002:adf:e986:: with SMTP id h6mr7600816wrm.106.1598304077509;
        Mon, 24 Aug 2020 14:21:17 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id k204sm1726281wma.21.2020.08.24.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:21:16 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH] ima: use kmemdup() rather than kmalloc+memcpy
Date:   Mon, 24 Aug 2020 22:21:02 +0100
Message-Id: <20200824212102.602559-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 security/integrity/ima/ima_policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b4de33074b37..ea917a787d9d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -284,7 +284,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	struct ima_rule_entry *nentry;
 	int i;
 
-	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
 	if (!nentry)
 		return NULL;
 
@@ -292,7 +292,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	memcpy(nentry, entry, sizeof(*nentry));
 	memset(nentry->lsm, 0, sizeof_field(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-- 
2.28.0

