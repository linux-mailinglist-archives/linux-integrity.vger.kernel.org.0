Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EE6651EEB
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 11:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiLTKhi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 05:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLTKhg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 05:37:36 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B342BE3D;
        Tue, 20 Dec 2022 02:37:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NbtB95WQzz9xqwx;
        Tue, 20 Dec 2022 18:30:09 +0800 (CST)
Received: from [10.45.156.176] (unknown [10.45.156.176])
        by APP2 (Coremail) with SMTP id GxC2BwDXqWBMkKFj9NEqAA--.5576S2;
        Tue, 20 Dec 2022 11:37:10 +0100 (CET)
Message-ID: <a04e6458-6814-97fc-f03a-617809e2e6ce@huaweicloud.com>
Date:   Tue, 20 Dec 2022 11:36:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] lib/mpi: Fix buffer overrun when SG is too long
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com,
        davem@davemloft.net, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
References: <20221209150633.1033556-1-roberto.sassu@huaweicloud.com>
 <Y5OGr59A9wo86rYY@sol.localdomain>
 <fa8a307541735ec9258353d8ccb75c20bb22aafe.camel@huaweicloud.com>
 <Y5bxJ5UZNPzxwtoy@gondor.apana.org.au>
 <0f80852578436dbba7a0fce03d86c3fa2d38c571.camel@huaweicloud.com>
 <Y6FjQPZiJYTEG1zI@gondor.apana.org.au>
Content-Language: en-US
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <Y6FjQPZiJYTEG1zI@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDXqWBMkKFj9NEqAA--.5576S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4rXrW5Aw45ArW3Zw4fZrb_yoW8Xw17pF
        4DXa1UGrWvg3yIy3ZrW3W8K345C3s8GF47Crs7tr1j9rZ3tw1FkrW0kw4F9347Wr4kXr4U
        Ja4qva4fZrWkArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4bWLQABsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/20/2022 8:24 AM, Herbert Xu wrote:
> On Mon, Dec 19, 2022 at 09:49:29AM +0100, Roberto Sassu wrote:
>>
>> do you have any news on this bug?
> 
> Thanks for the reminder.  Could you please try this patch?

Tried, could not boot the UML kernel.

After looking, it seems we have to call sg_miter_stop(). Or 
alternatively, we could let sg_miter_next() be called but not writing 
anything inside the loop.

With either of those fixes, the tests pass (using one scatterlist).

Roberto

> ---8<---
> The helper mpi_read_raw_from_sgl ignores the second parameter
> nbytes when reading the SG list and may overrun its own buffer
> because it only allocates enough memory according to nbytes.
> 
> Fixes: 2d4d1eea540b ("lib/mpi: Add mpi sgl helpers")
> Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
> index 39c4c6731094..6bffc68c1a5a 100644
> --- a/lib/mpi/mpicoder.c
> +++ b/lib/mpi/mpicoder.c
> @@ -494,17 +494,15 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
>   	val->sign = 0;
>   	val->nlimbs = nlimbs;
>   
> -	if (nbytes == 0)
> -		return val;
> -
>   	j = nlimbs - 1;
>   	a = 0;
>   	z = BYTES_PER_MPI_LIMB - nbytes % BYTES_PER_MPI_LIMB;
>   	z %= BYTES_PER_MPI_LIMB;
>   
> -	while (sg_miter_next(&miter)) {
> +	while (nbytes && sg_miter_next(&miter)) {
>   		buff = miter.addr;
> -		len = miter.length;
> +		len = min_t(unsigned, miter.length, nbytes);
> +		nbytes -= len;
>   
>   		for (x = 0; x < len; x++) {
>   			a <<= 8;

