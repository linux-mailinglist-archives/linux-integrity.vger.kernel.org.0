Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A02F380CE5
	for <lists+linux-integrity@lfdr.de>; Fri, 14 May 2021 17:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhENP3Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 May 2021 11:29:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3068 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhENP3X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 May 2021 11:29:23 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FhXM30KP7z6cw6b;
        Fri, 14 May 2021 23:22:07 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 17:28:08 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 00/12] evm: Improve usability of portable signatures
Date:   Fri, 14 May 2021 17:27:41 +0200
Message-ID: <20210514152753.982958-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

EVM portable signatures are particularly suitable for the protection of
metadata of immutable files where metadata is signed by a software vendor.
They can be used for example in conjunction with an IMA policy that
appraises only executed and memory mapped files.

However, until now portable signatures can be properly installed only if
the EVM_ALLOW_METADATA_WRITES initialization flag is also set, which
disables metadata verification until an HMAC key is loaded. This will cause
metadata writes to be allowed even in the situations where they shouldn't
(metadata protected by a portable signature is immutable).

The main reason why setting the flag is necessary is that the operations
necessary to install portable signatures and protected metadata would be
otherwise denied, despite being legitimate, due to the fact that the
decision logic has to avoid an unsafe recalculation of the HMAC that would
make the unsuccessfully verified metadata valid. However, the decision
logic is too coarse, and does not fully take into account all the possible
situations where metadata operations could be allowed.

For example, if the HMAC key is not loaded and it cannot be loaded in the
future due the EVM_SETUP_COMPLETE flag being set, it wouldn't be a problem
to allow metadata operations, as they wouldn't result in an HMAC being
recalculated.

This patch set extends the decision logic and adds the necessary exceptions
to use portable signatures without turning off metadata verification and
deprecates the EVM_ALLOW_METADATA_WRITES flag.

More in detail, patch 1 allows EVM to be used without loading an HMAC key.
Patch 2 avoids appraisal verification of public keys (they are already
verified by the key subsystem).

Patches 3-4 still allow to turn off metadata verification but in a safe way
(by ensuring that IMA revalidates metadata when there is a change).

Patches 5-8 extend the decision logic to keep the metadata verification on,
by ignoring the INTEGRITY_NOLABEL and INTEGRITY_NOXATTS errors when
possible, by accepting any metadata modification until signature
verification succeeds (useful when xattrs/attrs are copied sequentially
from a source) and afterwards by only allowing operations that don't change
metadata.

Patch 9 deprecates the EVM_ALLOW_METADATA_WRITES flag after the decision
logic has been extended with the above exceptions.

Patch 10 makes it possible to use portable signatures when the IMA policy
requires file signatures and patch 11 shows portable signatures in the
measurement list when the ima-sig template is selected.

Lastly, patch 12 avoids undesired removal of security.ima when a file is
not selected by the IMA policy.

Test:
https://github.com/robertosassu/ima-evm-utils/blob/ima-evm-fixes-v7-devel-v3/tests/portable_signatures.test

Test results:
https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/505367559
https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/505367563


Changelog

v6:
- update documentation to deprecate EVM_ALLOW_METADATA_WRITES and to
  clarify how <securityfs>/evm should be used (suggested by Mimi)
- rename evm_status_revalidate() to evm_revalidate_status() (suggested by
  Mimi)
- revalidate status also when security.evm is modified (suggested by Mimi)

v5:
- remove IMA xattr post hooks and call evm_revalidate() from pre hooks
  (suggested by Mimi)
- rename evm_ignore_error_safe() to evm_hmac_disabled() and check the errors
  inline (suggested by Mimi)
- improve readability of error handling in evm_verify_hmac() (suggested by Mimi)
- don't show an error message if the EVM status is INTEGRITY_PASS_IMMUTABLE
  (suggested by Mimi)
- check if CONFIG_FS_POSIX_ACL is defined in evm_xattr_acl_change() (reported
  by kernel test robot)
- fix return value of evm_xattr_change() (suggested by Christian Brauner)
- simplify EVM_ALLOW_METADATA_WRITES check in evm_write_key() (suggested by
  Mimi)

v4:
- add patch to pass mnt_userns to EVM inode set/remove xattr hooks
  (suggested by Christian Brauner)
- pass mnt_userns to posix_acl_update_mode()
- use IS_ERR_OR_NULL() in evm_xattr_acl_change() (suggested by Mimi)

v3:
- introduce evm_ignore_error_safe() to correctly ignore INTEGRITY_NOLABEL
  and INTEGRITY_NOXATTRS errors
- fix an error in evm_xattr_acl_change()
- replace #ifndef with !IS_ENABLED() in integrity_load_keys()
- reintroduce ima_inode_removexattr()
- adapt patches to apply on top of the idmapped mounts patch set

v2:
- replace EVM_RESET_STATUS flag with evm_status_revalidate()
- introduce IMA post hooks ima_inode_post_setxattr() and
  ima_inode_post_removexattr()
- remove ima_inode_removexattr()
- ignore INTEGRITY_NOLABEL error if the HMAC key is not loaded

v1:
- introduce EVM_RESET_STATUS integrity flag instead of clearing IMA flag
- introduce new template field evmsig
- add description of evm_xattr_acl_change() and evm_xattr_change()

Roberto Sassu (12):
  evm: Execute evm_inode_init_security() only when an HMAC key is loaded
  evm: Load EVM key in ima_load_x509() to avoid appraisal
  evm: Refuse EVM_ALLOW_METADATA_WRITES only if an HMAC key is loaded
  evm: Introduce evm_revalidate_status()
  evm: Introduce evm_hmac_disabled() to safely ignore verification
    errors
  evm: Allow xattr/attr operations for portable signatures
  evm: Pass user namespace to set/remove xattr hooks
  evm: Allow setxattr() and setattr() for unmodified metadata
  evm: Deprecate EVM_ALLOW_METADATA_WRITES
  ima: Allow imasig requirement to be satisfied by EVM portable
    signatures
  ima: Introduce template field evmsig and write to field sig as
    fallback
  ima: Don't remove security.ima if file must not be appraised

 Documentation/ABI/testing/evm             |  36 +++-
 Documentation/security/IMA-templates.rst  |   4 +-
 include/linux/evm.h                       |  18 +-
 include/linux/integrity.h                 |   1 +
 security/integrity/evm/evm_main.c         | 245 ++++++++++++++++++++--
 security/integrity/evm/evm_secfs.c        |   8 +-
 security/integrity/iint.c                 |   4 +-
 security/integrity/ima/ima_appraise.c     |  43 ++--
 security/integrity/ima/ima_init.c         |   4 +
 security/integrity/ima/ima_template.c     |   2 +
 security/integrity/ima/ima_template_lib.c |  33 ++-
 security/integrity/ima/ima_template_lib.h |   2 +
 security/security.c                       |   4 +-
 13 files changed, 353 insertions(+), 51 deletions(-)

-- 
2.25.1

