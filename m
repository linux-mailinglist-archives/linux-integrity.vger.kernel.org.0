Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00974179456
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Mar 2020 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgCDQEP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Mar 2020 11:04:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38096 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDQEO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Mar 2020 11:04:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id t11so3062827wrw.5;
        Wed, 04 Mar 2020 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U/EkvVl7FAi6+YEFd5JxFzG6+4DfZZOGAx7Rl8CToMk=;
        b=E1JN1GbGM8dgvnEHDscwegwpfaMaQ7uNI35EyIvMcMf2sw+8icQudqTE5OJkyH//m4
         sxWXzYGXuxf17vSkNtS6vwLBXIQN1WthG6PDuKUeppzQI0CbXr+99sBifnfdr0DVC4Q3
         8bE9hDL/ExIVkl9SoyKHBUo6CqfBn1IS0o5oFHlidXR2mK4ZKIEIz++HhIJhkna/UIl5
         DllgjA+teBq5a1OTvkme+RyeCZYdxgzYOG1sQhCRvEyEsa7KcgBiJCTz1VksSuA5zDxf
         cUOwDWP2NiFZOJdu+ynWXIQaT2sOkz1YxEo3zJlhg9h+2kDeAC6hwj0992FeW9pGF4hf
         sp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U/EkvVl7FAi6+YEFd5JxFzG6+4DfZZOGAx7Rl8CToMk=;
        b=QXAWdMWEjunXo0OTwno+wW0dkJLOuonfEvdyC3R6YTyBbZrlyS3Mk1rpKMP+UUJGcR
         cb9URABGVluJ7ntxmbseWfXrZHZiM+UEKvKKgpy46e1rXTTu6ifVUuXX0GYb8FBSJevd
         wYHhLgIOEX6Xf5pNSr2t/gZspCjZlasaRRGYfMG3Lh6daTK4t7j2a83bG9q5nWv0Khc0
         WWyfMnibqMi/xIlqwW/hDKk1r8Ry0pF91bCNBglsriXvoq/y9OGlSO29FEXkTpDS8fhr
         znnqEhsb9jNNirhR+nnZw5Kk12nXd+0uSA4GUEYjQWC/goUDnhF0ObLdDtZkmZCTFZxL
         rxyA==
X-Gm-Message-State: ANhLgQ3malTn5gsTac5/EsWKGOSC/ttE5KiXstuD6oqLQp33e5ii3/K3
        KMb+iHRJvJZ0RvnZYYuHD7k=
X-Google-Smtp-Source: ADFU+vu6NnUvsLhagcO8Q4poilEAI652nzvJveCmlcKlhnSPTvayuVO6DjHuiAqzqYSqFm2261DWgw==
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr4544176wrs.231.1583337852868;
        Wed, 04 Mar 2020 08:04:12 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d16:4100:3093:39f0:d3ca:23c6])
        by smtp.gmail.com with ESMTPSA id y1sm3699219wrh.65.2020.03.04.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:04:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
Date:   Wed,  4 Mar 2020 17:03:59 +0100
Message-Id: <20200304160359.16809-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
to trusted-keys/trusted_tpm1.c in security/keys/.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: security/keys/trusted.c
  warning: no file matches F: include/keys/trusted.h

Rectify the KEYS-TRUSTED entry in MAINTAINERS now.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Sumit, please ack.
Jarkko, please pick this patch.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c755e03ddee..cf389058ca76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9276,8 +9276,8 @@ L:	keyrings@vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
-F:	security/keys/trusted.c
-F:	include/keys/trusted.h
+F:	include/keys/trusted_tpm.h
+F:	security/keys/trusted-keys/trusted_tpm1.c
 
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
-- 
2.17.1

