Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C64463509
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 14:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhK3NDc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 08:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhK3NDc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 08:03:32 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74018C061574
        for <linux-integrity@vger.kernel.org>; Tue, 30 Nov 2021 05:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638277212;
        bh=WbsCwODG0tNAwrCQWZwzuygwhfVc3PiURHXWEcl7deM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=jPLotuYDw6KAoOGuwaPiJ6WQzURAwTXQc2I8IEsoSX1sZfjKQL9b6xTytPYZRHdww
         43LM/kW95mkWnvsqSFSp8hxIGvmcMvmyoyKR3sP1HzkWMdnMDIuV5WDnXALDStnTZ8
         lfh74Un6igD9/3DB88luFgCz1gsvUKRZi07v9lMs=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 09A3312805E5;
        Tue, 30 Nov 2021 08:00:12 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CpEad8vbMWiH; Tue, 30 Nov 2021 08:00:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638277211;
        bh=WbsCwODG0tNAwrCQWZwzuygwhfVc3PiURHXWEcl7deM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Si7cZMPos35C7+Tbd5HHVXRsWEZRCxGYFDXp4du+nzwYJYR5kwC+gI+w7Xss70Xkx
         dVWZDOQofvNzu3bvO8VxdadecxZ04KIcmU8bA+nwu7Y5+/fHrADDAgvWpDbfawat+E
         ix4r0jn7Ub5ER2vRg20E6gsWIE2QrnheHBTku7PY=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BE50512804CF;
        Tue, 30 Nov 2021 08:00:10 -0500 (EST)
Message-ID: <c6c6f2ebf37b88cb66189bbac16feb611ae2b9ab.camel@HansenPartnership.com>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Date:   Tue, 30 Nov 2021 08:00:09 -0500
In-Reply-To: <20211130045904.GB32444@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
         <20211129045834.GB20606@mail.hallyn.com>
         <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
         <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
         <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
         <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
         <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
         <20211129153539.GA26325@mail.hallyn.com>
         <16e27be21e2886ba17298d94fdaff39236667890.camel@HansenPartnership.com>
         <20211130045904.GB32444@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 22:59 -0600, Serge E. Hallyn wrote:
> On Mon, Nov 29, 2021 at 11:44:35AM -0500, James Bottomley wrote:
> > On Mon, 2021-11-29 at 09:35 -0600, Serge E. Hallyn wrote:
> > > On Mon, Nov 29, 2021 at 09:46:55AM -0500, James Bottomley wrote:
> > [...]
> > > > Well, there's a reason it's an unpublished patch.  However, the
> > > > more important point is that namespacing IMA requires
> > > > discussion of certain points that we never seem to drive to a
> > > > conclusion.  Using the akpm method, I propose simple patches
> > > > that drive the discussion.  I think the points are:
> > > > 
> > > >    1. Should IMA be its own namespace or tied to the user
> > > > namespace?  The previous patches all took the separate
> > > > Namespace approach, but I think that should be reconsidered now
> > > > keyrings are in the user namespace.
> > > 
> > > Well that purely depends on the needed scope.
> > > 
> > > The audit container identifier is a neat thing.  But it
> > > absolutely must be settable, so seems to conflict with your
> > > needs.
> > 
> > I think not allowing duplicate entries for the lifetime of the log
> > is required, which causes a problem since namespaces can die before
> > this lifetime ends.  I think there is a nice security benefit in
> > making it not user settable, but I don't think that's necessarily a
> > requirement.
> > 
> > > Your patch puts an identifier on the user_namespace.  I'm not
> > > quite sure, does that satisfy Stefan's needs?  A new ima ns if
> > > and only if there is a new user ns?
> > 
> > Part of the problem is that IMA needs an admin user ... to be able
> > to read the log and set the policy and, when we get to appraisal,
> > set and read the keyrings.  IMA NS iff user ns satisfies this, but
> > the minimalist in me then asks why not make them the same thing?
> > 
> > > I think you two need to get together and discuss the
> > > requirements, and come back with a brief but very precise
> > > document explaining what you need. Are you both looking at the
> > > same use case?  Who is consuming the audit log, and to what
> > > end?  Container administrators?  Any time they log in? How do
> > > they assure themselves that the securityfs file they're reading
> > > hasn't been overmounted?
> > 
> > There are several different use cases.  I'm asking how I would use
> > the IMA namespace for the unprivileged containers I usually set up
> > by hand.  Stefan is looking at how docker/kubernetes would do
> > it.  There's also the Huawei use case which is a sort of
> > attestation for function as a service and there's the Red Hat use
> > case for OpenShift.
> > 
> > However, the common denominator in all of these is they require a
> > way to uniquely distinguish the containers, which is why the patch
> > series I sent as an RFC starts that way.  If we can start with the
> > common elements, we can build towards something that satisfies all
> > the use cases ... and allow consensus to emerge as further patches
> > are discussed.
> 
> The reason I asked this question in response to this patch is because
> here I'm not picking at the userns->uuid, but rather it's the new
> linked lists for the inode that feel wrong.

Well that one's fully separable.  The first two patches could be
complete for this round.  However, if you believe there has to be one
entry per inode per namespace then the iint cache needs to accommodate
that.  The measurement is a function of the inode alone: if the inode
doesn't change that value is the same regardless of namespace.  it's
only whether it's been logged that's really per namespace, hence the
namespace list hanging off the iint entry ... if there were a huge
number of namespaces, perhaps it should be a btree instead of a list,
but it needs to be some type of two level thing, I think?

The design of patch 3 is mostly to get people to think about what
should be in the per namespace log.

>   So if you can get what you need some other way - maybe just "we
> opened all these files and got no integrity failure messages", or a
> hash table keyed on (userns *, inode *) instead of the linked lists
> to look up whether an inode has been measured, or some userspace
> daemon to resubmit already logged approvals, which I gather won't
> work for unpriv containers - that would be nice.

I could do a separate (userns *, inode *) btree for the measured part,
but we'd still have to have the per inode store of the measurement
because that's namespace blind.  Given this, it seems inefficient not
to make use of the tie between the two.

> > Part of my problem is I don't really know what I need, I just want
> > IMA namespaces to work easily for the unprivileged use case and
> > I'll figure it out as I play with it ... but to do that I need
> > something to start playing with.
> 
> But for that kind of research you use an out of tree patchset, not
> speculative infrastructure in the kernel.  If that's what this
> patchset is, then I'll (feel a little silly and) look over it with a
> different set of eyes :)

Well, no, you're looking with the right set of eyes.  The design of
this patch set is to begin incrementally with the pieces everyone can
agree on, so start as small as it can be: the namespace and a label as
a trial balloon.  If everyone had agreed it looked OK, there would be
no reason not to put it upstream and start on the next step.

James


