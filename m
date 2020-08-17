Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230F3247887
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHQVOo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:14:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:7106 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgHQVOo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:14:44 -0400
IronPort-SDR: rQZOcFoOZwbex413NN+bfzTJnTaKtUILB1WSoUdaRDMLnEPdZ+Uq266RPUgZjzL/vraxJYFm4f
 nMj1hCe2B8iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142418315"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="142418315"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 14:14:43 -0700
IronPort-SDR: 93bBxgHVUdBFDBPXTqCH049KLd5f1W+pOOV9QvsaqTtXyXjP231jxgbapnbPPCOTem2pKWeG3j
 1lQEZarRN7QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="296609612"
Received: from bbartede-mobl.ger.corp.intel.com (HELO localhost) ([10.249.32.24])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2020 14:14:40 -0700
Date:   Tue, 18 Aug 2020 00:14:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial
 device
Message-ID: <20200817211440.GB44714@linux.intel.com>
References: <20200728031433.3370-1-masahisa.kojima@linaro.org>
 <20200728031433.3370-3-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728031433.3370-3-masahisa.kojima@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 28, 2020 at 12:14:32PM +0900, Masahisa Kojima wrote:
> Add a compatible string for the SynQuacer TPM to the binding for a
> TPM exposed via a memory mapped TIS frame. The MMIO window behaves
> slightly differently on this hardware, so it requires its own
> identifier.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

I applied these patches:

http://git.infradead.org/users/jjs/linux-tpmdd.git/log/refs/heads/master

/Jarkko
