Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD21023C965
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHEJmS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 05:42:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHEJmS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 05:42:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAE59ABF4;
        Wed,  5 Aug 2020 09:42:33 +0000 (UTC)
Date:   Wed, 5 Aug 2020 11:42:15 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200805094215.GA32709@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200731210653.p5m4efy52melqwgs@altlinux.org>
 <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
 <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
 <20200803130755.GA30440@dell5510>
 <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
 <20200803164635.GB4914@dell5510>
 <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
 <20200804072234.GA4337@dell5510>
 <20200804075453.GA7285@dell5510>
 <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Vitaly,

...
> "[PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR registers"
> was posted here on the linux-integrity mailing list[1].  It's important
> to get this patch upstreamed, but I think the PCR file format is useful
> on its own.  For this reason, I'm going to backtrack and include it in
> 1.3.1.
Thanks a lot for info!

> I've posted a new version of "travis: openssl gost engine" addressing
> the branch version and lack of an install target.   It assumes that
> openssl was built with engine support and builds the gost engine
> support from the git repo.  The environment variable is set, but has
> not been tested.

> Everything, including this change, should now be in the next-testing
> branch.
Nice, thanks! Tested:
https://travis-ci.org/github/pevik/ima-evm-utils

I hope I'll have time for docker based travis patch next week.

Kind regards,
Petr

> [1] message-id: 
> 20200722155739.26957-2-James.Bottomley@HansenPartnership.com
