Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A5D38A05F
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 10:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhETI6x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 04:58:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3087 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhETI6s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 04:58:48 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fm3LP4CsTz6wjc7;
        Thu, 20 May 2021 16:48:45 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:57:20 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 0/7] ima: Add template fields to verify EVM portable signatures
Date:   Thu, 20 May 2021 10:56:54 +0200
Message-ID: <20210520085701.465369-1-roberto.sassu@huawei.com>
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

The recent patch set 'evm: Improve usability of portable signatures' added
the possibility to include EVM portable signatures in the IMA measurement
list.

However, the information necessary to verify the signature were not
included in the IMA measurement list. This patch set introduces new
template fields to accomplish this goal:

- 'iuid': the inode UID;
- 'igid': the inode GID;
- 'mntuidmap': the UID mappings of the idmapped mount (nr extents,
  [ uid_gid_extent1 ] ... [ uid_gid_extentN ], all u32 in canonical
  format);
- 'mntgidmap': the GID mappings of the idmapped mount (same format as
  'mntuidmap');
- 'imode': the inode mode;
- 'evmxattrs': the EVM protected xattrs (num xattrs (u32 in canonical
   format), xattr names separated by \0, xattr lengths (u32 in canonical
   format) and xattr values).

mntuidmap and mntgidmap are not empty only if the measurement is performed
on an idmapped mount. In that case, the inode UID and GID need to be
converted with the provided mappings.

Patches 1-4, 6 introduce new template fields. Patch 5 make it possible to
verify EVM portable signatures which protect xattrs belonging to LSMs not
enabled in the target platform. Patch 7 fixes a small issue in
evm_write_xattrs() when audit is not enabled.

This patch set has been tested with:

https://github.com/robertosassu/ima-evm-utils/blob/ima-template-fields-v1-devel-v1/tests/verify_evmsig.test
https://github.com/robertosassu/ima-evm-utils/blob/ima-template-fields-v1-devel-v1/tests/evm_hmac_non_enabled_xattrs.test

The first test sets the IMA template format to:

d-ng|n-ng|sig|evmxattrs|iuid|igid|imode|mntuidmap|mntgidmap

Then, it creates a test file, sets some metadata and reads the file to
generate a measurement entry. To verify that the information provided by
IMA are correct, the test creates another file and sets the metadata
obtained from the measurement list. Finally, it executes evmctl to verify
the signature on the second file.

The test is performed without and with an idmapped mount. evmctl has been
extended to parse mntuidmap and mntgidmap (only one mapping), so that it
can convert the mapped UID and GID from the measurement list to the
original ones. In this way, the signature can be verified.

The second test verifies that setting a non-enabled xattr does not change
the HMAC.

The test results are available at:

https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/506431933
https://travis-ci.com/github/robertosassu/ima-evm-utils/jobs/506431937

This patch set has been also tested on s390x, with and without the
canonical format enabled (the test results are not shown, as the UML kernel
used in Travis is not available for this architecture).

Roberto Sassu (7):
  ima: Add ima_show_template_uint() template library function
  ima: Introduce template fields iuid and igid
  ima: Introduce template fields mntuidmap and mntgidmap
  ima: Introduce template field imode
  evm: Verify portable signatures against all protected xattrs
  ima: Introduce template field evmxattrs
  evm: Don't return an error in evm_write_xattrs() if audit is not
    enabled

 Documentation/security/IMA-templates.rst  |  10 +
 include/linux/evm.h                       |   6 +
 security/integrity/evm/evm.h              |   1 +
 security/integrity/evm/evm_crypto.c       |   7 +
 security/integrity/evm/evm_main.c         |  56 +++-
 security/integrity/evm/evm_secfs.c        |  18 +-
 security/integrity/ima/ima_template.c     |  14 +
 security/integrity/ima/ima_template_lib.c | 322 +++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  14 +
 9 files changed, 434 insertions(+), 14 deletions(-)

-- 
2.25.1

