Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B374F71213D
	for <lists+linux-integrity@lfdr.de>; Fri, 26 May 2023 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbjEZHhn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 May 2023 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbjEZHhl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 May 2023 03:37:41 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF6E170E;
        Fri, 26 May 2023 00:36:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QSGgW1kg8z9xFQf;
        Fri, 26 May 2023 15:26:15 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAHwUdYYXBkVgbbAg--.2318S2;
        Fri, 26 May 2023 08:36:05 +0100 (CET)
Message-ID: <a4cefa07e717bd99fa0ae8e5f18950d69145bd24.camel@huaweicloud.com>
Subject: Re: [PATCH v5 2/2] KEYS: asymmetric: Copy sig and digest in
 public_key_verify_signature()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 26 May 2023 09:35:47 +0200
In-Reply-To: <Y+W/fwRbzj5A5v44@kernel.org>
References: <20221227142740.2807136-1-roberto.sassu@huaweicloud.com>
         <20221227142740.2807136-3-roberto.sassu@huaweicloud.com>
         <Y64XB0yi24yjeBDw@sol.localdomain>
         <d2a54ddec403cad12c003132542070bf781d5e26.camel@huaweicloud.com>
         <857eedc5ad18eddae7686dca63cf8c613a051be4.camel@huaweicloud.com>
         <Y+VBMQEwPTPGBIpP@gmail.com> <Y+W/fwRbzj5A5v44@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAHwUdYYXBkVgbbAg--.2318S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWfZw48Xr15AF18uryDJrb_yoW5Gr1fpF
        W3G3W5JF4jqryfCrsIv34F9F1rt3y8Jr15Xw1rZ34UZryv9rn8ur4IgF1fWFyDAr10kFW5
        JF45Xr9ruw1jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4m+WgAAsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-02-10 at 05:52 +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 09, 2023 at 06:53:37PM +0000, Eric Biggers wrote:
> > On Thu, Feb 09, 2023 at 11:49:19AM +0100, Roberto Sassu wrote:
> > > On Fri, 2023-01-27 at 09:27 +0100, Roberto Sassu wrote:
> > > > On Thu, 2022-12-29 at 14:39 -0800, Eric Biggers wrote:
> > > > > On Tue, Dec 27, 2022 at 03:27:40PM +0100, Roberto Sassu wrote:
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > 
> > > > > > Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> > > > > > mapping") checks that both the signature and the digest reside in the
> > > > > > linear mapping area.
> > > > > > 
> > > > > > However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> > > > > > stack support") made it possible to move the stack in the vmalloc area,
> > > > > > which is not contiguous, and thus not suitable for sg_set_buf() which needs
> > > > > > adjacent pages.
> > > > > > 
> > > > > > Always make a copy of the signature and digest in the same buffer used to
> > > > > > store the key and its parameters, and pass them to sg_init_one(). Prefer it
> > > > > > to conditionally doing the copy if necessary, to keep the code simple. The
> > > > > > buffer allocated with kmalloc() is in the linear mapping area.
> > > > > > 
> > > > > > Cc: stable@vger.kernel.org # 4.9.x
> > > > > > Fixes: ba14a194a434 ("fork: Add generic vmalloced stack support")
> > > > > > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > > > > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > ---
> > > > > >  crypto/asymmetric_keys/public_key.c | 38 ++++++++++++++++-------------
> > > > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > > > 
> > > > > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Hi David
> > > > 
> > > > could you please take this patch in your repo, if it is ok?
> > > 
> > > Kindly ask your support here. Has this patch been queued somewhere?
> > > Wasn't able to find it, also it is not in linux-next.
> > > 
> > 
> > The maintainer of asymmetric_keys (David Howells) is ignoring this patch, so
> > you'll need to find someone else to apply it.  Herbert Xu, the maintainer of the
> > crypto subsystem, might be willing to apply it.  Or maybe Jarkko Sakkinen, who
> > is a co-maintainer of the keyrings subsystem (but not asymmetric_keys, for some
> > reason; should that change?).
> 
> I can apply this if no objections?

Hi Jarkko

I wasn't able to reach David about this patch. Could you please apply
it?

Thanks

Roberto

