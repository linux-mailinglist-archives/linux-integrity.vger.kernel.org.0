Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9087337395B
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 13:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhEELbD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 07:31:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3004 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhEELbB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 07:31:01 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZvVj5bCPz6yj77;
        Wed,  5 May 2021 19:24:13 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 13:30:01 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 00/11] evm: Improve usability of portable signatures
Date:   Wed, 5 May 2021 13:29:24 +0200
Message-ID: <20210505112935.1410679-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

EVM portable signatures are particularly suitable for the protection of
metadata of immutable files where metadata is signed by a software vendor.
They can be used for example in conjunction with an IMA policy that
appraises only executed and memory mapped files.

However, some usability issues are still unsolved, especially when EVM is
used without loading an HMAC key. This patch set attempts to fix the open
issues.

Patch 1 allows EVM to be used without loading an HMAC key. Patch 2 avoids
appraisal verification of public keys (they are already verified by the key
subsystem).

Patches 3-4 allow metadata verification to be turned off when no HMAC key
is loaded and to use this mode in a safe way (by ensuring that IMA
revalidates metadata when there is a change).

Patches 5-8 make portable signatures more usable if metadata verification
is not turned off, by ignoring the INTEGRITY_NOLABEL and INTEGRITY_NOXATTS
errors when possible, by accepting any metadata modification until
signature verification succeeds (useful when xattrs/attrs are copied
sequentially from a source) and by allowing operations that don't change
metadata.

Patch 9 makes it possible to use portable signatures when the IMA policy
requires file signatures and patch 10 shows portable signatures in the
measurement list when the ima-sig template is selected.

Lastly, patch 11 avoids undesired removal of security.ima when a file is
not selected by the IMA policy.

Test:
https://github.com/robertosassu/ima-evm-utils/blob/ima-evm-fixes-v6-devel-v1/tests/portable_signatures.test

Test results:
https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/503096506
https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/503096510


Changelog

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

Roberto Sassu (11):
  evm: Execute evm_inode_init_security() only when an HMAC key is loaded
  evm: Load EVM key in ima_load_x509() to avoid appraisal
  evm: Refuse EVM_ALLOW_METADATA_WRITES only if an HMAC key is loaded
  evm: Introduce evm_status_revalidate()
  evm: Introduce evm_hmac_disabled() to safely ignore verification
    errors
  evm: Allow xattr/attr operations for portable signatures
  evm: Pass user namespace to set/remove xattr hooks
  evm: Allow setxattr() and setattr() for unmodified metadata
  ima: Allow imasig requirement to be satisfied by EVM portable
    signatures
  ima: Introduce template field evmsig and write to field sig as
    fallback
  ima: Don't remove security.ima if file must not be appraised

Roberto Sassu (11):
  evm: Execute evm_inode_init_security() only when an HMAC key is loaded
  evm: Load EVM key in ima_load_x509() to avoid appraisal
  evm: Refuse EVM_ALLOW_METADATA_WRITES only if an HMAC key is loaded
  evm: Introduce evm_status_revalidate()
  evm: Introduce evm_hmac_disabled() to safely ignore verification
    errors
  evm: Allow xattr/attr operations for portable signatures
  evm: Pass user namespace to set/remove xattr hooks
  evm: Allow setxattr() and setattr() for unmodified metadata
  ima: Allow imasig requirement to be satisfied by EVM portable
    signatures
  ima: Introduce template field evmsig and write to field sig as
    fallback
  ima: Don't remove security.ima if file must not be appraised

 Documentation/ABI/testing/evm             |   5 +-
 Documentation/security/IMA-templates.rst  |   4 +-
 include/linux/evm.h                       |  18 +-
 include/linux/integrity.h                 |   1 +
 security/integrity/evm/evm_main.c         | 227 ++++++++++++++++++++--
 security/integrity/evm/evm_secfs.c        |   5 +-
 security/integrity/iint.c                 |   4 +-
 security/integrity/ima/ima_appraise.c     |  43 ++--
 security/integrity/ima/ima_init.c         |   4 +
 security/integrity/ima/ima_template.c     |   2 +
 security/integrity/ima/ima_template_lib.c |  33 +++-
 security/integrity/ima/ima_template_lib.h |   2 +
 security/security.c                       |   4 +-
 13 files changed, 304 insertions(+), 48 deletions(-)

-- 
2.25.1

