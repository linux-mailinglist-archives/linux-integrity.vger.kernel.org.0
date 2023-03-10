Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791A96B5126
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 20:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCJTwk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 14:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCJTwi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 14:52:38 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0776116C04;
        Fri, 10 Mar 2023 11:52:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9145860502;
        Fri, 10 Mar 2023 20:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678477955; bh=CuKbNaGtEDyVbPW61gz5KSbY6WR5g87E5w7kTRz4ab4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E1QmAxzvt0C5Kq4QBJrC6OqnepQMit6YL0hGAQsfjaNbFlNr2uCSr598UvorR8xTm
         CewuIPQwXN1c4mLOYXm/GkX0jrFjuCigSRdDqYHCzfwA0xIbSkD6ezREBsce+eYV1o
         1QYuSd5nKXAznjnVPgENXUXtmh/0BHbCLi2XzpWkngjVbrGjz61B9YRMc2yj/PSkvQ
         H9LL2FHcPPci9Hph5UsU78SsdeyKsO11PxQ8sY5S+APjEFG5ZgAFHTl77H5jm2m3s9
         5yH2wOnQybghguLUJQ5RnpPUoyReQ7ggrUegBgED5gnvF1UbMILS/y/t+m8d/WIpHN
         zM3Mgx4syLQiQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pNZjIkBOeHwH; Fri, 10 Mar 2023 20:52:33 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id DC47660501;
        Fri, 10 Mar 2023 20:52:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678477953; bh=CuKbNaGtEDyVbPW61gz5KSbY6WR5g87E5w7kTRz4ab4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KhNWiZHrHQgkUFvebV0tNunC4acveo3nl7DljXoEVIPpP/Ci6AKfTU9rkFbmK/4QO
         z9fu9BLg2bBTovzKcHihoh9F+Tiiw4RoVBQ6pdNi03Q1WIAXoP19phGRGWNcO7TBrE
         lRMAb4K4CdvHiqcXeKG8JLiBzY/Ivw2kCY3yhFOzft3haAZ9twobTGMqYLr2cfOb4l
         QzgNaVsIKsqeINkjg4o4CENd8X88GcPgVvW5RYqMOOL3Zqf1pu0mhGauwSUDKB69fs
         dQbTsL7wptW6TRvD+BodvJoV7EbBJJzS60WNTHr1D6DkNardMYpWgV7B/JwCRyWczv
         +bDFx9trnVOOA==
Message-ID: <47129238-d98e-0561-0921-adfe40b6b85f@alu.unizg.hr>
Date:   Fri, 10 Mar 2023 20:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/2] Add release hook to LSM
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
Content-Language: en-US, hr
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

Mea culpa.

I misunderstood that you have approved the change when saying that I should
file a formal patch. It worked with Florian Westphal in my first patch, so I
thought it would be inappropriate to leave out who endorsed the patch.

Thousand apologies. This is my second patch, so I am asking for some extra
grace ...

What should I do now?

Regards,
Mirsad

>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Mimi Zohar <zohar@linux.ibm.com>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: Thomas Weißschuh <linux@weissschuh.net>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Use --cc parameter to `git send-email`.

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

