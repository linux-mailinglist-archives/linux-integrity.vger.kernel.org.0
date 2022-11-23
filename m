Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CA635896
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiKWKBN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 05:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiKWKAf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 05:00:35 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBF815801;
        Wed, 23 Nov 2022 01:52:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NHGTZ5Zttz9v7gP;
        Wed, 23 Nov 2022 17:45:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAH829J7X1jzDqKAA--.13162S2;
        Wed, 23 Nov 2022 10:52:21 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 0/6] evm: Prepare for moving to the LSM infrastructure
Date:   Wed, 23 Nov 2022 10:51:56 +0100
Message-Id: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAH829J7X1jzDqKAA--.13162S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF43ury7ury3Jr48Jw17trb_yoWfuF18pF
        WagF15Krn8AF9rWrWfAa1xu3WSgrWrCrW7J393GryUZ3Z8Gr1Iqr40yr15uas8XrZ5JF92
        qw42yw13urn8A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
        xVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4HGPQAEsM
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
to support one xattr provided by LSM and one by EVM. It is ready to support
multiple xattrs, as it can call the initxattrs() callback provided by
filesystems. security_old_inode_init_security() can only support one xattr
due to its API.

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
after the one not being initialized. security_check_compact_filled_xattrs()
has been introduced to overcome this problem and also to check the
correctness of the xattrs provided by the LSMs.

Filesystems calling security_inode_init_security() are already able to set
multiple xattrs. Those which were using security_old_inode_init_security(),
ocfs2 and reiserfs, were converted to using security_inode_init_security()
and security_old_inode_init_security() was removed. However, they are still
limited to setting only one xattr despite more are available, as their code
is not ready to set multiple xattrs at inode creation time. Support for it
can be added by those filesystems later.

This patch set has been tested by introducing several instances of a
TestLSM (some providing an xattr, some not, one with a wrong implementation
to see how the LSM infrastructure handles it, one providing multiple xattrs
and another providing an xattr but in a disabled state). The patch is not
included in this set but it is available here:

https://github.com/robertosassu/linux/commit/e13a03236df0c399dccb73df5fe4cfceb4bb1d89

The test, added to ima-evm-utils, is available here:

https://github.com/robertosassu/ima-evm-utils/blob/evm-multiple-lsms-v5-devel-v3/tests/evm_multiple_lsms.test

The test takes a UML kernel built by Github Actions and launches it several
times, each time with a different combination of LSMs and filesystems (ext4,
reiserfs, ocfs2). After boot, it first checks that there is an xattr for each
LSM providing it (for reiserfs and ocfs2 just the first LSM), and then (for
ext4) calculates the HMAC in user space and compares it with the HMAC
calculated by EVM in kernel space.

A test report can be obtained here:

https://github.com/robertosassu/ima-evm-utils/actions/runs/3525619568/jobs/5912560168

The patch set has been tested with both the SElinux and Smack test suites.
Below, there is the summary of the test results:

SELinux Test Suite result (without patches):
Files=73, Tests=1346, 225 wallclock secs ( 0.43 usr  0.23 sys +  6.11 cusr 58.70 csys = 65.47 CPU)
Result: FAIL
Failed 4/73 test programs. 13/1346 subtests failed.

SELinux Test Suite result (with patches):
Files=73, Tests=1346, 225 wallclock secs ( 0.44 usr  0.22 sys +  6.15 cusr 59.94 csys = 66.75 CPU)
Result: FAIL
Failed 4/73 test programs. 13/1346 subtests failed.

Smack Test Suite result (without patches):
95 Passed, 0 Failed, 100% Success rate

Smack Test Suite result (with patches):
95 Passed, 0 Failed, 100% Success rate

The patch set has also been successfully tested with a WIP branch where
IMA/EVM have been moved to the LSM infrastructure. It is available here:

https://github.com/robertosassu/linux/commits/ima-evm-lsms-v1-devel-v9-test

This is the patch that moves EVM to the LSM infrastructure:

https://github.com/robertosassu/linux/commit/a1e0682ef75cc8087327e6f446f586c02dd87c60

The only trivial changes, after this patch set, would be to allocate one
element less in the xattr array (because EVM will reserve its own xattr),
and to simply remove the call to evm_inode_init_security().

The test report when IMA and EVM are moved to the LSM infrastructure is
available here:

https://github.com/robertosassu/ima-evm-utils/actions/runs/3525750217/jobs/5912853636

Changelog

v4:
- Remove patch to call reiserfs_security_free(), already queued
- Switch ocfs2 and reiserfs to security_inode_init_security() (suggested by
  Mimi)
- Remove security_old_inode_init_security() (suggested by Paul)
- Rename security_check_compact_xattrs() to
  security_check_compact_filled_xattrs() and add function description
  (suggested by Mimi)
- Rename checked_xattrs parameter of security_check_compact_filled_xattrs()
  to num_filled_xattrs (suggested by Mimi)
- Rename cur_xattrs variable in security_inode_init_security() to
  num_filled_xattrs (suggested by Mimi)

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

Roberto Sassu (6):
  reiserfs: Switch to security_inode_init_security()
  ocfs2: Switch to security_inode_init_security()
  security: Remove security_old_inode_init_security()
  security: Allow all LSMs to provide xattrs for inode_init_security
    hook
  evm: Align evm_inode_init_security() definition with LSM
    infrastructure
  evm: Support multiple LSMs providing an xattr

 fs/ocfs2/namei.c                    |  18 ++---
 fs/ocfs2/xattr.c                    |  30 +++++++-
 fs/reiserfs/xattr_security.c        |  23 ++++--
 include/linux/evm.h                 |  12 +--
 include/linux/lsm_hook_defs.h       |   3 +-
 include/linux/lsm_hooks.h           |  17 ++--
 include/linux/security.h            |  12 ---
 security/integrity/evm/evm.h        |   2 +
 security/integrity/evm/evm_crypto.c |   9 ++-
 security/integrity/evm/evm_main.c   |  28 +++++--
 security/security.c                 | 115 +++++++++++++++++++++-------
 security/selinux/hooks.c            |  19 +++--
 security/smack/smack_lsm.c          |  26 ++++---
 13 files changed, 213 insertions(+), 101 deletions(-)

-- 
2.25.1

