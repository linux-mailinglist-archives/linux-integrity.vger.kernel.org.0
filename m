Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00B67CCFF
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjAZN6r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 08:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjAZN6o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 08:58:44 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11631043B
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 05:58:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P2htM0slTz9v7J4
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 21:50:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB39P_4htJj+ajLAA--.553S2;
        Thu, 26 Jan 2023 14:58:23 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v4 00/11] Support testing in new enviroments
Date:   Thu, 26 Jan 2023 14:57:56 +0100
Message-Id: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB39P_4htJj+ajLAA--.553S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFWfXFWfJFWfGr43Gr13XFb_yoWxAw43pa
        yUW34Yka97JF9Fy397GF4Ikryrtw48Gr15CrykX34rZ3Z8ury0yr129ay3ZF9I9ry0qFy8
        Zw40qrnY9w1DCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4ggawABs-
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

First, fix error messages and a variable in evmctl. Then, add kernel
configuration options for the tests, to be merged with the default
configuration. Add a new job in the Github workflow to build the UML kernel
from a repository and branch specified in the LINUX_URL and LINUX_BRANCH
variables (if the kernel repository does not have a branch with the same
name of the ima-evm-utils one). Per Github documentation, these variables
can be defined at organization, repository and environment level.

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

v3:
 - Split config-uml in multiple parts (suggested by Mimi) and move them to
   kernel-configs/
 - Tune the kernel configuration to avoid building unnecessary drivers for
   kernels to be run in virtual machines
 - Fix style issues in functions.sh (suggested by Stefan)
 - Fix environment shutdown logic
 - Declare variables used inside the tests in
   tests/portable_signatures.test as local (suggested by Stefan)

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
  Add kernel configuration for tests
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
 kernel-configs/base             |  213 ++++++
 kernel-configs/integrity        |   29 +
 src/evmctl.c                    |   14 +-
 tests/Makefile.am               |    2 +-
 tests/boot_aggregate.test       |    2 +-
 tests/fsverity.test             |   14 +-
 tests/functions.sh              |  113 +++-
 tests/install-fsverity.sh       |    3 +-
 tests/install-mount-idmapped.sh |    6 +
 tests/portable_signatures.test  | 1122 +++++++++++++++++++++++++++++++
 13 files changed, 1615 insertions(+), 19 deletions(-)
 create mode 100644 kernel-configs/base
 create mode 100644 kernel-configs/integrity
 create mode 100755 tests/install-mount-idmapped.sh
 create mode 100755 tests/portable_signatures.test

-- 
2.25.1

