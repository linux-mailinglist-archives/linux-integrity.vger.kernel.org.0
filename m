Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8AD2FE625
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbhAUJT3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 04:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbhAUJTT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 04:19:19 -0500
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2276C061575
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jan 2021 01:18:26 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DLxdV4N3RzMqNgr;
        Thu, 21 Jan 2021 10:18:22 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DLxdS702Gzlh8Tb;
        Thu, 21 Jan 2021 10:18:20 +0100 (CET)
Subject: Re: [PATCH v3 08/10] certs: Check that builtin blacklist hashes are
 valid
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-9-mic@digikod.net> <YAe9egzT5D7B0swR@kernel.org>
 <11ce77c9-7b43-e2a0-55bc-c0035bf3d681@digikod.net>
 <YAjCbKwQf8nS+Nuu@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <c644f660-8b65-586d-42d8-45601ca58ca3@digikod.net>
Date:   Thu, 21 Jan 2021 10:18:20 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <YAjCbKwQf8nS+Nuu@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 21/01/2021 00:53, Jarkko Sakkinen wrote:
> On Wed, Jan 20, 2021 at 12:57:55PM +0100, Mickaël Salaün wrote:
>>
>> On 20/01/2021 06:19, Jarkko Sakkinen wrote:
>>> On Thu, Jan 14, 2021 at 04:19:07PM +0100, Mickaël Salaün wrote:
>>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>>
>>>> Add and use a check-blacklist-hashes.awk script to make sure that the
>>>> builtin blacklist hashes will be approved by the run time blacklist
>>>> description checks.  This is useful to debug invalid hash formats, and
>>>> it make sure that previous hashes which could have been loaded in the
>>>> kernel (but ignored) are now noticed and deal with by the user.
>>>>
>>>> Cc: David Howells <dhowells@redhat.com>
>>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>
>>> I get this with a self-signed cert:
>>>
>>> certs/Makefile:18: *** target pattern contains no '%'.  Stop.
>>>
>>> CONFIG_SYSTEM_BLACKLIST_HASH_LIST="tbs:8eed1340eef37c1dc84d996406ad05c7dbb3eade19132d688408ca2f63904869"
>>
>> As said in the Kconfig documentation for
>> CONFIG_SYSTEM_BLACKLIST_HASH_LIST, you need to provide a file with the
>> list, not to set the string directly in the configuration variable. This
>> patch series didn't change this behavior. The same kind of macros are
>> used for CONFIG_MODULE_SIG_KEY.
> 
> OK, the documentation just states that:
> 
> "Hashes to be preloaded into the system blacklist keyring"
> 
> No mention about a file. I'd add a patch to update this documentation.

I was referring to the full description:

config SYSTEM_BLACKLIST_HASH_LIST
	string "Hashes to be preloaded into the system blacklist keyring"
	depends on SYSTEM_BLACKLIST_KEYRING
	help
	  If set, this option should be the filename of a list of hashes in the
	  form "<hash>", "<hash>", ... .  This will be included into a C
	  wrapper to incorporate the list into the kernel.  Each <hash> should
	  be a string of hex digits.

…but the short description doesn't mention filename.

> 
>>
>>>
>>> I used the script in 10/10 to test this, which is another
>>> reamark: the patches are in invalid order, as you need to
>>> apply 10/10 before you can test  8/10.
>>
>> I'll move patch 10/10 earlier but this kind of formatting was already
>> required (but silently ignored) for this option to be really taken into
>> account. Only the kernel code was available to understand how to
>> effectively create such hash.
> 
> Great, thanks.
> 
> 
>>>
>>> /Jarkko
>>>
> 
> 
> /Jarkko
> 
