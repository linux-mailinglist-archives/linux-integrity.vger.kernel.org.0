Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B030F122173
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 02:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfLQB0P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 20:26:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:1402 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLQB0P (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 20:26:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 17:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="416654626"
Received: from chauvina-mobl1.ger.corp.intel.com ([10.251.85.48])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2019 17:26:12 -0800
Message-ID: <f4ac8ac982daf33f5b2a5bdc0bf63f67fd40413a.camel@linux.intel.com>
Subject: Re: [PATCH V2] tpm_tis_spi: use new `delay` structure for SPI
 transfer delays
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>
Date:   Tue, 17 Dec 2019 03:26:11 +0200
In-Reply-To: <6920bc5e8bc932dd85fa8e14755d2e6999512f25.camel@analog.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
         <20191210065619.7395-1-alexandru.ardelean@analog.com>
         <20191211173700.GE4516@linux.intel.com>
         <6920bc5e8bc932dd85fa8e14755d2e6999512f25.camel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 07:21 +0000, Ardelean, Alexandru wrote:
> That's a habit from Github's Markdown.
> We keep our kernel repo on Github and Markdown formats `text` into a
> certain form.

Ah.

> When I open a PR, the PR text is formatted to highlight certain elements
> [that I want highlighted].
> I did not get any comments on it so far.
> 
> I can change it if you want.
> 
> As a secondary note: Markdown seems to be used on Gitlab and Bitbucket

Please change it.

/Jarkko

