Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6848776E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiAGMJG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 07:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiAGMJF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 07:09:05 -0500
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E23C0611FD;
        Fri,  7 Jan 2022 04:09:04 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JVhpP4dy5zMwpPR;
        Fri,  7 Jan 2022 13:09:01 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4JVhpM0bdNzlhSMW;
        Fri,  7 Jan 2022 13:08:58 +0100 (CET)
Message-ID: <86c5010e-a926-023a-8915-d6605cfc4f0a@digikod.net>
Date:   Fri, 7 Jan 2022 13:14:30 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andreas Rammhold <andreas@rammhold.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <20210712170313.884724-1-mic@digikod.net>
 <7e8d27da-b5d4-e42c-af01-5c03a7f36a6b@digikod.net> <YcGVZitNa23PCSFV@iki.fi>
 <5030a9ff-a1d1-a9bd-902a-77c3d1d87446@digikod.net> <Ydc/E3S2vmtDOnpw@iki.fi>
 <YddADJJNLDlQAYRW@iki.fi>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v8 0/5] Enable root to update the blacklist keyring
In-Reply-To: <YddADJJNLDlQAYRW@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 06/01/2022 20:16, Jarkko Sakkinen wrote:
> On Thu, Jan 06, 2022 at 09:12:22PM +0200, Jarkko Sakkinen wrote:
>> On Tue, Jan 04, 2022 at 04:56:36PM +0100, Mickaël Salaün wrote:
>>>
>>> On 21/12/2021 09:50, Jarkko Sakkinen wrote:
>>>> On Mon, Dec 13, 2021 at 04:30:29PM +0100, Mickaël Salaün wrote:
>>>>> Hi Jarkko,
>>>>>
>>>>> Since everyone seems OK with this and had plenty of time to complain, could
>>>>> you please take this patch series in your tree? It still applies on
>>>>> v5.16-rc5 and it is really important to us. Please let me know if you need
>>>>> something more.
>>>>>
>>>>> Regards,
>>>>>    Mickaël
>>>>
>>>> I'm off-work up until end of the year, i.e. I will address only important
>>>> bug fixes and v5.16 up until that.
>>>>
>>>> If any of the patches is yet missing my ack, feel free to
>>>>
>>>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>
>>> Thanks Jarkko. Can you please take it into your tree?
>>
>> I can yes, as I need to anyway do a revised PR for v5.17, as one commit
>> in my first trial had a truncated fixes tag.
> 
> Please check:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> 
> /Jarkko

Great, thanks!
