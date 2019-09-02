Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4DCA586E
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfIBNxy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 09:53:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:44926 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfIBNxx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 09:53:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="266026347"
Received: from doblerbe-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.100])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2019 06:53:49 -0700
Date:   Mon, 2 Sep 2019 16:53:48 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Seunghun Han <kkamagui@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
Message-ID: <20190902135348.3pndbtbi6hpgjpjn@linux.intel.com>
References: <20190830095639.4562-1-kkamagui@gmail.com>
 <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca>
 <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 30, 2019 at 05:58:39PM +0000, Safford, David (GE Global Research, US) wrote:
> > Thank you for your advice. We also discussed earlier and concluded that
> > checking and raw remapping are enough to work around this. The link is
> > here, https://lkml.org/lkml/2019/8/29/962 .
> 
> I don't see Matthew Garrett's agreement on that thread.

No one has agreed on anything.

/Jarkko
