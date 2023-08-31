Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0E78F171
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Aug 2023 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjHaQru (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Aug 2023 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHaQru (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Aug 2023 12:47:50 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E342124;
        Thu, 31 Aug 2023 09:47:46 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37VGkSEh004670;
        Thu, 31 Aug 2023 11:46:28 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37VGkR8V004669;
        Thu, 31 Aug 2023 11:46:27 -0500
Date:   Thu, 31 Aug 2023 11:46:27 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Message-ID: <20230831164627.GA4371@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com> <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com> <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com> <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com> <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com> <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com> <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com> <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com> <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com> <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 31 Aug 2023 11:46:28 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 30, 2023 at 07:22:27PM -0400, Paul Moore wrote:

Good morning.

> On Wed, Aug 30, 2023 at 7:07???PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Wed, 2023-08-30 at 18:23 -0400, Paul Moore wrote:
> > > On Wed, Aug 30, 2023 at 6:21???PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Aug 30, 2023 at 5:50???PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > On Wed, 2023-08-30 at 16:47 -0400, Paul Moore wrote:
> > > > > > On Wed, Aug 30, 2023 at 4:25???PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > > Your initial question was "what happens if the file/filesystem becomes
> > > > > > > inaccessible at some point and an attestation client attempts to read
> > > > > > > the entire log?".  For what reason would it be inaccessible?  For the
> > > > > > > original single tmpfs file, what would make it inaccessible?
> > > > > >
> > > > > > In your reply that I had responded to you had mentioned that the
> > > > > > kernel was simply being passed a fd and taking ownership of it, the fd
> > > > > > could either be a tmpfs backed file or some form of persistent storage
> > > > > > as both were discussed in this thread.  I imagine a tmpfs filesystem
> > > > > > could still be forcibly unmounted, resulting in problems, but I can't
> > > > > > say that for certain.  However, there are definitely cases where a fd
> > > > > > backed against an arbitrary filesystem could run into problems:
> > > > > > storage device issues for local filesystems, networking issues for
> > > > > > network filesystems, and good old fashioned user/admin intervention in
> > > > > > both cases.
> > > > >
> > > > > "I imagine tmpfs filesystem could still be forcibly unmounted" sounds
> > > > > like an attack. Not being able to verify the measurement list against a
> > > > > quote is probably a good thing.
> > > >
> > > > Okay, can you answer the question for an arbitrary persistent
> > > > filesystem?  That was always the more important question, ...
> >
> > The original proposal, not mine, suggested using a tmpfs file.   The
> > idea of writing the measurements to a file on a persistent filesystem
> > wasn't mine either.  Sush/Tushar were pushing for writing to a
> > persistent file(s).  No argument from me that writing to a file on an
> > arbitrary persistent filesystem is not a good idea.

> Progress.  Okay, so we all now agree that the kernel writing to an
> arbitrary filesystem is not a good idea, and using tmpfs doesn't
> solve the problem of general memory pressure (from previously in
> this thread), that's all helpful and good to clarify.
>
> Assuming Sush and Tushar rework the document to clarify the
> motivation/purpose for the work, as you suggested earlier, I'm
> assuming we can revisit this problem and solutions?

IMA will obviously go, with our blessings, in its own direction.

I would only call out, as I indicated in my reply to Ken Goldman, that
our 20+ year old integrity and attestation architectures and models
are now arguably challenged, given emerging technologies and their
requirements for integrity and confidentiality.

This thread highlights a lot of the issues that caused us to bring
TSEM to the table.

If we, for the moment, isolate discussion to the growth and/or
management of the event log.  The architecture of externally modeled
namespaces gets the events immediately out of the kernel for a
userspace Trusted Modeling Agent (TMA) to deal with, however it
chooses.

The TMA doesn't even need to be running on the machine itself.  We are
currently feeding security event streams to entirely different
platforms, some hypervisor based, particularly for the training and
enforcement of machine learning models.

There are obviously concessions that need to be made for LSM event
handlers running in atomic context, but that isn't an issue for a
security model based simply on file integrity.  IMA in atomic context
isn't possible, not only from the perspective of doing the file I/O
but the need to sleep while the TPM transaction runs.

Once again, no criticism of IMA, it is proven and has its own camp and
following.  From our perspective, and our collaborators, there is an
opportunity, and need, to enhance the options available.

> paul-moore.com

Best wishes for an end of summer holiday weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
