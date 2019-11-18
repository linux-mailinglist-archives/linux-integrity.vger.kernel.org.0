Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87805100AF6
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2019 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfKRR72 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 12:59:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:53198 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfKRR72 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 12:59:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 09:59:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="208926876"
Received: from cooperwu-mobl.gar.corp.intel.com (HELO localhost) ([10.252.3.195])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2019 09:59:25 -0800
Date:   Mon, 18 Nov 2019 19:59:24 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jsnitsel@redhat.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
Message-ID: <20191118175924.GA5984@linux.intel.com>
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com>
 <20191114164426.GC9528@linux.intel.com>
 <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Nov 16, 2019 at 09:32:06AM -0500, Stefan Berger wrote:
> On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
> > On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
> > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > 
> > > > Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
> > > > tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
> > > > This move handles error conditions better that may arise if anything
> > > > before fails in tpm_tis_probe_irq_single.
> > > > 
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > What about just changing the condition?
> > Also cannot take this since it is not a bug (no fixes tag).
> 
> I'll repost but will wait until Jerry has tested it on that machine.

OK, great, thank you.

This is really needs some reasoning on why this was the right way to
fix the issue. In addition, a source code comment might make sense.

/Jarkko
