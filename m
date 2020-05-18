Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F061D884F
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2020 21:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgERTiL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 May 2020 15:38:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:29951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgERTiL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 15:38:11 -0400
IronPort-SDR: V6OJC9JfMgtIbgqTZK7di4sWXhGvgo/rQVBVOAgAEDTmbKEu3j3KEIK3ZWd8X5yLWD44fd2Ay9
 wHNowKF6cLNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 12:38:10 -0700
IronPort-SDR: JZGy6sBI2Vjp/UK56cBIPjG9xAIo0dm/8rzzZOU9UkxBvQJfqjury8Gg8UoRXwRVKYRoLQvYyc
 u/5QWr6Dp++Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="299333022"
Received: from afloress-mobl2.amr.corp.intel.com ([10.252.56.85])
  by fmsmga002.fm.intel.com with ESMTP; 18 May 2020 12:38:07 -0700
Message-ID: <e886d85baa24c09a6b571dd993e7450d5b16d48c.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] tpm_ftpm_tee: register driver on tee bus
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Date:   Mon, 18 May 2020 22:38:06 +0300
In-Reply-To: <20200518133459.28019-3-maxim.uvarov@linaro.org>
References: <20200518133459.28019-1-maxim.uvarov@linaro.org>
         <20200518133459.28019-3-maxim.uvarov@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-05-18 at 16:34 +0300, Maxim Uvarov wrote:
> Register driver on tee bus. module tee registers bus,
> and module optee calls optee_enumerate_devices() to scan
> all devices on the bus. This TA can be Early TA's ( can be
> compiled into optee-os). In that case it will be on optee
> bus before linux booting. Also optee-suplicant application
> is needed to be loaded between optee module and ftpm module to
> to maintain functionality for ftpm driver.

Please use proper casing in the commit message e.g. tee to TEE
and so forth. What is TA?

/Jarkko

