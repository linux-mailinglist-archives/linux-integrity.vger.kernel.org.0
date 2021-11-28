Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6121460AF2
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Nov 2021 23:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359501AbhK1XDD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Nov 2021 18:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbhK1XBC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Nov 2021 18:01:02 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AFAC061757
        for <linux-integrity@vger.kernel.org>; Sun, 28 Nov 2021 14:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638140191;
        bh=6Y1wf1TxxgqTgC/Vd8H3g00Xplhc1nL4Z2Q84U9OTyQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=MDy87sOGS7rBU/wrszLKFZm72R0ZSICsMMy4LkzHLDCzEIBa9ytq+M0ugsNTY5SyT
         yrf2YMCfOLq/3AiVoQDGePpKGk4QDcbpNUIbQFh4GUMu2hi1SrQU6I3fk6CknTK5do
         jrO4c8ci7aLGVBQXiBAhwn65cS1HZMqb5WxOgr0s=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8A2AD12804C9;
        Sun, 28 Nov 2021 17:56:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xVJ8qGqGAoW6; Sun, 28 Nov 2021 17:56:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638140191;
        bh=6Y1wf1TxxgqTgC/Vd8H3g00Xplhc1nL4Z2Q84U9OTyQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=MDy87sOGS7rBU/wrszLKFZm72R0ZSICsMMy4LkzHLDCzEIBa9ytq+M0ugsNTY5SyT
         yrf2YMCfOLq/3AiVoQDGePpKGk4QDcbpNUIbQFh4GUMu2hi1SrQU6I3fk6CknTK5do
         jrO4c8ci7aLGVBQXiBAhwn65cS1HZMqb5WxOgr0s=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 46682128028D;
        Sun, 28 Nov 2021 17:56:30 -0500 (EST)
Message-ID: <e1d8fcb0dffd5d88c95140f644ece25273071d79.camel@HansenPartnership.com>
Subject: Re: [RFC 1/3] userns: add uuid field
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Date:   Sun, 28 Nov 2021 17:56:28 -0500
In-Reply-To: <20211128214906.GA18470@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
         <20211128044558.GA11794@mail.hallyn.com>
         <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
         <20211128151805.GA15306@mail.hallyn.com>
         <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
         <20211128204715.GA17707@mail.hallyn.com>
         <e1b36c9c36f0f6d3262de6141ad67e8044cfeade.camel@HansenPartnership.com>
         <20211128214906.GA18470@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-11-28 at 15:49 -0600, Serge E. Hallyn wrote:
> On Sun, Nov 28, 2021 at 04:21:29PM -0500, James Bottomley wrote:
> > On Sun, 2021-11-28 at 14:47 -0600, Serge E. Hallyn wrote:
> > > On Sun, Nov 28, 2021 at 01:00:28PM -0500, James Bottomley wrote:
> > > > On Sun, 2021-11-28 at 09:18 -0600, Serge E. Hallyn wrote:
[...]
> > > > > So given that 'unique per boot' is sufficient, what would be
> > > > > the problem with simply adding a simple ever-increasing
> > > > > unique atomix count to the struct user_namespace?
> > > > 
> > > > I don't think there is any ... but I equally don't see why
> > > > people would want to save and restore the uuid but not the new
> > > > monotonic identifier ... because it's still just a marker on a
> > > > namespace.
> > > 
> > > But you've called it "the namespace uuid".  I'm not even really
> > > thinking of checkpoint/restart, just stopping and restarting a
> > > container.  I'm convinced people will want to start using it
> > > because, well, it is a nice feature.
> > 
> > Right, but the uniqueness property depends on you not being able to
> > set it.  If you just want a namespace label, you can have that, but
> > anything a user can set is either a pain to guarantee uniqueness
> > (have to check all the other objects) or is simply a non-unique
> > label.
> > 
> > If you want to label a container, which could have many namespaces
> > and be stopped and restarted many times, it does sound like you
> > want a non-unique settable label.  However, IMA definitely needs a
> > guaranteed per namespace unique label.
> > 
> > Is the objection simply you think a UUID sound like it should be
> 
> Objection is too strong.  Concern.
> 
> But yes, to me a uuid (a) feels like it should be generally useful
> including being settable and (b) not super duper 100% absolutely
> guaranteed to always be unique per boot, as an incremented counter
> would be.

OK, but a bunch of cats I found on the Internet agree with me, a UUID
shouldn't be settable:

https://en.wikipedia.org/wiki/Universally_unique_identifier

The key point being, if you can set the id, it can't be unique ... it
doesn't have to be random (some of the versions are time or other
unique object based properties) but it does have to be derived by
something that gives reasonably reliable uniqueness (which is why
humans aren't allowed to set them ... we're bad a choosing unique
labels).

> > settable and a monotonic counter sounds like it shouldn't?  Because
> > to me (coming I suppose from dealing with uuids in edk2) neither
> > sounds like it should be settable.
> 
> Huh - yes, in contrast, for virtualization based tests of secureboot
> and fs-y things we do indeed always set the uuids.

Well, the old msdos label had a settable ID that often caused problems
because it wasn't unique.  The new gpt partition label specifically
doesn't allow you to set the GUID label because it should be unique:

https://en.wikipedia.org/wiki/GUID_Partition_Table

I think some of the tools have emergency modes where you can set the
label "just in case" but they shouldn't

The point is that if you're using a settable uuid for containers,
you're doing the wrong thing ... it should either be a non-unique label
(in which case why not make it more human readable) or only the system
should be allowed to set it using the prescribed algorithm.

James


