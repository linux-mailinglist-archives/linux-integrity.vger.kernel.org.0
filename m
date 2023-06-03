Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE9720F79
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Jun 2023 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjFCKlo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 3 Jun 2023 06:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjFCKlm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 3 Jun 2023 06:41:42 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D370E1;
        Sat,  3 Jun 2023 03:41:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QYGPH6kPbz9y4Sm;
        Sat,  3 Jun 2023 18:31:15 +0800 (CST)
Received: from [10.81.212.119] (unknown [10.81.212.119])
        by APP2 (Coremail) with SMTP id GxC2BwCHWWDBGHtkrCoAAw--.3560S2;
        Sat, 03 Jun 2023 11:41:16 +0100 (CET)
Message-ID: <97fd9066-9afc-9faa-a604-46110ed1268c@huaweicloud.com>
Date:   Sat, 3 Jun 2023 12:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
Content-Language: en-US
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
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
 <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
 <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHWWDBGHtkrCoAAw--.3560S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5Ww1fXr15Aw1rXFW8Zwb_yoW8KFyxpF
        WSgw4vkr1DJw1xG34xZw4rZ34ayFZ5Xr15GFs8Gr98Cwn8WFnav3yxt3y7ua13CrZ7Ww1I
        qr40g34Du3s8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj44O5wABsD
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/3/2023 2:02 AM, Linus Torvalds wrote:
> On Fri, Jun 2, 2023 at 1:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The patch re-uses the allocation it already does for the key data, and
>> it seems sane.
> 
> Ugh. I had to check that it was ok to re-use the key buffer, but it
> does seem to be the case that you can just re-use the buffer after
> you've done that crypto_akcipher_set_priv/pub_key() call, and the
> crypto layer has to copy it into its own data structures.

Yes, we could not do it if the set_pub_key/set_priv_key methods use 
internally the passed pointer. I guess it depends on the methods, for 
RSA and ECDSA it seems fine (they copy to a different location).

The doubt comes because the buffer is freed after crypto_wait_req() and 
not after crypto_akcipher_set_*_key(), suggesting that it could be 
actually used during the crypto operation.

Rechecked the thread, and the suggestion to reuse the buffer and not 
append the signature and digest at the end was by Eric Biggers.

Eric, in light of this finding, should we still reuse the buffer?

Thanks

Roberto

> I absolutely abhor the crypto interfaces. They all seem designed for
> that "external DMA engine" case that seems so horrendously pointless
> and slow.  In practice so few of them are that, and we have all those
> optimized routines for doing it all on the CPU - but have in the
> meantime wasted all that time and effort into copying everything,
> turning simple buffers into sg-bufs etc etc. The amount of indirection
> and "set this state in the state machine" is just nasty, and this
> seems to all be a prime example of it all. With some of it then
> randomly going through some kthread too.
> 
> I still think that patch is probably fine, but was also going "maybe
> the real problem is in that library helper function
> (asymmetric_verify(), in this case), which takes those (sig, siglen,
> digest, digestlen) arguments and turns it into a 'struct
> public_key_signature' without marshalling them.
> 
> Just looking at this mess of indirection and different "helper"
> functions makes me second-guess myself about where the actual
> conversion should be - while also feeling like it should never have
> been done as a scatter-gather entry in the first place.
> 
> Anyway, I don't feel competent to decide if that pull request is the
> right fix or not.
> 
> But it clearly is *a* fix.
> 
>              Linus

