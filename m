Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AFE749ACE
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jul 2023 13:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGFLhA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jul 2023 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjGFLg7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jul 2023 07:36:59 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C019A7;
        Thu,  6 Jul 2023 04:36:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QxZ1329c9z9xFbN;
        Thu,  6 Jul 2023 19:24:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXXWQcp6Zkn5EkBA--.56266S2;
        Thu, 06 Jul 2023 12:36:14 +0100 (CET)
Message-ID: <932ace044d3e0230cd21b8ded1d024889a94c405.camel@huaweicloud.com>
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
Date:   Thu, 06 Jul 2023 13:35:52 +0200
In-Reply-To: <20230706105304.GA26175@wind.enjellic.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
         <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
         <ab8e68962feba9f16ed0a715d46ed003da61cfe8.camel@huaweicloud.com>
         <17702e7f-479a-22b8-70d9-56e418c8120b@huawei.com>
         <20230706105304.GA26175@wind.enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwDXXWQcp6Zkn5EkBA--.56266S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww17ury8Zr1kAF4furWxZwb_yoWfuF1DpF
        W3KF42kF1kJ3WxAryIqw18uaySy395JF13Xr93KryfAwn09r1IkF12qr1fuFyDXrZagw1Y
        q3yYyr9Fv3WDZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4vXUAAAsx
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-07-06 at 05:53 -0500, Dr. Greg wrote:
> On Tue, Jul 04, 2023 at 05:18:43PM +0200, Petr Tesarik wrote:
> 
> Good morning, I hope the week is going well for everyone.
> 
> > On 7/3/2023 5:28 PM, Roberto Sassu wrote:
> > > On Mon, 2023-07-03 at 17:06 +0200, Jann Horn wrote:
> > > > On Thu, Jun 22, 2023 at 4:45???PM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > I wanted to execute some kernel workloads in a fully isolated user
> > > > > space process, started from a binary statically linked with klibc,
> > > > > connected to the kernel only through a pipe.
> > > > 
> > > > FWIW, the kernel has some infrastructure for this already, see
> > > > CONFIG_USERMODE_DRIVER and kernel/usermode_driver.c, with a usage
> > > > example in net/bpfilter/.
> > > 
> > > Thanks, I actually took that code to make a generic UMD management
> > > library, that can be used by all use cases:
> > > 
> > > https://lore.kernel.org/linux-kernel/20230317145240.363908-1-roberto.sassu@huaweicloud.com/
> > > 
> > > > > I also wanted that, for the root user, tampering with that process is
> > > > > as hard as if the same code runs in kernel space.
> > > > 
> > > > I believe that actually making it that hard would probably mean that
> > > > you'd have to ensure that the process doesn't use swap (in other
> > > > words, it would have to run with all memory locked), because root can
> > > > choose where swapped pages are stored. Other than that, if you mark it
> > > > as a kthread so that no ptrace access is allowed, you can probably get
> > > > pretty close. But if you do anything like that, please leave some way
> > > > (like a kernel build config option or such) to enable debugging for
> > > > these processes.
> > > 
> > > I didn't think about the swapping part... thanks!
> > > 
> > > Ok to enable debugging with a config option.
> > > 
> > > > But I'm not convinced that it makes sense to try to draw a security
> > > > boundary between fully-privileged root (with the ability to mount
> > > > things and configure swap and so on) and the kernel - my understanding
> > > > is that some kernel subsystems don't treat root-to-kernel privilege
> > > > escalation issues as security bugs that have to be fixed.
> > > 
> > > Yes, that is unfortunately true, and in that case the trustworthy UMD
> > > would not make things worse. On the other hand, on systems where that
> > > separation is defined, the advantage would be to run more exploitable
> > > code in user space, leaving the kernel safe.
> > > 
> > > I'm thinking about all the cases where the code had to be included in
> > > the kernel to run at the same privilege level, but would not use any of
> > > the kernel facilities (e.g. parsers).
> > 
> > Thanks for reminding me of kexec-tools. The complete image for booting a
> > new kernel was originally prepared in user space. With kernel lockdown,
> > all this code had to move into the kernel, adding a new syscall and lots
> > of complexity to build purgatory code, etc. Yet, this new implementation
> > in the kernel does not offer all features of kexec-tools, so both code
> > bases continue to exist and are happily diverging...
> > 
> > > If the boundary is extended to user space, some of these components
> > > could be moved away from the kernel, and the functionality would be the
> > > same without decreasing the security.
> 
> > All right, AFAICS your idea is limited to relatively simple cases
> > for now. I mean, allowing kexec-tools to run in user space is not
> > easily possible when UID 0 is not trusted, because kexec needs to
> > open various files and make various other syscalls, which would
> > require a complex LSM policy. It looks technically possible to write
> > one, but then the big question is if it would be simpler to review
> > and maintain than adding more kexec-tools features to the kernel.
> 
> You either need to develop and maintain a complex system-wide LSM
> policy or you need a security model that is specifically tuned and
> then scoped to the needs of the workload running on behalf of the
> kernel as a UID=0 userspace process.
> 
> As I noted in my e-mail to Roberto, our TSEM LSM brings forward the
> ability to do both, as a useful side effect of the need to limit model
> complexity when the objective is to have a single functional
> description of the security state of a system.
> 
> > Anyway, I can sense a general desire to run less code in the most
> > privileged system environment. Robert's proposal is one of few that
> > go in this direction. What are the alternatives?
> 
> As I noted above, TSEM brings the ability to provide highly specific
> and narrowly scoped security policy to a process heirarchy
> ie. workload.
> 
> However, regardless of the technology applied, in order to pursue
> Roberto's UMD model of having a uid=0 process run tasks on behalf of
> the kernel, there would seem to be a need to define what the security
> objectives are.
> 
> From the outside looking in, there would seem to be a need to address
> two primary issues:
> 
> 1: Trust/constrain what the UMD process can do.

Very simple:

read from a kernel-opened fd, write to another kernel-opened fd, close
the fds and exit.

With the seccomp strict profile, a process cannot call any other system
call, and it gets killed if it does.

I tried to write a BPF filter, to see how far I can go, and that seems
sufficient to constrain what the UMD process can do.

Please note that the UMD process setup is done by the kernel, before
any user space code has the chance to run. The kernel is responsible to
properly establish the communication with the UMD process.

> 2: Constrain what the system at large can do to the UMD process.

If someone outside can influence the behavior of the UMD process,
meaning altering the result, that would be unacceptable.

I found that denying ptrace on the UMD process as target, more or less
covers everything, even trying to read or write /proc/<pid>/fd/<N>.

There might be something more subtle, like what Iann pointed out, avoid
swapping of the UMD process, as there is no integrity check when the
page comes back.

Other than that, I was limiting the kill, maybe we have to do something
similar with io_uring (but we would know if the UMD process uses it).
With that in place, the UMD process seems pretty much isolated.

I would definitely not complicate things more than that, seems that
this problem is already difficult enough to solve.

Since the goal is very specific, I think writing a very small LSM would
make sense. With SELinux or Smack, you could also do it, but you have
to care about loading a policy, enforcing, etc..

The main question is if the kernel is able to enforce isolation on the
UMD process as it would do for itself.

I'm not considering confidentiality for now, just integrity. And with
the most simple case of the UMD process only communicating with the
kernel (sufficient for my use cases).

> As we have seen before, requirement 1 implies a definition of what it
> means for a process to be 'trusted'.
> 
> In the absence of formal verification, which appears to be a
> non-starter in practice, this would seem to imply defining a standard
> for the allowed security behavior of the UMD workload.
> 
> From our perspective, with TSEM, we define 'trusted' for a workload to
> mean that it has not requested a security behavior inconsistent with
> what the workload has been unit tested to.  If a process does this, its
> ability to execute additional security behaviors is curtailed.
> 
> With respect to requirement two.
> 
> Here is the ASCII art diagram of Roberto's proposed system:
> 
>      r/w  ^                             kernel space
> ----------|-----------------------------------------
>           v (pipe)                        user space
>  +-----------------+       +-----------------------+
>  | trustworthy UMD |---X---| rest of the processes |
>  +-----------------+       +-----------------------+
> 
> Casey noted that he believed the Linux LSM had sufficient coverage to
> provide the necessary security controls for this model.  He
> specifically mentioned that it had support for network traffic
> controls and labeling.
> 
> I haven't seen a reply from Roberto to my e-mail questioning what the
> following means:
> 
> ---X---

That means no communication.

Thanks

Roberto

> But I get the sense that it means that any other process in userspace
> couldn't have any impact, or I assume visibility, into what the UID=0
> process is doing on behalf of the kernel.  I don't think it means that
> there is supposed to be some type of highly controlled traffic between
> the UMD and other processes.
> 
> We will see what comments Roberto has on this.
> 
> This arguably may be the most difficult requirement to meet if our
> interpretation of this requirement is correct, particularly so if this
> involves a confidentiality requirement, perhaps a bit less so if there
> is only a requirement of integrity of execution.
> 
> As I mentioned in a previous e-mail, depending on the requirements,
> issue 2 starts to look a lot like protected enclave technologies such
> as SGX.  As history has shown, providing a protected execution
> environment, against the rest of the system, is a somewhat formidable
> undertaking, with probably a requirement for hardware support if SGX
> and/or TDX are any examples.
> 
> So, I believe that TSEM brings useful technology to the table, but
> regardless of technology, it would seem there is a need to
> specifically define the security requirements for the UMD model.
> 
> > Petr T
> 
> Have a good day.
> 
> As always,
> Dr. Greg
> 
> The Quixote Project - Flailing at the Travails of Cybersecurity

