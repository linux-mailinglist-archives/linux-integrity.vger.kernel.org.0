Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F416A461D72
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 19:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbhK2SVl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 13:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhK2STl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 13:19:41 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087CC12A74F
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638197218;
        bh=NS3dcvMtXFtau0X4BYh03gxK9rHBvkiPP3WisweRvm8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WsRrEOGrYMMnkEZA+LXlMbC9oSrXiJ4brLgKXpn1QWku+oE67E3PJCN+qWV3EF9hg
         0WJpHKfOSePZHqarMkdjRF+ecdWswjRUdHYvb/lSNdbHMzEjj1ElSx345finGy4OPu
         ZnkgxflE4fZveKXiOWq/iI1uuhPSX9NxWEJUm8xM=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3B89912804CF;
        Mon, 29 Nov 2021 09:46:58 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 39h086_xX76D; Mon, 29 Nov 2021 09:46:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638197218;
        bh=NS3dcvMtXFtau0X4BYh03gxK9rHBvkiPP3WisweRvm8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WsRrEOGrYMMnkEZA+LXlMbC9oSrXiJ4brLgKXpn1QWku+oE67E3PJCN+qWV3EF9hg
         0WJpHKfOSePZHqarMkdjRF+ecdWswjRUdHYvb/lSNdbHMzEjj1ElSx345finGy4OPu
         ZnkgxflE4fZveKXiOWq/iI1uuhPSX9NxWEJUm8xM=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CDE2512803C3;
        Mon, 29 Nov 2021 09:46:56 -0500 (EST)
Message-ID: <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
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
Date:   Mon, 29 Nov 2021 09:46:55 -0500
In-Reply-To: <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
         <20211129045834.GB20606@mail.hallyn.com>
         <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
         <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
         <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
         <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 15:22 +0100, Christian Brauner wrote:
> On Mon, Nov 29, 2021 at 09:10:29AM -0500, James Bottomley wrote:
> > On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
> > > On 11/29/21 07:50, James Bottomley wrote:
> > > > On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
> > > > > On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley
> > > > > wrote:
> > > > > > Currently we get one entry in the IMA log per unique file
> > > > > > event.  So, if you have a measurement policy and it
> > > > > > measures a particular binary it will not get measured again
> > > > > > if it is subsequently executed. For Namespaced IMA, the
> > > > > > correct behaviour seems to be to log once per inode per
> > > > > > namespace (so every unique execution in a namespace gets a
> > > > > > separate log entry).  Since logging once per inode per
> > > > > > namespace is
> > > > > I suspect I'll need to do a more in depth reading of the
> > > > > existing code, but I'll ask the lazy question anyway (since
> > > > > you say "the correct behavior seems to be") - is it actually
> > > > > important that files which were appraised under a parent
> > > > > namespace's policy already should be logged again?
> > > > I think so.  For a couple of reasons, assuming the namespace
> > > > eventually gets its own log entries, which the next incremental
> > > > patch proposed to do by virtualizing the securityfs
> > > > entries.  If you don't do this:
> > > 
> > > To avoid duplicate efforts, an implementation of a virtualized 
> > > securityfs is in this series here:
> > > 
> > > https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
> > > 
> > > It starts with 'securityfs: Prefix global variables with
> > > secruityfs_'
> > 
> > That's quite a big patch series.  I already actually implemented
> > this as part of the RFC for getting the per namespace measurement
> > log.  The attached is basically what I did.
> > 
> > Most of the time we don't require namespacing the actual virtualfs
> > file, because it's world readable.  IMA has a special requirement
> > in this regard because the IMA files should be readable (and
> > writeable when we get around to policy updates) by the admin of the
> > namespace but their protection is 0640 or 0440.  I thought the
> > simplest solution would be to make an additional flag that coped
> > with the permissions and a per-inode flag way of making the file as
> > "accessible by userns admin".  Doing something simple like this
> > gives a much smaller diffstat:
> 
> That's a NAK from me. Stefan's series might be bigger but it does
> things correctly. I appreciate the keep it simple attitude but no. I
> won't speciale-case securityfs or similar stuff in core vfs helpers.

Well, there's a reason it's an unpublished patch.  However, the more
important point is that namespacing IMA requires discussion of certain
points that we never seem to drive to a conclusion.  Using the akpm
method, I propose simple patches that drive the discussion.  I think
the points are:

   1. Should IMA be its own namespace or tied to the user namespace?  The
      previous patches all took the separate Namespace approach, but I
      think that should be reconsidered now keyrings are in the user
      namespace.
   2. How do we get a unique id for the IMA namespace to use in the log?
   3. how should we virtualize securityfs for IMA given the need of the
      namespace admin to read and write the IMA files?

And, of course, the fun ones we're coming to.

   1. Given that the current keyring namespacing doesn't give access to
      the system keyrings, how do we get per-namespace access for
      .ima/_ima system keyrings given that the namespace admin is going to
      want to set their own key for appraisal?
   2. What mechanism should we use for .ima/_ima key setting?  The current
      mechanism is must be signed by a key in the system keyrings sounds
      appropriate, but is problematic given most system owners don't
      actually have any private keys for keys in the system keyrings. 
      Hopefully the MoK keyring patches will help us have an easier
      approach to this.

James


