Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE89C4F7
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2019 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfHYRAe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Aug 2019 13:00:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52950 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfHYRAe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Aug 2019 13:00:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so13263898wmh.2;
        Sun, 25 Aug 2019 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p9k1FKMnIrxG0b37UnbB0s6eICj+7+p6AjxyIjJWcRc=;
        b=jYgRL8ynDKjcrxuB72XaidT8PNpyXFNlXzDCmWDotk2kMb4z0K3WUpCNiIQvXAz3Mb
         1vhw9GQPs7fPKXRhkVgoZL/Fw6wBTfaZUfjwRKtOYuaDmhTcgJZuM/T2nMZ9Kz8jtAuB
         G4H8DHJUuceq/ND5LOwmk9y7RaCa2b1xRrxokYwozUBbBlGdEx0PCyBFDmR1Xf9NFYmL
         W/jzUHm1hXCgtuWrMiHVeMMBdK2dPUYcFBs49Hl0QKioGt2l2dzLd0P07TIPuoJhmPO4
         4blw9OHRSiQdQzkHWESe1nfKstCNHFJ4Uug7tYgVU9ZKzSGAZZF4GxIViMBiGAZlEtML
         MPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p9k1FKMnIrxG0b37UnbB0s6eICj+7+p6AjxyIjJWcRc=;
        b=haKIjZ0a+2g7vQO0Wy1bJR0f/yFQ7tQ44wMNFml+63rWmi3Bbc/FQJ7HD7JBST2Ehc
         zPWbuNKE7vwag286c/rMXuKHR9B77kMgACFHq4ADE3k7ne3ohjL8hRoZCyAgOAavk4mP
         X46neRLFfnkV+WRCwXVOAEFZT+kobPg+EBVOPs8ugyOfKVCjuzPIbojDIkgierzlWSWk
         frNBBklYZzwQnJMxt4fUdjtNS88a26RNYV/EQVoO2Ihf5fGNqtxbcyruNY8s3pNwTaUP
         VKfUC/rLtsK6Kh+UwAw7J59DEqXiEi73irAdvcjMws9o1ohmxZ62t7iyLvke13QWWkdR
         Z5IQ==
X-Gm-Message-State: APjAAAVQOA4AEdIJh7+9Wd8yTharNi1dggm6LAV/INkyKAlfyfqMYnVn
        6ZOjoUUCD+kNJ4U2131eZuo=
X-Google-Smtp-Source: APXvYqxmgkfJw05/1SCRbDKujNB6+wS972IXRO+F/0tXfiML4NN35FhScA8bV3wnbKd2ExHotWh0aQ==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr16712674wmi.16.1566752432408;
        Sun, 25 Aug 2019 10:00:32 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2df7:8200:64bc:6b75:d016:739d])
        by smtp.gmail.com with ESMTPSA id j10sm17688223wrd.26.2019.08.25.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 10:00:31 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RESEND][PATCH v2-resend] MAINTAINERS: fix style in KEYS-TRUSTED entry
Date:   Sun, 25 Aug 2019 19:00:15 +0200
Message-Id: <20190825170015.3199-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
further maintainer to the KEYS-TRUSTED section entry.

In fact, ./scripts/checkpatch.pl -f MAINTAINERS complains:

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #8581: FILE: MAINTAINERS:8581:
  +M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

The issue was detected when writing a script that parses MAINTAINERS.

Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/patchwork/patch/1040412/
  - Joe Perches clarified that this is a style defect.

v2: applies cleanly to v5.1-rc4 and next-20190412

v2-resend: applies cleanly to v5.3-rc5 and next-20190823

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43604d6ab96c..6cb9a4927da8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8937,7 +8937,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
-- 
2.17.1

