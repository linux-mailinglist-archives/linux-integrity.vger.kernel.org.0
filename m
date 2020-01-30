Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BD414D7CA
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 09:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgA3Ihb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 03:37:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:46437 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgA3Ihb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 03:37:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 00:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,381,1574150400"; 
   d="scan'208";a="232837098"
Received: from kvehmane-mobl.ger.corp.intel.com (HELO jsakkine-mobl1) ([10.237.50.119])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2020 00:37:26 -0800
Message-ID: <a3720028f46885e806f201b6fa6ea6f8ef6b0d44.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] tpm: tis: add support for MMIO TPM on SynQuacer
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter =?ISO-8859-1?Q?H=FCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Date:   Thu, 30 Jan 2020 10:37:25 +0200
In-Reply-To: <CAKv+Gu-9KvzLEcNQnRfsOkU=5oc1otY_NS15fR5Oi4Z4UVvurw@mail.gmail.com>
References: <20200114141647.109347-1-ardb@kernel.org>
         <20200114141647.109347-3-ardb@kernel.org>
         <ada03416b1b362fa255feb45257414655d8ab023.camel@linux.intel.com>
         <CAKv+Gu-9KvzLEcNQnRfsOkU=5oc1otY_NS15fR5Oi4Z4UVvurw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-23 at 13:29 +0100, Ard Biesheuvel wrote:
> On Thu, 23 Jan 2020 at 13:27, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Tue, 2020-01-14 at 15:16 +0100, Ard Biesheuvel wrote:
> > > When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> > > window that is backed by the SPI command sequencer in the SPI bus
> > > controller. This arrangement has the limitation that only byte size
> > > accesses are supported, and so we'll need to provide a separate set
> > > of read and write accessors that take this into account.
> > 
> > What is SynQuacer platform?
> > 
> 
> It is an arm64 SoC manufactured by Socionext.
> 
> > I'm also missing a resolution why tpm_tis.c is extended to handle both
> > and not add tpm_tis_something.c instead. It does not follow the pattern
> > we have in place (e.g. look up tpm_tis_spi.c).
> > 
> 
> We could easily do that instead, if preferred. It's just that it would
> duplicate a bit of code.

I'm fine with that. Overally I think it is cleaner flow.

/Jarkko

