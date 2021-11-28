Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E894609C1
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Nov 2021 21:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357083AbhK1Uwd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Nov 2021 15:52:33 -0500
Received: from mail.hallyn.com ([178.63.66.53]:41266 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237349AbhK1Uud (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Nov 2021 15:50:33 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 6A61666F; Sun, 28 Nov 2021 14:47:15 -0600 (CST)
Date:   Sun, 28 Nov 2021 14:47:15 -0600
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
Message-ID: <20211128204715.GA17707@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
 <20211128044558.GA11794@mail.hallyn.com>
 <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
 <20211128151805.GA15306@mail.hallyn.com>
 <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 28, 2021 at 01:00:28PM -0500, James Bottomley wrote:
> On Sun, 2021-11-28 at 09:18 -0600, Serge E. Hallyn wrote:
> > On Sun, Nov 28, 2021 at 08:29:21AM -0500, James Bottomley wrote:
> > > On Sat, 2021-11-27 at 22:45 -0600, Serge E. Hallyn wrote:
> > > > On Sat, Nov 27, 2021 at 04:45:47PM +0000, James Bottomley wrote:
> > > > > As a precursor to namespacing IMA a way of uniquely identifying
> > > > > the namespace to appear in the IMA log is needed.  This log may
> > > > > be transported away from the running system and may be analyzed
> > > > > even after the system has been rebooted.  Thus we need a way of
> > > > > identifying namespaces in the log which is unique.  UUID, being
> > > > > designed probabilistically never to repeat, fits this bill so
> > > > > add it to the user_namespace which we'll also use for
> > > > > namespacing IMA.
> > > > 
> > > > If the logs run across 5 boots, is it important to you that the
> > > > uuid be unique across all 5 boots?  Would it suffice to have a
> > > > per-boot unique count and report that plus some indicator of the
> > > > current boot (like boot time in jiffies)?
> > > 
> > > For the purposes of IMA it's only really important to have the uuid
> > > be unique within the particular log ... i.e. unique per
> > > boot.  However, given the prevalence of uuids elsewhere and the
> > > fact we have no current per-boot unique label for the namespace
> > > (the inode number could repeat), it seemed reasonable to employ
> > > uuids for this rather than invent a different identifier.  Plus IMA
> > > isn't going to complain if we have a globally unique identifier ...
> > 
> > Ok - Note I'm not saying I heavily object, but I'm mildly concerned
> > about users who happen to spin off a lot of user namespaces for
> > quick jobs being penalized.
> 
> Well, that's why I use the uuid_gen coupled to prandom ... there
> shouldn't be a measurable overhead generating it.

Does prandom have *no*, or just little effect on the entopy pool?
Tried briefly looking at prandom_u32, not quite getting how it's
using net_rand_state - it reads it and uses it but doesn't make
any changes to it?

> >   I suspect Eric will also worry about the namespacing implications -
> > i.e. people *will* want to start restoring user namespaces with a
> > previously used uuid.
> 
> So this is a problem I tried to address in the last paragraph.  If I
> put any marker on a namespace, people are potentially going to want to
> save and restore it. The bottom line is that ima logs are add only. 
> You can't save and restore them so we're already dealing with something
> that can't be CRIU transported.  I had hoped that it would be obvious
> that a randomly generated uuid, whose uniqueness depends on random
> generation likewise can't be saved and restored because we'd have no
> way to prevent a clash.

Yes but you're making this a general user_namespace struct member.
So once that's there people will want to export it, use it for
things other than ima.

> > So given that 'unique per boot' is sufficient, what would be the
> > problem with simply adding a simple ever-increasing unique atomix
> > count to the struct user_namespace?
> 
> I don't think there is any ... but I equally don't see why people would
> want to save and restore the uuid but not the new monotonic identifier
> ... because it's still just a marker on a namespace.

But you've called it "the namespace uuid".  I'm not even really thinking
of checkpoint/restart, just stopping and restarting a container.  I'm
convinced people will want to start using it because, well, it is a nice
feature.

-serge
