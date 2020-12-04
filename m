Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1482CE727
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 05:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgLDEwK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Dec 2020 23:52:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:61310 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgLDEwK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Dec 2020 23:52:10 -0500
IronPort-SDR: 7VR+0eJ84V9k50ccJIqrCR4sG97H8Z/x7m0+yjJhmIXJ8bGVoSjd931AzvYq5Xldy6fj3pb4xy
 ZaRzGGCjpG0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="191569061"
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="191569061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 20:50:30 -0800
IronPort-SDR: 3b7TjePQRXO3OdcTKCJaAJ9Oimt6I7GjleeZ0lf6IMxqmIOPiqy20VP4wMgN3tqrmUgIQKuNuj
 BBTR4YFccu2A==
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="315982689"
Received: from kramerha-mobl.ger.corp.intel.com (HELO linux.intel.com) ([10.252.53.177])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 20:50:26 -0800
Date:   Fri, 4 Dec 2020 06:50:21 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org,
        kbuild-all@lists.01.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        jarkko@kernel.org
Subject: Re: [PATCH v14 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <20201204045021.GE84413@linux.intel.com>
References: <20201129222004.4428-5-James.Bottomley@HansenPartnership.com>
 <202011301002.yYRCOdq5-lkp@intel.com>
 <5e94c7199c675bbfa7112f8b79fcb91f8d2d4fe7.camel@HansenPartnership.com>
 <20201204044908.GD84413@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204044908.GD84413@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 04, 2020 at 06:49:15AM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 30, 2020 at 11:58:43AM -0800, James Bottomley wrote:
> > On Mon, 2020-11-30 at 10:10 +0800, kernel test robot wrote:
> > [...]
> > >  > 331		if (payload->blob_len < 0)
> > >    332			return payload->blob_len;
> > 
> > OK, I can rework this to use the signed version of blob len as below.
> > 
> > James
> 
> Do you have the patches in a git branch somewhere with this fixed?
> 
> I can take from there and apply.

CC my korg address. Sorry for the latency, I have this LKML migration
going on (MAINTAINERS is already updated). Sometimes forgot to check
this inbox.

/Jarkko
