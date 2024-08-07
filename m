Return-Path: <linux-integrity+bounces-3298-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373EF949EED
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2024 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699F51C216A4
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2024 04:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED541191F88;
	Wed,  7 Aug 2024 04:49:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1019066D;
	Wed,  7 Aug 2024 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723006174; cv=none; b=ObcmirSX4ms/Aks4wBwOrAc7T1hSyf2ZAbYcYgYYImP86pF+iMBavd5OvlgdvK3xXUvykIctX89aL9fW/4TT3u+sNYlx1tvJWZOcyAxNRSSU26LonA2o10jc4lv3pL49oMZOUccYoNwSHh1NBX6RtJ6XTGoVUwa4/GC7UObIkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723006174; c=relaxed/simple;
	bh=qa39epjqjdsOVNsHgEqDKXlLdppVmF7MiqUmOzTRPYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EF8cDiGg5EOwtW6MB53m2768zxfbRU5XMaQ5GPMP89z1O9mg/aTuB/f3i3kMZo5U+x+Vy2MBGVam1KUnjcX2VQ7zTzSgzb0rtGqahEi8/fVMcDIrxH03oH4S0NlFmTZ1TzC0812f7NinOF9ZavXGGFNxe2NfWGV4MojuulyJCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af7d2.dynamic.kabel-deutschland.de [95.90.247.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4D7E161E5FE01;
	Wed,  7 Aug 2024 06:48:21 +0200 (CEST)
Message-ID: <5880e801-e896-4bf0-9a69-2cf5acb51ec3@molgen.mpg.de>
Date: Wed, 7 Aug 2024 06:48:20 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 20/20] MAINTAINERS: ipe: add ipe maintainer
 information
To: Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com,
 jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
 axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 eparis@redhat.com, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 fsverity@lists.linux.dev, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-21-git-send-email-wufan@linux.microsoft.com>
 <de7857fb-63d9-42fc-af1e-12ffcdfcdda8@molgen.mpg.de>
 <CAHC9VhRmcReVM_Le5bYor2deotnSe4OT08UYhL6xhiKCu0+3kA@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAHC9VhRmcReVM_Le5bYor2deotnSe4OT08UYhL6xhiKCu0+3kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Paul,


Am 06.08.24 um 22:54 schrieb Paul Moore:
> On Sat, Aug 3, 2024 at 4:15 AM Paul Menzel wrote:

>> Thank you very much for your patch. Two nits, should you sent another
>> interation: A more specific summary would avoid people having to look at
>> the message body or diff, and `git log --oneline` would be enough.
>>
>> MAINTAINERS: Add IPE entry with M: Fan Wu
>>
>> MAINTAINERS: Add IPE entry with Fan Wu as maintainer
>>
>> Am 03.08.24 um 08:08 schrieb Fan Wu:
>>> Update MAINTAINERS to include ipe maintainer information.
>>
>> I’d at least mention Integrity Policy Enforcement. As you not only
>> include the maintainer information but add a new entry, I’d leave the
>> body out, or mention that a new entry is added.
>>
>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> Working under the current assumption that a new revision is not
> needed, I can fix this up during the merge.  Fan, other-Paul, are you
> both okay with the following:
> 
>    "MAINTAINERS: add IPE entry with Fan Wu as maintainer
> 
>     Add a MAINTAINERS entry for the Integrity Policy Enforcement (IPE) LSM."

Thank you. That is fine by me.


Kind regards,

Paul


>>> --
>>> v1-v16:
>>>     + Not present
>>>
>>> v17:
>>>     + Introduced
>>>
>>> v18:
>>>     + No changes
>>>
>>> v19:
>>>     + No changes
>>>
>>> v20:
>>>     + No changes
>>> ---
>>>    MAINTAINERS | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8766f3e5e87e..4cdf2d5a2058 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -11118,6 +11118,16 @@ T:   git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>>>    F:  security/integrity/
>>>    F:  security/integrity/ima/
>>>
>>> +INTEGRITY POLICY ENFORCEMENT (IPE)
>>> +M:   Fan Wu <wufan@linux.microsoft.com>
>>> +L:   linux-security-module@vger.kernel.org
>>> +S:   Supported
>>> +T:   git https://github.com/microsoft/ipe.git
>>> +F:   Documentation/admin-guide/LSM/ipe.rst
>>> +F:   Documentation/security/ipe.rst
>>> +F:   scripts/ipe/
>>> +F:   security/ipe/
>>> +
>>>    INTEL 810/815 FRAMEBUFFER DRIVER
>>>    M:  Antonino Daplas <adaplas@gmail.com>
>>>    L:  linux-fbdev@vger.kernel.org

