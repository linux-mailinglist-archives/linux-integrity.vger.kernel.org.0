Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0B41D925
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350556AbhI3L53 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 07:57:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3894 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350526AbhI3L53 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 07:57:29 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKs7m4b6Pz67Vmm;
        Thu, 30 Sep 2021 19:53:08 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 13:55:44 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 0/7] ima: Measure and appraise files with DIGLIM
Date:   Thu, 30 Sep 2021 13:55:26 +0200
Message-ID: <20210930115533.878169-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'm posting this patch set, although the dependencies are not yet accepted,
to provide a more complete picture about DIGLIM and how it can be
concretely used.

This patch set depends on:
- new execution policies in IMA
  (https://lore.kernel.org/linux-integrity/20210409114313.4073-1-roberto.sassu@huawei.com/)
- support for the euid policy keyword for critical data
  (https://lore.kernel.org/linux-integrity/20210705115650.3373599-1-roberto.sassu@huawei.com/)
- DIGLIM basic features
  (https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/)
- DIGLIM advanced features
  (https://lore.kernel.org/linux-integrity/20210915163145.1046505-1-roberto.sassu@huawei.com/)

The patch sets 'integrity: Introduce DIGLIM' and 'integrity: Introduce
DIGLIM advanced features' introduced the possibility to build a repository
of reference values for files shipped with Linux distributions.

Currently those reference values can be loaded from a file in the compact
format, supported by the kernel, or from RPM headers. With future patch
sets, which will add support for PGP appended signatures, it will also be
possible to appraise untouched RPM headers with IMA.

The objective of this patch set is to introduce an alternative method for
performing measurements and appraisal with IMA, that overcome some
important limitations of the currently supported methods. For example,
for measurement, it is very hard to obtain a stable PCR that can be use
for sealing of TPM keys or data. For appraisal, Linux distributions vendors
have to change their building systems to include file signatures in the
packages.

The alternative method introduced with this patch set consists in skipping
the measurement and/or in granting access, when appraisal is in enforcing
mode, if the file or metadata digest has been found in the DIGLIM hash
table. A discussion about this approach can be found in the Benefits
section at:

https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/

The structure of this patch set is as follows.

Patches 1-3 introduce the 'use_diglim' keyword to select the alternative
method for measurement and appraisal and two new hardcoded policies to
measure and appraise DIGLIM-related files, and to enable usage of DIGLIM
for the other selected policy rules.

Patches 4-5 query respectively the file and metadata digest in DIGLIM.
DIGLIM returns whether the digest lists containing the passed digest have
been measured and appraised (requirement to select the alternative method),
and whether the file or metadata are immutable. In a future extension, a
new modifier will be introduced to tell IMA that the digest belongs to a
deny list instead of an allow list, so that IMA can act accordingly.

Patches 5-6 introduce the alternative method for measurement and appraisal.
If at least one digest list containing the calculated file or metadata
digest have been measured, IMA behaves as it performed a measurement. If at
least one digest list containing the calculated metadata digest has been
appraised, metadata verification is successful (required only when EVM is
enabled). If the same condition is verified for the calculated file or
metadata digest, file content verification is successful and the file is
marked as immutable if the digest lists have the corresponding modifier set
in the header.

It is important to remark that unless 'use_diglim' is set in the IMA
policy, DIGLIM is completely ignored and IMA behaves as before. In
addition, even if DIGLIM usage is enabled, other appraisal verification
methods with the xattr or the appended signature take precedence.

Roberto Sassu (7):
  integrity: Change type of IMA rule-related flags to u64
  ima: Introduce new policy keyword use_diglim
  ima: Introduce diglim and appraise_diglim policies
  ima: Query file digest and retrieve info from its digest lists
  ima: Query metadata digest and retrieve info from its digest lists
  ima: Skip measurement of files found in DIGLIM hash table
  ima: Add support for appraisal with digest lists

 Documentation/ABI/testing/ima_policy          |   4 +-
 .../admin-guide/kernel-parameters.txt         |  19 ++-
 include/linux/evm.h                           |  14 ++
 security/integrity/evm/evm_main.c             |  40 +++++
 security/integrity/ima/ima.h                  |   9 +-
 security/integrity/ima/ima_api.c              |   2 +-
 security/integrity/ima/ima_appraise.c         |  37 ++++-
 security/integrity/ima/ima_main.c             |  84 +++++++++-
 security/integrity/ima/ima_policy.c           | 144 +++++++++++++++++-
 security/integrity/integrity.h                |  62 ++++----
 10 files changed, 365 insertions(+), 50 deletions(-)

-- 
2.32.0

