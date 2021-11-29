Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C01461BBB
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbhK2Q3O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 11:29:14 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36152 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244824AbhK2Q1N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 11:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638203028;
        bh=xPNipZt/4wQBEActY1Dd9mBHUhc6/PCR2MJmoxfAE0Y=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=cafs1KVuEdavSLF40QBBPMYAo5T3Yj/V0JVpUdoVlEM8FZYJNK0DGaVblvhkeFL1H
         kQoCy63uZeymBtRdZ7kCOTaBuDMvv2jr1VcEGx1GOS6ba4kpe3FneyV+3eCtejB3+9
         2M3AtPf/bR+/r6fdh2uyeTX2/Hrg0k4PXUmBJoeM=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DF8B41280975;
        Mon, 29 Nov 2021 11:23:48 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SE6fwn6yX7hq; Mon, 29 Nov 2021 11:23:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638203028;
        bh=xPNipZt/4wQBEActY1Dd9mBHUhc6/PCR2MJmoxfAE0Y=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=cafs1KVuEdavSLF40QBBPMYAo5T3Yj/V0JVpUdoVlEM8FZYJNK0DGaVblvhkeFL1H
         kQoCy63uZeymBtRdZ7kCOTaBuDMvv2jr1VcEGx1GOS6ba4kpe3FneyV+3eCtejB3+9
         2M3AtPf/bR+/r6fdh2uyeTX2/Hrg0k4PXUmBJoeM=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 71A3C128096D;
        Mon, 29 Nov 2021 11:23:47 -0500 (EST)
Message-ID: <0d882e9cb371485c506d73a9b702a2cc398125af.camel@HansenPartnership.com>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
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
Date:   Mon, 29 Nov 2021 11:23:46 -0500
In-Reply-To: <3e609b60-221a-8b9b-5f55-ab7081a83786@linux.ibm.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
         <20211129045834.GB20606@mail.hallyn.com>
         <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
         <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
         <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
         <20211129142235.hez3ovtuj3rpscgm@wittgenstein>
         <afee2f0483271a6cdb1bc7b48b819a3ca2c4ceda.camel@HansenPartnership.com>
         <3e609b60-221a-8b9b-5f55-ab7081a83786@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 10:27 -0500, Stefan Berger wrote:
> On 11/29/21 09:46, James Bottomley wrote:
[...]
> > And, of course, the fun ones we're coming to.
> > 
> >     1. Given that the current keyring namespacing doesn't give
> > access to the system keyrings, how do we get per-namespace access
> > for .ima/_ima system keyrings given that the namespace admin is
> > going to want to set their own key for appraisal?
> >     2. What mechanism should we use for .ima/_ima key setting?  The
> > current mechanism is must be signed by a key in the system keyrings
> > sounds appropriate, but is problematic given most system owners
> > don't actually have any private keys for keys in the system
> > keyrings. Hopefully the MoK keyring patches will help us have an
> > easier approach to this.
> 
> The approach we took in the previous implementation was to support
> BYOK (bring your own key) for every container. The (trusted)
> container runtime has to do what dracut would typically do, namely
> create the keyrings and load the keys onto it.

Right, that's why I think the staged approach is the right way to do
this.  Let's first of all try to get an IMA namespace that can be used
to measure things and then worry about trying to add appraisal to the
namespace later, since it's a separable use case.  I think they how of
appraisal is one of the more complex issues, but it shouldn't hold up
actually starting to get an IMA namespace upstream and encouraging use
cases.

> The container runtime would
> 
> 1a) expect keys to be found inside a container's filesystem at the
> usual location (/etc/keys/ima) but then also allow for a CA key that
> is used to verify the signature of those keys; that CA key is
> typically baked  into the Linux kernel when .ima is to be used, but
> for containers and BYOK it's an additional file in the container's
> filesystem
> 
> 1b) passing in keys via command line should be possible as well but 
> that's an implementation detail

I do think the namespace should use a mechanism that's as close as
possible to the one on the physical system, so it shouldn't depend on
the orchestration system doing anything (there might not even be one).

The current way you install a new ima key is by adding it as root to
_ima or by adding one signed by a key on the system keyring to .ima; I
think this mechanism should be usable inside the namespace as well ...
that's not to say there can't be other mechanisms, but mirroring the
existing mechanism should be part of this.

> 2) container runtime sets up either a restricted keyring [ 
> https://elixir.bootlin.com/linux/latest/source/Documentation/crypto/asymmetric-keys.rst#L359 
> ] if that CA key is found in the filesystem or a 'normal' keyring.
> The container runtime then loads the keys onto that keyring; call
> that keyring '.ima' or '_ima' for as long as the kernel knows what
> keyring to search for.

and this keyring should be owned by the admin of the IMA namespace.

>  We created that keyring under a session keyring. With
> the user namespace isolation and keyrings support in the user
> namespace the  isolation of the IMA related keyrings between
> different user namespaces should be possible.

Yes, I think so.  Really system keyrings are keyrings root can't create
but which are owned by root, so it can see them.  This mechanism should
carry over to the admin of the IMA namespace, so I see no reason why we
can't set up mirrors of .ima/_ima in the keyring (user) namespace.

Part of the reason why I think using the user namespace for the IMA
namespace is because this will have to be done on first create of a new
IMA namespace, so it's much easier if the keyring and IMA namespaces
are the same namespace.

> The same would be done for the IMA policy where the container
> runtime also needs to do some work that usually dracut would do:
> 
> - expect the IMA policy for the container at the usual location 
> (/etc/ima/ima-policy) and load it into the container's 'securityfs' 
> policy file

Right, since non system containers don't boot, we discount the kernel
command line option.  Once we have the securityfs namespaced for the
IMA files, doing the policy write should be trivial.  The next question
would be how to process it so that we don't cause a security breach
(like turn of measurement on a filesystem where the original policy
required it).

James


