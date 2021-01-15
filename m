Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E862F834A
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 19:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbhAOSId (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 13:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbhAOSId (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 13:08:33 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA03CC061757;
        Fri, 15 Jan 2021 10:07:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B35C0128076C;
        Fri, 15 Jan 2021 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610734072;
        bh=ci3+bzcXi6cVS9rIkEZ+G1Ap63+K6eb8eLjYxo/Zm2k=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=wJ6Q9MrXy0Mk/pzVjvQwMie/bimvdj+NtuMCg6A2df2Qs7EM1hUqyEDLmk8wS35Fc
         so7VKGcZKmWVoy0RH2aDJiRYvjYdmWJaazZ+XMymXkEK6sK7Wt9awveBYpSoNJzYHb
         G2wnfUaOnyC2Zv/5s6a8de7/Mu75kdz/FroTDkI8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aW_Wd4Jj4lK8; Fri, 15 Jan 2021 10:07:52 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 43FF81280757;
        Fri, 15 Jan 2021 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610734072;
        bh=ci3+bzcXi6cVS9rIkEZ+G1Ap63+K6eb8eLjYxo/Zm2k=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=wJ6Q9MrXy0Mk/pzVjvQwMie/bimvdj+NtuMCg6A2df2Qs7EM1hUqyEDLmk8wS35Fc
         so7VKGcZKmWVoy0RH2aDJiRYvjYdmWJaazZ+XMymXkEK6sK7Wt9awveBYpSoNJzYHb
         G2wnfUaOnyC2Zv/5s6a8de7/Mu75kdz/FroTDkI8=
Message-ID: <7a245c854925c8619eeb02aab6ff32bbccc92ed9.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg KH <greg@kroah.com>, Joe Perches <joe@perches.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Date:   Fri, 15 Jan 2021 10:07:51 -0800
In-Reply-To: <eb2acffef1368c48b3ca2d85105ef73b31797fe7.camel@HansenPartnership.com>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
         <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
         <X//55I26mxVQKKOE@kroah.com>
         <ce0ce0c5b3b66e2b1506ab9c4f10ffbbcfa648d8.camel@HansenPartnership.com>
         <YAGeez8OZWDXugTW@kroah.com>
         <eb2acffef1368c48b3ca2d85105ef73b31797fe7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-01-15 at 09:26 -0800, James Bottomley wrote:
> On Fri, 2021-01-15 at 14:54 +0100, Greg KH wrote:
> > On Thu, Jan 14, 2021 at 04:21:08PM -0800, James Bottomley wrote:
> [...]
> > > It looks like we already have a couple of bugs in the kernel
> > > introduced by this confusion ...  return sysfs_emit() vs return
> > > sysfs_emit_at() being the most tricky ...
> > 
> > Hm, Joe, you did the conversion to these functions (and wrote the
> > api), care to review this?
> 
> A cursory glance tells me that summary_show in 
> drivers/infiniband/hw/usnic/usnic_ib_sysfs.c has a problem, I think
> the last = should be +=

The use in drivers/base/node.c:node_read_meminfo() is highly
questionable.  While currently not emitting wrong code, it depends on
len being 0 when passed in to sysfs_emit_at().  That argues it should
either be using sysfs_emit() or it should have a len += just in case
something gets prepended that makes len non zero.

James


