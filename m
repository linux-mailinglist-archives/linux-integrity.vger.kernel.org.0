Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F026A28F4B1
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgJOO11 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 10:27:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:14154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730882AbgJOO11 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 10:27:27 -0400
IronPort-SDR: ZoXx9AkVkzjC6g6ZiMC/A/m9MmOiyiot9mr+kFmLM4bXUq6wuHtj/pgDGAOKHe9afKn/ox0gfY
 Rd8NzEFDHi9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="165581470"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="165581470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 07:27:26 -0700
IronPort-SDR: +ny1WHzu6fLRQQOwVpnzusLvy3sUUu1Iw0e1Vs3fvkxbTQO+G6HJ8C8PDm7uqKHLd9SNQTuSv+
 jNDWgwjcDqqw==
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="300276779"
Received: from cbenunes-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.35.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 07:27:21 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-sgx@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, Joe Perches <joe@perches.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] MAINTAINERS: jarkko.sakkinen@linux.intel.com -> jarkko@kernel.org
Date:   Thu, 15 Oct 2020 17:26:37 +0300
Message-Id: <20201015142710.8371-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use @kernel.org address as the main communications end point. Update the
corresponding M-entries and .mailmap (for git shortlog translation).

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v2:
* Update the .mailmap (suggested by Joe Perches).
  https://lore.kernel.org/lkml/b1ccdfbb3119528490ea10f40e1da084b1b23f87.camel@perches.com/
 .mailmap    | 1 +
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index e4ccac4e2f88..1e14566a3d56 100644
--- a/.mailmap
+++ b/.mailmap
@@ -133,6 +133,7 @@ James Ketrenos <jketreno@io.(none)>
 Jan Glauber <jan.glauber@gmail.com> <jang@de.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
+Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 6594f0966716..afe2a20fb85a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9668,7 +9668,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko@kernel.org>
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
@@ -9680,7 +9680,7 @@ F:	security/keys/trusted-keys/
 
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
-M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko@kernel.org>
 L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/security/keys/core.rst
@@ -17616,7 +17616,7 @@ F:	drivers/platform/x86/toshiba-wmi.c
 
 TPM DEVICE DRIVER
 M:	Peter Huewe <peterhuewe@gmx.de>
-M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Jarkko Sakkinen <jarkko@kernel.org>
 R:	Jason Gunthorpe <jgg@ziepe.ca>
 L:	linux-integrity@vger.kernel.org
 S:	Maintained
-- 
2.25.1

