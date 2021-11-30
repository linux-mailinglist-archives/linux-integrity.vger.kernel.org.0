Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEAA46351B
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhK3NMy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 08:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhK3NMy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 08:12:54 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71165C061574
        for <linux-integrity@vger.kernel.org>; Tue, 30 Nov 2021 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638277775;
        bh=n1TFcwEoygn1lnCP6+JLiYGxZufgS7TqcZcMf0iCa1c=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=O2lkS5VI74CZRcmuQl3a8z4HY5D9G84UKcOA/hXP/6fUfxye4kujZG8An6SLAm995
         KDxclJ9tRO9GMB6DpdI4JzwqwaMr6Q01yEPIVVvtqcZ7Y3JMdiKvBcAu5rw77h2aw6
         FZn5e9LBVsvnLGHV6IK2tcyYs3LVMZ2Tb7f9D5Ho=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 236AD12805E5;
        Tue, 30 Nov 2021 08:09:35 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a2nHguwqJ_RH; Tue, 30 Nov 2021 08:09:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638277774;
        bh=n1TFcwEoygn1lnCP6+JLiYGxZufgS7TqcZcMf0iCa1c=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CFOEpKNDaUcEwbZaNo+esTYo6pinWAjs2bJjlgpq6uQKS9rhfL/CEDQNZANJU8291
         +M+QvGoZ+JwNNuKrT9xBTqVFBT5GozqnuDO7VJ3P50gMf9YPB8UrLE2l0QRst+WuNU
         3VqzOid86XC/xHTiRD/gLZlIbyBNdMIN23VW7CgQ=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 243A512804CF;
        Tue, 30 Nov 2021 08:09:32 -0500 (EST)
Message-ID: <22f44b97c03d70ac0205f494657856f27fa75030.camel@HansenPartnership.com>
Subject: Re: [RFC 1/3] userns: add uuid field
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
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
Date:   Tue, 30 Nov 2021 08:09:31 -0500
In-Reply-To: <20211129135639.3boeegnusxllho35@wittgenstein>
References: <20211128044558.GA11794@mail.hallyn.com>
         <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
         <20211128151805.GA15306@mail.hallyn.com>
         <60c99d461368593dfd51765c527b01c6bf0a9fea.camel@HansenPartnership.com>
         <20211128204715.GA17707@mail.hallyn.com>
         <e1b36c9c36f0f6d3262de6141ad67e8044cfeade.camel@HansenPartnership.com>
         <20211128214906.GA18470@mail.hallyn.com>
         <e1d8fcb0dffd5d88c95140f644ece25273071d79.camel@HansenPartnership.com>
         <20211129015901.GA20161@mail.hallyn.com>
         <9f3466c1-276b-1d7e-917c-37c6f02d5571@linux.ibm.com>
         <20211129135639.3boeegnusxllho35@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 14:56 +0100, Christian Brauner wrote:
> On Mon, Nov 29, 2021 at 08:49:40AM -0500, Stefan Berger wrote:
> > On 11/28/21 20:59, Serge E. Hallyn wrote:
> > > On Sun, Nov 28, 2021 at 05:56:28PM -0500, James Bottomley wrote:
> > > > On Sun, 2021-11-28 at 15:49 -0600, Serge E. Hallyn wrote:
> > > > > On Sun, Nov 28, 2021 at 04:21:29PM -0500, James Bottomley
> > > > > wrote:
> > > > > > On Sun, 2021-11-28 at 14:47 -0600, Serge E. Hallyn wrote:
> > > > > > > On Sun, Nov 28, 2021 at 01:00:28PM -0500, James Bottomley
> > > > > > > wrote:
> > > > > > > > On Sun, 2021-11-28 at 09:18 -0600, Serge E. Hallyn
> > > > > > > > wrote:
> > > > [...]
> > > > > > > > > So given that 'unique per boot' is sufficient, what
> > > > > > > > > would be the problem with simply adding a simple
> > > > > > > > > ever-increasing unique atomix count to the struct
> > > > > > > > > user_namespace?
> > > > > > > > I don't think there is any ... but I equally don't see
> > > > > > > > why people would want to save and restore the uuid but
> > > > > > > > not the new monotonic identifier ... because it's still
> > > > > > > > just a marker on a namespace.
> > > > > > > But you've called it "the namespace uuid".  I'm not even
> > > > > > > really thinking of checkpoint/restart, just stopping and
> > > > > > > restarting a container.  I'm convinced people will want
> > > > > > > to start using it because, well, it is a nice feature.
> > > > > > Right, but the uniqueness property depends on you not being
> > > > > > able to set it.  If you just want a namespace label, you
> > > > > > can have that, but anything a user can set is either a pain
> > > > > > to guarantee uniqueness (have to check all the other
> > > > > > objects) or is simply a non-unique label.
> > > > > > 
> > > > > > If you want to label a container, which could have many
> > > > > > namespaces and be stopped and restarted many times, it does
> > > > > > sound like you want a non-unique settable label.  However,
> > > > > > IMA definitely needs a guaranteed per namespace unique
> > > > > > label.
> > > > > > 
> > > > > > Is the objection simply you think a UUID sound like it
> > > > > > should be
> > > > > Objection is too strong.  Concern.
> > > > > 
> > > > > But yes, to me a uuid (a) feels like it should be generally
> > > > > useful including being settable and (b) not super duper 100%
> > > > > absolutely guaranteed to always be unique per boot, as an
> > > > > incremented counter would be.
> > > > OK, but a bunch of cats I found on the Internet agree with me,
> > > > a UUID shouldn't be settable:
> > > > 
> > > > https://en.wikipedia.org/wiki/Universally_unique_identifier
> > > > 
> > > > The key point being, if you can set the id, it can't be unique
> > > > ... it
> > > Ok, so can you just put a comment above there saying "this must
> > > not be settable from userspace" ?
> > 
> > So I have been working on an IMA namespacing series again as well
> > and would like to use some sort of unique identifier for audit
> > messages emitted from an IMA/user namespace other than the
> > init_ima_ns. This UUID may just work for this, but how would one
> > associate the UUID with a container if it ever comes to that when
> > evaluating audit logs? Shouldn't it be settable from user
> > space for some sort of 'coordination' between container runtime and
> > kernel?
> 
> Wouldn't this be solved by the audit container id patchset? In fact,
> can't we use this for IMA as well?

Stefan asked, but it really doesn't have the properties we need, plus
they don't seem to want the audit id used as the container id.

How about this:  Since the label has to be unique for the lifetime of
the system, if we allow it to be settable, we'll have to carry it
outside the namespace anyway because memory of the label has to live on
after the namespace dies to avoid duplication, so I'll move it into a
parallel namespace structure ima will carry.  it will be settable once,
but if you don't set it before it's used, then we'll set it to a
randombly generated uuid.  If you do set it, it will be checked for
uniqueness against all previous labels.

James


