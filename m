Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4244C7E04F
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfHAQgF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 12:36:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:1467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfHAQgF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 12:36:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 09:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="177879812"
Received: from muelc-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.57])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2019 09:35:58 -0700
Date:   Thu, 1 Aug 2019 19:35:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190801163557.jrrztre6nhutw3it@linux.intel.com>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
 <20190711201059.GA18260@apalos>
 <20190712033758.vnwrmdxvz2kplt65@linux.intel.com>
 <20190715090525.GA28477@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715090525.GA28477@apalos>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 15, 2019 at 12:05:25PM +0300, Ilias Apalodimas wrote:
> On Fri, Jul 12, 2019 at 06:37:58AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jul 11, 2019 at 11:10:59PM +0300, Ilias Apalodimas wrote:
> > > Will report back any issues when we start using it on real hardware
> > > rather than QEMU
> > > 
> > > Thanks
> > > /Ilias
> > 
> > That would awesome. PR is far away so there is time to add more
> > tested-by's. Thanks.
> > 
> 
> I tested the basic fucntionality on QEMU and with the code only built as a
> module. You can add my tested-by on this if you want

Thank you. Added.

/Jarkko
