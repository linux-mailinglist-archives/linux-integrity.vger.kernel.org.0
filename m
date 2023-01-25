Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9967ACCE
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 09:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjAYIvn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 03:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYIvn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 03:51:43 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ABA116
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 00:51:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P1y6b4dv5z9xHvP
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 16:43:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3fQmG7dBjf2fGAA--.15976S2;
        Wed, 25 Jan 2023 09:51:25 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v3 00/11] Support testing in new enviroments
Date:   Wed, 25 Jan 2023 09:50:19 +0100
Message-Id: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fQmG7dBjf2fGAA--.15976S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFWfXFWfJFWfGr43Gr13XFb_yoWxJw13pa
        yUWw1Fka97JF9Fy3s7Gr4xKryFqw48Gr15CrykX34rZ3Z8uFy0yF129ay3ZF9xuFy0qry8
        Za10qr95Wwn8CaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj4QNvwAAsJ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

One of the main limitations of running tests in the current environment is
that features/bug fixes to be tested need to be already included in the
running kernel, which is not always the case.

User Mode Linux (UML) and virtual machines can be used to overcome this
limitation. They allow to create a new environment and run a custom kernel
built by a CI or by the user. The tests can then check the features/bug
fixes of the custom kernel.

Running tests in a new environment also gives the ability to control the
configuration, and to have a clean state for each test by creating new
environments as necessary. The current environment might not allow that,
e.g. for security reasons.

Introduce a mechanism for creating and managing new environments. Expose an
API that allow to transparently create one or multiple environments in a
test script, and to reexecute that script in the new one. Using that API
requires minimal changes to the existing scripts.

The API is generic enough to support different types of enviroments. The
environment can be selected with the TST_ENV environment variable. At the
moment, only UML is supported. QEMU will be added at a later stage.

With the ability to test custom kernels, ima-evm-utils might introduce
specific tests for that, separated from the tests to verify the
ima-evm-utils user space functionality. At the moment, there is no such
distinction, existing tests verify both.

First, fix error messages and a variable in evmctl. Then, add the
config-uml file with custom kernel configuration options for the tests, to
be merged with the default configuration. Add a new job in the Github
workflow to build the UML kernel from a repository and branch specified in
the LINUX_URL and LINUX_BRANCH variables (if the kernel repository does not
have a branch with the same name of the ima-evm-utils one). Per Github
documentation, these variables can be defined at organization, repository
and environment level.

Return the correct script exit code if no test was executed. Introduce the
new API for creating and managing new enviroments, for existing and new
test scripts. If TST_ENV is not set, calling the API results in a nop, and
tests are executed in the current environment.

Add the possibility to select individual tests to run in a test script,
with the TST_LIST variable, so that a new environment can be created
multiple times for a subset of tests (useful if for example a test require
kernel settings different from the previous test).

Add tests for EVM portable signatures and modify fsverity.test to use the
new API.

Finally, don't require making changes to the system to run fsverity.test,
install a software dependency after the appropriate repository has been
set up, and temporarily remove CONFIG_DEBUG_SG to avoid a kernel panic
until the patches to fix it are accepted in the upstream kernel.

Changelog

v2:
 - Compile everything built-in for the UML kernel in Github Actions
 - Replace UML_MODE with TST_ENV, introduce TST_KERNEL to specify the path
   of the kernel to run
 - Temporarily disable CONFIG_DEBUG_SG (patch by Mimi)
 - Rename mdlen and hash variable respectively to siglen and sig (suggested
   by Stefan)
 - Always use _report_exit_and_cleanup() as trap function and pass the
   cleanup function as argument
 - Rename _run_user_mode(), _exit_user_mode(), _init_user_mode(),
   _cleanup_user_mode() respectively to _run_env(), _exit_env(),
   _init_env() and _cleanup_env()
 - Fix style issues in tests/functions.sh and
   tests/portable_signatures.test (suggested by Stefan)
 - Get the script exit code in _report_exit_and_cleanup() and return that
   if no test was executed
 - Mount tmpfs in the new environment, to avoid interference with the host
 - Don't delete fsverity-utils and mount-idmapped directories so that the
   built binaries are available for use without installing them (suggested
   by Stefan)
 - Rename global variables in tests/portable_signatures.test to avoid
   collisions (suggested by Stefan)
 - Declare the 'format' variable as local in get_xattr() in
   tests/portable_signatures.test (suggested by Stefan)
 - Print a message in tests/portable_signatures.test when the
   mount-idmapped binary is found
 - Check more paths for the private key in tests/portable_signatures.test
   (suggested by Mimi)
 - Increase the memory allocation for the UML kernel to 2048M to satisfy
   requests to mount tmpfs

v1:
 - Use Github vars context instead of secrets (suggested by Mimi)
 - Define default values of LINUX_URL and LINUX_BRANCH in case they are not
   provided (suggested by Mimi)
 - Pull source code with depth 1 instead of 5, as it is not necessary now
 - Run 'make ARCH=um olddefconfig' before merging test-specific options in
   config-uml
 - Install haveged for CentOS 8 after the EPEL repository is configured
   (patch by Mimi)

Mimi Zohar (2):
  ci: haveged requires EPEL on CentOS stream:8
  Temporarily remove CONFIG_DEBUG_SG to test portable signatures

Roberto Sassu (9):
  Fix error messages and vars in calc_evm_hmac()
  Add config for UML kernel
  Compile the UML kernel and download it in Github Actions
  Pass cleanup function and its arguments to _report_exit_and_cleanup()
  Add support for creating a new testing environment in functions.sh
  Introduce TST_LIST variable to select a test to execute
  Add tests for EVM portable signatures
  Adapt fsverity.test to be able to run in a new testing environment
  Use in-place built fsverity binary instead of installing it

 .github/workflows/ci.yml        |   99 ++-
 build.sh                        |    5 +
 ci/fedora.sh                    |   12 +-
 config-uml                      |  234 +++++++
 src/evmctl.c                    |   14 +-
 tests/Makefile.am               |    2 +-
 tests/boot_aggregate.test       |    2 +-
 tests/fsverity.test             |   14 +-
 tests/functions.sh              |  105 ++-
 tests/install-fsverity.sh       |    3 +-
 tests/install-mount-idmapped.sh |    6 +
 tests/portable_signatures.test  | 1088 +++++++++++++++++++++++++++++++
 12 files changed, 1565 insertions(+), 19 deletions(-)
 create mode 100644 config-uml
 create mode 100755 tests/install-mount-idmapped.sh
 create mode 100755 tests/portable_signatures.test

-- 
2.25.1

