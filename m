Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58638E42D
	for <lists+linux-integrity@lfdr.de>; Mon, 24 May 2021 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhEXKim (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 May 2021 06:38:42 -0400
Received: from wind.enjellic.com ([76.10.64.91]:49442 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232640AbhEXKil (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 May 2021 06:38:41 -0400
X-Greylist: delayed 1628 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 May 2021 06:38:40 EDT
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 14OA9Pxw029605;
        Mon, 24 May 2021 05:09:25 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 14OA9Ndt029604;
        Mon, 24 May 2021 05:09:23 -0500
Date:   Mon, 24 May 2021 05:09:23 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com, glin@suse.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Subject: Re: [RFC PATCH 0/3] Add additional MOK vars
Message-ID: <20210524100923.GA29476@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com> <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com> <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com> <c134ad45d924e8b719f8abb6d36b426b889e9394.camel@linux.ibm.com> <4A887886-BDB2-4F88-9D83-73B9BC9E641F@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A887886-BDB2-4F88-9D83-73B9BC9E641F@oracle.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 24 May 2021 05:09:25 -0500 (CDT)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 20, 2021 at 02:37:31PM -0600, Eric Snowberg wrote:

Good morning, I hope the week is starting well for everyone.

> > On May 19, 2021, at 8:32 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> >> After going through the mailing list history related to IMA appraisal, 
> >> is this feature strictly geared towards a custom kernel used for a 
> >> specific purpose?  Do you view it as not being a feature suitable for 
> >> a generic distribution kernel to offer? 
> > 
> > IMA-appraisal is enabled by distros, but requires labeling the
> > filesystem with security.ima xattrs, before loading an appraisal
> > policy.

> I was referring to digital signature based IMA-appraisal.  If a
> company wanted to ship a distro where all immutable files are IMA
> signed, today it would not be feasible.  The end-user will
> undoubtably want to install their own application, but this is not
> possible. The end-user can not IMA sign anything since they do not
> have the ability to add their own IMA CA.

I've spent 6+ years working on this issue, with a focus on trusted
endpoint devices and their communications with trusted cloud
endpoints.

The challenge to trusted systems is that they not only have to be
secure, they have to be tractable for the general development
community to easily target, that is currently not the case.  Eric, as
you note, this extends to the notion of generic Linux distributions
being able to deliver this tractability and flexibility to their user
communities.

Making this happen requires a much more generic system for modeling
security behavior then what currently exists.  If one looks at how
security co-processors are going to evolve, this modeling will end up
going out of the kernel into external devices, which are not going to
be generic TPM's [*].

We have such an architecture for the 5.4 kernel, that with a little
luck, we hope to be able to release by mid-summer.  It peacefully
co-exists with all of the existing integrity infrastructure which
would make it tractable for a value add patch.

It includes a namespace implementation for the security event
modeling, without which, tractable trusted system development is a
non-starter.

If you are interested I will keep you in the loop.

Have a good day.

Greg

[*] We've used SGX enclaves and ST based micro-controller
implementations.

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"The vast majority of human beings dislike and even dread all notions
 with which they are not familiar.  Hence it comes about that at their
 first appearance innovators have always been derided as fools and
 madmen."
                                -- Aldous Huxley
