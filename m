Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4275B222C59
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 21:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgGPTwh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 15:52:37 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:52232 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbgGPTwh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 15:52:37 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id AA634BC078;
        Thu, 16 Jul 2020 19:52:33 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] encrypted-keys: Replace HTTP links with HTTPS ones
Date:   Thu, 16 Jul 2020 21:52:27 +0200
Message-Id: <20200716195227.65839-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 include/keys/encrypted-type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/keys/encrypted-type.h b/include/keys/encrypted-type.h
index 38afb341c3f2..abfcbe02001a 100644
--- a/include/keys/encrypted-type.h
+++ b/include/keys/encrypted-type.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2010 IBM Corporation
  * Copyright (C) 2010 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
+ *                    TORSEC group -- https://security.polito.it
  *
  * Authors:
  * Mimi Zohar <zohar@us.ibm.com>
-- 
2.27.0

