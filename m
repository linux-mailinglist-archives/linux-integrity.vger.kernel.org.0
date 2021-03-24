Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA838347700
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 12:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhCXLVR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 07:21:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62478 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbhCXLU5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 07:20:57 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12OBKdaE096058;
        Wed, 24 Mar 2021 20:20:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Wed, 24 Mar 2021 20:20:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12OBKdEH096052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Mar 2021 20:20:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
 <20210319200358.22816-2-zohar@linux.ibm.com>
 <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
 <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
 <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
 <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
 <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
 <8a8763a7-eeeb-3578-d50c-c15919fbe1f9@i-love.sakura.ne.jp>
 <3ed2004413e0ac07c7bd6f10294d6b6fac6fdbf3.camel@linux.ibm.com>
 <cc01e7b7-d685-289c-a792-fc76fabba807@i-love.sakura.ne.jp>
 <721b4f8d38b014babb0f4ae829d76014bbf7734e.camel@linux.ibm.com>
 <0a0c5cc5-0e1b-ef01-60c4-5247af2124f4@i-love.sakura.ne.jp>
 <37aeaf361bfbd800e29db761f5160f2ce1869298.camel@linux.ibm.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <05ca20d0-9596-152e-4da2-1ffe28c52055@i-love.sakura.ne.jp>
Date:   Wed, 24 Mar 2021 20:20:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <37aeaf361bfbd800e29db761f5160f2ce1869298.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021/03/24 20:10, Mimi Zohar wrote:
> On Wed, 2021-03-24 at 19:10 +0900, Tetsuo Handa wrote:
>> On 2021/03/24 1:13, Mimi Zohar wrote:
>>> On Wed, 2021-03-24 at 00:14 +0900, Tetsuo Handa wrote:
>>>> On 2021/03/23 23:47, Mimi Zohar wrote:
>>>>> Initially I also questioned making "integrity" an LSM.  Perhaps it's
>>>>> time to reconsider.   For now, it makes sense to just fix the NULL
>>>>> pointer dereferencing.
>>>>
>>>> Do we think calling panic() as "fix the NULL pointer dereferencing" ?
>>>
>>> Not supplying "integrity" as an "lsm=" option is a user error.  There
>>> are only two options - allow or deny the caller to proceed.   If the
>>> user is expecting the integrity subsystem to be properly working,
>>> returning a NULL and allowing the system to boot (RFC patch version)
>>> does not make sense.   Better to fail early.
>>
>> What does the "user" mean? Those who load the vmlinux?
>> Only the "root" user (so called administrators)?
>> Any users including other than "root" user?
>>
>> If the user means those who load the vmlinux, that user is explicitly asking
>> for disabling "integrity" for some reason. In that case, it is a bug if
>> booting with "integrity" disabled is impossible.
>>
>> If the user means something other than those who load the vmlinux,
>> is there a possibility that that user (especially non "root" users) is
>> allowed to try to use "integrity" ? If processes other than global init
>> process can try to use "integrity", wouldn't it be a DoS attack vector?
>> Please explain in the descripotion why calling panic() does not cause
>> DoS attack vector.
> 
> User in this case, is anyone rebooting the system and is intentionally
> changing the default values, dropping the "integrity" option on the
> boot command line.

OK. Then, I expect that the system boots instead of calling panic().
That user is explicitly asking for disabling "integrity" for some reason.
