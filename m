Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886C2747522
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jul 2023 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjGDPTC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jul 2023 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjGDPTA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jul 2023 11:19:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD6010EC;
        Tue,  4 Jul 2023 08:18:47 -0700 (PDT)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QwRFJ3CTLz67cSL;
        Tue,  4 Jul 2023 23:15:48 +0800 (CST)
Received: from [10.45.151.231] (10.45.151.231) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 17:18:44 +0200
Message-ID: <17702e7f-479a-22b8-70d9-56e418c8120b@huawei.com>
Date:   Tue, 4 Jul 2023 17:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [QUESTION] Full user space process isolation?
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jann Horn <jannh@google.com>
CC:     Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        LuisChamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, <linux-mm@kvack.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
 <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
 <ab8e68962feba9f16ed0a715d46ed003da61cfe8.camel@huaweicloud.com>
Content-Language: en-US
From:   Petr Tesarik <petr.tesarik.ext@huawei.com>
In-Reply-To: <ab8e68962feba9f16ed0a715d46ed003da61cfe8.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.45.151.231]
X-ClientProxiedBy: frapeml100004.china.huawei.com (7.182.85.167) To
 frapeml500002.china.huawei.com (7.182.85.205)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/3/2023 5:28 PM, Roberto Sassu wrote:
> On Mon, 2023-07-03 at 17:06 +0200, Jann Horn wrote:
>> On Thu, Jun 22, 2023 at 4:45 PM Roberto Sassu
>> <roberto.sassu@huaweicloud.com> wrote:
>>> I wanted to execute some kernel workloads in a fully isolated user
>>> space process, started from a binary statically linked with klibc,
>>> connected to the kernel only through a pipe.
>>
>> FWIW, the kernel has some infrastructure for this already, see
>> CONFIG_USERMODE_DRIVER and kernel/usermode_driver.c, with a usage
>> example in net/bpfilter/.
> 
> Thanks, I actually took that code to make a generic UMD management
> library, that can be used by all use cases:
> 
> https://lore.kernel.org/linux-kernel/20230317145240.363908-1-roberto.sassu@huaweicloud.com/
> 
>>> I also wanted that, for the root user, tampering with that process is
>>> as hard as if the same code runs in kernel space.
>>
>> I believe that actually making it that hard would probably mean that
>> you'd have to ensure that the process doesn't use swap (in other
>> words, it would have to run with all memory locked), because root can
>> choose where swapped pages are stored. Other than that, if you mark it
>> as a kthread so that no ptrace access is allowed, you can probably get
>> pretty close. But if you do anything like that, please leave some way
>> (like a kernel build config option or such) to enable debugging for
>> these processes.
> 
> I didn't think about the swapping part... thanks!
> 
> Ok to enable debugging with a config option.
> 
>> But I'm not convinced that it makes sense to try to draw a security
>> boundary between fully-privileged root (with the ability to mount
>> things and configure swap and so on) and the kernel - my understanding
>> is that some kernel subsystems don't treat root-to-kernel privilege
>> escalation issues as security bugs that have to be fixed.
> 
> Yes, that is unfortunately true, and in that case the trustworthy UMD
> would not make things worse. On the other hand, on systems where that
> separation is defined, the advantage would be to run more exploitable
> code in user space, leaving the kernel safe.
> 
> I'm thinking about all the cases where the code had to be included in
> the kernel to run at the same privilege level, but would not use any of
> the kernel facilities (e.g. parsers).

Thanks for reminding me of kexec-tools. The complete image for booting a
new kernel was originally prepared in user space. With kernel lockdown,
all this code had to move into the kernel, adding a new syscall and lots
of complexity to build purgatory code, etc. Yet, this new implementation
in the kernel does not offer all features of kexec-tools, so both code
bases continue to exist and are happily diverging...

> If the boundary is extended to user space, some of these components
> could be moved away from the kernel, and the functionality would be the
> same without decreasing the security.

All right, AFAICS your idea is limited to relatively simple cases for
now. I mean, allowing kexec-tools to run in user space is not easily
possible when UID 0 is not trusted, because kexec needs to open various
files and make various other syscalls, which would require a complex LSM
policy. It looks technically possible to write one, but then the big
question is if it would be simpler to review and maintain than adding
more kexec-tools features to the kernel.

Anyway, I can sense a general desire to run less code in the most
privileged system environment. Robert's proposal is one of few that go
in this direction. What are the alternatives?

Petr T

