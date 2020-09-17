Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7778726E6E7
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 22:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIQUr5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 16:47:57 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:51282 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQUr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 16:47:57 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 16:47:56 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru EA3FD20A0DC1
Received: from LanCloud
Received: from LanCloud
Subject: Re: LSM that blocks execution of the code from the anonymous pages
To:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <5f166ecd-38e4-a808-c377-683aabf6bf65@omprussia.ru>
 <2ba01c4961b2b967bb314e2d618a92e91d4fe511.camel@linux.ibm.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <88b9444e-08bc-4240-7943-298070dfc47c@omprussia.ru>
Date:   Thu, 17 Sep 2020 23:39:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2ba01c4961b2b967bb314e2d618a92e91d4fe511.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.179.245.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To LFEX15.lancloud.ru
 (fd00:f066::45)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

My question is more about whether this functionality fits into IMA's
responsibility. I.e. I can propose the changes as the extension of IMA's
functionality (which I think it would be better), or I could create a separate
LSM if this functionality doesn't align with IMA's purpose for some reason.
This is the first question.

And the second question, what kind of operation modes do you think would
be useful?

1) no anonymous code for privileged processes (as currently),
2) no anonymous code for all processes,
3) no anonymous code for all processes with xattr-based exceptions (may be
      with xattr value signing)

For #3 I definitely would prefer to implement the code as a part of IMA
because of sharing of xattrs cache, etc. to avoid reinventing the wheel.

Thank you.

On 17.09.2020 21:11, Mimi Zohar wrote:
> Hi Igor,
> 
> Sorry for the delay in responding.
> 
> On Thu, 2020-09-03 at 19:20 +0300, Igor Zhbanov wrote:
>> Hello!
>>
>> Earlier in the therad "Should mprotect(..., PROT_EXEC) be checked by IMA?"
>> we've discussed whether IMA should intercept making executable of anonymous
>> pages.
>>
>> I've implemented simple LSM that blocks execution of the code from anonymous
>> pages, like: mmap(RW) + read_unsigned_code_from_file() + mprotect(RX).
>>
>> Currently it uses hooks similar to selinux_mmap_file() and
>> selinux_file_mprotect() to restrict any privileged processes (any uid is 0,
>> or any gid is 0 or any capability is set) from executing of anonymous unsigned
>> code.
>>
>> The IMA module is specializing in file-backed (non-anonymous) code integrity
>> measurement while allowing execution of arbitrary anonymous code. In
>> conjunction with my LSM it would be possible to be sure that any code that is
>> executed on a device is trusted.
>>
>> This would prevent malware payloads from being downloaded and executed in
>> both file-backed and anonymous memory. For example, there is even a framework
>> for making of filless malware:
>> https://www.prodefence.org/fireelf-fileless-linux-malware-framework/
>> Also there is an article about execution of ELFs from memory:
>> https://magisterquis.github.io/2018/03/31/in-memory-only-elf-execution.html
>> https://blog.fbkcs.ru/elf-in-memory-execution/
>>
>> So it could be an independent LSM or extension of the LSM IMA functionality.
>>
>> Also I'm thinking about extending working modes to:
>> 1) no anonomous code for privileged processes (as currently),
>> 2) no anonomous code for all processes,
>> 3) no anonomous code for all processes with xattr-based exceptions (may be
>>      with xattr value signing)
>>
>> I've found that some applications like browsers are using anonymous code
>> pages for JavaScript JIT code. Also some processes are using libffi that also
>> modifies to code. But it looks like it's possible to rebuild libffi with
>> trampoline support (PaX compatibility mode) to avoid altering the code pages.
>> Also QML-based application also use JS JIT. (And may be python scripts too.)
>>
>> So for some (mostly unprivileged processes) we would need to make the
>> exceptions. But for most of the privileged system services (that is a good
>> target for attack because of their ptivileges) there is no need in code pages
>> modification, so the proposed functionality could be used to protect them,
>> as well as in embedded world where could be no user processes with JIT at all.
>>
>> So IMA with this LSM would ensure that all the code that is executes is
>> trusted, signed and verified.
>>
>> What do you think?
> 
> Preventing malware payloads from being downloaded and executed as
> either file-backed or from anonymous memory is really important.  As
> long as IMA has the ability to define a system wide integrity policy,
> it doesn't make a difference whether blocking anonymous pages is part
> of IMA or as a separate LSM.
> 
> If it's a separate LSM, then IMA would delegate responsibility for
> enforcing the IMA policy to the LSM.


-- 
Игорь Жбанов
зам. тех. директора по технологиям
ООО «Открытая мобильная платформа»
Тел.: +7 495 269-07-79, доб. 606
Моб.: +7 903 001-98-55
E-mail: i.zhbanov@omprussia.ru
