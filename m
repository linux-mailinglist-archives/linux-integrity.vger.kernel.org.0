Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19D922598D
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGTIAk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 04:00:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTIAj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 04:00:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C40ACB97A;
        Mon, 20 Jul 2020 08:00:44 +0000 (UTC)
Date:   Mon, 20 Jul 2020 10:00:37 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Add sanity check for file parameter of
 ima_boot_aggregate
Message-ID: <20200720080037.GB8754@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200717120422.71299-1-pvorel@suse.cz>
 <1595167054.27397.72.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595167054.27397.72.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

...
> Thanks!  I made minor changes as noted below.  A subsequent patch
> makes a similar change for the new TPM 1.2 PCRs.
+1 to all the changes. I guess you haven't pushed it yet.


Kind regards,
Petr

> >  src/evmctl.c | 7 +++++++
> >  1 file changed, 7 insertions(+)

> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 04dc2ad..3ad5039 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -2082,6 +2082,13 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
> >  	int len;
> >  	int i;

> > +	struct stat s;
> > +	stat(file, &s);

> Checked stat return code.


> > +	if (!S_ISREG(s.st_mode)) {
> > +		log_errno("Not a regular file or link to regular file.\n");

> Prefixed message with "Bios event log: not ..."
...
