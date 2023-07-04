Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5497477C2
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jul 2023 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGDR2p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jul 2023 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGDR2p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jul 2023 13:28:45 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 131B110D7;
        Tue,  4 Jul 2023 10:28:42 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 364HQt86009384;
        Tue, 4 Jul 2023 12:26:55 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 364HQrPS009383;
        Tue, 4 Jul 2023 12:26:53 -0500
Date:   Tue, 4 Jul 2023 12:26:53 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
Subject: Re: [QUESTION] Full user space process isolation?
Message-ID: <20230704172653.GA8804@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com> <20230629021000.GA368825@mail.hallyn.com> <14599d8216f1b7520ff5f6cfb27377fa79709f13.camel@huaweicloud.com> <20230702175542.GA25867@wind.enjellic.com> <0870d82571d1075433a2b81b2953cf8b4afcd415.camel@huaweicloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0870d82571d1075433a2b81b2953cf8b4afcd415.camel@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 04 Jul 2023 12:26:55 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 03, 2023 at 09:57:53AM +0200, Roberto Sassu wrote:

> On Sun, 2023-07-02 at 12:55 -0500, Dr. Greg wrote:
> > On Thu, Jun 29, 2023 at 10:11:26AM +0200, Roberto Sassu wrote:
> > 
> > Good morning, I hope the weekend is going well for everyone, greetings
> > to Roberto and everyone copied.
> > 
> > > On Wed, 2023-06-28 at 21:10 -0500, Serge E. Hallyn wrote:
> > > > On Thu, Jun 22, 2023 at 04:42:37PM +0200, Roberto Sassu wrote:
> > > > > Hi everyone
> > > > > 
> > > > > I briefly discussed this topic at LSS NA 2023, but I wanted to have an
> > > > > opinion from a broader audience.
> > > > > 
> > > > > In short:
> > > > > 
> > > > > I wanted to execute some kernel workloads in a fully isolated user
> > > > > space process, started from a binary statically linked with klibc,
> > > > > connected to the kernel only through a pipe.
> > > > > 
> > > > > I also wanted that, for the root user, tampering with that process is
> > > > > as hard as if the same code runs in kernel space.
> > > > > 
> > > > > I would use the fully isolated process to parse and convert unsupported
> > > > > data formats to a supported one, after the kernel verified the
> > > > 
> > > > Can you give some examples here of supported and unsupported data
> > > > formats?  ext2 is supported, but we sadly don't trust the sb parser
> > > > to read a an ext2fs coming from unknown source.  So I'm not quite
> > > > clear what problem you're trying to solve.
> > > 
> > > + eBPF guys (as I'm talking about eBPF)
> > 
> > If the week goes well, we will be submitting the second version of our
> > TSEM LSM for review.  It incorporates a significant number of changes
> > and enhancements, based on both initial review comments, and
> > importantly, feedback from our collaborators in the critical
> > infrastructure community.
> > 
> > Just as a levelset.  TSEM provides kernel infrastructure to implement
> > security controls based on either deterministic or machine learning
> > models.  Quixote is the userspace infrastructure that enables use of
> > the TSEM kernel infrastructure.
> > 
> > Based on your description Roberto, TSEM may be of assistance in
> > addressesing your issues at two different levels.
> > 
> > First with respect to protection of an isolated workload.
> > 
> > TSEM is inherently workload based, given that it is based on an
> > architecture that implements security modeling namespaces that a
> > process heirarchy can be placed into.  This reduces model complexity
> > and provides the implementation of very specific and targeted security
> > controls based on the needs of a proposed workload.
> > 
> > The security controls are prospective rather than retrospective,
> > ie. TSEM will pro-actively block any security behaviors that are not
> > in a security model that has been defined for the workload.
> > 
> > For example, with respect to the concerns you had previously mentioned
> > about ptrace.  If the security model definition does not include a
> > security state coefficient for a ptrace_traceme security event, it
> > will be disallowed, regardless of what goes on with respect to kernel
> > development, modulo of course the ptrace_traceme LSM hook being
> > discontinued.

> Hi Greg

Hi, I hope your day is going well.

> thanks for your insights.

Such as they were, the price was right... :-)

> The policy is quite simple:
> 
> 
>      r/w  ^                             kernel space
> ----------|-----------------------------------------
>           v (pipe)                        user space
>  +-----------------+       +-----------------------+
>  | trustworthy UMD |---X---| rest of the processes |
>  +-----------------+       +-----------------------+
> 
> The question was more, is the LSM infrastructure complete enough that
> the X can be really enforced?
> 
> Could there be other implicit information flows that the LSM
> infrastructure is not able/does not yet mediate, that could break the
> policy above?

When we initiated the Quixote project, to bring security modeling and
machine learning based security policy to the kernel, the predicate
assumed was that the LSM hooks represented the complete basis set of
information that was required to define the security state of a
system.

If the current LSM hooks are insufficient in number or lack being
fully descriptive in character, the LSM by definition, cannot fully
protect a platform.

I see that Casey replied downthread and indicated he thought the LSM
hooks were sufficient to model the necessary security threats,
obviously good news for both your work and ours.

Just as a note of clarification.

Casey indicated that the LSM supported labeled networking would be of
assistance in your model, but my assumption from your diagram, is that
the dashed line with the X in it, implies that there is to be NO
information flow allowed between the sandboxed UMD process and the
rest of the processes running on the system.

This would be in contrast to the line representing some type of
limited network or pipe connectivity, with appropriate security
controls or labeling on the traffic, is this a correct assumption?

It would seem like there would need to be two classes of security
guarantees in place for your model.  First, the fact that the
trustworthy UMD cannot be forced to commit some action that was not
intended for it, and second, that the surrounding system can be
trusted to not try and exert nefarious influence on the UMD.

Wouldn't the second requirement necessitate that the UMD operate with
some form of attestation as to the character of the surrounding
system?

Other than the fact that Intel chose to not make the technology
sufficiently ubiquitous, it would seem that SGX would be tailor made
for this.

> I guess TSEM could be for more elaborated security models, but in
> this case the policy is quite straithforward. Also, your TSEM would
> be as limited as mine by the LSM hooks available.

TSEM isn't about elaborate, it is about defining the notion of
workload specific security models.  A TMA running a security model,
that acts only on file digests accessed by files with uid=0, would
roughly implement IMA, with appraisal essentially for 'free'.

With respect to this discussion, one of the points that I was trying
to make is that if you make the need to parse file digests from .rpms
and .debs go away, the need for the highly protected UMD goes away as
well.

TSEM, with a signed security model processed by a trust orchestrator,
implements that model, along with an invariant representation of the
state of the system.

In fact, we have micro-controller based TMA's that pull their security
models over a CAT1.M network connection, completely external to the OS
being modeled, which is probably as much isolation as is
possible... :-)

> Thanks
> 
> Roberto

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
