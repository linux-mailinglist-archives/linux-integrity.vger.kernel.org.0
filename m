Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269F3A6DA8
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfICQK4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 12:10:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:60358 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICQK4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 12:10:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 09:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="184803149"
Received: from vkuppusa-mobl2.ger.corp.intel.com ([10.252.39.67])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 09:10:51 -0700
Message-ID: <f73c8da9fe417eb07137baac9c96dc0e0b6f63a3.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism
 for supporting AMD's fTPM
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Sep 2019 19:10:50 +0300
In-Reply-To: <CAHjaAcR4H6CnHxzR3NHLpMCgdafVHYuKCp4qxUd8b+K0SN34BQ@mail.gmail.com>
References: <20190830095639.4562-1-kkamagui@gmail.com>
         <20190830095639.4562-3-kkamagui@gmail.com>
         <20190830124334.GA10004@ziepe.ca>
         <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
         <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com>
         <20190902135348.3pndbtbi6hpgjpjn@linux.intel.com>
         <CAHjaAcR4H6CnHxzR3NHLpMCgdafVHYuKCp4qxUd8b+K0SN34BQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-03 at 07:42 +0900, Seunghun Han wrote:
> I have a question. Do you think this patch is not enough to handle
> AMD's fTPM problem? If so, would you tell me about it? I will change
> my patch.

I have no new feedback to give at this point and no absolutely time to
brainstorm new ideas.

You've now sent the same patch set version twice. The one that was
sent 8-30 has the same patch version and no change log so no action
taken from my part.

Please version your patch sets and keep the change log in the cover
letter.

/Jarkko

