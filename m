Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BC6B5D92
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 16:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCKP42 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 10:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCKP4P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 10:56:15 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9BE1BED;
        Sat, 11 Mar 2023 07:56:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0E373604F2;
        Sat, 11 Mar 2023 16:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678550169; bh=s5AI3tH+dWxbWSbXy8OcQD5Kry89PyAWfBvcYI7JyUQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=prBs7RYxNmKlx7vVGUl8qaA/yXHvjbkUbtm8x7GxEZaHy6eXtyO88gQagT7uOR5um
         81r3RszM3nYhYU3Wo+T6yku+tUeXxViZQnmyW6Q+nSn4zgPebsHtPqaqzaYbooh+jB
         hNKMGjsOWCUsu9UE49YkXgwzOmzt9vqbKyupHeMkPB24RYkYV5qZU3AA6M69ohaSgA
         NMmkA/Kz1ZNeML59G1yueHpJK+SjEtFNNnU3KyT+ThXS2UgAKZo/YBvsm/uXxa0vxu
         +t3ozKrhIjCdryykp5p0lwA+ajswJIyg/ynj4FaSyqMlLCroa2uOWxuP4sLL8N0EWW
         4gfLRvmFYwI+A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T7NkecPtnJf2; Sat, 11 Mar 2023 16:56:06 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 668D8604ED;
        Sat, 11 Mar 2023 16:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678550166; bh=s5AI3tH+dWxbWSbXy8OcQD5Kry89PyAWfBvcYI7JyUQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CTCV6XRVLuLr5BIODlTuzvFfAw5bDpMXP0UV9/FHPk6brtVwglXkm6hic8KJRI5U7
         uZ7hmj9vJk//YVkOxMO0oQn8CF24ILPqvz3pXoX+iCxvlK+EkHP4GDAg8EqWutAOJ/
         thNW8n/lUBYqTfSRwJKY/NeSXLBfhQLDWNyFVGsfmDgfPTq1x3rxcWyFzox0TVGLkE
         uIe2mQGZnEyrEw7BeLbXab3XexJWwLbm8vriz1VJq/LJylWeFbT8YVH67qZRookJd+
         4abjjncjdofoH2w5TALKv6T9weoCJpY41csviMB/jcq/lhWDAta0Ka4mTJGuFpGRc3
         MKdwq/3h+G0jw==
Message-ID: <205de56d-5502-fc74-e9a3-58aee25ad79e@alu.unizg.hr>
Date:   Sat, 11 Mar 2023 16:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
To:     Paul Moore <paul@paul-moore.com>
Cc:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
References: <20230310192614.GA528@domac.alu.hr>
 <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
 <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr>
 <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11. 03. 2023. 15:59, Paul Moore wrote:
> On Fri, Mar 10, 2023 at 5:53 PM Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>> On 10. 03. 2023. 23:33, Paul Moore wrote:
>>> On Fri, Mar 10, 2023 at 2:26 PM Mirsad Goran Todorovac
>>> <mirsad.goran.todorovac@alu.hr> wrote:
>>>>
>>>> LSM security/integrity/iint.c had the case of kmem_cache_create() w/o a proper
>>>> kmem_cache_destroy() destructor.
>>>>
>>>> Introducing the release() hook would enable LSMs to release allocated resources
>>>> on exit, and in proper order, rather than dying all together with kernel shutdown
>>>> in an undefined order.
>>>>
>>>> Thanks,
>>>>         Mirsad
>>>>
>>>> ---
>>>>  include/linux/lsm_hooks.h | 1 +
>>>>  security/integrity/iint.c | 7 +++++++
>>>>  2 files changed, 8 insertions(+)
>>>
>>> I only see the 1/2 patch, did you send the 2/2 patch to the LSM list?
>>> If not, you need to do that
>>
>> I will resend everything, because this first attempt was buggy and
>> incorrect regarding the credits. Will try this, Andy said that I wait
>> for the comments, but I did not expect them before the weekend.
>>
>> Thank you guys for patience, I am just finishing the test of devres
>> patch and then I will proceed with integrity LSM patch submission.
> 
> Thank you for resending the patchset, although a couple of
> administrative things to consider for your next posting:
> 
> * Each time you post a patchset it is generally considered a best
> practice to increment the version number, e.g. "[PATCH vX 0/2]" with
> 'X' being the version number.  This makes it easier to identify
> specific revisions and ensure that everyone is reviewing the latest
> patchset.
> 
> * It is a good idea to use the "./scripts/get_maintainer.pl" script to
> ensure you have included the right people and mailing lists on your
> submissions as your latest resend did not include the LSM list when it
> should have.

Thank you for the advice, Mr. Moore.

It is really my second attempt at patch submission. I've seen
later that other contributors add RESEND or increase the patch
set version.

For the maintainer list, I have trusted the output of a script.
But yes, it's probably best to check thoroughly twice.

> With that out of the way, I wanted to make a quick comment on the
> patch itself.  Currently LSMs do not support unloading, or dynamic
> loading for that matter.  There are several reasons for this, but
> perhaps the most important is that in order to help meet the security
> goals for several of the LSMs they need to be present in the kernel
> from the very beginning and remain until the very end.  Adding a
> proper "release" method to a LSM is going to be far more complicated
> than what you've done with this patchset, involving a lot of
> discussion both for the LSM layer itself and all of the currently
> supported LSMs, and ultimately I don't believe it is something we will
> want to support.


I have already realised that simply calling kmem_cache_destroy()
would not even deallocate all possibly allocated subnodes which
I saw from the source.

It is based on the idea of the userspace programs in which I
always relinquish memory on the heap instead of relying in just
exit(). (This also allows greater flexibility with signals,
but that is OT now.)

If this is bound not to cause any problems with TPMs or vTMPs
on the virtual machines, maybe it's a non-issue.

> I appreciate your desire to help, and I want to thank you for your
> patch and the effort behind it, but I don't believe the kobject memory
> leak you saw at kernel shutdown was a real issue (it was only "leaked"
> because the system was shutting down) and I'm not sure the current
> behavior is something we want to change in the near future.

Yes, I was worried about the leaks that would be destroyed
all at once or in an undefined order.

I have learned about the devm_kalloc() family of functions and
how it is not used here.

Thank you for considering the patchset at such short notice
and of course I see more experienced developer's ideas dismissed,
so I do not take it with disappointment.

I was already aware that there is currently no mechanism to call
this .release() callback or hook, how should we call it.

Thank you very much for your review.

As I said, I was worried that it could cause problems, in particular
with vTMPs I've read about, randomness for security, nonces that
may not repeat even on virtual server rollbacks or restores to
bare metal and other RFC 4086 considerations which are not even
completely clear to me, as I do not consider myself an expert
in either field.

I am a believer of proper cleanups, and this will not change, but
you have greater experience and knowledge and might find such
mechanism impractical, which I respect with Vulcan aspired logic
and respect :-)

This patch attempt gave me a great brainstorming on how the Linux
drivers work, and I am content with that result. Code of Conduct
warned that newbie kernel developers get ideas on how things should
be done that are not accepted.

Thank you once again, and really have a nice and blessed weekend!

Best regards,
Mirsad

> --
> paul-moore.com

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

