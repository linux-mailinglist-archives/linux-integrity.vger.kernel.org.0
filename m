Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B271B883D9
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2019 22:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfHIU2T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Aug 2019 16:28:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:13225 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfHIU2S (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Aug 2019 16:28:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 13:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="166108401"
Received: from wulili-mobl1.ger.corp.intel.com ([10.249.36.9])
  by orsmga007.jf.intel.com with ESMTP; 09 Aug 2019 13:28:14 -0700
Message-ID: <f441fd9a5452bf2943e5dbe6d74b5d5f26016a90.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/4] tpm: tpm_tis_spi: Export functionality to other
 drivers
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>, Peter Huewe <peterhuewe@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Date:   Fri, 09 Aug 2019 23:28:13 +0300
In-Reply-To: <20190806220750.86597-3-swboyd@chromium.org>
References: <20190806220750.86597-1-swboyd@chromium.org>
         <20190806220750.86597-3-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-08-06 at 15:07 -0700, Stephen Boyd wrote:
> We want to use most of the code in this driver, except we want to modify
> the flow control and idle behavior. Let's "libify" this driver so that
> another driver can call the code in here and slightly tweak the
> behavior.

Neither "libifying" nor "slightly tweaking" gives an idea what the
commit does. A great commit message should be in imperative form
describe what it does and why in as plain english as possible.

Often commit messages are seen just as a necessary bad and not much
energy is spent on them but for a maitainer solid commit messages have
an indispensable value.

> +	void (*pre_transfer)(struct tpm_tis_spi_phy *phy);

Adding a new calback should be a commit of its own.

/Jarkko

