Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C941FBAAE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 18:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgFPPnf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 11:43:35 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54540 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731812AbgFPPnc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 11:43:32 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C084620B4780;
        Tue, 16 Jun 2020 08:43:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C084620B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592322211;
        bh=RynDn+a/ofKU7OdV/8LbyELxOuKAdSPTNjMGDzeL//0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UHO6ZtVxj39eqvlVM44GPhHNLb5TrHlvXCgGPBbLz/yR2e0oli1hzCERttTv4pLZG
         uNRmbxDkaMjDoGJUVqiKyWCeGuNs3whJthdOoaC+Iz8bdBslIpnJIAteXKKgrkY1H3
         OeL14WdFa3WSwXF68arcCq2glFGGQDE9Mm/LqXq0=
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
To:     Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
 <8800031.dr63W5FlUW@x2>
 <CAHC9VhT6JSLBD-JMfQbn9eUsUg=juznRz41DTOaia-=WhrAAuA@mail.gmail.com>
 <6643272.rC52FQZPYE@x2>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <958966b6-9972-051f-a7d5-cd6d1beb3244@linux.microsoft.com>
Date:   Tue, 16 Jun 2020 08:43:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6643272.rC52FQZPYE@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/16/20 8:29 AM, Steve Grubb wrote:

>>>>> The idea is a good idea, but you're assuming that "result" is always
>>>>> errno.  That was probably true originally, but isn't now.  For
>>>>> example, ima_appraise_measurement() calls xattr_verify(), which
>>>>> compares the security.ima hash with the calculated file hash.  On
>>>>> failure, it returns the result of memcmp().  Each and every code path
>>>>> will need to be checked.
>>>>
>>>> Good catch Mimi.
>>>>
>>>> Instead of "errno" should we just use "result" and log the value given
>>>> in the result parameter?
>>>
>>> That would likely collide with another field of the same name which is
>>> the
>>> operation's results. If it really is errno, the name is fine. It's
>>> generic
>>> enough that it can be reused on other events if that mattered.
>>
>> Steve, what is the historical reason why we have both "res" and
>> "result" for indicating a boolean success/fail?  I'm just curious how
>> we ended up this way, and who may still be using "result".
> 
> I think its pam and some other user space things did this. But because of
> mixed machines in datacenters supporting multiple versions of OS, we have to
> leave result alone. It has to be 0,1 or success/fail. We cannot use it for
> errno.

As Mimi had pointed out, since the value passed in result parameter is 
not always an error code, "errno" is not an appropriate name.

Can we add a new field, say, "op_result" to report the result of the 
specified operation?

thanks,
  -lakshmi


