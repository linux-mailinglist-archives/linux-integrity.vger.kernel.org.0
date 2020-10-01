Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8564C27FA37
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 09:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgJAH0k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 03:26:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:56300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAH0k (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 03:26:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AD74ACD8;
        Thu,  1 Oct 2020 07:26:39 +0000 (UTC)
Date:   Thu, 1 Oct 2020 09:26:37 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 4/4] ima_tpm.sh: Fix calculating PCR aggregate
Message-ID: <20201001072637.GA32109@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200930160214.29358-1-pvorel@suse.cz>
 <20200930160214.29358-5-pvorel@suse.cz>
 <b10815a3a0abade8ec8872757ab5ac2a4f7839f4.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b10815a3a0abade8ec8872757ab5ac2a4f7839f4.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> <snip>

> > +get_pcr10_aggregate()
> > +{
> > +	local params pcr
> > +	local msg="$ERRMSG_EVMCTL"
> > +	local res=TCONF
> > +
> > +	if [ -z "$MISSING_EVMCTL" ]; then
> > +		params="--ignore-violations"  <=== 

> Violations should cause the measurement list verification to fail.
I didn't get this one. the idea is: TCONF for old evmctl version (failure can be
caused by old version, but TFAIL for new version).

> > +		msg=
> > +		res=TFAIL
> > +	elif check_ima_policy_cmdline "tcb"; then
> > +		tst_res TCONF "using builtin IMA TCB policy $ERRMSG_EVMCTL"
> > +		return
> > +	fi
> > +
> > +	evmctl -v ima_measurement $params $BINARY_MEASUREMENTS > hash.txt 2>&1
> > +	if [ $? -ne 0 -a -z "$MISSING_EVMCTL" ]; then
> > +		tst_res TFAIL "evmctl failed $ERRMSG_EVMCTL"
> > +		tst_res TINFO "hash file:"
> > +		cat hash.txt >&2
> > +		return
> > +	fi
> > +
> > +	pcr=$(grep -E "^($ALGORITHM: )*PCRAgg.*:" hash.txt \

> The IMA measurement list may contain records for other PCR 10.  The
> output may contain other PCRs.  Using "PCRAgg.*10:" is safer.  
> Probably need to use "grep -m 1 -E" as well.
+1 good point.

Kind regards,
Petr
