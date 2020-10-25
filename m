Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09A298248
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Oct 2020 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417000AbgJYPer (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Oct 2020 11:34:47 -0400
Received: from wind.enjellic.com ([76.10.64.91]:58280 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416999AbgJYPer (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Oct 2020 11:34:47 -0400
X-Greylist: delayed 1988 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2020 11:34:46 EDT
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 09PF0ZYl023036;
        Sun, 25 Oct 2020 10:00:35 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 09PF0Wg7023035;
        Sun, 25 Oct 2020 10:00:32 -0500
Date:   Sun, 25 Oct 2020 10:00:32 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
        "sunyuqiong1988@gmail.com" <sunyuqiong1988@gmail.com>,
        "mkayaalp@cs.binghamton.edu" <mkayaalp@cs.binghamton.edu>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        "christian@brauner.io" <christian@brauner.io>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "jannh@google.com" <jannh@google.com>,
        Luke Hinds <lhinds@redhat.com>
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
Message-ID: <20201025150031.GA23011@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200818152037.11869-1-krzysztof.struczynski@huawei.com> <20200818164943.va3um7toztazcfud@wittgenstein> <d77a6cd783319702fddd06783cb84fdeb86210a6.camel@linux.ibm.com> <20200906171413.GA8305@wind.enjellic.com> <CAKrSGQR3Pw=Rad2RgUuCHqr0r2Nc6x2nLoo2cVAkD+_8Vbmd7A@mail.gmail.com> <d405bab0d262b32fd16e85444791b6c49d820aa2.camel@linux.ibm.com> <a75a6541991d4f8dbaa30e0af517b829@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75a6541991d4f8dbaa30e0af517b829@huawei.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 25 Oct 2020 10:00:35 -0500 (CDT)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 19, 2020 at 09:30:27AM +0000, Krzysztof Struczynski wrote:

Good morning, I hope this note finds the weekend going well for
everyone.

> > The concept of the IMA namespace as a separate namespace, not
> > attached to the user or mount namespace, remains the same as in
> > the last set of Stefan's patches. The creation and configuration
> > mechanism changed, partially because of the changes in the
> > upstream kernel like extension of the CLONE_ flags, that
> > facilitated other solutions. The main inspiration in this regard
> > was the new time namespace.
> >
> > The implemented mechanism is intended to make the configuration of
> > the IMA namespace as similar as possible to the upstream IMA
> > implementation and allows to configure the new IMA namespace
> > before any process enters that namespace, so the very first
> > actions can be measured/appraised/audited.
> >
> > In this implementation many design points formulated by Stefan
> > still stand.  The significant difference in the presented design
> > is the threat model.  The actions of the host's root and any other
> > user within the container are measured/appraised/audited according
> > to the container's policy. However, every action that affects
> > objects in the root namespace, is detected when processes from the
> > root namespace access them.

> Do you think that the above proposal addresses the aforementioned
> "IMA namespacing" issue? If it doesn't, would you please clarify
> what are the main, outstanding problems?

From our perspective, a significant objective of the namespacing
discussion needs to be considerations regarding how additional growth
and sophistication of IMA as a sub-system will occur.

IMA, if taken to its limit, resolves into the notion of modeling the
behavior of a hardware platform, its operating system and the
supported application stack.  We believe the most important issue with
respect to namespacing is to provide an opportunity to allow more
sophisticated and capable models to be developed and implemented,
without having the process unduely constrained by the realities of
kernel development.

Coupled with this issue is the fact that it doesn't seem reasonable to
believe that TPM's are going to be the venue or root of trust for this
modeling, for a variety of reasons, perhaps most principally the fact
that they are a 'blackbox' that have not enjoyed universal trust.
This is perhaps particularly relevant now that they are being
implemented in firmware rather then actual hardware.

The sophistication and security capabilities of micro-controllers that
are being developed for the IOT security space make a case for
developing open-source/architecture security co-processors that
implement the modeling and root of trust for independent modeling/IMA
namespaces.

TPM's also implicitly constrain the modeling to be a function based on
linear extension summing.  It seems pretty clear that stochastic as
well as deterministic models will be needed, particularly for more
dynamic systems.

So the optimum approach would seem to be for the namespace to have the
option of implementing its own policy or to provide a mechanism for
forwarding all of the Turing event characteristics to an entity that
can implement the desired integrity or model policy.

All of this would also seem to be consistent with the direction of the
mobile market, which appears to be moving toward a model of an
operating system that binds together multiple co-processors or
functional units.  IMA, in this model, is a separate functional entity
resonsible for interpreting and disciplining kernel behavior.

> > > Definitely, let's have this discussion.

> Shall we continue the discussion here, or in addition use a format similar
> to the Stefan's "drawing board":
> https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations

It has always been said that code speaks louder then words.  So we are
working through the process of cleaning up our implementation of the
approach described above so that people can at least take a look at
the architecture we are proposing.

We don't have any belief that it would be suitable to survive the
gauntlet of the kernel development process but we will offer it as a
proof of concept of where we think all of this will, can and needs to
end up going.

We were able to bolt all of this on top of standard IMA in a
reasonably straight forward fashion.  Our initial implementation of an
external modeling engine was based on SGX, which was remarkably useful
for this purpose, albeit not well understood.

Given the trajectory that technology has been placed on, we now have
an implementation based on an ARM micro-controller as the external
modeling/policy engine.  While not quite as flexible as the SGX based
approach it has a number of its own advantages, most principally
ubiquity of implementation.  Both approaches required no modification
of the namespaced IMA implementation which we believe speaks to the
flexibility of the approach.

> Best regards,
> Krzysztof Struczynski

Hopefully the above reflections are helpful in steering progress of
discussions, if not the price was certainly right.

Best wishes for a productive week to everyone.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Attendants at a service station in Eunice, Louisiana, handed more than
 $100 to a naked man who claimed to have a gun in his pocket."
                                -- Unknown
