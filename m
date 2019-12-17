Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F45122981
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLQLGH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 06:06:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:22434 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfLQLGH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 06:06:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:06:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="212525575"
Received: from pbroex-mobl1.ger.corp.intel.com ([10.251.85.107])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2019 03:06:03 -0800
Message-ID: <fab70737263a076ce6a853e9f554e190f3cfb883.camel@linux.intel.com>
Subject: Re: [PATCH] tpm/ppi: replace assertion code with recovery in
 tpm_eval_dsm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Dec 2019 13:06:02 +0200
In-Reply-To: <20191215182314.32208-1-pakki001@umn.edu>
References: <20191215182314.32208-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-12-15 at 12:23 -0600, Aditya Pakki wrote:
> In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
> By returning NULL to the callers, instead of crashing, the error
> can be better handled.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Thanks.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

