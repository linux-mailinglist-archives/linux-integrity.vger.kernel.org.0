Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB554635B9
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 14:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhK3Nrj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 08:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhK3Nrj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 08:47:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0703C061574
        for <linux-integrity@vger.kernel.org>; Tue, 30 Nov 2021 05:44:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 09889CE19FE
        for <linux-integrity@vger.kernel.org>; Tue, 30 Nov 2021 13:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC75C53FC1;
        Tue, 30 Nov 2021 13:44:10 +0000 (UTC)
Date:   Tue, 30 Nov 2021 14:44:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
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
Message-ID: <20211130134407.3hy2p7vlrevei2aa@wittgenstein>
References: <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
 <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
 <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
 <20211129153539.GA26325@mail.hallyn.com>
 <20211129161650.dtcvh2ozgquz6rli@wittgenstein>
 <c73dd2cc-7915-9343-5ad0-e53c762e29a3@linux.ibm.com>
 <20211130050316.GC32444@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130050316.GC32444@mail.hallyn.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 29, 2021 at 11:03:17PM -0600, Serge Hallyn wrote:
> On Mon, Nov 29, 2021 at 12:04:29PM -0500, Stefan Berger wrote:
> > 
> > On 11/29/21 11:16, Christian Brauner wrote:
> > > On Mon, Nov 29, 2021 at 09:35:39AM -0600, Serge Hallyn wrote:
> > > > On Mon, Nov 29, 2021 at 09:46:55AM -0500, James Bottomley wrote:
> > > > > On Mon, 2021-11-29 at 15:22 +0100, Christian Brauner wrote:
> > > > > > On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
> > > > > > 
> > > I kept thinking about this question while I was out running and while I
> > > admittedly have reacted poorly to CLONE_NEWIMA patches before it feels
> > > to me that this is the right approach after all. Making it part of
> > > userns at least in this form isn't clean.
> > > 
> > > I think attaching a uuid to a userns alone for the sake of IMA is wrong.
> > > Additionally, I think a uuid only for the userns is too limited. This is
> > > similar to the problem of the audit container id. If we have some sort
> > > of uuid for ima it will automatically evolve into something like a
> > > container id (I'm not even arguing that this is necessarily wrong.).
> > > We also have the issue that we then have the container audit id thing -
> > > if this ever lands and the ima userns uuid. All that makes it quite
> > > messy.
> > > 
> > > I think CLONE_NEWIMA is ultimately nicer and allows the implementation
> > > to be decoupled from the userns and self-contained as possible. This
> > > also means that ima ns works for privileged containers which sure is a
> > > valid use-case.
> > 
> > The thing is that piggy backing on the user namespace at least allows us to
> > 'always see' where IMA's keyring is (across setns()). If we were using an
> > independent IMA namespace how would we guarantee that the user sees the
> > keyring for IMA appraisal? We would at least have to take a reference (as in
> > get_user_ns()) to the user namespace when the IMA namespace is created so
> > that it at least the association of IMA namespace to user namespace remains
> 
> Maybe we pull they keyring info into a new struct which is referred
> to and pinned by both user_ns and ima_ns?  (But I actually am ignorant
> of how ima is using the keyrings, so again I need to go do some reading.)

That's one way of doing it and we'd be able to shrink struct
user_namespace because of it if we have to go down that road anyway.

> 
> More moving parts isn't my first choice.  But if you need namespaced IMA
> for containers that aren't doing CLONE_NEWUSER, then a separate ima_ns is
> your only option.  Is that a requirement for you?
