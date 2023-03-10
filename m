Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55026B558F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 00:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCJXXk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 18:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjCJXX2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 18:23:28 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369223109;
        Fri, 10 Mar 2023 15:23:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id DABC6604EF;
        Sat, 11 Mar 2023 00:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678490587; bh=thvE290k7D9fKCuXiWV3PdNOaCPUOdzAVZV5qp0MFaI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XelauMt9V0BR30I2DeSWVdLMp3fjRRprGISVaGa/2PpBAPkZsgXlA6nCnXDCh8G/5
         FVLcrk+9BvrqrNoaP6Jsyngk6CpZZK8iIkfWk88hZogbtXF1IFJHVg6h8kL2KDlT/X
         +BycPFoh5srfm5q0FooCnC/aMTFE/IMqW3C74Them1WbA5Wj7sBB6rCUpzo7/bHrA5
         cDtcxBRKzm6KzeEzKxtS4u0yvm7LUrzAPj4lD8gL6hj5r1XUNFOZpIMaKdPAMWL8AK
         sD/7pJTUCJp1UJx7iCtqga3v4ZwfkoXbHwN0rKB2kpJsV6mb5zBDf5CUb6QSPbuLsa
         X3ne6+cswserA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lJ1aZtSHt-_N; Sat, 11 Mar 2023 00:23:05 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id D9E26604ED;
        Sat, 11 Mar 2023 00:23:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678490585; bh=thvE290k7D9fKCuXiWV3PdNOaCPUOdzAVZV5qp0MFaI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zj0O/soo4ROwwe0iFHEL956mOPrscivw9/KyXdlEYay/TmHSKxNcC+N00BcIjgCAZ
         Kea6VF2TXL84G1OEwbZC7+XmzAYGUqWq5L50VQLNTbuA3yo+VUfi69k2tOzOyKBhVu
         9ONlAxf43LkYTipcm+hpCeCIIGc7rI1HjqOaORnfdfndP8ragw5opbWFSFqfn2glxq
         B8bkq2abg0sis5n5FGp6QDXfeJ0qsdfJ9+btSBVR9HShvwksoF66FOnm2tdhU74GhM
         DknS9KHOLDOx2AhUnWx3+ayIkZWXe88Zk8JOWLgcGidmXrvk7BQJlAGkuZ6jW2NDqr
         lE0ttaSAeUp/g==
Message-ID: <d20c7249-d407-1ddf-7903-ff1037d69656@alu.unizg.hr>
Date:   Sat, 11 Mar 2023 00:23:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/2] Add release hook to LSM
Content-Language: en-US, hr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
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
 <47129238-d98e-0561-0921-adfe40b6b85f@alu.unizg.hr>
 <ZAuPNm3UdC/c1EXm@smile.fi.intel.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZAuPNm3UdC/c1EXm@smile.fi.intel.com>
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

On 10. 03. 2023. 21:12, Andy Shevchenko wrote:
> On Fri, Mar 10, 2023 at 08:52:32PM +0100, Mirsad Goran Todorovac wrote:
>> On 10. 03. 2023. 20:47, Andy Shevchenko wrote:
>>> On Fri, Mar 10, 2023 at 08:42:00PM +0100, Mirsad Goran Todorovac wrote:
>>>>
>>>> Add release() hook to the definition of the LSM modules, to enable calling
>>>> destructors and deallocating allocated resources cleanly.
>>>>
>>>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>
>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> I haven't given you this tag. Sorry, you must not add something
>>> which was not explicitly given.
>>
>> Mea culpa.
>>
>> I misunderstood that you have approved the change when saying that I should
>> file a formal patch. It worked with Florian Westphal in my first patch, so I
>> thought it would be inappropriate to leave out who endorsed the patch.
> 
> We have Suggested-by tag for that.

Done exactly that, and now I have to reward myself for the first
successful multi-part patch submission.

>> Thousand apologies. This is my second patch, so I am asking for some extra
>> grace ...
> 
>> What should I do now?
> 
> Wait at least a couple of days (even more, since it's weekend) for other
> comments and then send a v2 of the series with the comments addressed.

Actually, Mr. Paul Moore requested the rest of the patch, so I
did a complete resend immediately.

> Btw, you may take my "smart" script [1] for sending patch series. It
> makes much less headache on how to do that properly.
> 
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

Thanks for the tip.

It's pleasure to be working with you guys, it's a great brainstorming
session and I really enjoyed it. It's a privilege to assist your
excellent team.

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

