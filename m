Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88764635A5
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 14:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhK3Nm2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 08:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhK3NmZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 08:42:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDBFC061574
        for <linux-integrity@vger.kernel.org>; Tue, 30 Nov 2021 05:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9EA74CE1A0B
        for <linux-integrity@vger.kernel.org>; Tue, 30 Nov 2021 13:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2193C53FC1;
        Tue, 30 Nov 2021 13:38:58 +0000 (UTC)
Date:   Tue, 30 Nov 2021 14:38:55 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
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
Message-ID: <20211130133855.rhrfvumx6lurj7jm@wittgenstein>
References: <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
 <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
 <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
 <20211129153539.GA26325@mail.hallyn.com>
 <20211129161650.dtcvh2ozgquz6rli@wittgenstein>
 <c73dd2cc-7915-9343-5ad0-e53c762e29a3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c73dd2cc-7915-9343-5ad0-e53c762e29a3@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 29, 2021 at 12:04:29PM -0500, Stefan Berger wrote:
> 
> On 11/29/21 11:16, Christian Brauner wrote:
> > On Mon, Nov 29, 2021 at 09:35:39AM -0600, Serge Hallyn wrote:
> > > On Mon, Nov 29, 2021 at 09:46:55AM -0500, James Bottomley wrote:
> > > > On Mon, 2021-11-29 at 15:22 +0100, Christian Brauner wrote:
> > > > > On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
> > > > > 
> > I kept thinking about this question while I was out running and while I
> > admittedly have reacted poorly to CLONE_NEWIMA patches before it feels
> > to me that this is the right approach after all. Making it part of
> > userns at least in this form isn't clean.
> > 
> > I think attaching a uuid to a userns alone for the sake of IMA is wrong.
> > Additionally, I think a uuid only for the userns is too limited. This is
> > similar to the problem of the audit container id. If we have some sort
> > of uuid for ima it will automatically evolve into something like a
> > container id (I'm not even arguing that this is necessarily wrong.).
> > We also have the issue that we then have the container audit id thing -
> > if this ever lands and the ima userns uuid. All that makes it quite
> > messy.
> > 
> > I think CLONE_NEWIMA is ultimately nicer and allows the implementation
> > to be decoupled from the userns and self-contained as possible. This
> > also means that ima ns works for privileged containers which sure is a
> > valid use-case.
> 
> The thing is that piggy backing on the user namespace at least allows us to
> 'always see' where IMA's keyring is (across setns()). If we were using an
> independent IMA namespace how would we guarantee that the user sees the
> keyring for IMA appraisal? We would at least have to take a reference (as in
> get_user_ns()) to the user namespace when the IMA namespace is created so
> that it at least the association of IMA namespace to user namespace remains
> a constant and the keyring IMA is using (and are held by the user namespace)

I don't think that this needs to be any different from other namespaces
that have an owning userns.

> is also constant across setns()'s. Otherwise it is possible that the user
> could do setns() to a different user namespace and be confused about the
> keys IMA is using. So at least by piggy backing we have them together. The
> aspect here may be 'usability'.

I mean, we do already have a dependence between pid namespaces and user
namespace etc., i.e. before you can join a pidns as an unpriv user you
need to join the userns. I think we can easily introduce a dependency
there. (Note also that a while back I extended setns() to take a pidfd
as an argument and you can now specify setns(pidfd, CLONE_NEWUSER |
CLONE_NEWPID | CLONE_NEWIMA).)

It's even worse in a sense since we can joing CLONE_NEWUSER in different
order depending whether we're privileging or devprivileging ourselves
(see the messy logic in nsenter and new*idmap for example). So there's
precedence for requiring dependencies between namespaces during setns().

> 
> I am somewhat sold on the USER namespace piggy backing thing... as suggested
> by James.
> 
> 
> > It will also make securityfs namespacing easier as it can be a keyed
> > super where the key is the ima ns (similar to how we deal with e.g.
> > mqueue).
> 
> Yes, mqueue is where I got the (API usage) idea from how to switch out the
> reference to the user namespace needed for the 'keyed' approach.
> 
> I will massage my 20 patch-series a bit more and then post it (for
> reference....). It does have 'somewhat dramatic' things in there that stem
> from virtualizing securityfs for example and IMA being a dependent of the
> user namespace and taking one more reference to the user namespace (it is a
> dependent of) and then the user namespace not being able to easily delete:
> 
> It's this here to help with an early tear-down to decrease the reference
> counter.
> 
> - https://github.com/stefanberger/linux-ima-namespaces/commit/1a5d7f2598764ca6f1a8c5a391672543fef83f2c
> 
> - https://github.com/stefanberger/linux-ima-namespaces/commit/d246f501f977e64333ecbd8bb79994e23b552b9b
> 
> - https://github.com/stefanberger/linux-ima-namespaces/commit/3b82058936862d7623b3a06bc1749d5efc018ab1#diff-99458ca9139231ac3811dbb0c0fced442c46c7cfdb94e86e4553fc0329d3a79bR647-R651
> 
> The teardown variable makes this a controlled process but ... is it
> acceptable?

I'll try to take a look later this week if that's ok.
