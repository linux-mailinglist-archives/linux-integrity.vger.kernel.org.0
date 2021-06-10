Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868923A31E3
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFJRSq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 13:18:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59066 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFJRSp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 13:18:45 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id DF1B420B83C2;
        Thu, 10 Jun 2021 10:16:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF1B420B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623345409;
        bh=xrcK9iOXmTh55gmK1vfkC1viqRPFZ9noMB/T92243/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfxZdiGHKs17jAlXW8SXaZ3Mn4R1ebNptsfQoVqLF+ZVOhg6ZMsy4t3Si4Yj37DHE
         J1SDquKgH0c1RyAujXjmAgcBtQ4sRzjuRyCshgzxSpJO+Zs6/htmHnj4j7sv3Zag4a
         yc/74D4dmBdG14dp7ZxJnoiNR1mWzYRfxzngzZZA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, robh@kernel.org, bauerman@linux.ibm.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tusharsu@linux.microsoft.com
Subject: [PATCH 2/2] ima: Fix warning: no previous prototype for function 'ima_post_key_create_or_update'
Date:   Thu, 10 Jun 2021 10:15:53 -0700
Message-Id: <20210610171553.3806-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610171553.3806-1-nramas@linux.microsoft.com>
References: <20210610171553.3806-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The function prototype for ima_post_key_create_or_update() is present
in 'linux/ima.h'.  But this header file is not included in
ima_asymmetric_keys.c where the function is implemented.  This results
in the following compiler warning when "-Wmissing-prototypes" flag
is turned on:

  security/integrity/ima/ima_asymmetric_keys.c:29:6: warning: no previous
  prototype for 'ima_post_key_create_or_update' [-Wmissing-prototypes]

Include the header file 'linux/ima.h' in ima_asymmetric_keys.c to
fix the compiler warning.

Fixes: 88e70da170e8 (IMA: Define an IMA hook to measure keys)
Cc: stable@vger.kernel.org
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 1fb0b0e09559..c985418698a4 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -11,6 +11,7 @@
 
 #include <keys/asymmetric-type.h>
 #include <linux/user_namespace.h>
+#include <linux/ima.h>
 #include "ima.h"
 
 /**
-- 
2.25.1

