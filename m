Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF97F9A3D
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfKLUHI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 15:07:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:16115 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLUHI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 15:07:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 12:07:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="198206403"
Received: from joshbuck-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.20.68])
  by orsmga008.jf.intel.com with ESMTP; 12 Nov 2019 12:07:04 -0800
Date:   Tue, 12 Nov 2019 22:07:03 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191112200703.GB11213@linux.intel.com>
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112033637.kxotlhm6mtr5irvd@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 11, 2019 at 08:36:37PM -0700, Jerry Snitselaar wrote:
> Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ
> before probing for interrupts").  Doesn't tpm_tis_send set this flag,
> and setting it here in tpm_tis_core_init short circuits what
> tpm_tis_send was doing before? There is a bug report of an interrupt
> storm from a tpm on a t490s laptop with the Fedora 31 kernel (5.3),
> and I'm wondering if this change could cause that. Before they got the
> warning about interrupts not working, and using polling instead.

Looks like it. Stefan?

/Jarkko
