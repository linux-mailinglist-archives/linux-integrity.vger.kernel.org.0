Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C4B3A31E1
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFJRSp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 13:18:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59056 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFJRSp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 13:18:45 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9E24420B7188;
        Thu, 10 Jun 2021 10:16:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E24420B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623345408;
        bh=QI9MxdMZ4JjR7zc8B0qW2kh7lEaVTJjZJKw3Xc8/UQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=hYKpETYchAV79TiOrMuCXLIhfzGEeKQ98EXbpq1maqFIZeeQbaz4cgNwlwB8Od/f+
         7DTdT5uoqH6Y2a40MMjVw4v+xqPY3EJUb5nSwnc8C7LigpG0YPgEnwKKR5x+GGmiiV
         SY63En9FWjQIVgxetFCHejBBLPnBSCkwiu0T5tK8=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, robh@kernel.org, bauerman@linux.ibm.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tusharsu@linux.microsoft.com
Subject: [PATCH 1/2] ima: Fix warning: no previous prototype for function 'ima_add_kexec_buffer'
Date:   Thu, 10 Jun 2021 10:15:52 -0700
Message-Id: <20210610171553.3806-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The function prototype for ima_add_kexec_buffer() is present
in 'linux/ima.h'.  But this header file is not included in
ima_kexec.c where the function is implemented.  This results
in the following compiler warning when "-Wmissing-prototypes" flag
is turned on:

  security/integrity/ima/ima_kexec.c:81:6: warning: no previous prototype
  for function 'ima_add_kexec_buffer' [-Wmissing-prototypes]

Include the header file 'linux/ima.h' in ima_kexec.c to fix
the compiler warning.

Fixes: dce92f6b11c3 (arm64: Enable passing IMA log to next kernel on kexec)
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 667887665823..f799cc278a9a 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -11,6 +11,7 @@
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
 #include <linux/of.h>
+#include <linux/ima.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
-- 
2.25.1

