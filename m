Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244250A71E
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Apr 2022 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390775AbiDURby (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Apr 2022 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390769AbiDURby (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Apr 2022 13:31:54 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F34757C
        for <linux-integrity@vger.kernel.org>; Thu, 21 Apr 2022 10:29:03 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Kkkzd1GFJzMq0wj;
        Thu, 21 Apr 2022 19:29:01 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KkkzZ4twRzljsTN;
        Thu, 21 Apr 2022 19:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1650562141;
        bh=AWCSMTsYxeqMfpT4j3/IgWzaiuTFvDGAFKxBu/PEs7A=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=z/OZ9pMPUnN5igC3T/CamIvR4CIXw3gz6R7fedUtl/VSHSza2ngjhZy0EATPOaHDm
         agAxEYfJstLZ6XqTARPrKMFOzlTvA9/IQvygJjWfIK3xUJfZKaSnsL7Vk5jCIofP9l
         RzFPfwpm0yireL020AbdYTSvdNbgMY7Uw0+hj3fw=
Message-ID: <329a078d-29e3-e41e-3118-cd8f3e00b003@digikod.net>
Date:   Thu, 21 Apr 2022 19:29:10 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20210312171232.2681989-4-mic@digikod.net>
 <20210312171232.2681989-1-mic@digikod.net>
 <648218.1650450548@warthog.procyon.org.uk> <YmF0eAh7dYmtLDVx@kernel.org>
 <01ec2ce7-986d-451a-4a36-f627263ef826@digikod.net>
 <YmF+4ZZCZxH9OrS+@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v7 3/5] certs: Make blacklist_vet_description() more
 strict
In-Reply-To: <YmF+4ZZCZxH9OrS+@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 21/04/2022 17:57, Jarkko Sakkinen wrote:
> On Thu, Apr 21, 2022 at 05:27:42PM +0200, Mickaël Salaün wrote:
>>
>> On 21/04/2022 17:12, Jarkko Sakkinen wrote:
>>> On Wed, Apr 20, 2022 at 11:29:08AM +0100, David Howells wrote:
>>>> Mickaël Salaün <mic@digikod.net> wrote:
>>>>
>>>>> +	/* The following algorithm only works if prefix lengths match. */
>>>>> +	BUILD_BUG_ON(sizeof(tbs_prefix) != sizeof(bin_prefix));
>>>>> +	prefix_len = sizeof(tbs_prefix) - 1;
>>>>> +	for (i = 0; *desc; desc++, i++) {
>>>>> +		if (*desc == ':') {
>>>>> +			if (tbs_step == prefix_len)
>>>>> +				goto found_colon;
>>>>> +			if (bin_step == prefix_len)
>>>>> +				goto found_colon;
>>>>> +			return -EINVAL;
>>>>> +		}
>>>>> +		if (i >= prefix_len)
>>>>> +			return -EINVAL;
>>>>> +		if (*desc == tbs_prefix[i])
>>>>> +			tbs_step++;
>>>>> +		if (*desc == bin_prefix[i])
>>>>> +			bin_step++;
>>>>> +	}
>>>>
>>>> I wonder if:
>>>>
>>>> 	static const char tbs_prefix[] = "tbs:";
>>>> 	static const char bin_prefix[] = "bin:";
>>>>
>>>> 	if (strncmp(desc, tbs_prefix, sizeof(tbs_prefix) - 1) == 0 ||
>>>> 	    strncmp(desc, bin_prefix, sizeof(bin_prefix) - 1) == 0)
>>>> 		goto found_colon;
>>>>
>>>> might be better.
>>>>
>>>> David
>>>
>>> I think it'd be.
>>>
>>> BR, Jarkko
>>
>> I'm confused. Didn't you plan to send this patch series before v5.18-rc2?
>> It's been a while since I started working on this.
> 
> That was my original plan but due to some other things, I've sent
> a PR for rc4. I CC'd you to the PR.

OK, I missed it. My micro-optimization isn't worth it, strncmp is much 
simple indeed.
