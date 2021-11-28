Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88238460A4B
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Nov 2021 22:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhK1V0v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Nov 2021 16:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhK1VYu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Nov 2021 16:24:50 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868DEC061574
        for <linux-integrity@vger.kernel.org>; Sun, 28 Nov 2021 13:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638134493;
        bh=z9HehhLNY5ToXm+mwpY8TCdeoltukaK4Hnqe39vD1yM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=saDV+mQf7r5j5dNOkf+RJ6YoAPW5k4g96oZ4wG4KNGdXZKHaGibuYFSlBWyXs2wFR
         0oROI9G8j/x6BplFhPg0NDbeCrjUi9S0TEZaHGCwM/ScsgCfx46tlKCTn0dtlJunwt
         RuKvpGqV6pUv6N2G4vN8roSr5fn66XfSpP6lzr8E=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0C2211280915;
        Sun, 28 Nov 2021 16:21:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tJIMfig_G2fV; Sun, 28 Nov 2021 16:21:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638134492;
        bh=z9HehhLNY5ToXm+mwpY8TCdeoltukaK4Hnqe39vD1yM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tKqpkcygt/I56XTxDhtN1g9VLfpPssLMhImqa4n4qPP6pQ/uLoWl8ilSvHLosaBON
         mPfHOXG9rHeelrpzRZji+ipNIBXUlqcz29bA7pFecUDd1WHK2HcqYYpdBk7hKNE6id
         q2t1SiEtAj3Jr5yHufEM/X+Ekm8h2t21LKaDUGqw=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AE90312808C3;
        Sun, 28 Nov 2021 16:21:31 -0500 (EST)
Message-ID: <e1b36c9c36f0f6d3262de6141ad67e8044cfeade.camel@HansenPartnership.com>
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
Date:   Sun, 28 Nov 2021 16:21:29 -0500
In-Reply-To: <20211128204715.GA17707@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
         <20211128044558.GA11794@mail.hallyn.com>
         <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
         <20211128151805.GA15306@mail.hallyn.com>
         <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
         <20211128204715.GA17707@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-11-28 at 14:47 -0600, Serge E. Hallyn wrote:
> On Sun, Nov 28, 2021 at 01:00:28PM -0500, James Bottomley wrote:
> > On Sun, 2021-11-28 at 09:18 -0600, Serge E. Hallyn wrote:
> > > On Sun, Nov 28, 2021 at 08:29:21AM -0500, James Bottomley wrote:
> > > > On Sat, 2021-11-27 at 22:45 -0600, Serge E. Hallyn wrote:
> > > > > On Sat, Nov 27, 2021 at 04:45:47PM +0000, James Bottomley
> > > > > wrote:
> > > > > > As a precursor to namespacing IMA a way of uniquely
> > > > > > identifying the namespace to appear in the IMA log is
> > > > > > needed.  This log may be transported away from the running
> > > > > > system and may be analyzed even after the system has been
> > > > > > rebooted.  Thus we need a way of identifying namespaces in
> > > > > > the log which is unique.  UUID, being designed
> > > > > > probabilistically never to repeat, fits this bill
> > > > > > so add it to the user_namespace which we'll also use for
> > > > > > namespacing IMA.
> > > > > 
> > > > > If the logs run across 5 boots, is it important to you that
> > > > > the uuid be unique across all 5 boots?  Would it suffice to
> > > > > have a per-boot unique count and report that plus some
> > > > > indicator of the current boot (like boot time in jiffies)?
> > > > 
> > > > For the purposes of IMA it's only really important to have the
> > > > uuid be unique within the particular log ... i.e. unique per
> > > > boot.  However, given the prevalence of uuids elsewhere and the
> > > > fact we have no current per-boot unique label for the namespace
> > > > (the inode number could repeat), it seemed reasonable to employ
> > > > uuids for this rather than invent a different identifier.  Plus
> > > > IMA isn't going to complain if we have a globally unique
> > > > identifier
> > > > ...
> > > 
> > > Ok - Note I'm not saying I heavily object, but I'm mildly
> > > concerned about users who happen to spin off a lot of user
> > > namespaces for quick jobs being penalized.
> > 
> > Well, that's why I use the uuid_gen coupled to prandom ... there
> > shouldn't be a measurable overhead generating it.
> 
> Does prandom have *no*, or just little effect on the entopy pool?
> Tried briefly looking at prandom_u32, not quite getting how it's
> using net_rand_state - it reads it and uses it but doesn't make
> any changes to it?

It has a first use effect to get the seed but once that happens it has
no further effect on the entropy pool.

> > >   I suspect Eric will also worry about the namespacing
> > > implications - i.e. people *will* want to start restoring user
> > > namespaces with a previously used uuid.
> > 
> > So this is a problem I tried to address in the last paragraph.  If
> > I put any marker on a namespace, people are potentially going to
> > want to save and restore it. The bottom line is that ima logs are
> > add only.  You can't save and restore them so we're already dealing
> > with something that can't be CRIU transported.  I had hoped that it
> > would be obvious that a randomly generated uuid, whose uniqueness
> > depends on random generation likewise can't be saved and restored
> > because we'd have no way to prevent a clash.
> 
> Yes but you're making this a general user_namespace struct member.
> So once that's there people will want to export it, use it for
> things other than ima.

Yes, that's why I did it.  However, the property of uniqueness for all
uuid type things depends on randomness, so ipso facto, they can never
be settable.

> > > So given that 'unique per boot' is sufficient, what would be the
> > > problem with simply adding a simple ever-increasing unique atomix
> > > count to the struct user_namespace?
> > 
> > I don't think there is any ... but I equally don't see why people
> > would want to save and restore the uuid but not the new monotonic
> > identifier ... because it's still just a marker on a namespace.
> 
> But you've called it "the namespace uuid".  I'm not even really
> thinking of checkpoint/restart, just stopping and restarting a
> container.  I'm convinced people will want to start using it because,
> well, it is a nice feature.

Right, but the uniqueness property depends on you not being able to set
it.  If you just want a namespace label, you can have that, but
anything a user can set is either a pain to guarantee uniqueness (have
to check all the other objects) or is simply a non-unique label.

If you want to label a container, which could have many namespaces and
be stopped and restarted many times, it does sound like you want a non-
unique settable label.  However, IMA definitely needs a guaranteed per
namespace unique label.

Is the objection simply you think a UUID sound like it should be
settable and a monotonic counter sounds like it shouldn't?  Because to
me (coming I suppose from dealing with uuids in edk2) neither sounds
like it should be settable.

James


