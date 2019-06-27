Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5327758346
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfF0NTG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 09:19:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:32100 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0NTG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 09:19:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 06:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="162634373"
Received: from unknown (HELO jsakkine-mobl1) ([10.252.36.47])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2019 06:19:02 -0700
Message-ID: <f98b870d8be4d3710f8114a2e864b18995d7929d.camel@linux.intel.com>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Date:   Thu, 27 Jun 2019 16:19:01 +0300
In-Reply-To: <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
References: <20190625201341.15865-1-sashal@kernel.org>
         <20190625201341.15865-2-sashal@kernel.org>
         <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
         <20190626235653.GL7898@sasha-vm>
         <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-06-27 at 16:17 +0300, Jarkko Sakkinen wrote:
> On Wed, 2019-06-26 at 19:56 -0400, Sasha Levin wrote:
> > > You've used so much on this so shouldn't this have that somewhat new
> > > co-developed-by tag? I'm also wondering can this work at all
> > 
> > Honestly, I've just been massaging this patch more than "authoring" it.
> > If you feel strongly about it feel free to add a Co-authored patch with
> > my name, but in my mind this is just Thiru's work.
> 
> This is just my subjective view but writing code is easier than making
> it work in the mainline in 99% of cases. If this patch was doing
> something revolutional, lets say a new outstanding scheduling algorithm,
> then I would think otherwise. It is not. You without question deserve
> both credit and also the blame (if this breaks everything) :-)

Not like I'm putting the pressure on this. You make the call
with the tag. Put it if you wwant. I'm cool with either.

/Jarkko

