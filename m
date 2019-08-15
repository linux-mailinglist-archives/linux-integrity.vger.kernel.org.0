Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC408F64C
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Aug 2019 23:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfHOVRF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Aug 2019 17:17:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:50855 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbfHOVRF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Aug 2019 17:17:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 14:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="194846939"
Received: from schuberw-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.145])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 14:17:02 -0700
Date:   Fri, 16 Aug 2019 00:17:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: Does probing of TIS with interrupts work
Message-ID: <20190815211701.7nhq3uelpddho7i7@linux.intel.com>
References: <f721bf34-1cfc-de2b-91e4-24b17150645b@linux.ibm.com>
 <20190813122838.GD29508@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813122838.GD29508@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 13, 2019 at 09:28:38AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2019 at 11:39:27PM -0400, Stefan Berger wrote:
> > I have tried to get probing of TIS with interrupts to work on a module and I
> > am wondering whether it works for anyone. I noticed it tries to probe while
> > locality 0 is released and the TPM_CHIP_FLAG_IRQ is never set, so it never
> > gets to certain places in the code. To get it to work I had to add a patch
> > like this one here to tpm_tis_core_init:
> 
> It worked a long time ago, probably bitrotted
> 
> We should probably drop it entirely if it doesn't even work today and
> nobody has complained.

I'd prefer to fix this.

/Jarkko
