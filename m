Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C481B234C37
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgGaU0m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 16:26:42 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56266 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgGaU0l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 16:26:41 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0B18772CCDC;
        Fri, 31 Jul 2020 23:26:39 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E8E5E4A4AE7;
        Fri, 31 Jul 2020 23:26:38 +0300 (MSK)
Date:   Fri, 31 Jul 2020 23:26:38 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
 <20200731201808.GA27841@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200731201808.GA27841@dell5510>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Petr,

On Fri, Jul 31, 2020 at 10:18:08PM +0200, Petr Vorel wrote:
> > > +++ b/tests/install-gost-engine.sh
> > > @@ -0,0 +1,10 @@
> > > +#!/bin/sh
> > > +
> > > +openssl version
> > > +
> > > +git clone https://github.com/gost-engine/engine.git
> 
> > gost-engine master branch corresponds to openssl-3.0 which is probably
> > not on Travis systems yet. I think branch `openssl_1_1_0` should be used.
> 
> >   git clone --branch openssl_1_1_0 https://github.com/gost-engine/engine.git
> 
> FYI: it work on current setup.
> https://travis-ci.org/github/pevik/ima-evm-utils/builds/713815774

I think `install-gost-engine.sh` is not executed in this line:

  257 $ if [ "${SSL}" = "openssl" ]; then ./tests/install-gost-engine.sh; openssl version; fi   0.00s

> 
> Kind regards,
> Petr
