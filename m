Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF4B915F
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfITOGT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Sep 2019 10:06:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:28343 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfITOGS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Sep 2019 10:06:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2019 07:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,528,1559545200"; 
   d="scan'208";a="388656882"
Received: from eergin-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.12])
  by fmsmga006.fm.intel.com with ESMTP; 20 Sep 2019 07:06:16 -0700
Date:   Fri, 20 Sep 2019 17:06:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 01/12] tpm-buf: move from static inlines to real
 functions
Message-ID: <20190920140459.GA9578@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
 <1568031476.6613.30.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568031476.6613.30.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 01:17:56PM +0100, James Bottomley wrote:
> This separates out the old tpm_buf_... handling functions from static
> inlines in tpm.h and makes them their own tpm-buf.c file.  This is a
> precursor so we can add new functions for other TPM type handling
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

What about TPM_BUF_2B that gets added in this commit?

/Jarkko
