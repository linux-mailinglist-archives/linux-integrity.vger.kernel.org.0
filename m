Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA46B54E6
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 23:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCJWzn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 17:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjCJWzU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 17:55:20 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29E3A90;
        Fri, 10 Mar 2023 14:54:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2A16D60502;
        Fri, 10 Mar 2023 23:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678488832; bh=rk862eW1fTcupKjZCZV4qVJp30st+OAtyH4yxU602sA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gh14jWjYA/a24Rlf+B/mu5aMRXom5NEcthcprianGO7qR2gXEhomWktW39oGPISWg
         QYkKoYue26tNJDaOflRLiqEOb4ukOJbly4tGo3EaGiZtVryMqi0cCciSc/hh/6aqHw
         ahPRefbuuqU8+m2MOZEKzAUKd+a0HvEmKRiKIRJwL18bKncrKQ/ydulVx2Q61Zi93V
         Ttepdik0pVnuX8kS2cfKpMn07I/yYA+zGo2ydg88lCR0LGHBefKNdC03qo9PYhgwKP
         +6U04ULbrnmHNNeGA9fFX3pTI/5Jy8deO28iDXYqK1qmqx5w0pMiiXSQpVt08mHypp
         yoWzIR6zPEUYg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KCbVmp58HOj0; Fri, 10 Mar 2023 23:53:49 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 9587D60501;
        Fri, 10 Mar 2023 23:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678488829; bh=rk862eW1fTcupKjZCZV4qVJp30st+OAtyH4yxU602sA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rb02J2SL5VwuGmsVv2ZmT4p3iXHYBJ+pWMncN3jgvOwPSMRI3wGXdeByKWt/zSdsw
         AvvfY92T0vJ4obbKNCh7Oz4LWWr0dMhKW/wOq1+Ri8JsXhHnmFbm+TYKEjEY37Ahr2
         iV3BH14NK9YGhQI4BggHts7jXP9kJztAgg0JXTW2qDuqtm4lfaDvfgZklNDs3Qtp5a
         SWRX5aIA/wT5q5ACdXIvwnPOfoNJe5WlgGhWA/xhc3yjeLWKGWIylw7cjTQD3y51Z5
         h1Vqg2GxBA/24Tg6xIEZKy6MUJQ+A9p/tGpmWFuFElickvhUVSOB7esJqOlY384FAW
         lc5zViSLa2OWQ==
Message-ID: <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr>
Date:   Fri, 10 Mar 2023 23:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
Content-Language: en-US, hr
To:     Paul Moore <paul@paul-moore.com>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
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
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
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

On 10. 03. 2023. 23:33, Paul Moore wrote:
> On Fri, Mar 10, 2023 at 2:26 PM Mirsad Goran Todorovac
> <mirsad.goran.todorovac@alu.hr> wrote:
>>
>> LSM security/integrity/iint.c had the case of kmem_cache_create() w/o a proper
>> kmem_cache_destroy() destructor.
>>
>> Introducing the release() hook would enable LSMs to release allocated resources
>> on exit, and in proper order, rather than dying all together with kernel shutdown
>> in an undefined order.
>>
>> Thanks,
>>         Mirsad
>>
>> ---
>>  include/linux/lsm_hooks.h | 1 +
>>  security/integrity/iint.c | 7 +++++++
>>  2 files changed, 8 insertions(+)
> 
> I only see the 1/2 patch, did you send the 2/2 patch to the LSM list?
> If not, you need to do that

I will resend everything, because this first attempt was buggy and
incorrect regarding the credits. Will try this, Andy said that I wait
for the comments, but I did not expect them before the weekend.

Thank you guys for patience, I am just finishing the test of devres
patch and then I will proceed with integrity LSM patch submission.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

