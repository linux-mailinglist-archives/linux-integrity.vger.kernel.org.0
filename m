Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A55827BA
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2019 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHEWwV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 18:52:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:53389 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfHEWwV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 18:52:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 15:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="181807926"
Received: from unknown (HELO localhost) ([10.252.52.83])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2019 15:51:39 -0700
Date:   Tue, 6 Aug 2019 01:51:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190805223324.qvbqa45xnp5fgsib@linux.intel.com>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
 <20190804214218.vdv2sn4oc4cityy2@linux.intel.com>
 <20190805180518.GC17747@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805180518.GC17747@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 05, 2019 at 02:05:18PM -0400, Sasha Levin wrote:
> On Mon, Aug 05, 2019 at 12:44:28AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jul 11, 2019 at 11:08:58PM +0300, Jarkko Sakkinen wrote:
> > > On Fri, Jul 05, 2019 at 04:47:44PM -0400, Sasha Levin wrote:
> > > > Changes from v7:
> > > >
> > > >  - Address Jarkko's comments.
> > > >
> > > > Sasha Levin (2):
> > > >   fTPM: firmware TPM running in TEE
> > > >   fTPM: add documentation for ftpm driver
> > > >
> > > >  Documentation/security/tpm/index.rst        |   1 +
> > > >  Documentation/security/tpm/tpm_ftpm_tee.rst |  27 ++
> > > >  drivers/char/tpm/Kconfig                    |   5 +
> > > >  drivers/char/tpm/Makefile                   |   1 +
> > > >  drivers/char/tpm/tpm_ftpm_tee.c             | 350 ++++++++++++++++++++
> > > >  drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
> > > >  6 files changed, 424 insertions(+)
> > > >  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
> > > >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
> > > >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
> > > >
> > > > --
> > > > 2.20.1
> > > >
> > > 
> > > I applied the patches now. Appreciate a lot the patience with these.
> > > Thank you.
> > 
> > Hi, can you possibly fix these:
> 
> Any objection to sending you a patch on top of your tree instead?

Go ahead. Added the previous patches to my master.

/Jarkko
