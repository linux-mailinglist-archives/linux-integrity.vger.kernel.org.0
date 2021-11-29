Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37D460C88
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 03:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbhK2CEU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Nov 2021 21:04:20 -0500
Received: from mail.hallyn.com ([178.63.66.53]:50240 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233004AbhK2CCU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Nov 2021 21:02:20 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id B028A774; Sun, 28 Nov 2021 19:59:01 -0600 (CST)
Date:   Sun, 28 Nov 2021 19:59:01 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux.dev,
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
Subject: Re: [RFC 1/3] userns: add uuid field
Message-ID: <20211129015901.GA20161@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
 <20211128044558.GA11794@mail.hallyn.com>
 <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
 <20211128151805.GA15306@mail.hallyn.com>
 <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
 <20211128204715.GA17707@mail.hallyn.com>
 <e1b36c9c36f0f6d3262de6141ad67e8044cfeade.camel@HansenPartnership.com>
 <20211128214906.GA18470@mail.hallyn.com>
 <e1d8fcb0dffd5d88c95140f644ece25273071d79.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d8fcb0dffd5d88c95140f644ece25273071d79.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 28, 2021 at 05:56:28PM -0500, James Bottomley wrote:
> On Sun, 2021-11-28 at 15:49 -0600, Serge E. Hallyn wrote:
> > On Sun, Nov 28, 2021 at 04:21:29PM -0500, James Bottomley wrote:
> > > On Sun, 2021-11-28 at 14:47 -0600, Serge E. Hallyn wrote:
> > > > On Sun, Nov 28, 2021 at 01:00:28PM -0500, James Bottomley wrote:
> > > > > On Sun, 2021-11-28 at 09:18 -0600, Serge E. Hallyn wrote:
> [...]
> > > > > > So given that 'unique per boot' is sufficient, what would be
> > > > > > the problem with simply adding a simple ever-increasing
> > > > > > unique atomix count to the struct user_namespace?
> > > > > 
> > > > > I don't think there is any ... but I equally don't see why
> > > > > people would want to save and restore the uuid but not the new
> > > > > monotonic identifier ... because it's still just a marker on a
> > > > > namespace.
> > > > 
> > > > But you've called it "the namespace uuid".  I'm not even really
> > > > thinking of checkpoint/restart, just stopping and restarting a
> > > > container.  I'm convinced people will want to start using it
> > > > because, well, it is a nice feature.
> > > 
> > > Right, but the uniqueness property depends on you not being able to
> > > set it.  If you just want a namespace label, you can have that, but
> > > anything a user can set is either a pain to guarantee uniqueness
> > > (have to check all the other objects) or is simply a non-unique
> > > label.
> > > 
> > > If you want to label a container, which could have many namespaces
> > > and be stopped and restarted many times, it does sound like you
> > > want a non-unique settable label.  However, IMA definitely needs a
> > > guaranteed per namespace unique label.
> > > 
> > > Is the objection simply you think a UUID sound like it should be
> > 
> > Objection is too strong.  Concern.
> > 
> > But yes, to me a uuid (a) feels like it should be generally useful
> > including being settable and (b) not super duper 100% absolutely
> > guaranteed to always be unique per boot, as an incremented counter
> > would be.
> 
> OK, but a bunch of cats I found on the Internet agree with me, a UUID
> shouldn't be settable:
> 
> https://en.wikipedia.org/wiki/Universally_unique_identifier
> 
> The key point being, if you can set the id, it can't be unique ... it

Ok, so can you just put a comment above there saying "this must not
be settable from userspace" ?

> doesn't have to be random (some of the versions are time or other
> unique object based properties) but it does have to be derived by
> something that gives reasonably reliable uniqueness (which is why
> humans aren't allowed to set them ... we're bad a choosing unique
> labels).
> 
> > > settable and a monotonic counter sounds like it shouldn't?  Because
> > > to me (coming I suppose from dealing with uuids in edk2) neither
> > > sounds like it should be settable.
> > 
> > Huh - yes, in contrast, for virtualization based tests of secureboot
> > and fs-y things we do indeed always set the uuids.
> 
> Well, the old msdos label had a settable ID that often caused problems
> because it wasn't unique.  The new gpt partition label specifically
> doesn't allow you to set the GUID label because it should be unique:
> 
> https://en.wikipedia.org/wiki/GUID_Partition_Table
> 
> I think some of the tools have emergency modes where you can set the
> label "just in case" but they shouldn't
> 
> The point is that if you're using a settable uuid for containers,
> you're doing the wrong thing ... it should either be a non-unique label
> (in which case why not make it more human readable) or only the system
> should be allowed to set it using the prescribed algorithm.

It seems to me you're confuddling things to make a point.  You want
noone to use things that look like uuids for things where they
choose the uuid - yet there are many places today where that's being
done.  Even the partition types: https://en.wikipedia.org/wiki/GUID_Partition_Table#Partition_type_GUIDs
C12A7328-F81F-11D2-BA4B-00A0C93EC93B was chosen for the EFI partition, 
and you must "set" the partition type to that.  So it's set-able.

Anyway I'm still not seeing what using uuids buys you over using
a counter, but I'll stop debating it and look at the rest of the
set.

thanks,
-serge
