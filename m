Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF89728F8
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGXHYR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 03:24:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfGXHYQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 03:24:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFD2AAD95;
        Wed, 24 Jul 2019 07:24:15 +0000 (UTC)
Date:   Wed, 24 Jul 2019 09:24:20 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v1] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190724072420.GA21901@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
 <20190723071545.GA26973@x230>
 <1563894876.14396.120.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563894876.14396.120.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> > > The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> > > userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> > > application is required to read PCRs.
> > OT: anyone aware why TPM 2.0 does not expose PCR banks to userspace via sysfs?

> TPM 2.0 support is slowly being upstreamed in stages.  Initially the
> TPM 2.0 event log was not exported.  Assuming that support for
> exposing the TPM 2.0 PCRs is upstreamed, it doesn't necessarily
> guarantee that it will be backported to stable.
Thanks for info. I'm glad it's being addressed :).
IMHO it'd be backporting it (once upstreamed), let's see.

> > Did I get it right, that in the end we don't use libibmtss, but tsspcrread.
> > So wouldn't be safer to detect it with AC_CHECK_PROGS macro?
> > See proposed diff.

> Yes, thank you!  I've included it in the next version.
You're welcome.

> thanks!

> Mimi

Kind regards,
Petr
