Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D196B521F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 21:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCJUqg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 15:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCJUqf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 15:46:35 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770551368B3;
        Fri, 10 Mar 2023 12:46:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0ADDE60502;
        Fri, 10 Mar 2023 21:46:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678481191; bh=0wWop1MJUIslEzuNZGOUUBW5eHPOEzo9RGwq49zSvL8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uLiZ8s2I5JV4hHzwZcovnQiYMjm2w2Pufs2tSthliMFW3G4GRLDlMpgeU08oAKlZB
         /aUrlwdz84Lx6yCD4W1uMgx2DJv+MRocLkCPXnE6xHQsiXhh6fs9ym2a3OIA69yJJe
         CLOiCTR1oRpWicR2mL8Cy2655luJjJd45CXXT3VcM4orsAfAru07lwj2S9o1sqN+Pv
         iroaH0MZxbeCkwv86pri5LyQh8m2M/jwrljbVqeDdy4PAO1FoKyAvFbxJWtG2LHMeV
         WUsy01nTlgafJVFEj58wjvBQwQdRNwFJKokQ1/gD/uRQKnsMF0tm3eAY1JZtT4/Z4I
         D1xC5Wxu2hf2Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QMZCEYY4uaJe; Fri, 10 Mar 2023 21:46:28 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 7902560501;
        Fri, 10 Mar 2023 21:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678481188; bh=0wWop1MJUIslEzuNZGOUUBW5eHPOEzo9RGwq49zSvL8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VhhR1rw/vdlUOrSga+hM0kIAID7o3l//cJ9UzhR/No9H1pUuq2sE68SEXqdIXU4O9
         HvKeOdLCH3GXXyHdf/I0C7/7AgvVPt6EBFI0DTcTR9Oh7mVP3fzpm6X1l/jbhETmof
         7+U+DN4oEZPnRLomsGKW7G8MSEkjBJ0G3jzNPywQ3dUQY82oV0Mhnw8IyYypuX0RDG
         B+bIsn+yyhJHQEJV+42aOzkBtABzWazICyIoVa0zmNUAh7663KpLB6m5ZUDYCtp1ja
         rYBwLlQg62KSF25N7kABf4iIbz+GGCi85XkeWMsgdhpKGkb+D7y8EMqoO7+ZIP/dda
         vyu14AxEyAh/Q==
Message-ID: <303e2cef-4568-26b9-a76f-1b6d5206bd7e@alu.unizg.hr>
Date:   Fri, 10 Mar 2023 21:46:26 +0100
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

Yes, I think that's what is right.

I agree that it is inappropriate to add something that was not
explicitly given. It's your tag and you define the rules. :-)

>> Thousand apologies. This is my second patch, so I am asking for some extra
>> grace ...
> 
>> What should I do now?
> 
> Wait at least a couple of days (even more, since it's weekend) for other
> comments and then send a v2 of the series with the comments addressed.

Will do. It is better done right than tonight.

> Btw, you may take my "smart" script [1] for sending patch series. It
> makes much less headache on how to do that properly.
> 
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

You should please understand that sometimes I simply block or deadlock on
some very simple things. I have not yet implemented RCUs but rely on
evil spinlocks :-)

Thanks again. Then I'll take a beer and chill out a bit. Perhaps sniff
around if something else is left without a destructor or a release hook,
too.

However, it might be too daring to go straight into the LSM area. I am
strongly depending on your experience and mentoring, and yes, you define
the rules for assisting your team.

I just hope I did not break the Rules of Conduct. Tried to Cc: as many
maintainers as I could.

They said that every beginning is hard. But no pain, no gain :-/

Regards,
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

