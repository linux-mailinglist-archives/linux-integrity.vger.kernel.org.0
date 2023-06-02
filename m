Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655037204B4
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jun 2023 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjFBOlr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jun 2023 10:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjFBOlq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 10:41:46 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D502BC;
        Fri,  2 Jun 2023 07:41:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QXll85lk2z9xtRv;
        Fri,  2 Jun 2023 22:29:56 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHUlmE_3lkXXL8Ag--.3617S2;
        Fri, 02 Jun 2023 15:41:19 +0100 (CET)
Message-ID: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
Subject: [GIT PULL] Asymmetric keys fix for v6.4-rc5
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Fri, 02 Jun 2023 16:41:04 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCHUlmE_3lkXXL8Ag--.3617S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4DCr1Dur1DGw4DGF17Jrb_yoW8XFWrp3
        yfKr13Kr4Utr17tw13Jr47Cw15JrWvyr13Ja17Aw1rAF1DZr15tr4Igr4rWryrJr97Ww13
        tr48Jr1UWr1DJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj4oNfAABsd
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus

sorry for this unusual procedure of me requesting a patch to be pulled.
I asked for several months the maintainers (David: asymmetric keys,
Jarkko: key subsystem) to pick my patch but without any luck.

I signed the tag, but probably it would not matter, since my key is not
among your trusted keys.

The following changes since commit 921bdc72a0d68977092d6a64855a1b8967acc1d9:

  Merge tag 'mmc-v6.4-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2023-06-02 08:35:13 -0400)

are available in the Git repository at:

  https://github.com/robertosassu/linux.git tags/asym-keys-fix-for-linus-v6.4-rc5

for you to fetch changes up to c3d03e8e35e005e1a614e51bb59053eeb5857f76:

  KEYS: asymmetric: Copy sig and digest in public_key_verify_signature() (2023-06-02 15:36:23 +0200)

----------------------------------------------------------------
Asymmetric keys fix for v6.4-rc5

Here is a small fix to make an unconditional copy of the buffer passed
to crypto operations, to take into account the case of the stack not in
the linear mapping area.

It has been tested and verified to fix the bug.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

----------------------------------------------------------------
Roberto Sassu (1):
      KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()

 crypto/asymmetric_keys/public_key.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)


