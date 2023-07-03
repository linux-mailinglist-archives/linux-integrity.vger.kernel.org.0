Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B106F745FF9
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 17:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGCPjK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGCPjJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 11:39:09 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC4BE58;
        Mon,  3 Jul 2023 08:39:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QvqX441y1z9xFr7;
        Mon,  3 Jul 2023 23:26:28 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA39kxs66JkU3IEBA--.51187S2;
        Mon, 03 Jul 2023 16:38:34 +0100 (CET)
Message-ID: <6526255a4e30f0222b3469975d6a7537c2d69e41.camel@huaweicloud.com>
Subject: Re: [QUESTION] Full user space process isolation?
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. Greg" <greg@enjellic.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        LuisChamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Date:   Mon, 03 Jul 2023 17:38:18 +0200
In-Reply-To: <2939cc00-2b8b-bf9a-45bc-b9a2d8d8def1@schaufler-ca.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
         <20230629021000.GA368825@mail.hallyn.com>
         <14599d8216f1b7520ff5f6cfb27377fa79709f13.camel@huaweicloud.com>
         <20230702175542.GA25867@wind.enjellic.com>
         <0870d82571d1075433a2b81b2953cf8b4afcd415.camel@huaweicloud.com>
         <2939cc00-2b8b-bf9a-45bc-b9a2d8d8def1@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwA39kxs66JkU3IEBA--.51187S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5ArykZw47Jr47KF4DJwb_yoW7WF4rpF
        W3tay3KF4ktF13Ar1qqw48uFWYy393Jry7XrnYq34rJwn0vrn3Cr1xtF1fuFyDGrWxJw1j
        vFWUt3sxXw1qvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
        W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1
        VOJ5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4+y0QABse
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-07-03 at 07:43 -0700, Casey Schaufler wrote:
> On 7/3/2023 12:57 AM, Roberto Sassu wrote:
> > On Sun, 2023-07-02 at 12:55 -0500, Dr. Greg wrote:
> > > On Thu, Jun 29, 2023 at 10:11:26AM +0200, Roberto Sassu wrote:
> > > 
> > > Good morning, I hope the weekend is going well for everyone, greetings
> > > to Roberto and everyone copied.
> > > 
> > > > On Wed, 2023-06-28 at 21:10 -0500, Serge E. Hallyn wrote:
> > > > > On Thu, Jun 22, 2023 at 04:42:37PM +0200, Roberto Sassu wrote:
> > > > > > Hi everyone
> > > > > > 
> > > > > > I briefly discussed this topic at LSS NA 2023, but I wanted to have an
> > > > > > opinion from a broader audience.
> > > > > > 
> > > > > > In short:
> > > > > > 
> > > > > > I wanted to execute some kernel workloads in a fully isolated user
> > > > > > space process, started from a binary statically linked with klibc,
> > > > > > connected to the kernel only through a pipe.
> > > > > > 
> > > > > > I also wanted that, for the root user, tampering with that process is
> > > > > > as hard as if the same code runs in kernel space.
> > > > > > 
> > > > > > I would use the fully isolated process to parse and convert unsupported
> > > > > > data formats to a supported one, after the kernel verified the
> > > > > Can you give some examples here of supported and unsupported data
> > > > > formats?  ext2 is supported, but we sadly don't trust the sb parser
> > > > > to read a an ext2fs coming from unknown source.  So I'm not quite
> > > > > clear what problem you're trying to solve.
> > > > + eBPF guys (as I'm talking about eBPF)
> > > If the week goes well, we will be submitting the second version of our
> > > TSEM LSM for review.  It incorporates a significant number of changes
> > > and enhancements, based on both initial review comments, and
> > > importantly, feedback from our collaborators in the critical
> > > infrastructure community.
> > > 
> > > Just as a levelset.  TSEM provides kernel infrastructure to implement
> > > security controls based on either deterministic or machine learning
> > > models.  Quixote is the userspace infrastructure that enables use of
> > > the TSEM kernel infrastructure.
> > > 
> > > Based on your description Roberto, TSEM may be of assistance in
> > > addressesing your issues at two different levels.
> > > 
> > > First with respect to protection of an isolated workload.
> > > 
> > > TSEM is inherently workload based, given that it is based on an
> > > architecture that implements security modeling namespaces that a
> > > process heirarchy can be placed into.  This reduces model complexity
> > > and provides the implementation of very specific and targeted security
> > > controls based on the needs of a proposed workload.
> > > 
> > > The security controls are prospective rather than retrospective,
> > > ie. TSEM will pro-actively block any security behaviors that are not
> > > in a security model that has been defined for the workload.
> > > 
> > > For example, with respect to the concerns you had previously mentioned
> > > about ptrace.  If the security model definition does not include a
> > > security state coefficient for a ptrace_traceme security event, it
> > > will be disallowed, regardless of what goes on with respect to kernel
> > > development, modulo of course the ptrace_traceme LSM hook being
> > > discontinued.
> > Hi Greg
> > 
> > thanks for your insights.
> > 
> > The policy is quite simple:
> > 
> > 
> >      r/w  ^                             kernel space
> > ----------|-----------------------------------------
> >           v (pipe)                        user space
> >  +-----------------+       +-----------------------+
> >  | trustworthy UMD |---X---| rest of the processes |
> >  +-----------------+       +-----------------------+
> > 
> > The question was more, is the LSM infrastructure complete enough that
> > the X can be really enforced?
> 
> I believe that it is. SELinux and Smack, users of the LSM infrastructure,
> enforce "X". They also require netlabel for IP communications, and Smack
> falls short on newer protocols, but that's not the fault of LSM.
> 
> > 
> > Could there be other implicit information flows that the LSM
> > infrastructure is not able/does not yet mediate, that could break the
> > policy above?
> 
> Sure. Every so often something pops into the kernel (e.g. io_uring)
> without proper LSM integration. We try to discourage that, and correct
> it when we find it.

Well, ok. I guess Paul's point was that it is better to write code in
the kernel to be sure, than running in this kind of risk. Maybe for
certain workloads, it is a much better choice.

For example, if the trustworthy UMD had the task to extract the crypto
material from X.509 certificates an PKCS#7 signatures, and pass it to
the kernel, breaking the isolation almost certainly would mean that the
kernel accepts more kernel modules than it should.

The question would be, if we restrict the scope of data processed by
trustworthy UMDs, would that make the solution more acceptable?

An idea for example would be: if we do appraisal with the traditional
methods (signature in the xattr, HMAC, etc.) the trustworthy UMD would
not have any impact.

Only if the IMA policy says, allow appraisal based on what the
trustworthy UMD provides, maybe it is ok? (Mimi?)

Thanks

Roberto

> > 
> > I guess TSEM could be for more elaborated security models, but in this
> > case the policy is quite straithforward. Also, your TSEM would be as
> > limited as mine by the LSM hooks available.
> > 
> > Thanks
> > 
> > Roberto
> > 

