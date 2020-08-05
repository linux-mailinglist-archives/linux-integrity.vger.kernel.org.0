Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B3C23CC08
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 18:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHEQT5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 12:19:57 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60672 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgHEQS6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:18:58 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E6A7972CCE9;
        Wed,  5 Aug 2020 19:18:09 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D2F6C4A4AE7;
        Wed,  5 Aug 2020 19:18:09 +0300 (MSK)
Date:   Wed, 5 Aug 2020 19:18:09 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200805161809.3smuj7kgoab64ypg@altlinux.org>
References: <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
 <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
 <20200803130755.GA30440@dell5510>
 <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
 <20200803164635.GB4914@dell5510>
 <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
 <20200804072234.GA4337@dell5510>
 <20200804075453.GA7285@dell5510>
 <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
 <20200805094215.GA32709@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200805094215.GA32709@dell5510>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Petr,

On Wed, Aug 05, 2020 at 11:42:15AM +0200, Petr Vorel wrote:
> Hi Mimi, Vitaly,
> 
> ...
> > "[PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR registers"
> > was posted here on the linux-integrity mailing list[1].  It's important
> > to get this patch upstreamed, but I think the PCR file format is useful
> > on its own.  For this reason, I'm going to backtrack and include it in
> > 1.3.1.
> Thanks a lot for info!
> 
> > I've posted a new version of "travis: openssl gost engine" addressing
> > the branch version and lack of an install target.   It assumes that
> > openssl was built with engine support and builds the gost engine
> > support from the git repo.  The environment variable is set, but has
> > not been tested.
> 
> > Everything, including this change, should now be in the next-testing
> > branch.
> Nice, thanks! Tested:
> https://travis-ci.org/github/pevik/ima-evm-utils

Probably not.

I still see there

  https://travis-ci.org/github/pevik/ima-evm-utils/jobs/715092182
  https://travis-ci.org/github/pevik/ima-evm-utils/jobs/715092183

SSL is not set and ./tests/install-gost-engine.sh is not run.
At the bottom we can see

  2077 $ tail -3 tests/ima_hash.log;
  2078 PASS: 14 SKIP: 4 FAIL: 0
  2082 $ tail -3 tests/sign_verify.log;
  2083 PASS: 81 SKIP: 10 FAIL: 0

This means that some tests aren't run. Probably, this is engine related
tests.

Thanks,

> 
> I hope I'll have time for docker based travis patch next week.
> 
> Kind regards,
> Petr
> 
> > [1] message-id: 
> > 20200722155739.26957-2-James.Bottomley@HansenPartnership.com
