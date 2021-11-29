Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE81462121
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhK2T67 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 14:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241950AbhK2T47 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 14:56:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A305C061748
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 08:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED586159B
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 16:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428E9C53FC7;
        Mon, 29 Nov 2021 16:21:02 +0000 (UTC)
Date:   Mon, 29 Nov 2021 17:20:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
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
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Message-ID: <20211129162059.udhl7m7tbt4otgxd@wittgenstein>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
 <1402f334-8072-48d1-b30b-2c2cdd4869dd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1402f334-8072-48d1-b30b-2c2cdd4869dd@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 29, 2021 at 09:30:00AM -0500, Stefan Berger wrote:
> 
> On 11/29/21 09:10, James Bottomley wrote:
> > On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
> > > On 11/29/21 07:50, James Bottomley wrote:
> > > > On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
> > > > > On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley wrote:
> > > > > > Currently we get one entry in the IMA log per unique file
> > > > > > event.  So, if you have a measurement policy and it measures a
> > > > > > particular binary it will not get measured again if it is
> > > > > > subsequently executed. For Namespaced IMA, the correct
> > > > > > behaviour
> > > > > > seems to be to log once per inode per namespace (so every
> > > > > > unique
> > > > > > execution in a namespace gets a separate log entry).  Since
> > > > > > logging
> > > > > > once per inode per namespace is
> > > > > I suspect I'll need to do a more in depth reading of the existing
> > > > > code, but I'll ask the lazy question anyway (since you say "the
> > > > > correct behavior seems to be") - is it actually important that
> > > > > files which were appraised under a parent namespace's policy
> > > > > already
> > > > > should be logged again?
> > > > I think so.  For a couple of reasons, assuming the namespace
> > > > eventually
> > > > gets its own log entries, which the next incremental patch proposed
> > > > to
> > > > do by virtualizing the securityfs entries.  If you don't do this:
> > > To avoid duplicate efforts, an implementation of a virtualized
> > > securityfs is in this series here:
> > > 
> > > https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
> > > 
> > > It starts with 'securityfs: Prefix global variables with secruityfs_'
> > That's quite a big patch series.  I already actually implemented this
> > as part of the RFC for getting the per namespace measurement log.  The
> > attached is basically what I did.
> 
> I know it's big. I tried to avoid having to bind-mount the system-wide
> single securityfs into the container and inherit all the other security
> subsystems' files and directories (evm, TPM, safesetid, apparmor, tomoyo [
> https://elixir.bootlin.com/linux/latest/C/ident/securityfs_create_dir ]) and
> instead have a  'view' that is a bit more restricted to those subsystems
> that are namespaced. The securityfs_ns I created can be mounted into each
> user namespace individually and only shows what you're supposed to see
> without other filesystem tricks to hide files or so. It should be
> future-extensible for other subsystem to register themselves there if they
> have something to show to the user.

From a quick glance, your implementation is doing the right thing.
You're creating a keyed super via get_tree_keyed().
