Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1823D280
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 22:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgHEUN0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 16:13:26 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37800 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHEQX2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:28 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4D97E72CCE9;
        Wed,  5 Aug 2020 19:23:05 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 39D1E4A4AE7;
        Wed,  5 Aug 2020 19:23:05 +0300 (MSK)
Date:   Wed, 5 Aug 2020 19:23:05 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200805162304.kxs62fi3lkuqzhxk@altlinux.org>
References: <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
 <20200803130755.GA30440@dell5510>
 <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
 <20200803164635.GB4914@dell5510>
 <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
 <20200804072234.GA4337@dell5510>
 <20200804075453.GA7285@dell5510>
 <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
 <20200805094215.GA32709@dell5510>
 <e01f39f3e0abc9f799bbe0a50e803287b9458888.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <e01f39f3e0abc9f799bbe0a50e803287b9458888.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Aug 05, 2020 at 09:31:40AM -0400, Mimi Zohar wrote:
> On Wed, 2020-08-05 at 11:42 +0200, Petr Vorel wrote:
> > Hi Mimi, Vitaly,
> > 
> > ...
> > > "[PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR registers"
> > > was posted here on the linux-integrity mailing list[1].  It's important
> > > to get this patch upstreamed, but I think the PCR file format is useful
> > > on its own.  For this reason, I'm going to backtrack and include it in
> > > 1.3.1.
> > Thanks a lot for info!
> > 
> > > I've posted a new version of "travis: openssl gost engine" addressing
> > > the branch version and lack of an install target.   It assumes that
> > > openssl was built with engine support and builds the gost engine
> > > support from the git repo.  The environment variable is set, but has
> > > not been tested.
> > > Everything, including this change, should now be in the next-testing
> > > branch.
> > Nice, thanks! Tested:
> > https://travis-ci.org/github/pevik/ima-evm-utils
> 
> >From the log, I see I somehow re-introduced testing "${SSL}" =
> "openssl".  I've removed it again and pushed out the update version.

Maybe I am fetching wrong, but it's still there.

origin is https://git.code.sf.net/p/linux-ima/ima-evm-utils

  $ git fetch origin
  $ git show -m origin/next-testing
  commit 76121b08b479f60a773653889070546002c2e826
  ...
  +before_install:
  +   - if [ "${SSL}" = "openssl" ]; then
  +        ./tests/install-gost-engine.sh;
  +        openssl version;
  +     fi

Thanks,


> 
> > I hope I'll have time for docker based travis patch next week.
> 
> Thanks!
> 
> Mimi
