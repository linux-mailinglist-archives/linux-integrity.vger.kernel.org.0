Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19CA1316F9
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAFRor (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 12:44:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:7403 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFRor (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 12:44:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 09:44:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="253427624"
Received: from emilywhi-mobl1.ger.corp.intel.com ([10.252.21.216])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2020 09:44:44 -0800
Message-ID: <3b4b8c39ae0e5bd8635980cdd8db83c576e3fe09.camel@linux.intel.com>
Subject: Re: [PATCH for-linus-v5.5-rc6 0/3] TPM changes for v5.5-rc6
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 06 Jan 2020 19:44:43 +0200
In-Reply-To: <20200104043259.krg7uo6q7owg4fka@cantor>
References: <20200103232935.11314-1-jarkko.sakkinen@linux.intel.com>
         <20200104043259.krg7uo6q7owg4fka@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-03 at 21:32 -0700, Jerry Snitselaar wrote:
> On Sat Jan 04 20, Jarkko Sakkinen wrote:
> > There has been a bunch of reports (one from kernel bugzilla linked)
> > reporting that when this commit is applied it causes on some machines
> > boot freezes.
> > 
> > Unfortunately hardware where this commit causes a failure is not widely
> > available (only one I'm aware is Lenovo T490), which means we cannot
> > predict yet how long it will take to properly fix tpm_tis interrupt
> > probing.
> > 
> > Thus, the least worst short term action is to revert the code to the
> > state before this commit. In long term we need fix the tpm_tis probing
> > code to work on machines that Stefan's code was supposed to fix.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=205935
> > Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > 
> > Jarkko Sakkinen (1):
> >  tpm: Revert "tpm_tis: reserve chip for duration of tpm_tis_core_init"
> > 
> > Stefan Berger (2):
> >  tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for
> >    interrupts"
> >  tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's"
> > 
> > drivers/char/tpm/tpm_tis_core.c | 34 +++++++++++++++------------------
> > 1 file changed, 15 insertions(+), 19 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

I'm sorry but forgot to append this before sending pull request :-/

/Jarkko

