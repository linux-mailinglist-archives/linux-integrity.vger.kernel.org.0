Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2AB13B0A9
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 18:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgANRSu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 12:18:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53486 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANRSt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 12:18:49 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id C35EE2008710;
        Tue, 14 Jan 2020 09:18:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C35EE2008710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579022329;
        bh=1Hl9ojLlmJi+C3sompTjr5GEjaqrcwfxrSpMjE5P+Tw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FlmnxcaPa1H3dOd3pnlZ70nsLmEI2rTJ0m6NSL04ISPo4CUwcXv5Indb/6+4OUmUU
         E5rLdXFshvNbw49/LZ8ExeKcblnnINuE3HcCTG9cU6PRl+VTL3rczMaQS889DcLIao
         m9Yf3OoPnI5GJYEOVpV6mp1IeUBKO5zD1ulRPkiw=
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
Message-ID: <52f0bced-2d8b-bdf4-b65a-26689ea1aed1@linux.microsoft.com>
Date:   Tue, 14 Jan 2020 09:19:06 -0800
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

Hi Dmitry,

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

Using sping_lock_irqsave() and spin_lock_irqrestore() in ima_queue_key() 
is the right approach. Found a relevant blog below:

https://stackoverflow.com/questions/50637489/spin-lock-irqsave-in-interrupt-context

I think it would be safe to use the same spinlock functions in 
ima_process_queued_keys() as well, but not a must.

Could you please confirm if your change fixed the crash?
I'll post a patch shortly.

thanks,
  -lakshmi

