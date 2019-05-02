Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD612024
	for <lists+linux-integrity@lfdr.de>; Thu,  2 May 2019 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEBQ3F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 12:29:05 -0400
Received: from sonic308-8.consmr.mail.bf2.yahoo.com ([74.6.130.47]:45791 "EHLO
        sonic308-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfEBQ3F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 12:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1556814543; bh=H2HJJesMA20BcYlJ+IOaax9VIeLCiinnSIhrnVVMHXE=; h=From:Subject:To:Cc:References:Date:In-Reply-To:From:Subject; b=KlNxglbHKJOisGlvlPTmrXU+egzI9pXzdY9co9OQCrQIAyfXMaKzspmvgGItp8d5W8O7cmUhkQmDXSb1FHfjLaehQUCwZtPhC+1LqV2h1GGzMuOrsHvn2KtQPr2xLFbzaerZStbnGPtU4mzd4NZQvhRSHxqxSJZRsFWfH4BHOs79n9oqorgzsEJMa0oMOEF3xud07AJ6ZGEQ1AJ4ybF79s1Lc9JrIPBmoD3D545rx8lptLpWCmfT7YS64cqTqn2xd8EBE3uBva5ReVUNM5Y1+W37/uTEntbWtUevesUnp+3uUDjIzxbBUS4nWuJlKNs21pC2Km59lowKwBJP8FTaOw==
X-YMail-OSG: KTxj1FUVM1mLqkxD6A.OYugj.k8xCJODq.rjAJmhegyCATWb6r2dAuIZjCJR3Mz
 wbgoL4DCYzB27TxZ78xDMyJupXa1Y3M9ROGneF3Q8U.O3mbGGHUc_wxnXewhtsWWDlBTThcdrPXT
 bQdlCg.99Ds_4rpJSiO40mACqAGTU51nT.dF29EZQFJYzVHA8HuJk0OjUG4LwEs2M1Ur2eDea23y
 bCoFpbF6IDq8OmslgvdQQFXIVbET0KYeHSFaP19qL7Ku1Cs5V8Bw7Ow4gzt8Aq9R32FSrP22Q9u6
 dqf1mZLKVcKPXUCf5mO9bX_u20E0vL4eq6WSWCfht20fe2K2Z05cWmShpdOkIVlQw2ZMiWvtpPIM
 lVherVpi04Hb9kQhsDDlMQ65raphU0t2l09Q1CXle.gREWoo9ceYOP5rGt71x3EVsaSelbLUoY_a
 jLpVsWg9.EYsxy0fDdpsNIdY0Vlt8tLvL6Z1VZciaonhTHSTdv9ni.3QYWnGKkbFpT6EsZ6KJBP2
 AppPJDGh82inBJqCmNBGFpjP5om0aDTuX_8brYDTXzmZQbb0xmMRlKppwV4kN4r672i2u.9Weq9t
 i5m5aQj5qJqhjWAM85EsHZ429Hz9KLso2vnydrkcWpwvDJ_6nkmGPaWD89m.aFuoFdseNR0rFwef
 jpi5Nu9yR4.LNoTC4AMs1ROel.5tAUFP4ZJiL_Pb9j3O8_XWwWx0hiY8xTRowgCR1HjmFGpCgtdy
 DyVgzD9lGG9OGTmjGA6ZMX0.vOX2BmZnZMKpS2V1_gRhObhwQ404H3lsRzGYWfR.3QT_jzx8gITg
 W01U4uwnOh1f_ZFW1ytq5trh8f4TtzQfbvyYICC7D9.qAx5GWeHF55LCJf9O.l81F9TcQZax1mmE
 aqawpk7sKdGTY8XQZomVyiPGbw0v391uelBU.JpQK.GcQSLD0cy6PTJrv73dsBLlzeJDl3bER73V
 oawUN2yM4kjBjsTVrSnS2oagktVBSTseB6g57sEWrCpbcm90A6kwL9wtK.Zev6R_1vZrNiF21gvh
 XPGhdWlG603NAzY2.1_3nEAplhVTcbIHON7.gA70AW4vOFI5lQetDoQ6_uWrJboC6QcJ52xfm23_
 q49EX5GuVmd9OD.NpbICukcA4E8Q_FCH_2swnfSN5pmHfZSfY4wVgggnBOFfuOfowreS8FJOHbo3
 Llyw.duZKK.dVunulCC.DA1fz9JNEuafa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Thu, 2 May 2019 16:29:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1fa7d2e534e1a0e9e92015fab12bde34;
          Thu, 02 May 2019 16:29:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] kexec_buffer measure
To:     Mimi Zohar <zohar@linux.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        casey@schaufler-ca.com
References: <CAEFn8qKkXgxUKtribbtFwvG9NykGQo10jQ5Du_i9wJz-wKreOA@mail.gmail.com>
 <1555978681.4914.305.camel@linux.ibm.com>
 <1556812101.4134.28.camel@linux.ibm.com>
Message-ID: <7af61ebe-28a8-799c-fe47-d72f247494ed@schaufler-ca.com>
Date:   Thu, 2 May 2019 09:28:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556812101.4134.28.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/2/2019 8:48 AM, Mimi Zohar wrote:
> [Cc'ing Paul, John, Casey]
>
> On Mon, 2019-04-22 at 20:18 -0400, Mimi Zohar wrote:
>> [Cc'ing LSM mailing list]
>>
>> On Fri, 2019-04-19 at 17:30 -0700, prakhar srivastava wrote:
>>
>>> 2) Adding a LSM hook
>>> We are doing both the command line and kernel version measurement in IMA.
>>> Can you please elaborate on how this can be used outside of the scenario?
>>> That will help me come back with a better design and code. I am
>>> neutral about this.
>> As I said previously, initially you might want to only measure the
>> kexec boot command line, but will you ever want to verify or audit log
>> the boot command line hash?????Perhaps LSMs would be interested in the
>> boot command line. ??Should this be an LSM hook?
>   From an LSM perspective, is there any interest in the boot command line?

I can imagine an LSM that cares about the command line,
but I don't have interest in it for any work I have in progress.

> Mimi
>
