Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7405A1B6C
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH2N2E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 09:28:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:40757 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfH2N2D (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 09:28:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="356448812"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2019 06:28:00 -0700
Date:   Thu, 29 Aug 2019 16:27:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexey Klimov <aklimov@redhat.com>
Subject: Re: [PATCH 1/2 v2] tpm: provide a way to override the chip returned
 durations
Message-ID: <20190829132758.mcwewifdqgai2zqr@linux.intel.com>
References: <20190828004621.29050-1-jsnitsel@redhat.com>
 <20190828004621.29050-2-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828004621.29050-2-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 27, 2019 at 05:46:20PM -0700, Jerry Snitselaar wrote:
> Patch adds method ->update_durations to override returned
> durations in case TPM chip misbehaves for TPM 1.2 drivers.
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
