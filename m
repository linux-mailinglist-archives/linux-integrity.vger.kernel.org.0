Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ECF1EE17C
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgFDJkY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 05:40:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:24887 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgFDJkY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 05:40:24 -0400
IronPort-SDR: /5EE5W+z3hS7Dgnjc+ioCgflv8Bjnay++CkN0LbnGBMWhu176RAN7hXR2t+bZ7lvWYMHd5ChaR
 +MD+cc6SaOvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 02:40:18 -0700
IronPort-SDR: VFL+KJou8gMWo0laEdHS6nT07WwXP+woyVDnNCMkMTDHMMS+wR+4LrWfXPGySZyApbi5daP2wC
 HzhdhtBJiG6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; 
   d="scan'208";a="273052623"
Received: from alachman-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.44.241])
  by orsmga006.jf.intel.com with ESMTP; 04 Jun 2020 02:40:14 -0700
Date:   Thu, 4 Jun 2020 12:40:12 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm_tis_spi: Don't send anything during flow control
Message-ID: <20200604094012.GA8989@linux.intel.com>
References: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
 <20200601014646.GA794847@linux.intel.com>
 <CAD=FV=VaET7ZXE0f6ciKmE=p1R1DMF9jCue9_XAD4870byKGog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VaET7ZXE0f6ciKmE=p1R1DMF9jCue9_XAD4870byKGog@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 01, 2020 at 03:54:03PM -0700, Doug Anderson wrote:
> Does that answer your question, or were you worried about us needing
> to init iobuf[0] to 0 in some other case?
> 
> -Doug

No, but it should be treated as a bug fix for CR50 implementation i.e.
for 797c0113c9a481d4554988d70b5b52fae657262f, or is there some reason
why it shouldn't?

/Jarkko
