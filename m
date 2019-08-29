Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818FAA29B8
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfH2WZU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 18:25:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:3799 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfH2WZU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 18:25:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 15:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="182478848"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2019 15:25:17 -0700
Date:   Fri, 30 Aug 2019 01:25:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/3 v3] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
Message-ID: <20190829222515.vx3uiczc3xpnncdf@linux.intel.com>
References: <20190829204947.2591-1-jsnitsel@redhat.com>
 <20190829204947.2591-4-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829204947.2591-4-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 29, 2019 at 01:49:47PM -0700, Jerry Snitselaar wrote:
> There was revealed a bug in the STM TPM chipset used in Dell R415s.
> Bug is observed so far only on chipset firmware 1.2.8.28
> (1.2 TPM, device-id 0x0, rev-id 78). After some number of
> operations chipset hangs and stays in inconsistent state:
> 
> tpm_tis 00:09: Operation Timed out
> tpm_tis 00:09: tpm_transmit: tpm_send: error -5
> 
> Durations returned by the chip are the same like on other
> firmware revisions but apparently with specifically 1.2.8.28 fw
> durations should be reset to 2 minutes to enable tpm chip work
> properly. No working way of updating firmware was found.
> 
> This patch adds implementation of ->update_durations method
> that matches only STM devices with specific firmware version.
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
