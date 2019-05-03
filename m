Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B4A125D7
	for <lists+linux-integrity@lfdr.de>; Fri,  3 May 2019 02:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfECAyE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 20:54:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55084 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECAyE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 20:54:04 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x430roj0088685;
        Fri, 3 May 2019 09:53:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Fri, 03 May 2019 09:53:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x430roWk088682
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 3 May 2019 09:53:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] kexec_buffer measure
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
References: <CAEFn8qKkXgxUKtribbtFwvG9NykGQo10jQ5Du_i9wJz-wKreOA@mail.gmail.com>
 <1555978681.4914.305.camel@linux.ibm.com>
 <1556812101.4134.28.camel@linux.ibm.com>
 <7af61ebe-28a8-799c-fe47-d72f247494ed@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <5490e443-b3ea-876e-a6b3-6a91005afe61@I-love.SAKURA.ne.jp>
Date:   Fri, 3 May 2019 09:53:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7af61ebe-28a8-799c-fe47-d72f247494ed@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019/05/03 1:28, Casey Schaufler wrote:
> On 5/2/2019 8:48 AM, Mimi Zohar wrote:
>> [Cc'ing Paul, John, Casey]
>>
>> On Mon, 2019-04-22 at 20:18 -0400, Mimi Zohar wrote:
>>> [Cc'ing LSM mailing list]
>>>
>>> On Fri, 2019-04-19 at 17:30 -0700, prakhar srivastava wrote:
>>>
>>>> 2) Adding a LSM hook
>>>> We are doing both the command line and kernel version measurement in IMA.
>>>> Can you please elaborate on how this can be used outside of the scenario?
>>>> That will help me come back with a better design and code. I am
>>>> neutral about this.
>>> As I said previously, initially you might want to only measure the
>>> kexec boot command line, but will you ever want to verify or audit log
>>> the boot command line hash? Perhaps LSMs would be interested in the
>>> boot command line. Should this be an LSM hook?
>>   From an LSM perspective, is there any interest in the boot command line?
> 
> I can imagine an LSM that cares about the command line,
> but I don't have interest in it for any work I have in progress.
> 

Since the kernel command line controls which LSMs to enable, I doubt that
an LSM which cares about the command line can detect that the kernel command
line was tampered when the kernel command line was tampered...
