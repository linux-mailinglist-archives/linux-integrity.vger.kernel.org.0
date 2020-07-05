Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB63F214FE9
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jul 2020 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgGEVp2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Jul 2020 17:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgGEVp1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Jul 2020 17:45:27 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB2FC061794;
        Sun,  5 Jul 2020 14:45:27 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id E4833BC127;
        Sun,  5 Jul 2020 21:45:23 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     jmorris@namei.org, serge@hallyn.com, john.johansen@canonical.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: security
Date:   Sun,  5 Jul 2020 23:45:12 +0200
Message-Id: <20200705214512.28498-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
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
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 security/Kconfig                                 | 2 +-
 security/apparmor/Kconfig                        | 2 +-
 security/integrity/ima/Kconfig                   | 2 +-
 security/integrity/ima/ima_template.c            | 2 +-
 security/integrity/ima/ima_template_lib.c        | 2 +-
 security/integrity/ima/ima_template_lib.h        | 2 +-
 security/keys/encrypted-keys/ecryptfs_format.c   | 2 +-
 security/keys/encrypted-keys/ecryptfs_format.h   | 2 +-
 security/keys/encrypted-keys/encrypted.c         | 2 +-
 security/keys/encrypted-keys/masterkey_trusted.c | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index cd3cc7da3a55..7561f6f99f1d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -118,7 +118,7 @@ config INTEL_TXT
 	  it was configured with, especially since they may be responsible for
 	  providing such assurances to VMs and services running on it.
 
-	  See <http://www.intel.com/technology/security/> for more information
+	  See <https://www.intel.com/technology/security/> for more information
 	  about Intel(R) TXT.
 	  See <http://tboot.sourceforge.net> for more information about tboot.
 	  See Documentation/x86/intel_txt.rst for a description of how to enable
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 03fae1bd48a6..348ed6cfa08a 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -77,7 +77,7 @@ config SECURITY_APPARMOR_KUNIT_TEST
 	  This builds the AppArmor KUnit tests.
 
 	  KUnit tests run during boot and output the results to the debug log
-	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  in TAP format (https://testanything.org/). Only useful for kernel devs
 	  running KUnit test harness and are not for inclusion into a
 	  production build.
 
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index edde88dbe576..6a5e4a77601b 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -26,7 +26,7 @@ config IMA
 	  an aggregate integrity value over this list inside the
 	  TPM hardware, so that the TPM can prove to a third party
 	  whether or not critical system files have been modified.
-	  Read <http://www.usenix.org/events/sec04/tech/sailer.html>
+	  Read <https://www.usenix.org/events/sec04/tech/sailer.html>
 	  to learn more about IMA.
 	  If unsure, say N.
 
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 5a2def40a733..1e89e2d3851f 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2013 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
+ *                    TORSEC group -- https://security.polito.it
  *
  * Author: Roberto Sassu <roberto.sassu@polito.it>
  *
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 635c6ac05050..41a5f435b793 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2013 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
+ *                    TORSEC group -- https://security.polito.it
  *
  * Author: Roberto Sassu <roberto.sassu@polito.it>
  *
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 9a88c79a7a61..6b3b880637a0 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2013 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
+ *                    TORSEC group -- https://security.polito.it
  *
  * Author: Roberto Sassu <roberto.sassu@polito.it>
  *
diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
index a7339d4de811..8fdd76105ce3 100644
--- a/security/keys/encrypted-keys/ecryptfs_format.c
+++ b/security/keys/encrypted-keys/ecryptfs_format.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2006 International Business Machines Corp.
  * Copyright (C) 2010 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
+ *                    TORSEC group -- https://security.polito.it
  *
  * Authors:
  * Michael A. Halcrow <mahalcro@us.ibm.com>
diff --git a/security/keys/encrypted-keys/ecryptfs_format.h b/security/keys/encrypted-keys/ecryptfs_format.h
index 939621d870e4..ed8466578616 100644
--- a/security/keys/encrypted-keys/ecryptfs_format.h
+++ b/security/keys/encrypted-keys/ecryptfs_format.h
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2006 International Business Machines Corp.
  * Copyright (C) 2010 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
+ *                    TORSEC group -- https://security.polito.it
  *
  * Authors:
  * Michael A. Halcrow <mahalcro@us.ibm.com>
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 14cf81d1a30b..20075b1308aa 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2010 IBM Corporation
  * Copyright (C) 2010 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
+ *                    TORSEC group -- https://security.polito.it
  *
  * Authors:
  * Mimi Zohar <zohar@us.ibm.com>
diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index c68528aa49c6..e6d22ce77e98 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
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

