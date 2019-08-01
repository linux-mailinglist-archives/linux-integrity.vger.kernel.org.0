Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687737E124
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfHARfA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 13:35:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:10949 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbfHARfA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 13:35:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 10:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="184318696"
Received: from nippert-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.219])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2019 10:34:56 -0700
Date:   Thu, 1 Aug 2019 20:34:54 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: Exposing the tpm 2.0 PCRs?  (renamed subject)
Message-ID: <20190801173454.4zjrndyxkn2mokzo@linux.intel.com>
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
 <20190723071545.GA26973@x230>
 <1563894876.14396.120.camel@linux.ibm.com>
 <20190724072420.GA21901@dell5510>
 <1563976601.4245.32.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563976601.4245.32.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 24, 2019 at 09:56:41AM -0400, Mimi Zohar wrote:
> [Cc'ing Jarkko]
> 
> On Wed, 2019-07-24 at 09:24 +0200, Petr Vorel wrote:
> > > > > The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> > > > > userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> > > > > application is required to read PCRs.
> > > > OT: anyone aware why TPM 2.0 does not expose PCR banks to userspace via sysfs?
> > 
> > > TPM 2.0 support is slowly being upstreamed in stages.  Initially the
> > > TPM 2.0 event log was not exported.  Assuming that support for
> > > exposing the TPM 2.0 PCRs is upstreamed, it doesn't necessarily
> > > guarantee that it will be backported to stable.
> 
> > Thanks for info. I'm glad it's being addressed :).
> > IMHO it'd be backporting it (once upstreamed), let's see.
> 
> Clarification, I'm not working on exposing the TPM 2.0 PCRs.  Too much
> else to do.
> 
> Jarkko, in case you missed this thread, is there any reason why the
> TPM 2.0 PCRs can not be exposed to userspace?

What is meant by TPM 2.0 PCRs support?

/Jarkko
