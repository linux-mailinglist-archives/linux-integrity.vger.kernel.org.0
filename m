Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768A013B013
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgANQyQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 11:54:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44706 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgANQyQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 11:54:16 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3BAC320B4798;
        Tue, 14 Jan 2020 08:54:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BAC320B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579020855;
        bh=Ucmyx/fCw1Ra6TuNnQWAln3iWLXAArkz0UXjKyjbhHU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PhSTT93HCojtCk5FZzm1Yc7XHAOgihAHujoeZCsaYCx1X16CwKuWE15Bo0fUYfo8j
         VnaN0NIcMkJFAXXtMVzGndOX8BDm3aftJvmT05IJbrjT83QmV8dJUwzAk45yi1OQwS
         imGeSlNiQFKg8kwZJmre3K4C/rXaYjZLiRHth2bo=
Subject: Re: inconsistent lock state in ima_process_queued_keys
To:     Dmitry Vyukov <dvyukov@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000486474059c19f4d7@google.com>
 <CACT4Y+av-ipjsdtsXs4d55w=inNHJqho3s3XKfU0Jo7f98yi8w@mail.gmail.com>
 <1579013812.12230.21.camel@linux.ibm.com>
 <CACT4Y+bgQVmibpeJgpwb_JTKW6jx3dzv0M-NGVat8qvJTo4X7A@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c98a54b7-ffc1-2ea5-5527-b0c7e381b613@linux.microsoft.com>
Date:   Tue, 14 Jan 2020 08:54:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bgQVmibpeJgpwb_JTKW6jx3dzv0M-NGVat8qvJTo4X7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I am investigating this.

thanks,
  -lakshmi

On 1/14/2020 7:21 AM, Dmitry Vyukov wrote:
> On Tue, Jan 14, 2020 at 3:57 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> On Tue, 2020-01-14 at 14:58 +0100, Dmitry Vyukov wrote:
>>> On Tue, Jan 14, 2020 at 2:56 PM syzbot
>>> <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    1b851f98 Add linux-next specific files for 20200114
>>>> git tree:       linux-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12bcbb25e00000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e7d9cf7ebfa08ad
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a4a503d7f37292ae1664
>>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>>>
>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com
>>>
>>> +Lakshmi, you seem to have submitted a number of changes to this file recently.
>>>
>>> This completely breaks linux-next testing for us, every kernel crashes
>>> a few minutes after boot.
>>>
>>> 2020/01/14 14:45:00 vm-26: crash: inconsistent lock state in
>>> ima_process_queued_keys
>>
>> Yikes!  Are you running with an IMA policy?
> 
> I don't know.
> 
>>   I assume this is being
>> caused by commit 8f5d2d06f217 ("IMA: Defined timer to free queued
>> keys".  Does reverting it prevent this from happening?
> 
> The following seems to help, but don't know if it's the right fix or not.
> 
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c
> b/security/integrity/ima/ima_asymmetric_keys.c
> index 61e478f9e8199..49d559501fe62 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -103,17 +103,18 @@ static bool ima_queue_key(struct key *keyring,
> const void *payload,
>   {
>          bool queued = false;
>          struct ima_key_entry *entry;
> +       unsigned long flags;
> 
>          entry = ima_alloc_key_entry(keyring, payload, payload_len);
>          if (!entry)
>                  return false;
> 
> -       spin_lock(&ima_keys_lock);
> +       spin_lock_irqsave(&ima_keys_lock, flags);
>          if (!ima_process_keys) {
>                  list_add_tail(&entry->list, &ima_keys);
>                  queued = true;
>          }
> -       spin_unlock(&ima_keys_lock);
> +       spin_unlock_irqrestore(&ima_keys_lock, flags);
> 
>          if (!queued)
>                  ima_free_key_entry(entry);
> 
