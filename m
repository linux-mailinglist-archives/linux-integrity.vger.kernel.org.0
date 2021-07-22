Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561913D2B3B
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhGVQyO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 12:54:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3451 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhGVQyJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 12:54:09 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVzmr1w3Mz6H7N6;
        Fri, 23 Jul 2021 01:23:08 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 19:34:42 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <pvorel@suse.cz>, <vt@altlinux.org>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH ima-evm-utils 0/7] ima-evm-utils: Add UML support and tests for EVM portable signatures
Date:   Thu, 22 Jul 2021 19:34:07 +0200
Message-ID: <20210722173414.1738041-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

During the development of the tests for the 'evm: Improve usability of
portable signatures' patch set, it became clear that a testing environment
available to a regular user was not sufficient. First, because some
operations needs to be executed with the privileges of the root user (for
example, writing to securityfs), which not always is available (for example
in a public testing plaform). Second, because some configuration steps
performed on the kernel cannot be undone.

The first goal of this patch set is to overcome these limitations by
adding support for running tests with a UML (User Mode Linux) kernel. In
this environment, a test script might operate as root with the objects
created in the new environment. It still has the limitations of the user
that launched the UML kernel, if the test script interacts with the rest of
the system.

The second goal of this patch set is to introduce the tests for the 'evm:
Improve usability of portable signatures' patch set.

Patches 1-2 download the UML kernel, its signing key and mount-idmapped (to
perform the tests on an idmapped mount). Patch 3 adds additional options
for the container engine to execute the UML kernel. Patch 4-5 adds the
infrastructure necessary to launch the UML kernel. Patch 6 adds the
possibility of executing tests individually and, lastly, Patch 7 adds the
tests for the 'evm: Improve usability of portable signatures' patch set.

To test this patch set, a new workflow for Github Actions has been defined
in the kernel repository. The patches to introduce it and the UML kernel
configuration are available at:

https://github.com/robertosassu/linux/commit/b3122b23a1e5f3ef5e3f1932204da39974a50257
https://github.com/robertosassu/linux/commit/9ccb667217fd1fdd933a5d6816ba0281a09bf980

Roberto Sassu (7):
  Download UML kernel and signing key
  Download mount-idmapped
  Add additional options to the container engine
  Add functions to the testing library to run a test script with UML
  Signal failures of tests executed by UML kernel with unclean shutdown
  Introduce TST_LIST variable to select a test to execute
  Add tests for EVM portable signatures

 .github/workflows/ci.yml       |   21 +
 .travis.yml                    |   19 +-
 build.sh                       |    1 +
 ci/alpine.sh                   |    8 +-
 ci/alt.sh                      |    1 +
 ci/debian.sh                   |    8 +
 ci/fedora.sh                   |   16 +-
 ci/tumbleweed.sh               |    9 +-
 tests/Makefile.am              |    3 +-
 tests/functions.sh             |   67 ++
 tests/portable_signatures.test | 1157 ++++++++++++++++++++++++++++++++
 11 files changed, 1305 insertions(+), 5 deletions(-)
 create mode 100755 tests/portable_signatures.test

-- 
2.25.1

