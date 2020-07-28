Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D035230C5B
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgG1OZK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jul 2020 10:25:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48448 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbgG1OZK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jul 2020 10:25:10 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4604D20B4908;
        Tue, 28 Jul 2020 07:25:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4604D20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595946309;
        bh=kf49Pl4vodwxbcCaCVjPOECW8xxDzk6EtLOs42dKW5M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n7hsyuxJEGAN2VcPdsLlUNFVFF4BLQhvYqXnhM4qQ28xeJqT+t+Ob/3mUlk1BrbNt
         roMUe9lkfvyJe5bANGjyV6/Ckx5lMh94srtffhHtKtkeMIziH9BSweuDN5qKRg0mTw
         pp2KOkg+YWjy90HyDGx4md5UwnAfAFse6EXXpU0w=
Subject: Re: [PATCH 1/2] ima: Pre-parse the list of keyrings in a KEY_CHECK
 rule
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200727140831.64251-1-tyhicks@linux.microsoft.com>
 <20200727140831.64251-2-tyhicks@linux.microsoft.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <953d1c54-ac80-3807-1082-e7fd00e386d5@linux.microsoft.com>
Date:   Tue, 28 Jul 2020 07:25:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727140831.64251-2-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/27/20 7:08 AM, Tyler Hicks wrote:
> The ima_keyrings buffer was used as a work buffer for strsep()-based
> parsing of the "keyrings=" option of an IMA policy rule. This parsing
> was re-performed each time an asymmetric key was added to a kernel
> keyring for each loaded policy rule that contained a "keyrings=" option.
> 
> An example rule specifying this option is:
> 
>   measure func=KEY_CHECK keyrings=a|b|c
> 
> The rule says to measure asymmetric keys added to any of the kernel
> keyrings named "a", "b", or "c". The size of the buffer size was
> equal to the size of the largest "keyrings=" value seen in a previously
> loaded rule (5 + 1 for the NUL-terminator in the previous example) and
> the buffer was pre-allocated at the time of policy load.
> 
> The pre-allocated buffer approach suffered from a couple bugs:
> 
> 1) There was no locking around the use of the buffer so concurrent key
>     add operations, to two different keyrings, would result in the
>     strsep() loop of ima_match_keyring() to modify the buffer at the same
>     time. This resulted in unexpected results from ima_match_keyring()
>     and, therefore, could cause unintended keys to be measured or keys to
>     not be measured when IMA policy intended for them to be measured.
> 
> 2) If the kstrdup() that initialized entry->keyrings in ima_parse_rule()
>     failed, the ima_keyrings buffer was freed and set to NULL even when a
>     valid KEY_CHECK rule was previously loaded. The next KEY_CHECK event
>     would trigger a call to strcpy() with a NULL destination pointer and
>     crash the kernel.
> 
> Remove the need for a pre-allocated global buffer by parsing the list of
> keyrings in a KEY_CHECK rule at the time of policy load. The
> ima_rule_entry will contain an array of string pointers which point to
> the name of each keyring specified in the rule. No string processing
> needs to happen at the time of asymmetric key add so iterating through
> the list and doing a string comparison is all that's required at the
> time of policy check.
> 
> In the process of changing how the "keyrings=" policy option is handled,
> a couple additional bugs were fixed:
> 
> 1) The rule parser accepted rules containing invalid "keyrings=" values
>     such as "a|b||c", "a|b|", or simply "|".
> 
> 2) The /sys/kernel/security/ima/policy file did not display the entire
>     "keyrings=" value if the list of keyrings was longer than what could
>     fit in the fixed size tbuf buffer in ima_policy_show().
> 
> Fixes: 5c7bac9fb2c5 ("IMA: pre-allocate buffer to hold keyrings string")
> Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_policy.c | 138 +++++++++++++++++++---------
>   1 file changed, 93 insertions(+), 45 deletions(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
