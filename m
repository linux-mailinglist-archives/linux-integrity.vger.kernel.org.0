Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFC10DBC4
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2019 00:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfK2X03 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Nov 2019 18:26:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:61596 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfK2X03 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Nov 2019 18:26:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 15:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,259,1571727600"; 
   d="scan'208";a="384195895"
Received: from gamanzi-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.3.126])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2019 15:26:25 -0800
Date:   Sat, 30 Nov 2019 01:26:24 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, jsnitsel@redhat.com
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
Message-ID: <20191129232624.GB19623@linux.intel.com>
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com>
 <20191114164426.GC9528@linux.intel.com>
 <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
 <20191121184949.yvw2gwzlkhjzko64@cantor>
 <20191127211109.GF14290@linux.intel.com>
 <CAPcyv4gO2T4xcZjYSYJ8-0kDPRnVYWhX_df5E94Cjyksx6WFbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gO2T4xcZjYSYJ8-0kDPRnVYWhX_df5E94Cjyksx6WFbg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 27, 2019 at 01:26:07PM -0800, Dan Williams wrote:
> [ add Jerry ]
> 
> On Wed, Nov 27, 2019 at 1:11 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 11:49:49AM -0700, Jerry Snitselaar wrote:
> > > On Sat Nov 16 19, Stefan Berger wrote:
> > > > On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
> > > > > On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
> > > > > > On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
> > > > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > >
> > > > > > > Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
> > > > > > > tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
> > > > > > > This move handles error conditions better that may arise if anything
> > > > > > > before fails in tpm_tis_probe_irq_single.
> > > > > > >
> > > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > > Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > What about just changing the condition?
> > > > > Also cannot take this since it is not a bug (no fixes tag).
> > > >
> > > > I'll repost but will wait until Jerry has tested it on that machine.
> > > >
> > > >    Stefan
> > > >
> > > >
> > > > >
> > > > > /Jarkko
> > > >
> > > >
> > >
> > > It appears they still have the problem. I'm still waiting on logistics
> > > to send me a system to debug.
> >
> > Which hardware is guaranteed to ignite this? I can try to get test hw
> > for this from somewhere. Kind of looking into this blinded ATM. Dan?
> 
> Jerry had mentioned that this was also occurring on T490s. Otherwise
> I'll ping you offline about the system I saw this on internally.

I'll see if I can get my hands on T490 or T490s or something with
equivalent hardware.

/Jarkko
