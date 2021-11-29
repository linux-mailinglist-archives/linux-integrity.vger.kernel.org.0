Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9D461BBA
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 17:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbhK2Q2f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 11:28:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57530 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhK2Q0f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 11:26:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5C38B811FC
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 16:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55682C53FAD;
        Mon, 29 Nov 2021 16:23:12 +0000 (UTC)
Date:   Mon, 29 Nov 2021 17:23:09 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
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
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Message-ID: <20211129162309.ax7qlht5tjjc7ry7@wittgenstein>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
 <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
 <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
 <20211129153539.GA26325@mail.hallyn.com>
 <20211129161650.dtcvh2ozgquz6rli@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211129161650.dtcvh2ozgquz6rli@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 29, 2021 at 05:16:56PM +0100, Christian Brauner wrote:
> On Mon, Nov 29, 2021 at 09:35:39AM -0600, Serge Hallyn wrote:
> > On Mon, Nov 29, 2021 at 09:46:55AM -0500, James Bottomley wrote:
> > > On Mon, 2021-11-29 at 15:22 +0100, Christian Brauner wrote:
> > > > On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
> > > > > On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
> > > > > > On 11/29/21 07:50, James Bottomley wrote:
> > > > > > > On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
> > > > > > > > On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley
> > > > > > > > wrote:
> > > > > > > > > Currently we get one entry in the IMA log per unique file
> > > > > > > > > event.  So, if you have a measurement policy and it
> > > > > > > > > measures a particular binary it will not get measured again
> > > > > > > > > if it is subsequently executed. For Namespaced IMA, the
> > > > > > > > > correct behaviour seems to be to log once per inode per
> > > > > > > > > namespace (so every unique execution in a namespace gets a
> > > > > > > > > separate log entry).  Since logging once per inode per
> > > > > > > > > namespace is
> > > > > > > > I suspect I'll need to do a more in depth reading of the
> > > > > > > > existing code, but I'll ask the lazy question anyway (since
> > > > > > > > you say "the correct behavior seems to be") - is it actually
> > > > > > > > important that files which were appraised under a parent
> > > > > > > > namespace's policy already should be logged again?
> > > > > > > I think so.  For a couple of reasons, assuming the namespace
> > > > > > > eventually gets its own log entries, which the next incremental
> > > > > > > patch proposed to do by virtualizing the securityfs
> > > > > > > entries.  If you don't do this:
> > > > > > 
> > > > > > To avoid duplicate efforts, an implementation of a virtualized 
> > > > > > securityfs is in this series here:
> > > > > > 
> > > > > > https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
> > > > > > 
> > > > > > It starts with 'securityfs: Prefix global variables with
> > > > > > secruityfs_'
> > > > > 
> > > > > That's quite a big patch series.  I already actually implemented
> > > > > this as part of the RFC for getting the per namespace measurement
> > > > > log.  The attached is basically what I did.
> > > > > 
> > > > > Most of the time we don't require namespacing the actual virtualfs
> > > > > file, because it's world readable.  IMA has a special requirement
> > > > > in this regard because the IMA files should be readable (and
> > > > > writeable when we get around to policy updates) by the admin of the
> > > > > namespace but their protection is 0640 or 0440.  I thought the
> > > > > simplest solution would be to make an additional flag that coped
> > > > > with the permissions and a per-inode flag way of making the file as
> > > > > "accessible by userns admin".  Doing something simple like this
> > > > > gives a much smaller diffstat:
> > > > 
> > > > That's a NAK from me. Stefan's series might be bigger but it does
> > > > things correctly. I appreciate the keep it simple attitude but no. I
> > > > won't speciale-case securityfs or similar stuff in core vfs helpers.
> > > 
> > > Well, there's a reason it's an unpublished patch.  However, the more
> > > important point is that namespacing IMA requires discussion of certain
> > > points that we never seem to drive to a conclusion.  Using the akpm
> > > method, I propose simple patches that drive the discussion.  I think
> > > the points are:
> > > 
> > >    1. Should IMA be its own namespace or tied to the user namespace?  The
> > >       previous patches all took the separate Namespace approach, but I
> > >       think that should be reconsidered now keyrings are in the user
> > >       namespace.
> > 
> > Well that purely depends on the needed scope.
> > 
> > The audit container identifier is a neat thing.  But it absolutely must
> > be settable, so seems to conflict with your needs.
> > 
> > Your patch puts an identifier on the user_namespace.  I'm not quite sure,
> > does that satisfy Stefan's needs?  A new ima ns if and only if there is a
> > new user ns?
> 
> I kept thinking about this question while I was out running and while I
> admittedly have reacted poorly to CLONE_NEWIMA patches before it feels
> to me that this is the right approach after all. Making it part of
> userns at least in this form isn't clean.
> 
> I think attaching a uuid to a userns alone for the sake of IMA is wrong.
> Additionally, I think a uuid only for the userns is too limited. This is
> similar to the problem of the audit container id. If we have some sort
> of uuid for ima it will automatically evolve into something like a
> container id (I'm not even arguing that this is necessarily wrong.).
> We also have the issue that we then have the container audit id thing -
> if this ever lands and the ima userns uuid. All that makes it quite
> messy.
> 
> I think CLONE_NEWIMA is ultimately nicer and allows the implementation
> to be decoupled from the userns and self-contained as possible. This
> also means that ima ns works for privileged containers which sure is a
> valid use-case.
> It will also make securityfs namespacing easier as it can be a keyed
> super where the key is the ima ns (similar to how we deal with e.g.
> mqueue).

s/ima ns/userns/g

which is what Stefan already did in the link he shared.
