Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B97623EF7
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 10:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKJJre (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 04:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiKJJr2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 04:47:28 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BC6AED5;
        Thu, 10 Nov 2022 01:47:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7Gzc2ztzz9v7Gj;
        Thu, 10 Nov 2022 17:40:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHc3CNyGxjO3hSAA--.1123S2;
        Thu, 10 Nov 2022 10:47:03 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 0/5] evm: Prepare for moving to the LSM infrastructure
Date:   Thu, 10 Nov 2022 10:46:34 +0100
Message-Id: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHc3CNyGxjO3hSAA--.1123S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF43ury7ury3Jr48Jw17trb_yoW3Ar1rpF
        WfKF45Krn8AF9rWrWfCan7u3WSgrWrGrWUJa93Gw1UZ3Z8Grn2qr40yr45uas8XrWkJFna
        qw12ywn8urn8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj4FG6gABsX
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

One of the challenges that must be tackled to move IMA and EVM to the LSM
infrastructure is to ensure that EVM is capable to correctly handle
multiple stacked LSMs providing an xattr at file creation. At the moment,
there are few issues that would prevent a correct integration. This patch
set aims at solving them.

From the LSM infrastructure side, the LSM stacking feature added the
possibility of registering multiple implementations of the security hooks,
that are called sequentially whenever someone calls the corresponding
security hook. However, security_inode_init_security() is currently limited
to support one xattr provided by LSM and one by EVM.
security_old_inode_init_security() can only support one xattr due to its
API.

In addition, using the call_int_hook() macro causes some issues. According
to the documentation in include/linux/lsm_hooks.h, it is a legitimate case
that an LSM returns -EOPNOTSUPP when it does not want to provide an xattr.
However, the loop defined in the macro would stop calling subsequent LSMs
if that happens. In the case of security_old_inode_init_security(), using
the macro would also cause a memory leak due to replacing the *value
pointer, if multiple LSMs provide an xattr.

From EVM side, the first operation to be done is to change the definition
of evm_inode_init_security() to be compatible with the security hook
definition. Unfortunately, the current definition does not provide enough
information for EVM, as it must have visibility of all xattrs provided by
LSMs to correctly calculate the HMAC. This patch set changes the security
hook definition by replacing the name, value and len triple with the xattr
array allocated by security_inode_init_security().

Secondly, given that the place where EVM can fill an xattr is not provided
anymore with the changed definition, EVM must know how many elements are in
the xattr array. EVM can rely on the fact that the xattr array must be
terminated with an element with name field set to NULL. If EVM is moved to
the LSM infrastructure, the infrastructure will provide additional
information.

Casey suggested to use the reservation mechanism currently implemented for
other security blobs, for xattrs. In this way,
security_inode_init_security() can know after LSM initialization how many
slots for xattrs should be allocated, and LSMs know the offset in the
array from where they can start writing xattrs.

One of the problem was that LSMs can decide at run-time, although they
reserved a slot, to not use it (for example because they were not
initialized). Given that the initxattrs() method implemented by filesystems
expect that the array elements are contiguous, they would miss the slots
after the one not being initialized. security_check_compact_xattrs() has
been introduced to overcome this problem and also to check the correctness
of the xattrs provided by the LSMs.

This patch set has been tested by introducing several instances of a
TestLSM (some providing an xattr, some not, one with a wrong implementation
to see how the LSM infrastructure handles it, one providing multiple xattrs
and another providing an xattr but in a disabled state). The patch is not
included in this set but it is available here:

https://github.com/robertosassu/linux/commit/e0eed5b271e44ded36b23713f9a5998810954843

The test, added to ima-evm-utils, is available here:

https://github.com/robertosassu/ima-evm-utils/blob/evm-multiple-lsms-v4-devel-v10/tests/evm_multiple_lsms.test

The test takes a UML kernel built by Github Actions and launches it several
times, each time with a different combination of LSMs. After boot, it first
checks that there is an xattr for each LSM providing it, and then calculates
the HMAC in user space and compares it with the HMAC calculated by EVM in
kernel space.

A test report can be obtained here:

https://github.com/robertosassu/ima-evm-utils/actions/runs/3435348442/jobs/5727609718

The patch set has been tested with both the SElinux and Smack test suites.
Below, there is the summary of the test results:

SELinux Test Suite result (without patches):
Files=73, Tests=1346, 225 wallclock secs ( 0.43 usr  0.23 sys +  6.11 cusr 58.70 csys = 65.47 CPU)

SELinux Test Suite result (with patches):
Files=73, Tests=1346, 225 wallclock secs ( 0.44 usr  0.22 sys +  6.15 cusr 59.94 csys = 66.75 CPU)

Smack Test Suite result (without patches):
95 Passed, 0 Failed, 100% Success rate

Smack Test Suite result (with patches):
95 Passed, 0 Failed, 100% Success rate

The patch set has also been successfully tested with a WIP branch where
IMA/EVM have been moved to the LSM infrastructure. It is available here:

https://github.com/robertosassu/linux/commits/ima-evm-lsms-v1-devel-v8

This is the patch that moves EVM to the LSM infrastructure:

https://github.com/robertosassu/linux/commit/08ceb14a2ddfd334cb9d8703a4e1a86ee721b580

The only trivial changes, after this patch set, would be to allocate one
element less in the xattr array (because EVM will reserve its own xattr),
and to simply remove the call to evm_inode_init_security().

The test report when IMA and EVM are moved to the LSM infrastructure is
available here:

https://github.com/robertosassu/ima-evm-utils/actions/runs/3435500712/jobs/5727933607

Changelog

v3:
- Don't free the xattr name in reiserfs_security_free()
- Don't include fs_data parameter in inode_init_security hook
- Don't change evm_inode_init_security(), as it will be removed if EVM is
  stacked
- Fix inode_init_security hook documentation
- Drop lsm_find_xattr_slot(), use simple xattr reservation mechanism and
  introduce security_check_compact_xattrs() to compact the xattr array
- Don't allocate xattr array if LSMs didn't reserve any xattr
- Return zero if initxattrs() is not provided to
  security_inode_init_security(), -EOPNOTSUPP if value is not provided to
  security_old_inode_init_security()
- Request LSMs to fill xattrs if only value (not the triple) is provided to
  security_old_inode_init_security(), to avoid unnecessary memory
  allocation

v2:
- rewrite selinux_old_inode_init_security() to use
  security_inode_init_security()
- add lbs_xattr field to lsm_blob_sizes structure, to give the ability to
  LSMs to reserve slots in the xattr array (suggested by Casey)
- add new parameter base_slot to inode_init_security hook definition

v1:
- add calls to reiserfs_security_free() and initialize sec->value to NULL
  (suggested by Tetsuo and Mimi)
- change definition of inode_init_security hook, replace the name, value
  and len triple with the xattr array (suggested by Casey)
- introduce lsm_find_xattr_slot() helper for LSMs to find an unused slot in
  the passed xattr array

Roberto Sassu (5):
  reiserfs: Add missing calls to reiserfs_security_free()
  security: Rewrite security_old_inode_init_security()
  security: Allow all LSMs to provide xattrs for inode_init_security
    hook
  evm: Align evm_inode_init_security() definition with LSM
    infrastructure
  evm: Support multiple LSMs providing an xattr

 fs/reiserfs/namei.c                 |   4 +
 fs/reiserfs/xattr_security.c        |   2 +-
 include/linux/evm.h                 |  12 +--
 include/linux/lsm_hook_defs.h       |   3 +-
 include/linux/lsm_hooks.h           |  17 ++--
 security/integrity/evm/evm.h        |   2 +
 security/integrity/evm/evm_crypto.c |   9 +-
 security/integrity/evm/evm_main.c   |  28 ++++--
 security/security.c                 | 132 ++++++++++++++++++++++------
 security/selinux/hooks.c            |  19 ++--
 security/smack/smack_lsm.c          |  26 +++---
 11 files changed, 187 insertions(+), 67 deletions(-)

-- 
2.25.1

