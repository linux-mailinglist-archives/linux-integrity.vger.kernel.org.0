Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA020262CE0
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Sep 2020 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIIKMB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Sep 2020 06:12:01 -0400
Received: from wind.enjellic.com ([76.10.64.91]:53888 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgIIKMA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Sep 2020 06:12:00 -0400
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 089ABMRJ016828;
        Wed, 9 Sep 2020 05:11:23 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 089ABLvd016827;
        Wed, 9 Sep 2020 05:11:21 -0500
Date:   Wed, 9 Sep 2020 05:11:21 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Luke Hinds <lhinds@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        krzysztof.struczynski@huawei.com, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, stefanb@linux.vnet.ibm.com,
        sunyuqiong1988@gmail.com, mkayaalp@cs.binghamton.edu,
        dmitry.kasatkin@gmail.com, "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>, christian@brauner.io,
        silviu.vlasceanu@huawei.com, roberto.sassu@huawei.com,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, luto@amacapital.net,
        jannh@google.com, nick.dusek@gmail.com
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
Message-ID: <20200909101120.GA16191@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200818152037.11869-1-krzysztof.struczynski@huawei.com> <20200818164943.va3um7toztazcfud@wittgenstein> <d77a6cd783319702fddd06783cb84fdeb86210a6.camel@linux.ibm.com> <20200906171413.GA8305@wind.enjellic.com> <CAKrSGQR3Pw=Rad2RgUuCHqr0r2Nc6x2nLoo2cVAkD+_8Vbmd7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKrSGQR3Pw=Rad2RgUuCHqr0r2Nc6x2nLoo2cVAkD+_8Vbmd7A@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 09 Sep 2020 05:11:23 -0500 (CDT)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 07, 2020 at 12:50:07PM +0100, Luke Hinds wrote:

Good morning, I hope the week is going well for everyone.

> On Sun, Sep 6, 2020 at 6:15 PM Dr. Greg <greg@enjellic.com> wrote:
> > Just to be clear, we are not campaigning or advocating what we have
> > done but are simply providing background for discussion.  We haven't
> > campaigned this approach given how complex the kernel development has
> > become, particurlarly with respect to security infrastructure.
> >
> > Candidly, given the politics of security technology being viewed as
> > 'constraining' user rights, I think that a lot of forthcoming security
> > technology may end up being out of tree moving forward.

> I think it's prudent to look forward and plan diligently, but I would not
> want perfect to be the enemy of good.
>
> I approach this more from a user's perspective. We are using IMA in
> https://keylime.dev to measure a host and would like to measure
> within a container too. It's the most common request we hear from
> our users.
>
> Perhaps we all collaborate on a proposal extending Stefans work here:
> https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations
>
> I have seen around 3-4 patches now get submitted, so work has been
> done before, and as above, users are present too. We could then have
> some consensus on how this should look and later patches might have
> more success at landing.
>
> Would anyone be interested in this and have recommendations on how
> we could approach this?

Obviously everyone is interested in sharpening their own knives so the
first challenge will be defining where this theme of measurement and
attestation needs to go.

Our focus in all of this is from a platform behavior modeling
perspective.  Our objective is to design platforms/containers that are
capable of self-disciplining themselves in the event that they exhibit
behavior inconsistent with the wishes of their designer.  Container
measurement trivially falls out of this model.

With respect to measurement namespaces, the first problem to be
addressed is what takes custody and responsibility for the measurement
events.  In classic IMA this is, of course, a TPM.  In our model we
use a Trusted Execution Environment (TEE) as this entity.

The TEE makes a decision as to whether or not the kernel should label
a context of execution as being a 'bad actor' if it indicates a desire
to exhibit a behavior inconsistent with a previously defined model.
As I noted previously we have an SGX based solution that provides this
infrastructure but have designed and are moving to a micro-controller
based alternative, given the fact that SGX is now moving to a 'cloud
only' solution.

One of the pain points in all of this appears to be whether or not a
measurement stream from a container should feed into the root
measurement of the platform or be fed into a measurement/monitoring
domain that can be attested against the root measurement of the
platform.  Based on our experiences the latter model is the only one
that is feasible or makes sense from an attestation perspective.

So it would seem that a generic approach to directing the target of
the measurement events would be the first objective.  If there is
interest we can make a copy of our patch available as it supports both
models.

> - Luke

Have a good day.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: dg@enjellic.com
------------------------------------------------------------------------------
"I created a hack to make the division come out right ... I was
 relieved because I thought I was coding wrong.

 Did you?  It took a guy (Thomas Nicely) with a Ph.D. doing heavy
 research in computational number theory to find it, yet you found it
 while working on a game in QuickBasic?"
                                -- Slashdot
