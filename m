Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26B9FCB06
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 17:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNQsq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 11:48:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:41737 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNQsq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 11:48:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 08:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="379628441"
Received: from pkamlakx-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.10.73])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2019 08:48:43 -0800
Date:   Thu, 14 Nov 2019 18:48:41 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191114164841.GD9528@linux.intel.com>
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <20191112200703.GB11213@linux.intel.com>
 <20191112201734.sury5nd3cptkckgb@cantor>
 <50290fc8-4d22-3eb5-c930-079f8b819a8e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50290fc8-4d22-3eb5-c930-079f8b819a8e@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 12, 2019 at 03:30:51PM -0500, Stefan Berger wrote:
> On 11/12/19 3:17 PM, Jerry Snitselaar wrote:
> > On Tue Nov 12 19, Jarkko Sakkinen wrote:
> > > On Mon, Nov 11, 2019 at 08:36:37PM -0700, Jerry Snitselaar wrote:
> > > > Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ
> > > > before probing for interrupts").  Doesn't tpm_tis_send set this flag,
> > > > and setting it here in tpm_tis_core_init short circuits what
> > > > tpm_tis_send was doing before? There is a bug report of an interrupt
> > > > storm from a tpm on a t490s laptop with the Fedora 31 kernel (5.3),
> > > > and I'm wondering if this change could cause that. Before they got the
> > > > warning about interrupts not working, and using polling instead.
> > > 
> > > Looks like it. Stefan?
> > > 
> > > /Jarkko
> > > 
> > 
> > Stefan is right about the condition check at the beginning of
> > tpm_tis_send.
> > 
> >     if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
> >         return tpm_tis_send_main(chip, buf, len);
> > 
> > Before his change it would've gone straight to calling
> > tpm_tis_send_main instead of jumping down and doing the irq test, due
> > to the flag not being set. With his change it should now skip this
> > tpm_tis_send_main call when tpm_tis_gen_interrupt is called, and then
> > after that time through tpm_tis_send priv->irq_tested will be set, and
> > the flag should be set as to whether or not irqs were working.
> > 
> > I should hopefully have access to a t490s in a few days so I can look at
> > it,
> > and try to figure out what is happening.
> > 
> I hope the t490s is an outlier. Give the patch I just posted a try.

First I must be first that it is the best way to fix the bug. Also,
it did not have fixes tag.

/Jarkko
