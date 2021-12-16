Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730CD477F99
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 22:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhLPVwv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 16:52:51 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:59070 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234629AbhLPVwv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 16:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1639691570;
        bh=LLHJG9qY3yjOObMbgWYj684Svyh+zyuMMlc5pZe48sg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=fBSP0jRzf9gJWoTO4i7RjpjxmNpN/UqHT7zpv4Yz3sQ6JygaHXPcgNAypJRspzJVl
         ywrvXGouqz7An9vFSPoF8bUU5T8s/zxxsE8X7e5pmf5GjPKIYEAJQmRJ9i3QlnNBat
         X4DN4l8Xa9TsThOn4fpCGFucfvM/74HNfaipiXaw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D9B701280B09;
        Thu, 16 Dec 2021 16:52:50 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HmOs0ZxTXecz; Thu, 16 Dec 2021 16:52:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1639691570;
        bh=LLHJG9qY3yjOObMbgWYj684Svyh+zyuMMlc5pZe48sg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=fBSP0jRzf9gJWoTO4i7RjpjxmNpN/UqHT7zpv4Yz3sQ6JygaHXPcgNAypJRspzJVl
         ywrvXGouqz7An9vFSPoF8bUU5T8s/zxxsE8X7e5pmf5GjPKIYEAJQmRJ9i3QlnNBat
         X4DN4l8Xa9TsThOn4fpCGFucfvM/74HNfaipiXaw=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 17C441280AF4;
        Thu, 16 Dec 2021 16:52:49 -0500 (EST)
Message-ID: <f408c42b74e28d90fce262abd50fc8a3079c0fa3.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 01/14] ima: Add IMA namespace support
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 16 Dec 2021 16:52:47 -0500
In-Reply-To: <20211216140806.hi4jxw54yvbu5cox@wittgenstein>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
         <20211216054323.1707384-2-stefanb@linux.vnet.ibm.com>
         <20211216140806.hi4jxw54yvbu5cox@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-12-16 at 15:08 +0100, Christian Brauner wrote:
> On Thu, Dec 16, 2021 at 12:43:10AM -0500, Stefan Berger wrote:
[...]
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index 6b2e3ca7ee99..6fa01323aac9 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/fs_struct.h>
> >  #include <linux/bsearch.h>
> >  #include <linux/sort.h>
> > +#include <linux/ima.h>
> >  
> >  static struct kmem_cache *user_ns_cachep __read_mostly;
> >  static DEFINE_MUTEX(userns_state_mutex);
> > @@ -141,8 +142,14 @@ int create_user_ns(struct cred *new)
> >  	if (!setup_userns_sysctls(ns))
> >  		goto fail_keyring;
> >  
> > +	ret = create_ima_ns(ns);
> 
> Instead of greedily allocating a new ima namespace for each new user
> namespace creation and wasting memory that is likely wasted since
> most containers won't use ima (for a long time at least) have you
> considered lazily allocating it like I suggested in one of my first
> reviews?
> 
> So under the assumption that the only way for a container to get its
> own ima policy it needs to have mounted a new securityfs instance you
> can move the ima namespace allocation into
> fill_super/ima_fs_ns_init():

The current patch set has the ima namespace born with an empty policy,
meaning it can never do anything until a new policy is inserted via a
write to the securityfs, and therefore the IMA namespace could be
lazily allocated.  However, that's not quite how the initial IMA
namespace behaves because a policy can be passed in on the kernel
command line (or built into the kernel).  If the ima NS were born with
a default policy (say taken from the initial IMA default policy, or
simply inherited from the parent at creation time) then we wouldn't be
able to do lazy allocation.  Before we tie ourselves to never being
able to have a default policy for an IMA namespace, perhaps we should
discuss if this is the correct behaviour we want to nail into the
system.

James




