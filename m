Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341236944CD
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Feb 2023 12:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBMLns (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Feb 2023 06:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjBMLnr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Feb 2023 06:43:47 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A10BBA27D;
        Mon, 13 Feb 2023 03:43:44 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 31DBhFVc015699;
        Mon, 13 Feb 2023 05:43:15 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 31DBhELw015698;
        Mon, 13 Feb 2023 05:43:14 -0600
Date:   Mon, 13 Feb 2023 05:43:14 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        shallyn@cisco.com, corbet@lwn.net
Subject: Re: [PATCH 04/14] Implement CAP_TRUST capability.
Message-ID: <20230213114313.GA15496@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-5-greg@enjellic.com> <a12483d1-9d57-d429-789b-9e47ff575546@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12483d1-9d57-d429-789b-9e47ff575546@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 13 Feb 2023 05:43:15 -0600 (CST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 04, 2023 at 06:54:20PM -0800, Casey Schaufler wrote:

Looping in some others, given that this issue is fundamental to
influencing how Linux can do security, also Sergey who raised a
similar issue to Casey.

Apologies for the delay in responding to this, catching up on issues
after a week of travel.

> On 2/3/2023 9:09 PM, Dr. Greg wrote:
> > TSEM was designed to support a Trust Orchestration System (TOS)
> > security architecture.  A TOS based system uses the concept of a
> > minimum Trusted Computing Base of utilities, referred to as trust
> > orchestrators, that maintain workloads in a trusted execution
> > state.  The trust orchestrators are thus, from a security
> > perspective, the most privileged assets on the platform.
> >
> > Introduce the CAP_TRUST capability that is defined as a
> > capability that allows a process to alter the trust status of the
> > platform.  In a fully trust orchestrated system only the
> > orchestrators carry this capability bit.

> How is this distinguishable from CAP_MAC_ADMIN?

CAP_TRUST is being introduced to enable Linux security architects to
ontologically differentiate processes that are allowed to modify
security guarantees based on deontological (rule-based) predicates
from processes allowed to modify security guarantees that are based on
narratival (event-based) predicates.

More generally, but less accurately, it allows security architectures
to be shaped by both Kantian and Hegelian logic perspectives. [0]

Given that the above will probably not be seen as an overly compelling
argument, in and of itself .... :-), some technical observations in
support of CAP_TRUST

Dictating to the choir here, but a brief background for those
following this discussion with an interest in security issues.

In general, classic mandatory access controls (MAC) are policy based.
For example, the standard bearers, SMACK and SeLinux, use classic
subject/object philosophies.  A process (subject) has a role/label
attached to it and objects acted on by the processes have a label
associated with them.  Policies, that can be viewed as rules, usually
quite elaborate and detailed for a whole system security policy, are
developed that define how subject labels may or may not interact with
object labels.

TSEM introduces an alternate notion of a security policy, defined as a
security model in TSEM parlance, that is created by unit testing of a
platform or workload.  Precise descriptions of the security events
generated by the testing are captured and used to maintain subsequent
executions of the workload in a known security or trust state.

Both approaches are considered 'mandatory' in nature, since userspace
cannot modify, in the case of policy based systems the labeling, or in
event based systems the security model being enforced.  Unless of
course a process has been assigned the capability to do so, hence this
discussion.

We are proposing CAP_TRUST as the privilege that is required by
processes to maintain the security state of a workload based on a set
of known valid security events.  In theory, and practice, it is
orthogonal to the actions permitted by CAP_MAC_ADMIN.  Although,
obviously, the intent of all these systems is to maintain a known
security state, however different those schemes may be from a
methodological perspective.

In security architectures, the concept of 'trust' has connotated the
notion of having a cryptographic guarantee of the state of a system.
As the cover letter and documentation discuss, TSEM is about blending
integrity measurement and mandatory access controls.

Trust orchestrators are designed to provide an attestation that a
workload has not deviated in any way from a previously defined
security model, CAP_TRUST is the privilege required to influence this
guarantee.  Once again, we view this as a different concept and
objective than the ability to modify a security policy.

Perhaps most importantly, TSEM shouldn't be viewed as an either/or
proposition when it comes to classic subject/object MAC
implementations.  A differentiation between CAP_TRUST and
CAP_MAC_ADMIN is needed in order to allow both architectures to work
together in a collaborative fashion.

It would be perfectly reasonable to believe that a TSEM modeled
workload would implement MAC (rules based) security controls.  In
order to achieve event based security guarantees, a trust orchestrator
drops CAP_TRUST for the workload process chain.  If CAP_MAC_ADMIN were
used, it would potentially impair the ability of the workload to
implement MAC policies, hence the desire to keep the privileges
orthogonal.

A quick example as to why this may be relevant.

Since TSEM is a generic security modeling architecture, with full
access to all security events, it can model the integrity of the
security meta-data needed by MAC based policies, similar to what
IMA/EVM does now, but entirely in the context of the LSM architecture
itself.  It would therefore be reasonable to operate both security
architectures in unison, with the event based TSEM protecting the
rules based MAC implementation.

Hopefully all of this helps clarify our thinking on this.

After reviewing the TSEM ABI and documentation, Paul Moore had some
questions and requests for clarification.  I am composing a response
to that e-mail that may also assist in understanding the role for
CAP_TRUST.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

[0]: In the interest of full disclosure, I need to officially
attribute the notion of the philosophical differences between the two
security architectures to a brilliant young cybersecurity engineer
that I was privileged to mentor in the field of security modeling.  We
struggled for a long time to explain why and how TSEM was different
until he offered this inspired reasoning.  I recognize him, but will
leave him anonymous due to his current roles and responsibilities.
