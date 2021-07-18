Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B63CC94F
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Jul 2021 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhGRNXG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Jul 2021 09:23:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33716 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhGRNXG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Jul 2021 09:23:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95473220E7;
        Sun, 18 Jul 2021 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626614407;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ai3s7IDK1deNKqu8yK/lPXHb/YiSx+uXQSI0Ype86JU=;
        b=oMXcdP/Qla7ScLm4aF+AABfm/UUoAguZfz5OpW9GNj37iW4HKW7E2eDAxCeugsOZAOaX6Z
        Vor5KRLMnovAuwuyNl3zM4hx1Fqw2N4DCkYV5HRp+2ZR/qGccPBvuIK5LRvI1KPmrafDLd
        qcg2rruSoDndAXBZ5k+AQZGHPKFFd7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626614407;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ai3s7IDK1deNKqu8yK/lPXHb/YiSx+uXQSI0Ype86JU=;
        b=af1nZTyfJnghCgmo5FaoqLu8P+wwVs7SpvFqvR/HyqoM/erGhci+U9+8pgDB7uVmQ5S7kc
        Q6OIvvxprXuG04Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 401431332A;
        Sun, 18 Jul 2021 13:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nt0cDYcq9GBPRAAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Sun, 18 Jul 2021 13:20:07 +0000
Date:   Sun, 18 Jul 2021 15:20:05 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v5] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
Message-ID: <YPQqhTPLTafjLCXP@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210716092237.17153-1-tianjia.zhang@linux.alibaba.com>
 <f7c05b2618125cb0887ee0302c1197a8c8f49864.camel@linux.ibm.com>
 <7921ca60-8818-b641-3e28-6ffd957f8a1b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7921ca60-8818-b641-3e28-6ffd957f8a1b@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> Hi Mimi,

> On 7/17/21 12:39 AM, Mimi Zohar wrote:
> > Hi Tianjia,

> > On Fri, 2021-07-16 at 17:22 +0800, Tianjia Zhang wrote:
> > > diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> > > index 088c041..17407ff 100644
> > > --- a/.github/workflows/ci.yml
> > > +++ b/.github/workflows/ci.yml
> > > @@ -17,6 +17,7 @@ jobs:
> > >                 ARCH: i386
> > >                 TSS: tpm2-tss
> > >                 VARIANT: i386
> > > +              OPENSSL3: true
> > >             # cross compilation builds
> > >             - container: "debian:stable"
> > > @@ -51,6 +52,7 @@ jobs:
> > >               env:
> > >                 CC: clang
> > >                 TSS: ibmtss
> > > +              OPENSSL3: true

> > I haven't had a chance to look at the entire patch, but defining
> > OPENSSL3 kind of stood out.  Just as "CC" and "TSS" are generic, I'd
> > prefer something more generic here.   In the past there was a request
> > to support Libressl, which never materialized.


> I agree that it is appropriate to use a generic variable name. I am thinking
> of 'CRYPTOGRAPHY' or 'CRYPPTO_LIBRARY'. Are there any better suggestions?
How about COMPILE_OPENSSL? Because that's the current purpose.

Kind regards,
Petr

> Best regards,
> Tianjia
