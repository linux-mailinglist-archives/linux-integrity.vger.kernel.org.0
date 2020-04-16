Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF181ACE65
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 19:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgDPRIO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 13:08:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:40337 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgDPRIO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 13:08:14 -0400
IronPort-SDR: xlrGfs5XVN0s+7sgOsYcL/D8+1EEqMxkuVXdrFWJB1ER+LlIKlFy2HVKj6ImBH7N6iXaPMy+CX
 eNdmtret6xuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 10:08:12 -0700
IronPort-SDR: 6UnbU5k+Zc3c+RQV0mPYlO5Udp34XmhLBQPWsV7sNAJC0OM5v4lB5biLwHWYo+B7OKynhNKi1H
 oPFoBLwIylBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="246046517"
Received: from otazetdi-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.42.128])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2020 10:08:11 -0700
Date:   Thu, 16 Apr 2020 20:08:10 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200416170810.GD199110@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 15, 2020 at 03:45:22PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We've encountered a particular model of STMicroelectronics TPM that
> transiently returns a bad value in the status register. This causes the
> kernel to believe that the TPM is ready to receive a command when it
> actually isn't, which in turn causes the send to time out in
> get_burstcount(). In testing, reading the status register one extra time
> convinces the TPM to return a valid value.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

So what is the bad value?

/Jarkko
