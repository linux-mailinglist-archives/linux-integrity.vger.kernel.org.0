Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2073D2B3A
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGVQyN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 12:54:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3453 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhGVQyK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 12:54:10 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVzqw0Wdtz6DGqg;
        Fri, 23 Jul 2021 01:25:48 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 19:34:43 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <pvorel@suse.cz>, <vt@altlinux.org>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH ima-evm-utils 2/7] Download mount-idmapped
Date:   Thu, 22 Jul 2021 19:34:09 +0200
Message-ID: <20210722173414.1738041-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722173414.1738041-1-roberto.sassu@huawei.com>
References: <20210722173414.1738041-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

mount-idmapped is a tool to create idmapped mounts, a feature recently
integrated in kernel 5.12 and that allows processes to see a different UID
and GID on that mount.

This patch downloads (errors are ignored) an artifact from
$MOUNT_IDMAPPED_URL/mount-idmapped, where MOUNT_IDMAPPED_URL is an
environment variable to be set in the configuration of the testing platform
(for Github Actions, the variable should be added in an environment named
'test').

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .github/workflows/ci.yml | 4 ++++
 .travis.yml              | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 51f7dbe0aaa6..4cfffbbd85f7 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -140,6 +140,10 @@ jobs:
         if [ -f linux ]; then
                 chmod +x linux
         fi
+        curl -L ${{ secrets.MOUNT_IDMAPPED_URL }}/mount-idmapped -s -f --output mount-idmapped || echo
+        if [ -f mount-idmapped ]; then
+                chmod +x mount-idmapped
+        fi
 
     - name: Compiler version
       run: $CC --version
diff --git a/.travis.yml b/.travis.yml
index 23c220e857b6..f3e3d93e1907 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -104,6 +104,11 @@ before_install:
         if [ -f "linux" ]; then
                 chmod +x linux
         fi
+    - curl -L $MOUNT_IDMAPPED_URL/mount-idmapped -s -f --output mount-idmapped || echo
+    - >
+        if [ -f "mount-idmapped" ]; then
+                chmod +x mount-idmapped
+        fi
     - $CONTAINER build $CONTAINER_ARGS -t ima-evm-utils .
 
 script:
-- 
2.25.1

