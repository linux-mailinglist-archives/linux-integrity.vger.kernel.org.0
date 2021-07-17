Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44D23CC3CC
	for <lists+linux-integrity@lfdr.de>; Sat, 17 Jul 2021 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhGQOZK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 17 Jul 2021 10:25:10 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60300 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhGQOZJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 17 Jul 2021 10:25:09 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B8A8172C8B4;
        Sat, 17 Jul 2021 17:22:10 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 405C34A46E9;
        Sat, 17 Jul 2021 17:22:10 +0300 (MSK)
Date:   Sat, 17 Jul 2021 17:22:10 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v5] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
Message-ID: <20210717142210.e4xy4lyfav5b4tzq@altlinux.org>
References: <20210716092237.17153-1-tianjia.zhang@linux.alibaba.com>
 <f7c05b2618125cb0887ee0302c1197a8c8f49864.camel@linux.ibm.com>
 <7921ca60-8818-b641-3e28-6ffd957f8a1b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <7921ca60-8818-b641-3e28-6ffd957f8a1b@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tianjia, Mimi,

On Sat, Jul 17, 2021 at 09:48:10AM +0800, Tianjia Zhang wrote:
> On 7/17/21 12:39 AM, Mimi Zohar wrote:
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
> > 
> > I haven't had a chance to look at the entire patch, but defining
> > OPENSSL3 kind of stood out.  Just as "CC" and "TSS" are generic, I'd
> > prefer something more generic here.   In the past there was a request
> > to support Libressl, which never materialized.
> > 
> 
> I agree that it is appropriate to use a generic variable name. I am thinking
> of 'CRYPTOGRAPHY' or 'CRYPPTO_LIBRARY'. Are there any better suggestions?

Perhaps, OPENSSL with tag name. If present, it's git cloned from
upstream, checked out appropriate tag, compiled, installed, and env set
to use it to compile ima-evm-utils. If not present (the default) native
OS OpenSSL is used.

Thanks,

> 
> Best regards,
> Tianjia
