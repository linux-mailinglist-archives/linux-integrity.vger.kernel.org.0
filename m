Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4E662BE2
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jan 2023 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjAIQ5R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Jan 2023 11:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjAIQ47 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jan 2023 11:56:59 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EBD22A
        for <linux-integrity@vger.kernel.org>; Mon,  9 Jan 2023 08:56:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NrKfQ5x1jz9v7YP
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 00:49:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXHWQ9R7xjPQWBAA--.14103S5;
        Mon, 09 Jan 2023 17:56:45 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils 3/8] Compile the UML kernel and download it in Github Actions
Date:   Mon,  9 Jan 2023 17:55:47 +0100
Message-Id: <20230109165552.3409716-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
References: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCXHWQ9R7xjPQWBAA--.14103S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1fCrW5Xw13JF17Kr17KFg_yoW7AF4xp3
        4Yy34Yvrs7J3W7Awn2vr18Cw4Y9393Ar13C34xJ345AF9xJayv9FsaqryYvF17ZrWxKF4f
        ZFWUWFyDKayxZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6dgAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4dfhAABsl
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a build job, prerequisite of the existing job, to compile the UML
kernel and upload it and the signing key to a cache. Github configuration
should have two secrets: LINUX_URL, the full URL of the kernel repository;
LINUX_BRANCH, the branch to check out as fallback if the name of the
ima-evm-utils branch is not found in the kernel repository.

If there is a cache hit (same kernel commit and same kernel configuration),
next time the UML kernel will not be rebuilt. To use the cache, it is
necessary to install zstd in the container. Add this dependency to
ci/fedora.sh.

The cache can be managed at the following URL:

https://github.com/<username>/ima-evm-utils/actions/caches

The page also offers the possibility to clean the cache, to force
rebuilding the kernel.

Add a new entry in the testing matrix, for the fedora-latest container
image, to run the tests with the UML kernel. The entry differs from the
others for the new environment variable UML_MODE, set to 1.

Add a new volume to the container, /dev/shm from the host, as it is
required for running the UML kernel.

Extend the existing job with steps to download the UML kernel and signing
key from the cache. The new steps are executed only if the matrix entry has
UML_MODE set to 1.

Finally, pass UML_MODE to the tests. A test should also propagate this
variable to the environment created with the UML kernel, by passing it to
the kernel command line.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .github/workflows/ci.yml | 92 +++++++++++++++++++++++++++++++++++++++-
 ci/fedora.sh             |  3 +-
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index d2afdfe15467..2e05d0027f83 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -3,7 +3,72 @@ name: "distros"
 on: [push, pull_request]
 
 jobs:
+  build:
+    runs-on: ubuntu-latest
+    outputs:
+      LINUX_SHA: ${{ steps.last-commit.outputs.LINUX_SHA }}
+    name: build
+    timeout-minutes: 100
+    strategy:
+      fail-fast: false
+
+    env:
+      linux_url: ${{ secrets.LINUX_URL }}
+      linux_branch: ${{ secrets.LINUX_BRANCH }}
+
+    steps:
+      - uses: actions/checkout@v3
+
+      - name: Determine last kernel commit
+        id: last-commit
+        shell: bash
+        run: |
+          mkdir linux-integrity
+          pushd linux-integrity
+          git init
+          git branch -m ${{ secrets.LINUX_BRANCH }}
+          git remote add origin ${{ secrets.LINUX_URL }}
+          LINUX_SHA=$(git ls-remote origin $GITHUB_REF_NAME | awk '{print $1}')
+          [ -z "$LINUX_SHA" ] && LINUX_SHA=$(git ls-remote origin ${{ secrets.LINUX_BRANCH }} | awk '{print $1}')
+          echo "LINUX_SHA=$LINUX_SHA" >> $GITHUB_OUTPUT
+          popd
+
+      - name: Cache UML kernel
+        id: cache-linux
+        uses: actions/cache@v3
+        with:
+          path: linux
+          key: linux-${{ steps.last-commit.outputs.LINUX_SHA }}-${{ hashFiles('**/config-uml') }}
+
+      - name: Cache signing key
+        id: cache-key
+        uses: actions/cache@v3
+        with:
+          path: signing_key.pem
+          key: signing_key.pem-${{ steps.last-commit.outputs.LINUX_SHA }}-${{ hashFiles('**/config-uml') }}
+
+      - name: Compile UML kernel
+        if: steps.cache-linux.outputs.cache-hit != 'true' || steps.cache-key.outputs.cache-hit != 'true'
+        shell: bash
+        run: |
+          if [ "$DEVTOOLSET" = "yes" ]; then
+                  source /opt/rh/devtoolset-10/enable
+          fi
+          if [ "$ARCH" = "i386" ]; then
+                  CROSS_COMPILE_OPT="CROSS_COMPILE=i686-linux-gnu-"
+          fi
+          pushd linux-integrity
+          git pull --depth 5 origin ${{ secrets.LINUX_BRANCH }}
+          ./scripts/kconfig/merge_config.sh -m .config ../config-uml
+          make ARCH=um olddefconfig
+          make ARCH=um $CROSS_COMPILE_OPT -j$(nproc)
+          chmod +x linux
+          cp linux ..
+          cp certs/signing_key.pem ..
+          popd
+
   job:
+    needs: build
     runs-on: ubuntu-latest
 
     strategy:
@@ -75,6 +140,12 @@ jobs:
               CC: clang
               TSS: ibmtss
 
+          - container: "fedora:latest"
+            env:
+              CC: clang
+              TSS: ibmtss
+              UML_MODE: 1
+
           - container: "centos:7"
             env:
               CC: gcc
@@ -98,7 +169,7 @@ jobs:
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
-      options: --privileged --device /dev/loop-control
+      options: --privileged --device /dev/loop-control -v /dev/shm:/dev/shm
 
     steps:
     - name: Show OS
@@ -125,8 +196,25 @@ jobs:
             fi
         fi
 
+    - name: Retrieve UML kernel
+      if: ${{ matrix.env.UML_MODE && fromJSON(matrix.env.UML_MODE) == 1 }}
+      uses: actions/cache@v3
+      continue-on-error: false
+      with:
+        path: linux
+        key: linux-${{ needs.build.outputs.LINUX_SHA }}-${{ hashFiles('**/config-uml') }}
+
+    - name: Retrieve signing key
+      if: ${{ matrix.env.UML_MODE && fromJSON(matrix.env.UML_MODE) == 1 }}
+      continue-on-error: false
+      uses: actions/cache@v3
+      with:
+        path: signing_key.pem
+        key: signing_key.pem-${{ needs.build.outputs.LINUX_SHA }}-${{ hashFiles('**/config-uml') }}
+
     - name: Compiler version
       run: $CC --version
 
     - name: Compile
-      run: CC="$CC" VARIANT="$VARIANT" COMPILE_SSL="$COMPILE_SSL" ./build.sh
+      run: |
+        CC="$CC" VARIANT="$VARIANT" COMPILE_SSL="$COMPILE_SSL" UML_MODE="$UML_MODE" ./build.sh
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 2272bbc57fae..e60de7981c60 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -44,7 +44,8 @@ yum -y install \
 	util-linux \
 	vim-common \
 	wget \
-	which
+	which \
+	zstd
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
-- 
2.25.1

