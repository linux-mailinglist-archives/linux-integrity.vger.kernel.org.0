Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC972089E
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jun 2023 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjFBRxN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jun 2023 13:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjFBRxM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 13:53:12 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A829F;
        Fri,  2 Jun 2023 10:53:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QXr1k29Bfz9y3D6;
        Sat,  3 Jun 2023 01:42:50 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCX8NthLHpkNl4EAw--.3454S2;
        Fri, 02 Jun 2023 18:52:46 +0100 (CET)
Message-ID: <f097e95715f0ff43929a4cb56b1ad29c2f2b1c44.camel@huaweicloud.com>
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Fri, 02 Jun 2023 19:52:29 +0200
In-Reply-To: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
         <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCX8NthLHpkNl4EAw--.3454S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4Dtw4UJFW7Gr1DuF18Grg_yoW8uF45p3
        yrKw4fKr1qgrZ2y34xGw4Uuay5Jws5JryUGrsxG34fu3Z8Xr9xCa4I9F43WFyakr4vga43
        KrW0gws8CrW5Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
        6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj4oO0gACsz
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

On Fri, 2023-06-02 at 13:38 -0400, Linus Torvalds wrote:
> On Fri, Jun 2, 2023 at 10:41 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > sorry for this unusual procedure of me requesting a patch to be pulled.
> > I asked for several months the maintainers (David: asymmetric keys,
> > Jarkko: key subsystem) to pick my patch but without any luck.
> 
> Hmm.
> 
> The patch behind that tag looks sane to me, but this is not code I am
> hugely familiar with.
> 
> Who is the caller that passes in the public_key_signature data on the
> stack to public_key_verify_signature()? This may well be the right
> point to move it away from the stack in order to have a valid sg-list,
> but even if this patch is all good, it would be nice to have the call
> chain documented as part of the commit message.

Oh, it seems it was only in the first version of the patch:

https://lore.kernel.org/linux-kernel/20221104122023.1750333-1-roberto.sassu@huaweicloud.com/

Originally, the kernel panic was due to EVM, but I later found that IMA
Appraisal could have caused the same.

> > I signed the tag, but probably it would not matter, since my key is not
> > among your trusted keys.
> 
> It does matter - I do pull from people even without full chains, I
> just end up being a lot more careful, and I still want to see the
> signature for any future reference...

Ok, then it makes sense to push my key to a key server.

Thanks

Roberto

> DavidH, Herbert, please comment:
> 
> >   https://github.com/robertosassu/linux.git tags/asym-keys-fix-for-linus-v6.4-rc5
> 
> basically public_key_verify_signature() is passed that
> 
>      const struct public_key_signature *sig
> 
> as an argument, and currently does
> 
>         sg_init_table(src_sg, 2);
>         sg_set_buf(&src_sg[0], sig->s, sig->s_size);
>         sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> 
> 
> on it which is *not* ok if the s->s and s->digest points to stack data
> that ends up not dma'able because of a virtually mapped stack.
> 
> The patch re-uses the allocation it already does for the key data, and
> it seems sane.
> 
> But again, this is not code I look at normally, so...
> 
>                Linus

