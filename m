Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FECD4621C2
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 21:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhK2UNA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 15:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhK2ULA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 15:11:00 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058CC0698CF
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638204277;
        bh=D63MuVTlcyWR7tJ8LjFr7KsXPx3ERPscNz6EFGrQWTQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PJLmwxPWh56RNSLJrFEN+syzcGHectLHdLWykinUeMvP7E+dv2FjcBc6AbtW+GvzC
         yFNnRY+5CAa7BsZ+TAN07EtlI/cfWI1ywFARYFyrMAfHcZLGTnbI5KibXv0AevhVm1
         5QfB0lST2orNNLF56ARt+B0YEO1JVAjGKFdS+cJw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A2C4112803C3;
        Mon, 29 Nov 2021 11:44:37 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MZ2jVXedFSow; Mon, 29 Nov 2021 11:44:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638204277;
        bh=D63MuVTlcyWR7tJ8LjFr7KsXPx3ERPscNz6EFGrQWTQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PJLmwxPWh56RNSLJrFEN+syzcGHectLHdLWykinUeMvP7E+dv2FjcBc6AbtW+GvzC
         yFNnRY+5CAa7BsZ+TAN07EtlI/cfWI1ywFARYFyrMAfHcZLGTnbI5KibXv0AevhVm1
         5QfB0lST2orNNLF56ARt+B0YEO1JVAjGKFdS+cJw=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4A0E312802FC;
        Mon, 29 Nov 2021 11:44:36 -0500 (EST)
Message-ID: <16e27be21e2886ba17298d94fdaff39236667890.camel@HansenPartnership.com>
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
Date:   Mon, 29 Nov 2021 11:44:35 -0500
In-Reply-To: <20211129153539.GA26325@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
         <20211129045834.GB20606@mail.hallyn.com>
         <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
         <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
         <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
         <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
         <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
         <20211129153539.GA26325@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 09:35 -0600, Serge E. Hallyn wrote:
> On Mon, Nov 29, 2021 at 09:46:55AM -0500, James Bottomley wrote:
[...]
> > Well, there's a reason it's an unpublished patch.  However, the
> > more important point is that namespacing IMA requires discussion of
> > certain points that we never seem to drive to a conclusion.  Using
> > the akpm method, I propose simple patches that drive the
> > discussion.  I think the points are:
> > 
> >    1. Should IMA be its own namespace or tied to the user
> > namespace?  The previous patches all took the separate Namespace
> > approach, but I think that should be reconsidered now keyrings are
> > in the user namespace.
> 
> Well that purely depends on the needed scope.
> 
> The audit container identifier is a neat thing.  But it absolutely
> must be settable, so seems to conflict with your needs.

I think not allowing duplicate entries for the lifetime of the log is
required, which causes a problem since namespaces can die before this
lifetime ends.  I think there is a nice security benefit in making it
not user settable, but I don't think that's necessarily a requirement.

> Your patch puts an identifier on the user_namespace.  I'm not quite
> sure, does that satisfy Stefan's needs?  A new ima ns if and only if
> there is a new user ns?

Part of the problem is that IMA needs an admin user ... to be able to
read the log and set the policy and, when we get to appraisal, set and
read the keyrings.  IMA NS iff user ns satisfies this, but the
minimalist in me then asks why not make them the same thing?

> I think you two need to get together and discuss the requirements,
> and come back with a brief but very precise document explaining what
> you need.

> Are you both looking at the same use case?  Who is consuming the
> audit log, and to what end?  Container administrators?  Any time they
> log in? How do they assure themselves that the securityfs file
> they're reading hasn't been overmounted?

There are several different use cases.  I'm asking how I would use the
IMA namespace for the unprivileged containers I usually set up by
hand.  Stefan is looking at how docker/kubernetes would do it.  There's
also the Huawei use case which is a sort of attestation for function as
a service and there's the Red Hat use case for OpenShift.

However, the common denominator in all of these is they require a way
to uniquely distinguish the containers, which is why the patch series I
sent as an RFC starts that way.  If we can start with the common
elements, we can build towards something that satisfies all the use
cases ... and allow consensus to emerge as further patches are
discussed.

Part of my problem is I don't really know what I need, I just want IMA
namespaces to work easily for the unprivileged use case and I'll figure
it out as I play with it ... but to do that I need something to start
playing with.

> I need to find a document to read about IMA's usage of PCRs.  For
> namespacing, are you expecting each container to be hooked up to a
> swtmp instance so they have their own PCR they can use?

That's one of the most complicated things of all: trying to attach a
vTPM to store the local extensions and quote the IMA log in the
namespace.  The Huawei patch doesn't have it, because they don't really
need it (they just want global attestation to work), the IBM patches
do.  I think there are many ways of attesting to the subset of the log
in the namespace, so I don't think a vTPM is required.  I do, however,
think it should be supported for the use cases that need it.

James


