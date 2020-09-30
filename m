Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC627DE82
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 04:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgI3C0n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 22:26:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:40809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbgI3C0m (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 22:26:42 -0400
IronPort-SDR: fwWuFDnfLwjJWVgpWPS4NDd0tqghhiB2FXm4HklZ0cJsnq/hB9z731dzenVZ9B4wsSPxYofS9M
 uo8GbKn2IBBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159723589"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="159723589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:26:42 -0700
IronPort-SDR: 23h2JwPX7TOXIkk/QYICoCtDJCTLmZYoXz4o/V5lUwb8siVTG6q+le0FTTf/piNka7KetvkjTn
 eRC12HcGmuOw==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="514899376"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:26:40 -0700
Date:   Wed, 30 Sep 2020 05:26:38 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
Message-ID: <20200930022638.GI808399@linux.intel.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
 <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
 <20200930022606.GH808399@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930022606.GH808399@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 30, 2020 at 05:26:10AM +0300, Jarkko Sakkinen wrote:
> Adding Jerry for feedback.

Ugh, sorry, Jerry was already in the CC list.

/Jarkko
