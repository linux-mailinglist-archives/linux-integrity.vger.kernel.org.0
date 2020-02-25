Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5116BEB2
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 11:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgBYK2G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 05:28:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:25768 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgBYK2G (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 05:28:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 02:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="226302845"
Received: from ayakove1-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.12.5])
  by orsmga007.jf.intel.com with ESMTP; 25 Feb 2020 02:28:01 -0800
Date:   Tue, 25 Feb 2020 12:27:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 1/2] tpm: tpm1_bios_measurements_next should increase
 position index
Message-ID: <20200225102746.GA8136@linux.intel.com>
References: <20200205220359.GA28111@linux.intel.com>
 <5d5c4779-0754-7ca2-8f3b-d7e6fa3f67ad@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5c4779-0754-7ca2-8f3b-d7e6fa3f67ad@virtuozzo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 25, 2020 at 09:26:08AM +0300, Vasily Averin wrote:
> If .next function does not change position index,
> following .show function will repeat output related
> to current position index.
> 
> In case of /sys/kernel/security/tpm0/ascii_bios_measurements
> and binary_bios_measurements:
> 1) read after lseek beyound end of file generates whole last line.
> 2) read after lseek to middle of last line generates
> expected end of last line and unexpected whole last line once again.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thank alot!

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
