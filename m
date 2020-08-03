Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED2A23A748
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHCNH6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 09:07:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:58696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHCNH6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 09:07:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29CB1B61B;
        Mon,  3 Aug 2020 13:08:12 +0000 (UTC)
Date:   Mon, 3 Aug 2020 15:07:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200803130755.GA30440@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
 <20200731201808.GA27841@dell5510>
 <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
 <20200731204044.GC27841@dell5510>
 <20200731210653.p5m4efy52melqwgs@altlinux.org>
 <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
 <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> On Fri, 2020-07-31 at 18:32 -0400, Mimi Zohar wrote:

> > > - Or even better, Bionic (which is supported by Travis) should have
> > >   gost-engine already in the libengine-gost-openssl1.1 package.

> > >   In that case `.travis.yml` should have `dist: bionic`.
> > >     https://docs.travis-ci.com/user/reference/bionic/

> > Yes, for the internal git repo I made this change.   The internal
> > travis support for bionic is different than the external
> > travis.   I'll post what I have as an RFC.

> The internal travis support on ppc defaults to using Bionic, but the
> way of specifying it is different.

> +os: linux-ppc64le
>  language: C
>  addons:
>   apt:

@Mimi: As I wrote, I'd suggest moving to docker based travis. I can do it once
other issues are addressed, if this setup work for your internal travis support
as well. See examples .travis.yml [1] [2], builds: [3] [4].

Advantages are more realistic builds for distro maintainers (different libc and
libraries versions, you can test old and new distro releases, etc), but maybe
that's not what you want/need.

Disadvantage is that sometimes docker releases have temporary packaging related
issues (first build in [3]; failure in first build [4] is a bug in LTP, corner
case, which would be otherwise undiscovered a long time).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/.travis.yml
[2] https://github.com/iputils/iputils/blob/master/.travis.yml
[3] https://travis-ci.org/github/iputils/iputils/builds/714445071
[4] https://travis-ci.org/github/linux-test-project/ltp/builds/714400199
