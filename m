Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17023AC8D
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 20:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgHCSmF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 14:42:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:47564 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgHCSmF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 14:42:05 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 099BB72CCE9;
        Mon,  3 Aug 2020 21:42:03 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E5C214A4AE7;
        Mon,  3 Aug 2020 21:42:02 +0300 (MSK)
Date:   Mon, 3 Aug 2020 21:42:02 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200803184202.zosc6gs3h2jpjwgr@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
 <20200731201808.GA27841@dell5510>
 <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
 <20200731204044.GC27841@dell5510>
 <20200731210653.p5m4efy52melqwgs@altlinux.org>
 <01efbe7c9a9cc9624785bcc9085866d8c0f4f4d3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <01efbe7c9a9cc9624785bcc9085866d8c0f4f4d3.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Aug 03, 2020 at 01:26:19PM -0400, Mimi Zohar wrote:
> On Sat, 2020-08-01 at 00:06 +0300, Vitaly Chikunov wrote:
> > On Fri, Jul 31, 2020 at 10:40:44PM +0200, Petr Vorel wrote:
> > - Or even better, Bionic (which is supported by Travis) should have
> >   gost-engine already in the libengine-gost-openssl1.1 package.
> > 
> >   In that case `.travis.yml` should have `dist: bionic`.
> >     https://docs.travis-ci.com/user/reference/bionic/
> 
> Petr, Vitaly, so I should drop  "ima-evm-utils: travis: openssl gost
> engine" and add "dist: bionic" instead?

I am not sure yet. As I remember, travis have different available ubuntu
distros for different arches. Thus, for ppc or s490x it may not have bionic.
It would be easier to fix install of gost-engine. It's small and will
build quickly.

Thanks,

