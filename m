Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4453C64F8
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhGLUaN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 16:30:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50726 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhGLUaM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 16:30:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CA0020002;
        Mon, 12 Jul 2021 20:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626121643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExQVv7YzlvAzz8rjNDW2kvbTr0Eh6ukFZioBM9EorCU=;
        b=DDAbmMAYPWkAt4QFsCJFwE5U2ua+l8EPR5s9NjvsKLXGFapsGP27dvDokJcrp7pMEAja8U
        ZmXtO6jaIC8loIQ75+ECPzQ8zvvxcv5ULbTd+eLCXNDX3HavVr5Mw56H26lOlw0baiHLUc
        ucBfkiCF1GA5VhFdpmSFyQdG/t4tfK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626121643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExQVv7YzlvAzz8rjNDW2kvbTr0Eh6ukFZioBM9EorCU=;
        b=YPUyB9qDb/QX1siWAYgM2rxl0Cvf2l282ZpFQA0OMSJAtycFY9GWkPheNP0CiysS0BwK3l
        Yz63x6BVYIn79jAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E517613BBA;
        Mon, 12 Jul 2021 20:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gpxANqql7GDxSwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 12 Jul 2021 20:27:22 +0000
Date:   Mon, 12 Jul 2021 22:27:21 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v3] ima-evm-utils: Support SM2 algorithm
 for sign and verify
Message-ID: <YOylqbuLL4gj0yTF@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210526084455.56705-1-tianjia.zhang@linux.alibaba.com>
 <d7526f84-f7c9-cbc6-c4a5-3e8b8d78fb60@linux.alibaba.com>
 <10f55257f543cc1d63e7a8ae36cbf2433a01c30b.camel@linux.ibm.com>
 <bb6afba7-255f-5254-5ac7-e793c24d56d3@linux.alibaba.com>
 <5f61f4b0f305a26df0346524e4999c5bbb66571f.camel@linux.ibm.com>
 <4f4a220d-23c5-dbf4-ac57-0ce16ecff2a7@linux.alibaba.com>
 <d1b072c36b4d3770d6b7385836fbed2ec23be349.camel@linux.ibm.com>
 <3b5aea51-c82c-70f3-d41e-d615bc14823a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b5aea51-c82c-70f3-d41e-d615bc14823a@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia, Mimi,

> On 7/12/21 8:35 PM, Mimi Zohar wrote:
> > On Mon, 2021-07-12 at 20:12 +0800, Tianjia Zhang wrote:

> > > On 7/9/21 8:05 PM, Mimi Zohar wrote:
> > > > On Fri, 2021-07-09 at 17:06 +0800, Tianjia Zhang wrote:
> > > > > On 7/7/21 10:28 AM, Mimi Zohar wrote:


> > > > > > I'm also seeing:
> > > > > > - openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 -sm3
> > > > > > -sigopt distid:1234567812345678 -config test-ca.conf -copy_extensions
> > > > > > copyall -newkey sm2 -out test-sm2.cer -outform DER -keyout test-sm2.key
> > > > > > req: Unrecognized flag copy_extensions


> > > > > This command is for openssl 3.0, and '-copy_extensions copyall' is also
> > > > > a parameter supported on 3.0. At present, the mainstream version of
> > > > > openssl 1.1.1 only partially supports SM2 signatures. For example, the
> > > > > USERID in the SM2 specification cannot be used, and the certificate
> > > > > cannot be operated in the command using the SM2/3 algorithm combination,
> > > > > just like the modification of libimaevm.c in this patch, this cannot be
> > > > > done directly through the openssl command, even if the '-copy_extensions
> > > > > copyall' parameter is deleted, this command will be failed on openssl
> > > > > 1.1.1. The final solution may be openssl 3.0.

> > > > > On openssl 1.1.1, there is no problem to operate the signature of the
> > > > > SM2/3 algorithm combination through the API. If it is possible, the
> > > > > sign_verify test of sm2/3 is not required. What is your opinion?

> > > > Instead of dropping the test altogether, add an openssl version
> > > > dependency.

> > > Great. will do in next version patch.

> > Please consider adding a new CI distro matrix rule that includes the
> > needed openssl version.  Another option would be to define a new script
> > in the tests directory to install openssl from the git repo.  Please
> > limit using that script to a single distro matrix rule.


> Got it, thanks for your suggestion. It seems that the second method is more
> suitable.
Although it appears there is no distro which would have openssl 3.0 [1],
Debian actually have 3.0.0~~beta1-1 in experimental [2]. openSUSE has slightly
older version openssl-3.0.0-alpha16 [3]. I suppose we update soon to beta1 as
well.

Using distro packages would be probably faster to run in CI than install from git.

Kind regards,
Petr

[1] https://pkgs.org/download/openssl
[2] https://tracker.debian.org/pkg/openssl
[3] https://build.opensuse.org/package/show/security:tls/openssl-3

> Thanks,
> Tianjia
