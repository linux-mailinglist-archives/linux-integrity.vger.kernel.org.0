Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FEF662BE4
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jan 2023 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjAIQ5R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Jan 2023 11:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjAIQ4v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jan 2023 11:56:51 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB48FC0
        for <linux-integrity@vger.kernel.org>; Mon,  9 Jan 2023 08:56:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NrKf833Pvz9xFGj
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 00:49:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXHWQ9R7xjPQWBAA--.14103S2;
        Mon, 09 Jan 2023 17:56:34 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils 0/8] Support testing with UML kernel
Date:   Mon,  9 Jan 2023 17:55:44 +0100
Message-Id: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCXHWQ9R7xjPQWBAA--.14103S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryrJw18uF15Gr1fCFy3Jwb_yoW8ZF1Upa
        yDKwnY9rykJF9Fvw13Wa1Ik345Kw48Cr15C3ZrXw13uFyDJF1jyr129FW3JF9xZrWvqr15
        Z3WvgF18KanxAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU06VbPUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4dfgAAAsg
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add support for running existing and new tests in an environment created
with an UML kernel. Adapting existing tests requires minimal changes, such
as adding calls to a newly defined API.

The main benefit of using the UML kernel is to run tests in an environment
similar to a virtual machine, without however requiring the host to support
virtualization. The UML kernel runs as a regular process and has visibility
to the host filesystem.

Adapt the Github workflow to build the UML kernel from a chosen repository
and branch, and use it for the tests. In this way, the ima-evm-utils test
suite is self-contained and does not depend on external repositories. In
the future, ima-evm-utils might have separate tests for the user space part
and for the kernel part.

Finally, introduce a new set of tests for EVM portable signatures, adapt
the existing fsverity.test to run with the UML kernel, and optimize
fsverity.test to not require installation of built binaries.

Roberto Sassu (8):
  Fix error messages and mdlen init in calc_evm_hmac()
  Add config for UML kernel
  Compile the UML kernel and download it in Github Actions
  Add support for UML in functions.sh
  Introduce TST_LIST variable to select a test to execute
  Add tests for EVM portable signatures
  Adapt fsverity.test to work with UML kernel
  Use in-place built fsverity binary instead of installing it

 .github/workflows/ci.yml        |   92 ++-
 build.sh                        |    5 +
 ci/fedora.sh                    |   10 +-
 config-uml                      |  235 +++++++
 src/evmctl.c                    |    8 +-
 tests/Makefile.am               |    2 +-
 tests/fsverity.test             |   18 +-
 tests/functions.sh              |   91 ++-
 tests/install-fsverity.sh       |    2 +-
 tests/install-mount-idmapped.sh |    7 +
 tests/portable_signatures.test  | 1173 +++++++++++++++++++++++++++++++
 11 files changed, 1631 insertions(+), 12 deletions(-)
 create mode 100644 config-uml
 create mode 100755 tests/install-mount-idmapped.sh
 create mode 100755 tests/portable_signatures.test

-- 
2.25.1

