Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0474461B31
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 16:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345419AbhK2Pnz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 10:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhK2Ply (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 10:41:54 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B6C09CE44
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 05:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638193619;
        bh=vM0Z06dYMKeDfdaUJofHYvkxJd+bmlhbphuRm9jYb1o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hkmpiXVZH+MXr0i9A0H4pakbqg4LwBLOmXS6rawNDYo8JKaBg0P6Hwre2sIiwVGfy
         8kg5dsW9wV9BdwqBfqO3KqJLCvXejlFouMjn2SYuVFP0yu84bupPJ3mG9LfAv2UX/l
         upd/m/0Y4tsFfSmFlxfSp217CHNI0py6gon9iriE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5E9F41280518;
        Mon, 29 Nov 2021 08:46:59 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GTjHqBm5gK3q; Mon, 29 Nov 2021 08:46:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638193619;
        bh=vM0Z06dYMKeDfdaUJofHYvkxJd+bmlhbphuRm9jYb1o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hkmpiXVZH+MXr0i9A0H4pakbqg4LwBLOmXS6rawNDYo8JKaBg0P6Hwre2sIiwVGfy
         8kg5dsW9wV9BdwqBfqO3KqJLCvXejlFouMjn2SYuVFP0yu84bupPJ3mG9LfAv2UX/l
         upd/m/0Y4tsFfSmFlxfSp217CHNI0py6gon9iriE=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7475112803C3;
        Mon, 29 Nov 2021 08:46:57 -0500 (EST)
Message-ID: <12c67a60f658828bbfab52df8ef81713dcaed6ec.camel@HansenPartnership.com>
Subject: Re: [RFC 1/3] userns: add uuid field
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
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
Date:   Mon, 29 Nov 2021 08:46:55 -0500
In-Reply-To: <20211129131254.sfr7gy7mc25tclri@wittgenstein>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
         <20211128044558.GA11794@mail.hallyn.com>
         <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
         <20211128151805.GA15306@mail.hallyn.com>
         <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
         <20211128204715.GA17707@mail.hallyn.com>
         <e1b36c9c36f0f6d3262de6141ad67e8044cfeade.camel@HansenPartnership.com>
         <20211128214906.GA18470@mail.hallyn.com>
         <20211129131254.sfr7gy7mc25tclri@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 14:12 +0100, Christian Brauner wrote:
> On Sun, Nov 28, 2021 at 03:49:06PM -0600, Serge Hallyn wrote:
> > On Sun, Nov 28, 2021 at 04:21:29PM -0500, James Bottomley wrote:
> > > On Sun, 2021-11-28 at 14:47 -0600, Serge E. Hallyn wrote:
> > > > On Sun, Nov 28, 2021 at 01:00:28PM -0500, James Bottomley
> > > > wrote:
> > > > > On Sun, 2021-11-28 at 09:18 -0600, Serge E. Hallyn wrote:
[...]
> > > > > > So given that 'unique per boot' is sufficient, what would
> > > > > > be the problem with simply adding a simple ever-increasing
> > > > > > unique atomix count to the struct user_namespace?
> > > > > 
> > > > > I don't think there is any ... but I equally don't see why
> > > > > people would want to save and restore the uuid but not the
> > > > > new monotonic identifier ... because it's still just a marker
> > > > > on a namespace.
> > > > 
> > > > But you've called it "the namespace uuid".  I'm not even really
> > > > thinking of checkpoint/restart, just stopping and restarting a
> > > > container.  I'm convinced people will want to start using it
> > > > because, well, it is a nice feature.
> > > 
> > > Right, but the uniqueness property depends on you not being able
> > > to set it.  If you just want a namespace label, you can have
> > > that, but anything a user can set is either a pain to guarantee
> > > uniqueness (have to check all the other objects) or is simply a
> > > non-unique label.
> > > 
> > > If you want to label a container, which could have many
> > > namespaces and be stopped and restarted many times, it does sound
> > > like you want a non-unique settable label.  However, IMA
> > > definitely needs a guaranteed per namespace unique label.
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
> I don't have strong feelings about uuid or counter. In something like
> an IMA log a uuid might be better but idk. I don't know enough about
> IMA to judge that. I see the problem you're getting at though. Making
> this a member of struct user_namespace will give the impression that
> is a generic identifier. I'd rather make it clear that this is an
> IMA-only thing.

I don't think that's possible; let's unwind and look at the
requirements:  We need a per log (i.e. per boot) unique label, that the
user of the system can't tamper with, for the namespace to record in
the IMA log.  The chances are orchestration systems are likely going to
want a way to query the label so they can tie their own internal name
for a container that is using namespaced IMA to the entry in the log. 
Given these two requirements, it can't be an IMA only thing, it has to
be some sort of marker on the namespace itself.

> Ideally by not having it be a member of struct user_namespace at all
> or at least by naming it ima_uuid or similar.

I can call it ima_uuid, but Serge is right, given people are going to
want to get it, we're not going to be able to prevent it being used for
non-ima things.  The main thing I was trying to make clear is the
unique per boot and tamper proof property means there can't be an API
to set it.

Given the assumption people will use it for other things, it is
necessary to think about the wider issues before settling on a scheme.

From the security perspective I like UUIDs because they would make each
IMA log unique which is a useful property to prevent replay or log
faking, but I think a unique per boot counter would also work.

James


