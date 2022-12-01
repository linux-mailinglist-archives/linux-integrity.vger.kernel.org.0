Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9363ED31
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Dec 2022 11:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiLAKHF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Dec 2022 05:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLAKHB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Dec 2022 05:07:01 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045412F67F;
        Thu,  1 Dec 2022 02:06:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NNBQ11lDXz9xFVM;
        Thu,  1 Dec 2022 17:59:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnkm+tfIhjWgGvAA--.50191S2;
        Thu, 01 Dec 2022 11:06:44 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/2] ima/evm: Ensure digest to verify is in linear mapping area
Date:   Thu,  1 Dec 2022 11:06:23 +0100
Message-Id: <20221201100625.916781-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCnkm+tfIhjWgGvAA--.50191S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1DGrW3CF15CFyUJw4fXwb_yoW8tw4DpF
        4vgas09F1ktryIkw43Cr47u3yYqw4rKF47Ww17tw1UZFn8Xr4vy340ya1fXrW5K34xJFWf
        tF97Kr13Wr1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6r
        WUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4IjIgACs7
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

As sg_set_buf() requires the buffer for a crypto operation to be in the
linear mapping area, so that it is always in adjacent pages, ensure that
this requirement is met for IMA/EVM.

Currently, evm_verify_hmac() and xattr_verify() put the evm_digest and
ima_max_digest_data structures in the stack. As normally the stack is in
the linear mapping area, passing them to sg_set_buf() would not be a
problem.

However, if CONFIG_VMAP_STACK is enabled, these structures will reside in
the vmalloc area instead. If CONFIG_DEBUG_SG is enabled, the kernel will
panic:

[  467.077359] kernel BUG at include/linux/scatterlist.h:163!
[  467.077939] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI

[...]

[  467.095225] Call Trace:
[  467.096088]  <TASK>
[  467.096928]  ? rcu_read_lock_held_common+0xe/0x50
[  467.097569]  ? rcu_read_lock_sched_held+0x13/0x70
[  467.098123]  ? trace_hardirqs_on+0x2c/0xd0
[  467.098647]  ? public_key_verify_signature+0x470/0x470
[  467.099237]  asymmetric_verify+0x14c/0x300
[  467.099869]  evm_verify_hmac+0x245/0x360
[  467.100391]  evm_inode_setattr+0x43/0x190

To overcome this problem, dynamically allocate the structures with
kmalloc() if CONFIG_VMAP_STACK is enabled, so that they are placed in the
linear mapping area, and use them instead of the in-stack counterparts.

A test report is available here:

https://github.com/robertosassu/ima-evm-utils/actions/runs/3590837109/jobs/6045608579

which contains the following test (include tests for EVM portable
signatures and IMA verity signatures):

https://github.com/robertosassu/ima-evm-utils/commit/41cf11d299e9fc2d13a60dce4b275c2675d9cc23

Changelog:

v1:
- Dynamically allocate the data structures in IMA and EVM, when necessary,
  instead of always making a copy in asymmetric_verify() (suggested by
  Mimi)

Roberto Sassu (2):
  evm: Alloc evm_digest in evm_verify_hmac() if CONFIG_VMAP_STACK=y
  ima: Alloc ima_max_digest_data in xattr_verify() if
    CONFIG_VMAP_STACK=y

 security/integrity/evm/evm_main.c     | 26 +++++++++++++++++++++-----
 security/integrity/ima/ima_appraise.c | 19 ++++++++++++++++---
 2 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.25.1

