Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0325D4D4
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIDJ1W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 05:27:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728205AbgIDJ1V (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 05:27:21 -0400
Received: from lhreml740-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id EC5356981EE86CB54334;
        Fri,  4 Sep 2020 10:27:19 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml740-chm.china.huawei.com (10.201.108.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 4 Sep 2020 10:27:19 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 4 Sep 2020 11:27:18 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 00/12] IMA/EVM fixes
Date:   Fri, 4 Sep 2020 11:23:27 +0200
Message-ID: <20200904092339.19598-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set includes various fixes for IMA and EVM.

Patches 1-3 are trivial fixes. The remaining improve support and usability
of EVM portable signatures. In particular patch 4 allows EVM to be used
without an HMAC key. Patch 5 avoids appraisal verification of public keys
(they are already verified by the key subsystem).

Patches 6-7 allow metadata verification to be turned off when the HMAC key
is not already loaded and to use this mode in a safe way (by ensuring that
IMA revalidates metadata when there is a change).

Patches 8-9 make portable signatures more usable if metadata verification
cannot be turned off (because the HMAC key is loaded) by accepting any
metadata modification until signature verification succeeds (useful when
xattrs/attrs are copied in a sequence from a source) and by allowing
operations that don't change metadata.

Patch 10 makes it possible to use portable signatures when the IMA policy
requires file signatures and patch 11 shows portable signatures when the
ima-sig measurement list template is selected.

Lastly, patch 12 avoids undesired removal of security.ima when a file is
not selected by the IMA policy.

Roberto Sassu (12):
  ima: Don't ignore errors from crypto_shash_update()
  ima: Remove semicolon at the end of ima_get_binary_runtime_size()
  evm: Check size of security.evm before using it
  evm: Execute evm_inode_init_security() only when the HMAC key is
    loaded
  evm: Load EVM key in ima_load_x509() to avoid appraisal
  evm: Refuse EVM_ALLOW_METADATA_WRITES only if the HMAC key is loaded
  evm: Introduce EVM_RESET_STATUS atomic flag
  evm: Allow xattr/attr operations for portable signatures if check
    fails
  evm: Allow setxattr() and setattr() if metadata digest won't change
  ima: Allow imasig requirement to be satisfied by EVM portable
    signatures
  ima: Introduce template field evmsig and write to field sig as
    fallback
  ima: Don't remove security.ima if file must not be appraised

 Documentation/ABI/testing/evm             |   6 +-
 Documentation/security/IMA-templates.rst  |   4 +-
 include/linux/integrity.h                 |   1 +
 security/integrity/evm/evm_main.c         | 151 ++++++++++++++++++++--
 security/integrity/evm/evm_secfs.c        |   2 +-
 security/integrity/iint.c                 |   2 +
 security/integrity/ima/ima_appraise.c     |  26 ++--
 security/integrity/ima/ima_crypto.c       |   2 +
 security/integrity/ima/ima_init.c         |   4 +
 security/integrity/ima/ima_main.c         |   8 +-
 security/integrity/ima/ima_queue.c        |   2 +-
 security/integrity/ima/ima_template.c     |   2 +
 security/integrity/ima/ima_template_lib.c |  39 +++++-
 security/integrity/ima/ima_template_lib.h |   2 +
 security/integrity/integrity.h            |   1 +
 15 files changed, 225 insertions(+), 27 deletions(-)

-- 
2.27.GIT

