Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7FA699F27
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 22:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBPVsD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 16:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPVsC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 16:48:02 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7FC326CE1;
        Thu, 16 Feb 2023 13:47:58 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 31GLlTE4024436;
        Thu, 16 Feb 2023 15:47:29 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 31GLlSv2024434;
        Thu, 16 Feb 2023 15:47:28 -0600
Date:   Thu, 16 Feb 2023 15:47:28 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        shallyn@cisco.com, corbet@lwn.net
Subject: Re: [PATCH 04/14] Implement CAP_TRUST capability.
Message-ID: <20230216214728.GA24250@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-5-greg@enjellic.com> <a12483d1-9d57-d429-789b-9e47ff575546@schaufler-ca.com> <20230213114313.GA15496@wind.enjellic.com> <553358e7-1bd7-c416-0e0f-ee504c0d0c66@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <553358e7-1bd7-c416-0e0f-ee504c0d0c66@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 16 Feb 2023 15:47:29 -0600 (CST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 13, 2023 at 10:02:16AM -0800, Casey Schaufler wrote:
> On 2/13/2023 3:43 AM, Dr. Greg wrote:
> > On Sat, Feb 04, 2023 at 06:54:20PM -0800, Casey Schaufler wrote:
> >
> > Looping in some others, given that this issue is fundamental to
> > influencing how Linux can do security, also Sergey who raised a
> > similar issue to Casey.
> >
> > Apologies for the delay in responding to this, catching up on issues
> > after a week of travel.
> >
> >> On 2/3/2023 9:09 PM, Dr. Greg wrote:
> >>> TSEM was designed to support a Trust Orchestration System (TOS)
> >>> security architecture.  A TOS based system uses the concept of a
> >>> minimum Trusted Computing Base of utilities, referred to as trust
> >>> orchestrators, that maintain workloads in a trusted execution
> >>> state.  The trust orchestrators are thus, from a security
> >>> perspective, the most privileged assets on the platform.
> >>>
> >>> Introduce the CAP_TRUST capability that is defined as a
> >>> capability that allows a process to alter the trust status of the
> >>> platform.  In a fully trust orchestrated system only the
> >>> orchestrators carry this capability bit.
> >> How is this distinguishable from CAP_MAC_ADMIN?
> > CAP_TRUST is being introduced to enable Linux security architects to
> > ontologically differentiate processes that are allowed to modify
> > security guarantees based on deontological (rule-based) predicates
> > from processes allowed to modify security guarantees that are based on
> > narratival (event-based) predicates.
> >
> > More generally, but less accurately, it allows security architectures
> > to be shaped by both Kantian and Hegelian logic perspectives. [0]
> >
> > Given that the above will probably not be seen as an overly compelling
> > argument, in and of itself .... :-), some technical observations in
> > support of CAP_TRUST
> >
> > Dictating to the choir here, but a brief background for those
> > following this discussion with an interest in security issues.
> >
> > In general, classic mandatory access controls (MAC) are policy based.
> > For example, the standard bearers, SMACK and SeLinux, use classic
> > subject/object philosophies.  A process (subject) has a role/label
> > attached to it and objects acted on by the processes have a label
> > associated with them.  Policies, that can be viewed as rules, usually
> > quite elaborate and detailed for a whole system security policy, are
> > developed that define how subject labels may or may not interact with
> > object labels.
> >
> > TSEM introduces an alternate notion of a security policy, defined as a
> > security model in TSEM parlance, that is created by unit testing of a
> > platform or workload.  Precise descriptions of the security events
> > generated by the testing are captured and used to maintain subsequent
> > executions of the workload in a known security or trust state.

> There's nothing fundamentally new here.  You are claiming the common
> practice of looking at the audit trail to develop "policy" is a new
> "alternative notion" for security.

We do apologize to everyone spending any time on this, for the paucity
of our thought processes and innovation, hopefully people will still
shake hands with us if our paths happen to cross in the future.

Innovation takes many forms, let me see if I can illuminate why we
think there might be at least some kind of a new take on things in all
of this.

For the record, we are not proposing to look at an audit trail of a
policy implementation that is incorrect for its workload, in an
attempt to fix it.

TSEM is about providing infrastructure for bringing CI/CD
methodologies, an accepted standard practice in software quality
programs, to the prospective development of security models that are
very specific, correct and complete for an intended workload.

Good or bad, the world seems to have moved to resource
compartmentalization and containers, TSEM is about acknowledging this
and providing support for these architectures.

A primary objective with all of this is to avoid having to go back to
the well and fix a generic system-wide policy that ends up being
wrong, for whatever reason.  In some of the environments that
Quixote/TSEM is intended for, that potentially involves rolling a
truck to someplace remote.

> You are familiar with SELinux's audit2allow I assume.

Yes, quite so.

For those reading along at home, the following description of the tool
and its usage may be helpful:

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/sect-security-enhanced_linux-troubleshooting-fixing_problems

As the URL itself indicates, it is a tool for troubleshooting and
fixing problems with a policy, after the policy has been diagnosed to
have an error in its security description of a platform.

The documentation states, multiple times and quite explicitly, that if
you have to use the tool, there is a 'bug' in the policy.  It also
recommends reporting this to the policy development team.

Succinctly; Quixote/TSEM is about prospectively developing a correct
security model for a workload, audit trail diagnosis is about
retrospectively fixing an incorrect policy.

We certainly don't indict the tool or the methodologies involved, they
are well understood, we just think there is the possibility of doing
better.

With Quixote/TSEM we are focused on providing alternative security
infrastructure that increases the likelihood of a security model being
correct for a workload, hopefully eliminating the need to fix the
policy after it is found to break a workload.

Which, if history, experience and the search engines are correct;
results in people simply turning off policy enforcement to eliminate
the problems it is producing.

From our perspective, biased of course, it would seem to qualify as
innovation if it were, at once, both simple and reliable, to develop a
policy/model that could lead to correct mandatory enforcement
decisions.  Particularly if it helps avoid people shutting off the
technology because they find it bothersome.

To further the notion of why Quixote/TSEM is being introduced, consider
the document at the following URL:

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/using_selinux/writing-a-custom-selinux-policy_using-selinux

Which carries the following description, with respect to its contents:

"This section guides you on how to write and use a custom policy that
 enables you to run your applications confined by SeLinux."

The document provides guidance to developers so that their
applications can be protected by SeLinux, given that platform
reference policies may not know about the needs of an added
application.

It may be useful for readers to compare those procedures, to the
procedure that we document for building a prospective security model
with Quixote/TSEM.  That procedure can be found in the TBDHTTRAD
section of the TSEM LSM documentation.

What should also be noted, and easy to find since it is
highlighted in red in the RedHat documentation, is the following:

Warning:

"Use only rules provided by Red Hat.  Red Hat does not support
 creating SELinux policy modules with custom rules, because this falls
 outside of the Production Support Scope of Coverage.  If you are not
 an expert, contact your Red Hat sales representative and request
 consulting services."

As the TSEM LSM documentation notes, we are concerned with making
higher levels of security easier to obtain for development teams, as a
natural result of the software development process.

Once again, biased as we may be, that seems like innovation.
Particularly if it allows developers to implement better security
without violating the software license agreement for the operating
system.

I think everyone reading this has been around long enough to know that
if security is hard to do, it doesn't get done, even more so if it
costs extra money.

> > Both approaches are considered 'mandatory' in nature, since userspace
> > cannot modify, in the case of policy based systems the labeling, or in
> > event based systems the security model being enforced.  Unless of
> > course a process has been assigned the capability to do so, hence this
> > discussion.
> >
> > We are proposing CAP_TRUST as the privilege that is required by
> > processes to maintain the security state of a workload based on a set
> > of known valid security events.  In theory, and practice, it is
> > orthogonal to the actions permitted by CAP_MAC_ADMIN.  Although,
> > obviously, the intent of all these systems is to maintain a known
> > security state, however different those schemes may be from a
> > methodological perspective.

> I read this as an argument for using CAP_MAC_ADMIN.

So it appears as if we disagree.

I posted a response to questions that Paul had raised after going
through the documentation.  Perhaps those discussions may provide
additional rational for why CAP_TRUST is being proposed.

> > In security architectures, the concept of 'trust' has connotated the
> > notion of having a cryptographic guarantee of the state of a system.
> > As the cover letter and documentation discuss, TSEM is about blending
> > integrity measurement and mandatory access controls.
> >
> > Trust orchestrators are designed to provide an attestation that a
> > workload has not deviated in any way from a previously defined
> > security model, CAP_TRUST is the privilege required to influence this
> > guarantee.  Once again, we view this as a different concept and
> > objective than the ability to modify a security policy.

> This is (to my simple mind) indistinguishable from the way SELinux
> is used in distributions. SELinux does not require a CAP_TRUST, and
> only uses CAP_MAC_ADMIN in certain unlikely error conditions which I
> believe you don't encounter.

A couple of points to consider.

The classic subject/object based MAC implementations provide a static
rules implementation that govern access rights of a process to
resources.  If they operate correctly, the platform is secure with
respect to the implemented policy.  Unless we have missed something,
the implementations do not offer a cryptographic attestation of the
state of the system to an external entity.

Events based trust orchestration is a dynamic process that evaluates
the characteristics of a security event for correctness with respect
to a previously defined model.  In addition to enforcing conformance
to the security model, the trust orchestrators are designed to provide
an attestation of the correctness of the enforcement.

In order to generate, and simplify the models, TSEM implements the
concept of security domains/namespaces, so the security models can be
scoped specifically to the workload.  This obviously needs to be a
privileged operation, we believe different from CAP_MAC_ADMIN, in
order to avoid having an adversary create a modeling domain under
their own security controls that could be used to avoid attestation of
its existence.

I know Casey has indicated in that past that he has no little or no
interest in TPM's, and I assume by extension, things like attestation.
Confidential computing, whether you believe in it or not, is going to
make attestation important, since a workload can't boot without it.
Quixote/TSEM, again, is about reducing barriers to developers being
able to implement it.

This debate seems to have come down to the fact that since both policy
and event based methodologies result in a mandatory access control
decision, the ability to control the implementation of both strategies
should come under CAP_MAC_ADMIN.

While they both end up providing mandatory access control decisions,
they do so by significantly different processes with different
security requirements, hence the introduction of CAP_TRUST.

As we have also noted previously, CAP_TRUST would seem more
appropriate to Stefan's IMA namespace work than CAP_MAC_ADMIN, given
that IMA is also about establishing a proclamation of trust to an
external entity.

> > Perhaps most importantly, TSEM shouldn't be viewed as an either/or
> > proposition when it comes to classic subject/object MAC
> > implementations.  A differentiation between CAP_TRUST and
> > CAP_MAC_ADMIN is needed in order to allow both architectures to work
> > together in a collaborative fashion.
> >
> > It would be perfectly reasonable to believe that a TSEM modeled
> > workload would implement MAC (rules based) security controls.  In
> > order to achieve event based security guarantees, a trust orchestrator
> > drops CAP_TRUST for the workload process chain.  If CAP_MAC_ADMIN were
> > used, it would potentially impair the ability of the workload to
> > implement MAC policies, hence the desire to keep the privileges
> > orthogonal.

> If you're giving the workload process chain the ability to modify
> the configuration of another LSM you are already on marshy ground.

I'm a simple guy too, didn't grow up on Long Island though, grew up in
the bog country of northeastern Minnesota, where people were referred
to as 'swamp-stompers'.  I know marshy ground really well, worked the
bog country with a chainsaw at -25 in the winter, cutting wood to heat
our house, since it was the only time you could walk on that ground,
let alone get trucks in to haul wood.

Your comment about being on marshy ground would seem to represent a
misunderstanding that I want to clarify so there are no further
misunderstandings about this moving forward.  TSEM does not modify, in
any way, the configuration of other LSM's in the stack, nor are we
proposing that, we are leaving that can of worms to BPF... :-)

Let me, again, clarify the point I was making.  Since it seems to have
been misunderstood and is relevant to larger conversations that Paul
is having with respect to integrating IMA into the LSM architecture.

TSEM is generic security modeling architecture that provides the
infrastructure needed for implementing integrity measurement functions,
strictly in the context of the LSM architecture itself.
Simplistically, all that is needed is a model implementation that only
handles the file_open and mmap_file hooks and treats the digest value
as the only characteristic in the CELL identity.

Label based MAC's need to have protection against offline 'Evil
{Maid,Butler}' attacks to be fully robust.  For those reading along at
home, the IMA implementation of those protections is in the following
directory in the kernel source tree:

security/integrity/evm

This isn't an issue that we are conjuring up, IBM wrote that code 18
years ago to address this issue.

If one were to implement an extended attribute security model, TSEM
would return -EPERM if the attributes being accessed were inconsistent
with the security model that the workload had been unit tested to.
The current LSM model is that the first denial 'wins'.  If TSEM were
in the call stack, before a label based MAC, access to an attribute
modified by an adversary would be denied before it could influence the
subject/object policy decision.

If an LSM returning a permission denial is somehow 'meddling' with
another LSM's configuration, than it would seem like the whole LSM
stacking architecture is on 'marshy' ground.  It would also seem to
call into question Paul's vision for bringing IMA into full communion
with the LSM architecture.

I would have to check lore, but I believe I saw an e-mail from Mimi go
by not too long ago commenting that when/if IMA/EVM were to become an
LSM, it would have to go 'early', in order for it to work.

So, if the trust orchestrators use and drop CAP_MAC_ADMIN, the
processes in the modeled workload would not have access to the
privileges needed to do whatever might need to be done via that
capability to manage a MAC policy being used in the workload.

Hopefully all of this helps further frame the conversation.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
