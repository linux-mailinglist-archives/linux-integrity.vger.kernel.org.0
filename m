Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2061219F7E
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 14:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgGIMAN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 08:00:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:64922 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgGIMAN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 08:00:13 -0400
IronPort-SDR: VoXYPPbBcEogUJ3D8gFVzaH3n/DU1Qs/z5xPb4Ptnggq3TyfVUKJtRATsN+zg2+ZsrehSeGIEP
 IWef8HzfL88Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="149467367"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="149467367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 05:00:11 -0700
IronPort-SDR: yeTdKlI4dprMjnusNpvYhmX12shyjq70DohI/oNO837KzfmT0OT9kjR1/KQ0YEmhGyDNEI9hPI
 5sSeqAjVJMvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="316205409"
Received: from nk4-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.52.252])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2020 05:00:07 -0700
Date:   Thu, 9 Jul 2020 15:00:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v3 0/2] synquacer: add TPM support
Message-ID: <20200709120006.GC683620@linux.intel.com>
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
 <20200708162017.GB549022@linux.intel.com>
 <CADQ0-X9im8yVVVJbJL5Ssaa49UTOw+M=tYrfhNoODUaY723O8A@mail.gmail.com>
 <CADQ0-X8xF0NpMakEB_Kqd2hVSrMsMB5FqFd7V9F1eLryJbEeFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ0-X8xF0NpMakEB_Kqd2hVSrMsMB5FqFd7V9F1eLryJbEeFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 09, 2020 at 08:46:35AM +0900, Masahisa Kojima wrote:
> Hi Jarkko,
> 
> > Hi Jakko,
> I apologize for mis-spelling of your name.
> Same mistake also appears in my another reply to "[PATCH v3 1/2] tpm:
> tis: add support for MMIO TPM on SynQuacer"

No worries :-)

/Jarkko
