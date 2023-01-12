Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC35667218
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjALMZo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 07:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjALMZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 07:25:42 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A9116F
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 04:25:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nt3Tr5QC5z9v7VX
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 20:17:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3sg0f_L9jKjyOAA--.25294S5;
        Thu, 12 Jan 2023 13:25:25 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v2 3/9] Compile the UML kernel and download it in Github Actions
Date:   Thu, 12 Jan 2023 13:24:20 +0100
Message-Id: <20230112122426.3759938-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3sg0f_L9jKjyOAA--.25294S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1fCrW5Xw13JF17Kr17KFg_yoW7Kr47pr
        WYk34Ygr4kJ3W7Aw4qyr18CayYg393Ar13C34xJ34rAF9xXayvvFs2vFy5ZF17ZrWxKF4f
        uFW8WFyDKayxZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4OGlgABsq
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a build job, prerequisite of the existing job, to compile the UML
kernel and upload it and the signing key to a cache. Github configuration
should have two variables: LINUX_URL, the full URL of the kernel
repository; LINUX_BRANCH, the branch to check out as fallback if the kernel
repository does not have the same branch name as the one being pushed for
ima-evm-utils. See:

https://docs.github.com/en/actions/learn-github-actions/variables

for directions on how to define those variables.

If the two variables are not defined, the default values are:

LINUX_URL=https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
LINUX_BRANCH=next-integrity

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
 .github/workflows/ci.yml | 96 +++++++++++++++++++++++++++++++++++++++-
 ci/fedora.sh             |  3 +-
 2 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index d2afdfe15467..930e5e517196 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -3,7 +3,77 @@ name: "distros"
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
+          LINUX_URL=${{ vars.LINUX_URL }}
+          if [ -z "$LINUX_URL" ]; then
+              LINUX_URL=https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
+          fi
+          LINUX_BRANCH=${{ vars.LINUX_BRANCH }}
+          if [ -z "$LINUX_BRANCH" ]; then
+              LINUX_BRANCH=next-integrity
+          fi
+          git remote add origin $LINUX_URL
+          LINUX_SHA=$(git ls-remote origin $GITHUB_REF_NAME | awk '{print $1}')
+          [ -z "$LINUX_SHA" ] && LINUX_SHA=$(git ls-remote origin $LINUX_BRANCH | awk '{print $1}')
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
+          git pull --depth 1 origin ${{ steps.last-commit.outputs.LINUX_SHA }}
+          make ARCH=um olddefconfig
+          ./scripts/kconfig/merge_config.sh -m .config ../config-uml
+          # Update manually, to specify ARCH=um
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
@@ -75,6 +145,12 @@ jobs:
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
@@ -98,7 +174,7 @@ jobs:
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
-      options: --privileged --device /dev/loop-control
+      options: --privileged --device /dev/loop-control -v /dev/shm:/dev/shm
 
     steps:
     - name: Show OS
@@ -125,8 +201,24 @@ jobs:
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
+      run: CC="$CC" VARIANT="$VARIANT" COMPILE_SSL="$COMPILE_SSL" UML_MODE="$UML_MODE" ./build.sh
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

