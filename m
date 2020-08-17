Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5098E247961
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 00:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgHQWAO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 18:00:14 -0400
Received: from sonic304-16.consmr.mail.bf2.yahoo.com ([74.6.128.39]:35810 "EHLO
        sonic304-16.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729060AbgHQWAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 18:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597701610; bh=mBv6GXNb/3F5RHHBMnK7Ok8fC5BMVU0RSg+izcnyp3o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=nsiW3rClcRSK6+ZPdjsYJGVWzgZlfzRvYAH6fCXOvb+WMiw0d5Q01HVqPFvQUnvsFHPPSXBs0Mv5CvuCkPxBsUYM528vBG8X/ofrE/VWI+lFKN0Bf5ZvOVR+ZP3AQ7N07F3jfcihfxthNQqZ5J/w3Oz/EYEuwAQISuYLN7UlhLWc2uSNkV2q7X0NSQVOCyZHy0GrvF5m40fBRaEjfFtYJk9s5o+Q5/PVzKz0LS8v5f0+VpnsjA0iFAgeGW8tZ9oXYgfz87m7To+tRfNNaKCF3GPWENVhkGRluGVyFM+F8ROQ9iGfk/uAkCU6Er0TikVexlS2B8yO1YycG/TxMOD+0w==
X-YMail-OSG: iTsMhMMVM1kLwAx8Bv76P6azF093UCqa75StCXcZU4ShW13BZzw_b2a_NZzqCnV
 4xTICwEU5GkVJcRUancUG5Sf2qB4k089QsEif0mQqJXkI6SVJ4PcCx.BgMwUaffrgbqHMsAVZR8Q
 zYcqGOxRINM9m_j8DXPo5LEGrrw9xqX4NBZqBjcW6lA3NosbPt_yUHXAJ6zOwjjs0HPBe_lHdkPw
 J9Z1HxCrBbd14bXiIgGXAZHP3KxUVPgsY30p.9z2S2Ki1h_Z7V2yphyl2A8V1xjCxPPt38iQr008
 5216vWQA9NJdrorVRa5cxX11ado12VQ4pt1TGWp8P3tFtyy9aO96t4C.to3tDEzTKYQlvcqJLyZo
 AVHBXx.Mcinlmu97R58tecHOQ2pDUjzRlE7blmb6TNym6lvhONHmVihP2ywfq426UCwS87QQTIdB
 O9IJRVyDxa0Qd3Xo6eXaIkR5MlFqLZAbIxFjbaGn.gF8j7Gznd4jFn0WPQIGVI5OnCMHm4DJ.Esx
 nIndRUtzIw5CMicNvNYjqFK43W3h2m4KVMXmy4cu871h8gwMgWWXyt_CY8wJ3_zDp1R3AwSmpWeo
 vAA8lT6Dl7qA0l92W1A_KvNbjJ_BrA_c4dy5OlmsEfjMxdQ5qRtf4GQ7AyTPB12Z1E9I.z0K_Kzo
 Kv6Tp95gBO7TTCvYnVNhDYrsmM0KSYFgxY.4jBSMvTGGtPbqvHsHytuNag3_ZJTRY_Wo4bbHmIAR
 bgUGGhNKAYRvd8tb4tk8PgevBTHyVWR8wOCQtdiFWBEbrYCupQ_G8yksngD3YuqSBcz5r.HQf9Vb
 nMPIT.y7Cc7OmJ4cpHAnfsQktLOFx3MhzrBSMLX5.Azvxd7Bni2_01z2NvudcsmIXm9yfBXwGDUp
 ozakJVP6urIETqKuQgcDOz1D7PVo00aw0Mr563OM60jPKjgqWcDuCC6_HSwKau9W7XmlqeWrn034
 fxAm.zvckEFvSpVIXOdcYe9iCFd537uoACmJapDxzKdUXLQKAZV3eQJmU38VNpc2FuSxtN6JFItJ
 c29gtLCFaBhkpkrSpk87.9543DNpkp_NL6zfqm5Mrjyiig_mqYFgf18v_lZRJDUeWZZMq2Sz5Djn
 .kMo8rGlw2EaDLYz78GLYTsu6oXFsqUkXB3iRJV8iKLLyW_tW2gXcoGDHLPZE79NSVm2RwkiV3wD
 _GJG_h4gCwpbkSWDypAd_YVlh70dqdEMm47YaROZyrEo3twj76OAVSQgjAToBaetmr0WwLNk5Umx
 G1kWt8e0v5vGXx5YRZDObAjQ0lXgShzyprdqhfjIJHQ8LRm8qOrY495ceth8ZJMYYrLjeQPa85DN
 NK.2HOAAAC8TqGg5GyE.v7godPAJWK.j4KB6fdvkqE8.4k2wB00nFCZBNqY3bf50L.FCiBO86vjg
 K22Bm95Lm35y7JKupWeE3KkkLYEZL8dLRXlGi8Iy69lwnYozFX0Ck0C44K8PT3iP8zHxpiiiCa00
 l2cYucV7ldP7.oLyLvTjHHqn6K4d4agL0kEBwoA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Mon, 17 Aug 2020 22:00:10 +0000
Received: by smtp422.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ad867973c6424ab985a38d29928ce789;
          Mon, 17 Aug 2020 22:00:06 +0000 (UTC)
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
 <20200813170707.2659-3-nramas@linux.microsoft.com>
 <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
 <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
 <CAEjxPJ6sZdm2w=bbkL0uJyEkHw0gCT_y812WQBZPtLCJzO6r3A@mail.gmail.com>
 <e935c06f-09e2-a2f7-f97f-768bc017f477@linux.microsoft.com>
 <CAEjxPJ7uWee5jjALtQ3azMvKRMk8pxFiYByWmYVhjgJiMNZ8ww@mail.gmail.com>
 <3679df359c35561f5bf6608911f96cc0292c7854.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <57f972a7-26f1-3ac7-4001-54c0bc7e12a8@schaufler-ca.com>
Date:   Mon, 17 Aug 2020 15:00:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3679df359c35561f5bf6608911f96cc0292c7854.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/17/2020 2:31 PM, Mimi Zohar wrote:
> On Thu, 2020-08-13 at 14:13 -0400, Stephen Smalley wrote:
>> On Thu, Aug 13, 2020 at 2:03 PM Lakshmi Ramasubramanian
>> <nramas@linux.microsoft.com> wrote:
>>> On 8/13/20 10:58 AM, Stephen Smalley wrote:
>>>> On Thu, Aug 13, 2020 at 1:52 PM Lakshmi Ramasubramanian
>>>> <nramas@linux.microsoft.com> wrote:
>>>>> On 8/13/20 10:42 AM, Stephen Smalley wrote:
>>>>>
>>>>>>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..f21b7de4e2ae
>>>>>>> --- /dev/null
>>>>>>> +++ b/security/selinux/measure.c
>>>>>>> @@ -0,0 +1,204 @@
>>>>>>> +static int selinux_hash_buffer(void *buf, size_t buf_len,
>>>>>>> +                   void **buf_hash, int *buf_hash_len)
>>>>>>> +{
>>>>>>> +    struct crypto_shash *tfm;
>>>>>>> +    struct shash_desc *desc = NULL;
>>>>>>> +    void *digest = NULL;
>>>>>>> +    int desc_size;
>>>>>>> +    int digest_size;
>>>>>>> +    int ret = 0;
>>>>>>> +
>>>>>>> +    tfm = crypto_alloc_shash("sha256", 0, 0);
>>>>>>> +    if (IS_ERR(tfm))
>>>>>>> +        return PTR_ERR(tfm);
>>>>>> Can we make the algorithm selectable via kernel parameter and/or writing
>>>>>> to a new selinuxfs node?
>>>>> I can add a kernel parameter to select this hash algorithm.
>>>> Also can we provide a Kconfig option for the default value like IMA does?
>>>>
>>> Would we need both - Kconfig and kernel param?
>>>
>>> The other option is to provide an IMA function to return the current
>>> hash algorithm used for measurement. That way a consistent hash
>>> algorithm can be employed by both IMA and the callers. Would that be better?
>> This is why I preferred just passing the serialized policy buffer to
>> IMA and letting it handle the hashing.  But apparently that approach
>> wouldn't fly.  IMA appears to support both a Kconfig option for
>> selecting a default algorithm and a kernel parameter for overriding
>> it.  I assume the idea is that the distros can pick a reasonable
>> default and then the end users can override that if they have specific
>> requirements.  I'd want the same for SELinux.  If IMA is willing to
>> export its hash algorithm to external components, then I'm willing to
>> reuse that but not sure if that's a layering violation.
> With the new ima_measure_critical_data() hook, I agree with you and
> Casey it doesn't make sense for each caller to have to write their own
> function.  Casey suggested exporting IMA's hash function or defining a
> new common hash function.   There's nothing specific to IMA.

Except that no one is going to use the function unless they're
doing an IMA operation. 

>   Should
> the common hash function be prefixed with "security_"?

Yuck. That prefix is for interfaces that are exported outside the
security sub-system. We're talking about a function that is provided
for use within the security sub-system, but not for any one particular
security module or non-module feature. We're currently using the lsm_
prefix for interfaces used within the security subsystem, so I suggest
lsm_hash_brown_potatoes() might be the way to go.

>
> Like when we add a new security hook call, the new LSM call is separate
> from any other change.   Please break up this patch with the SELinux
> specific pieces separated from the ima_measure_critical_data() call as
> much as possible.
>
> thanks,
>
> Mimi
>
