Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001F6722D18
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjFEQ4i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 12:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFEQ4h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 12:56:37 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBDE6
        for <linux-integrity@vger.kernel.org>; Mon,  5 Jun 2023 09:56:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QZfcy37TJz9ypbn
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 00:46:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDXU_+pE35kXiQSAw--.3839S2;
        Mon, 05 Jun 2023 17:56:16 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 ima-evm-utils 0/4] Simple EVM HMAC calculation tests
Date:   Mon,  5 Jun 2023 18:55:50 +0200
Message-Id: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDXU_+pE35kXiQSAw--.3839S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDXr4kZrW3KFW7Jw15CFg_yoW8XFWxp3
        yvgwnak34kAF1fK34fJa1xG343Aa1IkF45Xr97Xr13CFsxG3WUtr1fKr45ua4Iqr1vqrWU
        Zw1UKr1S93WDAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj4467QAAs+
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add two simple tests to check whether or not the HMAC calculated by the
kernel and evmctl matches. Do the tests for a regular file, and for a
directory successfully transmuted with Smack.

Also add two bug fixes to include the filesystem UUID and the inode
generation in the HMAC calculation, and the new option --hmackey to specify
an alternate location of the HMAC key.

Changelog

v1:
- Add documentation for --hmackey option of evmctl (suggested by Mimi)
- Update kernel configuration for CI
- Include inode generation in HMAC calculation for directories
- Specify kernel patches required for the tests (suggested by Mimi)
- Move xattr compare code to compare_xattr()
- Add new Smack-specific test to check HMAC of transmuting directory
  (suggested by Mimi)
- Check in the test that the --hmackey option is available (suggested by
  Mimi)
- Remove i_version mount option (should be default in ext4)
- Mount smackfs if the UML kernel is used

Roberto Sassu (4):
  Include the filesystem UUID in HMAC calculation
  Restore correct HMAC calculation for directories
  Add --hmackey option for evmctl
  Add simple test to check EVM HMAC calculation

 README                   |   3 +-
 kernel-configs/base      |   4 +-
 kernel-configs/integrity |   1 +
 src/evmctl.c             |  31 ++++-
 src/imaevm.h             |   1 +
 tests/Makefile.am        |   2 +-
 tests/evm_hmac.test      | 251 +++++++++++++++++++++++++++++++++++++++
 tests/functions.sh       |   6 +
 8 files changed, 293 insertions(+), 6 deletions(-)
 create mode 100755 tests/evm_hmac.test

-- 
2.25.1

