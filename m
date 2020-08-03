Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611AD23AAC1
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 18:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHCQqi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 12:46:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCQqi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 12:46:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEC0DAB71;
        Mon,  3 Aug 2020 16:46:51 +0000 (UTC)
Date:   Mon, 3 Aug 2020 18:46:35 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200803164635.GB4914@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
 <20200731201808.GA27841@dell5510>
 <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
 <20200731204044.GC27841@dell5510>
 <20200731210653.p5m4efy52melqwgs@altlinux.org>
 <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
 <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
 <20200803130755.GA30440@dell5510>
 <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

...
> > @Mimi: As I wrote, I'd suggest moving to docker based travis. I can do it once
> > other issues are addressed, if this setup work for your internal travis support
> > as well. See examples .travis.yml [1] [2], builds: [3] [4].

> > Advantages are more realistic builds for distro maintainers (different libc and
> > libraries versions, you can test old and new distro releases, etc), but maybe
> > that's not what you want/need.

> > Disadvantage is that sometimes docker releases have temporary packaging related
> > issues (first build in [3]; failure in first build [4] is a bug in LTP, corner
> > case, which would be otherwise undiscovered a long time).

> Nice!  I definitely want to move to a docker based travis.   How should
> we move forward?   Should there be a 1.3.1 release now with just the
> few changes in the next branch and include the existing travis branch
> with changes to address Vitaly's comments?
Yes, that would work for me. Travis changes aren't related to the release
(it just needs to be published in git), let's give users the fixes.

Docker based setup shouldn't take long It's all about to find the dependencies
for used distros (I usually keep them in travis/ directory [5] [6]) and agree on the
variants (which distros, how many jobs are still meaningful, which crypto and
TPM libraries, whether use also: clang, non-intel archs and cross-compilation).

Kind regards,
Petr

> Mimi

> > [1] https://github.com/linux-test-project/ltp/blob/master/.travis.yml
> > [2] https://github.com/iputils/iputils/blob/master/.travis.yml
> > [3] https://travis-ci.org/github/iputils/iputils/builds/714445071
> > [4] https://travis-ci.org/github/linux-test-project/ltp/builds/714400199

[5] https://github.com/linux-test-project/ltp/blob/master/travis/
[6] https://github.com/iputils/iputils/blob/master/travis/
