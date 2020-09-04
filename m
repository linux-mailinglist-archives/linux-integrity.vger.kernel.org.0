Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B4D25DBDF
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgIDOe7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 10:34:59 -0400
Received: from wind.enjellic.com ([76.10.64.91]:53456 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbgIDOev (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 10:34:51 -0400
X-Greylist: delayed 1672 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 10:34:50 EDT
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 084E6Dui018627;
        Fri, 4 Sep 2020 09:06:13 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 084E6BWY018626;
        Fri, 4 Sep 2020 09:06:11 -0500
Date:   Fri, 4 Sep 2020 09:06:11 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
        "sunyuqiong1988@gmail.com" <sunyuqiong1988@gmail.com>,
        "mkayaalp@cs.binghamton.edu" <mkayaalp@cs.binghamton.edu>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "christian@brauner.io" <christian@brauner.io>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, nick.dusek@gmail.com
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
Message-ID: <20200904140611.GA18124@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200818152037.11869-1-krzysztof.struczynski@huawei.com> <1597767571.3898.15.camel@HansenPartnership.com> <401a2f36149f450291d1742aeb6c2260@huawei.com> <5331e60b5a1afb55e2bc778db1b95998466b687d.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5331e60b5a1afb55e2bc778db1b95998466b687d.camel@linux.ibm.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 04 Sep 2020 09:06:13 -0500 (CDT)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 02, 2020 at 02:53:17PM -0400, Mimi Zohar wrote:

Good morning, I hope the week is ending well for everyone.

> On Fri, 2020-08-21 at 15:13 +0000, Krzysztof Struczynski wrote:
> > > From: James Bottomley [mailto:James.Bottomley@HansenPartnership.com]
> > > On Tue, 2020-08-18 at 17:20 +0200, krzysztof.struczynski@huawei.com
> > > wrote:
> > > > The measurement list remains global, with the assumption that there
> > > > is only one TPM in the system. Each IMA namespace has a unique ID,
> > > > that allows to track measurements per IMA namespace. Processes in one
> > > > namespace, have access only to the measurements from that namespace.
> > > > The exception is made for the initial IMA namespace, whose processes
> > > > have access to all entries.
> > > 
> > > So I think this can work in the use case where the system owner is
> > > responsible for doing the logging and attestation and the tenants just
> > > trust the owner without requiring an attestation.  However, in a multi-
> > > tenant system you need a way for the attestation to be per-container
> > > (because the combined list of who executed what would be a security
> > > leak between tenants).  Since we can't virtualise the PCRs without
> > > introducing a vtpm this is going to require a vtpm infrastructure like
> > > that used for virtual machines and then we can do IMA logging per
> > > container.
> > 
> > I agree and wonder if we should decouple the attestation trust model,
> > which depends on the specific use case (e.g. multi/single tenant,
> > public/private cloud), from the IMA logic of linking the measurements to
> > the container. Indeed, attestation from within the container might require
> > anchoring to a vTPM/vPCR and the current measurement tagging mechanism can
> > support several ways of anchoring them to a (virtual) root of trust.
> > 
> > > I don't think the above has to be in your first patch set, we just have
> > > to have an idea of how it could be done to show that nothing in this
> > > patch set precludes a follow on from doing this.
> > 
> > Given that virtualizing trust anchors seems like a separate problem in
> > which industry consensus is not easy to reach for all use cases, an
> > anchoring mechanism should probably be a separate IMA feature.

> Other trust anchors for "trusted keys" has been discussed, but I wasn't
> aware of any discussion about other trust anchors for the IMA
> measurement list.  The IMA measurement list is very much tied to a TPM.
> 
> Including container measurements in the host measurement list, will
> unnecessarily cause the host measurement list to grow.  The decision of
> what should and shouldn't be included in the host measurement list
> shouldn't be defined by the container.

We have been shipping, and more importantly maintaining in the wild,
systems with a namespaced IMA implementation for 4+ years now. We
presented the foundations for all of this at the 2015 Linux Security
Summit in Seattle.

For the purposes of further conversation, I should clarify and
indicate that we have been shipping and maintaining what a namespaced
IMA implementation turns into when all of the engineering challenges
have been addressed with respect to workability issues, particularly
in regards to keeping the resultant system from being too fragile to
be effectively deployed and maintained.

If practical experience is worth anything, I don't believe that
namespacing the current IMA implementation is the optimum path
forward.  With respect to developing operationally relevant trusted
platforms, the objective needs to be modeling the behavior of
namespaces spawned from a known root behavior.

The current IMA implementation provides a great deal of relevant
infrastructure, but as these conversations have suggested, namespacing
the current implementation is problematic given how entangled it has
become with existing kernel infrastructure.  What is needed is
something far simpler that delegates, on the basis of a namespace,
security policy to something other then the kernel, consistent with
what we have learned about policy over the last 29+ years of Linux
development.

With respect to roots of trust, I don't think TPM's/fTPM's, virtual or
otherwise, are going to be the relevant technology moving forward,
although they will be part of the picture.

Mimi has another post down thread that I will provide some more direct
reflections on all of this for whatever value they may have.

> Mimi

Have a good day.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: dg@enjellic.com
------------------------------------------------------------------------------
"I had far rather walk, as I do, in daily terror of eternity, than feel
 that this was only a children's game in which all of the contestants
 would get equally worthless prizes in the end."
                                -- T. S. Elliot
