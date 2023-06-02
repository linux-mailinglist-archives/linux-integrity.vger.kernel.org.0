Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC0720391
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jun 2023 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjFBNkS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jun 2023 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjFBNkR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 09:40:17 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47F1A7;
        Fri,  2 Jun 2023 06:40:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QXkPp4Syrz9xqxL;
        Fri,  2 Jun 2023 21:29:50 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHjFMW8Xlkdj_8Ag--.3115S2;
        Fri, 02 Jun 2023 14:39:48 +0100 (CET)
Message-ID: <6fc56d38e9c9c79b263d4677a594d3a701279f9b.camel@huaweicloud.com>
Subject: Re: [PATCH v5 2/2] KEYS: asymmetric: Copy sig and digest in
 public_key_verify_signature()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 02 Jun 2023 15:39:30 +0200
In-Reply-To: <20230602131724.GA628@quark.localdomain>
References: <20221227142740.2807136-1-roberto.sassu@huaweicloud.com>
         <20221227142740.2807136-3-roberto.sassu@huaweicloud.com>
         <fd161de5-61ce-94bf-96cf-65965115f981@linux.ibm.com>
         <62078920aa02c2912beeb33511fdf6636365e6c8.camel@huaweicloud.com>
         <20230602131724.GA628@quark.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDHjFMW8Xlkdj_8Ag--.3115S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1UKw17JFyUuw17JFW3trb_yoW8uF1xpa
        y8K3W5GF4DXry8AF4a9ay0yFyrt3ykXryUX3y5J343Zrn09Fn8ur4IgF43WF98Cr18KFWY
        yFWYg3sFq34UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj44JRQAAsm
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

On Fri, 2023-06-02 at 06:17 -0700, Eric Biggers wrote:
> On Fri, Jun 02, 2023 at 11:17:04AM +0200, Roberto Sassu wrote:
> > On Thu, 2023-06-01 at 17:00 -0400, Stefan Berger wrote:
> > > On 12/27/22 09:27, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> > > > mapping") checks that both the signature and the digest reside in the
> > > > linear mapping area.
> > > > 
> > > > However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> > > > stack support") made it possible to move the stack in the vmalloc area,
> > > > which is not contiguous, and thus not suitable for sg_set_buf() which needs
> > > > adjacent pages.
> > > > 
> > > > Always make a copy of the signature and digest in the same buffer used to
> > > > store the key and its parameters, and pass them to sg_init_one(). Prefer it
> > > > to conditionally doing the copy if necessary, to keep the code simple. The
> > > > buffer allocated with kmalloc() is in the linear mapping area.
> > > > 
> > > > Cc: stable@vger.kernel.org # 4.9.x
> > > > Fixes: ba14a194a434 ("fork: Add generic vmalloced stack support")
> > > > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > > 
> > > I just ran into an issue with OpenBMC on ARM where EVM ECDSA signature verification failed due to invalid hashes being passed to the ECDSA signature verification algorithm. This patch here resolved the issue.
> > > 
> > > Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Thanks, Stefan.
> > 
> > I did multiple attempts to have the patch included, but I didn't have
> > any luck with the maintainers (David, Jarkko).
> > 
> > It would be awesome if any maintainer picks it.
> > 
> > Thanks!
> > 
> 
> As the maintainers are ignoring this patch, you could try the "maintainers of
> last resort" (Andrew Morton or Linus Torvalds).

Thanks, will do.

Roberto

