Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9E22472C0
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbgHQSrB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 14:47:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:35786 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391607AbgHQSq6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 14:46:58 -0400
IronPort-SDR: iM7JMPgDl1SMpaEYb0MNNo+9icdl3D11PMZ+vS//g1N4Spj5RZ1E+YUzrtijlZ2NtEiCjHSeme
 Wb9ZisOhJZiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216296295"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="216296295"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 11:46:56 -0700
IronPort-SDR: es36+i1onmXPqW83f7u1/Q1fmWC0Un2m/tSACm7I0mIyVf6iSR9ZNsTqARmWaOvlBH2ZlSsai6
 37iELQbJqWrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="292520047"
Received: from martincl-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.45.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2020 11:46:53 -0700
Date:   Mon, 17 Aug 2020 21:46:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial
 device
Message-ID: <20200817184652.GA44714@linux.intel.com>
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

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
