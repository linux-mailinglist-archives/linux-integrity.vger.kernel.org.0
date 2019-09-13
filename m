Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C361EB2423
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2019 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389592AbfIMQfV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Sep 2019 12:35:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40664 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387822AbfIMQfV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Sep 2019 12:35:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so15533829pgj.7;
        Fri, 13 Sep 2019 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U1A+7K7DBCYzZ10LaOWX7DewnzC97b4Covgem9tPITc=;
        b=WDywiucKcTd0TVEp5ZnkILQ3wgFeKxmG4pJuqgS4DyzPjMacxPh4ZxfK8KjJHI+iXP
         zmlKc+R7wpq+uJM57/COIqb9U7qbCJGVk3yxz8BP9Kv8B5CkktfoGswxvL4zE/PXOL91
         Q0cYM1ZHnEZWUQcXweTJA6zJWDTf9ZrGrilmKZyz0JVO+Vstxc6G88AsEtpZO6BK+mXq
         DtvlrHN+SlH4eMhNh9gsB/bF/k0neI1OPvHCn/H48KeaIDC0kNX5/lFrKVGuO/s+dnnf
         x9w33nx6mfwNk0ApBaRG+WXN1oMC6tEW/D58bHZTFgbIsxPIgfjVfR7DI7ZmbwWAPS/4
         mOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U1A+7K7DBCYzZ10LaOWX7DewnzC97b4Covgem9tPITc=;
        b=rtK9s8JvqWf7nr8wuG6rzP2SDkm9sx1khi26fZ8RzKUAlSpYy31szL9tMrDp8KxJ6Y
         RwUKMhzBQUcgg5QmABNKeNr+i1x4lKOMiz6zl4fftPI34rvZTAb/Tx+52L6YxlntEKlM
         VxoW2PAOirETQ38gez2BMRbPfW+S9KpLV9IBOrF/p9Hm//2mrVFGuSFPBQFRYFDMSj75
         dir5Y/+XDdIeDxb9h5v04xQIv8AyluP0C3mMPLEc/OyP2/S3N4DAMHUSOvWvl5OK8oNc
         E8/5yCP1HYeoG1qWn/be+iQJ5B6WBbQGTyzY9gMf77nKeJYX+E7ZD6+CAQw39pvwhJ+C
         mANw==
X-Gm-Message-State: APjAAAUc2pVcYf7EtX0Qd1FeOKdKZiAA2GFniLpzs88I63BIRBeLalN4
        gpg2W+24O6IeY48BlzP5I/s=
X-Google-Smtp-Source: APXvYqw2x57TgLuZYyv7s+sdwpz6y9pno7nl9Tn8GS7DnHpyGJ6XnIwjsmPewtoeMUodWUryGoKfIw==
X-Received: by 2002:a17:90a:eac7:: with SMTP id ev7mr6337926pjb.61.1568392519733;
        Fri, 13 Sep 2019 09:35:19 -0700 (PDT)
Received: from SD ([106.222.13.126])
        by smtp.gmail.com with ESMTPSA id c62sm40785154pfa.92.2019.09.13.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 09:35:19 -0700 (PDT)
Date:   Fri, 13 Sep 2019 22:05:06 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: ima: make use of kmemdup
Message-ID: <20190913163506.GA30916@SD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replace call to kmalloc followed by memcpy with a direct call
to kmemdup to achieve same functionality.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 security/integrity/ima/ima_policy.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6df7f641ff66..1bd77c5eaeb7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -262,15 +262,14 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	struct ima_rule_entry *nentry;
 	int i, result;
 
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
 	memset(nentry->lsm, 0, FIELD_SIZEOF(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-- 
2.20.1

