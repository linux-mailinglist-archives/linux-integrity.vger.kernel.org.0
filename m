Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA946264C
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 23:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhK2Wue (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 17:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhK2Wtu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 17:49:50 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C763C0C20E9
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 09:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638206943;
        bh=tr0JLk6qKvAnEjWDEXB82mOEdfU6Wn/gr7hw226U6xg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=I+qldLTbuZVtzS23cHM7po6s6S8lCiFnm6llODhKLDzUPGns7Q7nmftEt+D87fHOH
         /q+pazW1OEjCjMuVxTjqB38WPdHcml2Cd5E8FLUHCmbqZ88xkYnn9aIydgEZywNj5N
         r8lpGIC+ItvSszwGYdONLpf+zq3OblazKLJxmqHw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EDA4112808E1;
        Mon, 29 Nov 2021 12:29:03 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uriTwyl-_eyu; Mon, 29 Nov 2021 12:29:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638206943;
        bh=tr0JLk6qKvAnEjWDEXB82mOEdfU6Wn/gr7hw226U6xg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=I+qldLTbuZVtzS23cHM7po6s6S8lCiFnm6llODhKLDzUPGns7Q7nmftEt+D87fHOH
         /q+pazW1OEjCjMuVxTjqB38WPdHcml2Cd5E8FLUHCmbqZ88xkYnn9aIydgEZywNj5N
         r8lpGIC+ItvSszwGYdONLpf+zq3OblazKLJxmqHw=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8F52E12806D9;
        Mon, 29 Nov 2021 12:29:02 -0500 (EST)
Message-ID: <06ac5a1b4186097b827ce9886d28ad0a3cfe5c1e.camel@HansenPartnership.com>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
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
Date:   Mon, 29 Nov 2021 12:29:01 -0500
In-Reply-To: <c73dd2cc-7915-9343-5ad0-e53c762e29a3@linux.ibm.com>
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
         <c73dd2cc-7915-9343-5ad0-e53c762e29a3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 12:04 -0500, Stefan Berger wrote:
> On 11/29/21 11:16, Christian Brauner wrote:
[...]
> > I kept thinking about this question while I was out running and
> > while I admittedly have reacted poorly to CLONE_NEWIMA patches
> > before it feels to me that this is the right approach after all.
> > Making it part of userns at least in this form isn't clean.
> > 
> > I think attaching a uuid to a userns alone for the sake of IMA is
> > wrong. Additionally, I think a uuid only for the userns is too
> > limited. This is similar to the problem of the audit container id.
> > If we have some sort of uuid for ima it will automatically evolve
> > into something like a container id (I'm not even arguing that this
> > is necessarily wrong.). We also have the issue that we then have
> > the container audit id thing - if this ever lands and the ima
> > userns uuid. All that makes it quite messy.
> > 
> > I think CLONE_NEWIMA is ultimately nicer and allows the
> > implementation to be decoupled from the userns and self-contained
> > as possible.  This also means that ima ns works for privileged
> > containers which sure is a valid use-case.
> 
> The thing is that piggy backing on the user namespace at least allows
> us to 'always see' where IMA's keyring is (across setns()). If we
> were  using an independent IMA namespace how would we guarantee that
> the user sees the keyring for IMA appraisal? We would at least have
> to take a  reference (as in get_user_ns()) to the user namespace when
> the IMA namespace is created so that it at least the association of
> IMA namespace to user namespace remains a constant and the keyring
> IMA is using (and are held by the user namespace) is also constant
> across setns()'s. Otherwise it is possible that the user could do
> setns() to a different user namespace and be confused about the keys
> IMA is using. So at least by piggy backing we have them together. The
> aspect here may be 'usability'.
> 
> I am somewhat sold on the USER namespace piggy backing thing... as 
> suggested by James.

And to be clear, I don't think a separate IMA namespace is necessarily
wrong a priori.  However, all the original patch sets had the separate
namespace approach and I worry that the keyring namespace in user
namespace has forced our hand somewhat, so I wanted at least to post a
semi-usable patch set showing what would happen if the IMA namespace
were the user namespace for illustration so it would serve as a basis
for discussion.

James


