Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7A6B515B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 21:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCJUC6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 15:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCJUCz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 15:02:55 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD7127111;
        Fri, 10 Mar 2023 12:02:34 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A63D460501;
        Fri, 10 Mar 2023 21:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678478544; bh=YffeLnjDyEIx0w1ntHgM2BilIFpyn+oOnwxK3tGazGo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XATnsg8W6DxG7i+SYve4S65ExlmyB89A8SYOR+8SmcJm5J1LCELUu7q/g5hdUs98d
         UfSs4DuW66SglxShrhnRmHO3o48oFp1ywm32/eeNnYulFE9W2kKa0Ql1L3Q8C8kDQF
         XOBqqDGAubmyWZY0wZR3/aifMGADofdfnocOTDVIDRCAWPyMI2a1Da3T6ZRfxpN5WR
         whtQYDDTeO9u0yVgvSQS3Ui1OFLzCgmewpGV6ks9zJGlviL+DDF/VFIyoFaLlcYyGx
         3Mc5HaLq1SPAXPAJZFHPBxS0dm2J6W8wsXd4jE49391HBydEmUcG2sv3rp22XaxEFJ
         VNcg7HimBxBEw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QF18HONfvMVj; Fri, 10 Mar 2023 21:02:22 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id D037660502;
        Fri, 10 Mar 2023 21:02:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678478542; bh=YffeLnjDyEIx0w1ntHgM2BilIFpyn+oOnwxK3tGazGo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P/mdzVPhYEfanPkfTQqLi9wsf7ysEWmnr1r7Ku5P0mGL4OYJP/8pzN0yVBBf2H2zE
         XFi7qqqIDiFxzGSpB2PX6zsYmjZ1N5lkvQ48AXiIsuK5XN8rC1n+9uttKz6iE/XjHQ
         gX4tTFEJcO0OOHcQsrWtADtFO5xM0RvSM6Lhz6VLBjGlVyuPo3g9dzn2wgjbVXkJn6
         Iwgzz5d2McH8F5ZNnXQKC14gzYjCHcHLiiOVKa4qWcJWdhg2SbMQBWKOHtUeygfEGf
         wgXPH5Tvm1UgfBCoaMWUGajgLkyrQJiuZgqtpeFA5Cg4UFpJBzIWMJKxiljCbM6Uaw
         mqDkieiuFEKww==
Message-ID: <147c1a43-b5a1-a802-3d14-5f2de8306cc3@alu.unizg.hr>
Date:   Fri, 10 Mar 2023 21:02:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/2] Add release hook to LSM
Content-Language: en-US, hr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
References: <20230310194159.GB528@domac.alu.hr>
 <ZAuJY1MM3hEiT0ri@smile.fi.intel.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZAuJY1MM3hEiT0ri@smile.fi.intel.com>
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

On 10. 03. 2023. 20:47, Andy Shevchenko wrote:
> On Fri, Mar 10, 2023 at 08:42:00PM +0100, Mirsad Goran Todorovac wrote:
>>
>> Add release() hook to the definition of the LSM modules, to enable calling
>> destructors and deallocating allocated resources cleanly.
>>
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I haven't given you this tag. Sorry, you must not add something
> which was not explicitly given.

Hi, Andy,

This change could have long lasting consequences if approved, and I am not
continuing the patch submission without your mentoring and approval.

It is true that I assumed that you have reviewed the patch, but you did not
explicitly give the Reviewed-by tag.

But I am rather new to this patch submission process, and please would you
please mentor me to do this the right way.

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

