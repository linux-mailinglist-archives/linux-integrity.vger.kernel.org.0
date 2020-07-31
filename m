Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8EE234C10
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 22:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGaUSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 16:18:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbgGaUSL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 16:18:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 732CFACA2;
        Fri, 31 Jul 2020 20:18:23 +0000 (UTC)
Date:   Fri, 31 Jul 2020 22:18:08 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200731201808.GA27841@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> > +++ b/tests/install-gost-engine.sh
> > @@ -0,0 +1,10 @@
> > +#!/bin/sh
> > +
> > +openssl version
> > +
> > +git clone https://github.com/gost-engine/engine.git

> gost-engine master branch corresponds to openssl-3.0 which is probably
> not on Travis systems yet. I think branch `openssl_1_1_0` should be used.

>   git clone --branch openssl_1_1_0 https://github.com/gost-engine/engine.git

FYI: it work on current setup.
https://travis-ci.org/github/pevik/ima-evm-utils/builds/713815774

Kind regards,
Petr
