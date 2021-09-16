Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CBB40ED36
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 00:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbhIPWPu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 18:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240828AbhIPWPt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 18:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631830468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0CG1ZeRgflAc20F7zcmBoOrMfwo5YGuJv5LLNqTMkY=;
        b=RUkrjnlNB71Q7S8ZyMixsP02D72FR71S/AnPvwoQMjMlwCV2uh42pp2FwmeTshsDSiFxKH
        tFKJIS/QwXIr8lK6GJf4gt+oxdVS8D5zCQ6M2tYbeUC/SObqdeWyPP7+2gzlQkvNZzOQCW
        cmwWy5NgQEkEjtOomN57/JbROwHCwj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-Yjm4HXchPxOivu-FlClMIQ-1; Thu, 16 Sep 2021 18:14:25 -0400
X-MC-Unique: Yjm4HXchPxOivu-FlClMIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B08541084681;
        Thu, 16 Sep 2021 22:14:21 +0000 (UTC)
Received: from redhat.com (ovpn-112-133.phx2.redhat.com [10.3.112.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8637F7A5CF;
        Thu, 16 Sep 2021 22:14:18 +0000 (UTC)
Date:   Thu, 16 Sep 2021 18:14:16 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
Message-ID: <20210916221416.onvqgz5iij3c7e6j@redhat.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <bee0ebc354a651ea5b263897f9b155dc604fa7c5.camel@kernel.org>
 <A02EE1DA-12BE-4998-ACE6-2D74FF380297@oracle.com>
 <f6e2e17cc6c8a3056cc066a7baa4d943eeb47c84.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6e2e17cc6c8a3056cc066a7baa4d943eeb47c84.camel@kernel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 16, 2021 at 06:15:50PM +0300, Jarkko Sakkinen wrote:
> On Wed, 2021-09-15 at 15:28 -0600, Eric Snowberg wrote:
> > > On Sep 15, 2021, at 11:57 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > 
> > > On Tue, 2021-09-14 at 17:14 -0400, Eric Snowberg wrote:
> > > > Back in 2013 Linus requested a feature to allow end-users to have the 
> > > > ability "to add their own keys and sign modules they trust". This was
> > > > his *second* order outlined here [1]. There have been many attempts 
> > > > over the years to solve this problem, all have been rejected.  Many 
> > > > of the failed attempts loaded all preboot firmware keys into the kernel,
> > > > including the Secure Boot keys. Many distributions carry one of these 
> > > > rejected attempts [2], [3], [4]. This series tries to solve this problem 
> > > > with a solution that takes into account all the problems brought up in 
> > > > the previous attempts.
> > > > 
> > > > On UEFI based systems, this series introduces a new Linux kernel keyring 
> > > > containing the Machine Owner Keys (MOK) called machine. It also defines
> > > > a new MOK variable in shim. This variable allows the end-user to decide 
> > > > if they want to load MOK keys into the machine keyring. Mimi has suggested 
> > > > that only CA keys contained within the MOK be loaded into the machine 
> > > > keyring. All other certs will load into the platform keyring instead.
> > > > 
> > > > By default, nothing changes; MOK keys are not loaded into the machine
> > > > keyring.  They are only loaded after the end-user makes the decision 
> > > > themselves.  The end-user would set this through mokutil using a new 
> > > > --trust-mok option [5]. This would work similar to how the kernel uses 
> > > > MOK variables to enable/disable signature validation as well as use/ignore 
> > > > the db. Any kernel operation that uses either the builtin or secondary 
> > > > trusted keys as a trust source shall also reference the new machine 
> > > > keyring as a trust source.
> > > > 
> > > > Secure Boot keys will never be loaded into the machine keyring.  They
> > > > will always be loaded into the platform keyring.  If an end-user wanted 
> > > > to load one, they would need to enroll it into the MOK.
> > > > 
> > > > Steps required by the end user:
> > > > 
> > > > Sign kernel module with user created key:
> > > > $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
> > > >   machine_signing_key.priv machine_signing_key.x509 my_module.ko
> > > > 
> > > > Import the key into the MOK
> > > > $ mokutil --import machine_signing_key.x509
> > > > 
> > > > Setup the kernel to load MOK keys into the .machine keyring
> > > > $ mokutil --trust-mok
> > > > 
> > > > Then reboot, the MokManager will load and ask if you want to trust the
> > > > MOK key and enroll the MOK into the MOKList.  Afterwards the signed kernel
> > > > module will load.
> > > > 
> > > > I have included links to both the mokutil [5] and shim [6] changes I
> > > > have made to support this new functionality.
> > > 
> > > How hard it is to self-compile shim and boot it with QEMU (I
> > > do not know even the GIT location of Shim)?
> > 
> > It is not hard, that is the setup I use for my testing.  Upstream shim 
> > is located here [1].  Or you can use my repo which contains the necessary
> > changes [2].
> > 
> > [1] https://github.com/rhboot/shim
> > [2] https://github.com/esnowberg/shim/tree/mokvars-v2
> > 
> 
> So, my 2nd Q would be: which order these should be upstreamed?
> 
> Linux patch set cannot depend on "yet to be upstreamed" things.
> 
> Code changes look good enough to me.

We can carry this support in shim before it's in kernel.  Eric's current
patch for shim and mokutil looks mostly reasonable, though I see a few
minor nits we'll have to sort out.

-- 
        Peter

