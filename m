Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57257667213
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 13:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjALMZ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 07:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjALMZ1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 07:25:27 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2D116F
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 04:25:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nt3TV5FTkz9xFQJ
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 20:17:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3sg0f_L9jKjyOAA--.25294S2;
        Thu, 12 Jan 2023 13:25:10 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v2 0/9] Support testing with UML kernel
Date:   Thu, 12 Jan 2023 13:24:17 +0100
Message-Id: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3sg0f_L9jKjyOAA--.25294S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW8WFW7Zw18WFyxCw43GFg_yoWrJw4xpa
        yUKa4FkF1kJF9rAwnxGF4Ik34rt3y8ArW5Crn7J34FkF98GFy0yr129FW3XF9ayryF9F4j
        va109F15Kw4DZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4ODFQADsu
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

UML kernels differ from other kernels for the ability of being executed as
processes in the current environment, without requirements such as
virtualization. It is sufficient to execute the binary, like the other
binaries.

In addition, UML kernels have the ability to see the host filesystem and
thus they could for example run an executable from the host as init and
have a fully working system without creating an image, as it would happen
if a regular virtual machine is used.

These features make UML kernels very suitable for integration in existing
test suites designed to perform the tests in the current environment such
as ima-evm-utils. In the current environment, test suites cannot test new
functionality not yet integrated in the host kernel, or with custom kernel
configuration options not usually enabled in production. Also, test suites
might not be able to set/reset kernel settings for security reasons.

With the ability to do kernel testing more in depth, ima-evm-utils might
introduce specific tests for that, separated from the tests to verify the
ima-evm-utils user space functionality. At the moment, there is no such
distinction, existing tests verify both.

The goal of this patch set is to overcome the limitations by making the
test suite in ima-evm-utils able to run in an environment created by the
UML kernel, with minimal changes. At the same time, it will preserve the
ability of the test suite to run in the current environment.

First, fix error messages and a variable in evmctl. Then, add the
config-uml file with custom kernel configuration options for the tests, to
be merged with the default configuration. Add a new job in the Github
workflow to build the UML kernel from a repository and branch specified in
the LINUX_URL and LINUX_BRANCH variables. Per Github documentation, these
variables can be defined at organization, repository and environment level.

Introduce a new API for using UML kernels for existing and new test
scripts. Unless the environment variable UML_MODE is set to 1, calling the
API results in a nop, and tests are executed in the current environment.

Add the possibility to select individual tests to run in a test script,
with the TST_LIST variable, so that the UML kernel can be launched multiple
times with a subset of tests (useful if for example a test require kernel
settings different from the previous test).

Add tests for EVM portable signatures supporting UML kernels and port
fsverity.test to use UML kernels.

Finally, don't require making changes to the system to run fsverity.test
and install a software dependency after the appropriate repository has been
set up.

Mimi Zohar (1):
  ci: haveged requires EPEL on CentOS stream:8

Roberto Sassu (8):
  Fix error messages and mdlen init in calc_evm_hmac()
  Add config for UML kernel
  Compile the UML kernel and download it in Github Actions
  Add support for UML in functions.sh
  Introduce TST_LIST variable to select a test to execute
  Add tests for EVM portable signatures
  Adapt fsverity.test to work with UML kernel
  Use in-place built fsverity binary instead of installing it

 .github/workflows/ci.yml        |   96 ++-
 build.sh                        |    5 +
 ci/fedora.sh                    |   12 +-
 config-uml                      |  235 +++++++
 src/evmctl.c                    |    8 +-
 tests/Makefile.am               |    2 +-
 tests/fsverity.test             |   18 +-
 tests/functions.sh              |   91 ++-
 tests/install-fsverity.sh       |    2 +-
 tests/install-mount-idmapped.sh |    7 +
 tests/portable_signatures.test  | 1173 +++++++++++++++++++++++++++++++
 11 files changed, 1637 insertions(+), 12 deletions(-)
 create mode 100644 config-uml
 create mode 100755 tests/install-mount-idmapped.sh
 create mode 100755 tests/portable_signatures.test

-- 
2.25.1

