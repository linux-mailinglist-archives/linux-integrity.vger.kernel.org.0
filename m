Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F231F219F36
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgGILmU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 07:42:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:5195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgGILmU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 07:42:20 -0400
IronPort-SDR: skiGhcDJ0FQz83L6XuKIPDsQbBB8jmZeHqVBIAknAoZxmchflmVeDdRTKjoQHNsQmzMLnYi3XC
 W4qeCSVQjlQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="128046864"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="128046864"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 04:42:19 -0700
IronPort-SDR: XE0d1mBqu7YGw3U+LrPHZjvrWGV04Jh6iYCGGr5seNBGkinrOOER7Cws5lhVPO97K6NPbKyLsU
 3uEAC/sbeqiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="324195429"
Received: from nk4-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.52.252])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 04:42:15 -0700
Date:   Thu, 9 Jul 2020 14:42:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v3 0/2] synquacer: add TPM support
Message-ID: <20200709114213.GB683620@linux.intel.com>
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
 <20200708162017.GB549022@linux.intel.com>
 <CADQ0-X9im8yVVVJbJL5Ssaa49UTOw+M=tYrfhNoODUaY723O8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ0-X9im8yVVVJbJL5Ssaa49UTOw+M=tYrfhNoODUaY723O8A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 09, 2020 at 08:34:27AM +0900, Masahisa Kojima wrote:
> Hi Jakko,
> 
> > Overally the code looks great. You've run it through checkpatch.pl?
> 
> Yes, I have run checkpatch.pl and removed errors.

OK, cool.

/Jarkko
