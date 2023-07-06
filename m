Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B4B74A05E
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jul 2023 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGFPF1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jul 2023 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGFPF0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jul 2023 11:05:26 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D010F5;
        Thu,  6 Jul 2023 08:05:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Qxfgh6qf8z9xFGj;
        Thu,  6 Jul 2023 22:54:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB37fj_16Zk1UMwBA--.58227S2;
        Thu, 06 Jul 2023 16:04:49 +0100 (CET)
Message-ID: <b497e9af87064089409f5013eef01b40e91618b6.camel@huaweicloud.com>
Subject: Re: [QUESTION] Full user space process isolation?
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     "Dr. Greg" <greg@enjellic.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
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
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 06 Jul 2023 17:04:28 +0200
In-Reply-To: <932ace044d3e0230cd21b8ded1d024889a94c405.camel@huaweicloud.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
         <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
         <ab8e68962feba9f16ed0a715d46ed003da61cfe8.camel@huaweicloud.com>
         <17702e7f-479a-22b8-70d9-56e418c8120b@huawei.com>
         <20230706105304.GA26175@wind.enjellic.com>
         <932ace044d3e0230cd21b8ded1d024889a94c405.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwB37fj_16Zk1UMwBA--.58227S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww13WFy8ZFWkuryDCFWrAFb_yoW3GFW3pF
        W5Kay5KF1ktw1SyryIqw4fZa4Sy397J3W3WrnxGryfAwn09F1I9F12gr1a9F9FqrsYgw1Y
        qr45try293WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4vaEQABs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-07-06 at 13:35 +0200, Roberto Sassu wrote:
> On Thu, 2023-07-06 at 05:53 -0500, Dr. Greg wrote:
> > On Tue, Jul 04, 2023 at 05:18:43PM +0200, Petr Tesarik wrote:
> > 
> > Good morning, I hope the week is going well for everyone.
> > 
> > > On 7/3/2023 5:28 PM, Roberto Sassu wrote:
> > > > On Mon, 2023-07-03 at 17:06 +0200, Jann Horn wrote:
> > > > > On Thu, Jun 22, 2023 at 4:45???PM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > I wanted to execute some kernel workloads in a fully isolated user
> > > > > > space process, started from a binary statically linked with klibc,
> > > > > > connected to the kernel only through a pipe.
> > > > > 
> > > > > FWIW, the kernel has some infrastructure for this already, see
> > > > > CONFIG_USERMODE_DRIVER and kernel/usermode_driver.c, with a usage
> > > > > example in net/bpfilter/.
> > > > 
> > > > Thanks, I actually took that code to make a generic UMD management
> > > > library, that can be used by all use cases:
> > > > 
> > > > https://lore.kernel.org/linux-kernel/20230317145240.363908-1-roberto.sassu@huaweicloud.com/
> > > > 
> > > > > > I also wanted that, for the root user, tampering with that process is
> > > > > > as hard as if the same code runs in kernel space.
> > > > > 
> > > > > I believe that actually making it that hard would probably mean that
> > > > > you'd have to ensure that the process doesn't use swap (in other
> > > > > words, it would have to run with all memory locked), because root can
> > > > > choose where swapped pages are stored. Other than that, if you mark it
> > > > > as a kthread so that no ptrace access is allowed, you can probably get
> > > > > pretty close. But if you do anything like that, please leave some way
> > > > > (like a kernel build config option or such) to enable debugging for
> > > > > these processes.
> > > > 
> > > > I didn't think about the swapping part... thanks!
> > > > 
> > > > Ok to enable debugging with a config option.
> > > > 
> > > > > But I'm not convinced that it makes sense to try to draw a security
> > > > > boundary between fully-privileged root (with the ability to mount
> > > > > things and configure swap and so on) and the kernel - my understanding
> > > > > is that some kernel subsystems don't treat root-to-kernel privilege
> > > > > escalation issues as security bugs that have to be fixed.
> > > > 
> > > > Yes, that is unfortunately true, and in that case the trustworthy UMD
> > > > would not make things worse. On the other hand, on systems where that
> > > > separation is defined, the advantage would be to run more exploitable
> > > > code in user space, leaving the kernel safe.
> > > > 
> > > > I'm thinking about all the cases where the code had to be included in
> > > > the kernel to run at the same privilege level, but would not use any of
> > > > the kernel facilities (e.g. parsers).
> > > 
> > > Thanks for reminding me of kexec-tools. The complete image for booting a
> > > new kernel was originally prepared in user space. With kernel lockdown,
> > > all this code had to move into the kernel, adding a new syscall and lots
> > > of complexity to build purgatory code, etc. Yet, this new implementation
> > > in the kernel does not offer all features of kexec-tools, so both code
> > > bases continue to exist and are happily diverging...
> > > 
> > > > If the boundary is extended to user space, some of these components
> > > > could be moved away from the kernel, and the functionality would be the
> > > > same without decreasing the security.
> > 
> > > All right, AFAICS your idea is limited to relatively simple cases
> > > for now. I mean, allowing kexec-tools to run in user space is not
> > > easily possible when UID 0 is not trusted, because kexec needs to
> > > open various files and make various other syscalls, which would
> > > require a complex LSM policy. It looks technically possible to write
> > > one, but then the big question is if it would be simpler to review
> > > and maintain than adding more kexec-tools features to the kernel.
> > 
> > You either need to develop and maintain a complex system-wide LSM
> > policy or you need a security model that is specifically tuned and
> > then scoped to the needs of the workload running on behalf of the
> > kernel as a UID=0 userspace process.
> > 
> > As I noted in my e-mail to Roberto, our TSEM LSM brings forward the
> > ability to do both, as a useful side effect of the need to limit model
> > complexity when the objective is to have a single functional
> > description of the security state of a system.
> > 
> > > Anyway, I can sense a general desire to run less code in the most
> > > privileged system environment. Robert's proposal is one of few that
> > > go in this direction. What are the alternatives?
> > 
> > As I noted above, TSEM brings the ability to provide highly specific
> > and narrowly scoped security policy to a process heirarchy
> > ie. workload.
> > 
> > However, regardless of the technology applied, in order to pursue
> > Roberto's UMD model of having a uid=0 process run tasks on behalf of
> > the kernel, there would seem to be a need to define what the security
> > objectives are.
> > 
> > From the outside looking in, there would seem to be a need to address
> > two primary issues:
> > 
> > 1: Trust/constrain what the UMD process can do.
> 
> Very simple:
> 
> read from a kernel-opened fd, write to another kernel-opened fd, close
> the fds and exit.
> 
> With the seccomp strict profile, a process cannot call any other system
> call, and it gets killed if it does.
> 
> I tried to write a BPF filter, to see how far I can go, and that seems
> sufficient to constrain what the UMD process can do.
> 
> Please note that the UMD process setup is done by the kernel, before
> any user space code has the chance to run. The kernel is responsible to
> properly establish the communication with the UMD process.
> 
> > 2: Constrain what the system at large can do to the UMD process.
> 
> If someone outside can influence the behavior of the UMD process,
> meaning altering the result, that would be unacceptable.
> 
> I found that denying ptrace on the UMD process as target, more or less
> covers everything, even trying to read or write /proc/<pid>/fd/<N>.
> 
> There might be something more subtle, like what Iann pointed out, avoid
> swapping of the UMD process, as there is no integrity check when the
> page comes back.
> 
> Other than that, I was limiting the kill, maybe we have to do something
> similar with io_uring (but we would know if the UMD process uses it).
> With that in place, the UMD process seems pretty much isolated.
> 
> I would definitely not complicate things more than that, seems that
> this problem is already difficult enough to solve.
> 
> Since the goal is very specific, I think writing a very small LSM would
> make sense. With SELinux or Smack, you could also do it, but you have
> to care about loading a policy, enforcing, etc..
> 
> The main question is if the kernel is able to enforce isolation on the
> UMD process as it would do for itself.

For those who didn't receive the patch set I just sent, I worked around
the first problem of supporting PGP for verifying the authenticity of
RPM headers and use them with IMA Appraisal.

I introduced in the kernel a new key format, TLV-based, and plan to let
Linux distribution vendors convert PGP keys to this new format in their
building infrastructure (trusted). The converted keys are embedded in
the kernel image.

Signatures can be converted in user space at run-time, since altering
them would make signature verification fail.

You can find the patch set here:

https://lore.kernel.org/linux-integrity/20230706144225.1046544-1-roberto.sassu@huaweicloud.com/

Thanks

Roberto

