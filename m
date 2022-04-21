Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33D50A413
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Apr 2022 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390067AbiDUPai (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Apr 2022 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390070AbiDUPac (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Apr 2022 11:30:32 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EE733A32
        for <linux-integrity@vger.kernel.org>; Thu, 21 Apr 2022 08:27:42 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KkhHX4tHNzMpnVP;
        Thu, 21 Apr 2022 17:27:36 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KkhHQ5DB5zlhRVS;
        Thu, 21 Apr 2022 17:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1650554856;
        bh=wfi/++th9BRPfWoeyhYKE1CzBwUJ6ThyRbpenoGiMFw=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=nNXoGIDoUO+Fk/7rXzk3ywqiM0Y/zb5zm49DgnpRjMToRDRzX7tnOtHKSTulUkDFX
         yPYpxVXVISMDd4GMp+GwXFbdKrk37+7MvvK38EsCpT+dCx8ue23yRizpGi6a8tL0/Z
         4UvMTcyOnFbX6lVPaGoTMq5PB6VWErrItIWV6SMQ=
Message-ID: <01ec2ce7-986d-451a-4a36-f627263ef826@digikod.net>
Date:   Thu, 21 Apr 2022 17:27:42 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v7 3/5] certs: Make blacklist_vet_description() more
 strict
In-Reply-To: <YmF0eAh7dYmtLDVx@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 21/04/2022 17:12, Jarkko Sakkinen wrote:
> On Wed, Apr 20, 2022 at 11:29:08AM +0100, David Howells wrote:
>> Mickaël Salaün <mic@digikod.net> wrote:
>>
>>> +	/* The following algorithm only works if prefix lengths match. */
>>> +	BUILD_BUG_ON(sizeof(tbs_prefix) != sizeof(bin_prefix));
>>> +	prefix_len = sizeof(tbs_prefix) - 1;
>>> +	for (i = 0; *desc; desc++, i++) {
>>> +		if (*desc == ':') {
>>> +			if (tbs_step == prefix_len)
>>> +				goto found_colon;
>>> +			if (bin_step == prefix_len)
>>> +				goto found_colon;
>>> +			return -EINVAL;
>>> +		}
>>> +		if (i >= prefix_len)
>>> +			return -EINVAL;
>>> +		if (*desc == tbs_prefix[i])
>>> +			tbs_step++;
>>> +		if (*desc == bin_prefix[i])
>>> +			bin_step++;
>>> +	}
>>
>> I wonder if:
>>
>> 	static const char tbs_prefix[] = "tbs:";
>> 	static const char bin_prefix[] = "bin:";
>>
>> 	if (strncmp(desc, tbs_prefix, sizeof(tbs_prefix) - 1) == 0 ||
>> 	    strncmp(desc, bin_prefix, sizeof(bin_prefix) - 1) == 0)
>> 		goto found_colon;
>>
>> might be better.
>>
>> David
> 
> I think it'd be.
> 
> BR, Jarkko

I'm confused. Didn't you plan to send this patch series before 
v5.18-rc2? It's been a while since I started working on this.
