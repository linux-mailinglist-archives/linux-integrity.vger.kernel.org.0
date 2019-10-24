Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F292CE3BE7
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392928AbfJXTPS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 15:15:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:36471 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390636AbfJXTPS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 15:15:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="399872227"
Received: from nesterov-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.8.153])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2019 12:15:14 -0700
Date:   Thu, 24 Oct 2019 22:15:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191024191514.GC12038@linux.intel.com>
References: <20191016182814.18350-1-ivan.lazeev@gmail.com>
 <20191021155735.GA7387@linux.intel.com>
 <20191023115151.GF21973@linux.intel.com>
 <20191023232035.ir7hmed4m3emovyx@cantor>
 <20191024155708.w3obpo3i6wz5b5er@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024155708.w3obpo3i6wz5b5er@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 24, 2019 at 08:57:08AM -0700, Jerry Snitselaar wrote:
> I see there is a patch from Hans de Goede already dealing with this:
> "tpm: Switch to platform_get_irq_optional()".

Sorry did not notice this before sending my response. Yes, Hans' patch
will fix this glitch.

/Jarkko
