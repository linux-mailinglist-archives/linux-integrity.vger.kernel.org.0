Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7E7339D3
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjFPT1Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jun 2023 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjFPT1D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jun 2023 15:27:03 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A5B4233
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jun 2023 12:25:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QjTNH0QNMz9xrpX
        for <linux-integrity@vger.kernel.org>; Sat, 17 Jun 2023 03:13:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAH2F7TtoxksMlFAw--.17356S2;
        Fri, 16 Jun 2023 20:24:09 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 ima-evm-utils 0/4] Simple EVM HMAC calculation tests
Date:   Fri, 16 Jun 2023 21:23:54 +0200
Message-Id: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAH2F7TtoxksMlFAw--.17356S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDXryUJF18Ww1rAFy5Arb_yoW8KF4rp3
        90gw1Ykr4kJF17trWfJF4xJ3y5Aa1IkF45XrZrJr1fCFsxu34ktw1rKr45Wa4Ivrn5tFWj
        v3W7Kr1S93WDArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0IzuJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj47ELQACsb
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add two simple tests to check whether or not the HMAC calculated by the
kernel and evmctl matches. Do one tests with a regular file, using SELinux
or Smack as active LSM (whichever is available, or with both for the UML
kernel) and another test with a directory successfully transmuted with
Smack.

Also add two bug fixes to include the filesystem UUID and the inode
generation in the HMAC calculation, and the new option --hmackey to specify
an alternate location of the HMAC key.

Changelog

v2:
- Set TST_EVM_CHANGE_MODE in Github Action workflow (suggested by Mimi)
- Add SELinux to kernel configuration option for CI
- Parameterize the check_evm_hmac() test with the LSM to test
- Skip the check_evm_hmac() test if the chosen LSM is not active
- Load the existing SELinux policy in the UML kernel environment
- Check EVM support for the additional Smack xattrs only in the
  check_evm_hmac_transmute() test (suggested by Mimi)
- Run the UML kernel twice, once with SELinux enabled and once with Smack
- Clarify in the error message why having at least one LSM active is
  necessary
- Add a justification for the --hmackey option added to evmctl (suggested
  by Mimi)

v1:
- Add documentation for --hmackey option of evmctl (suggested by Mimi)
- Update kernel configuration for CI
- Include inode generation in HMAC calculation for directories
- Specify kernel patches required for the tests (suggested by Mimi)
- Move xattr compare code to compare_xattr()
- Add new Smack-specific test to check HMAC of transmuting directory
  (suggested by Mimi)
- Check in the test that the --hmackey option is available (suggested by
  Mimi)
- Remove i_version mount option (should be default in ext4)
- Mount smackfs if the UML kernel is used

Roberto Sassu (4):
  Include the filesystem UUID in HMAC calculation
  Restore correct HMAC calculation for directories
  Add --hmackey option for evmctl
  Add simple tests to check EVM HMAC calculation

 .github/workflows/ci.yml |   1 +
 README                   |   3 +-
 kernel-configs/base      |   6 +-
 kernel-configs/integrity |   1 +
 src/evmctl.c             |  31 ++++-
 src/imaevm.h             |   1 +
 tests/Makefile.am        |   2 +-
 tests/evm_hmac.test      | 281 +++++++++++++++++++++++++++++++++++++++
 tests/functions.sh       |   6 +
 9 files changed, 326 insertions(+), 6 deletions(-)
 create mode 100755 tests/evm_hmac.test

-- 
2.25.1

