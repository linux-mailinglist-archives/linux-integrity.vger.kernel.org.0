Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D914F910
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Feb 2020 18:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgBARDc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Feb 2020 12:03:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:38216 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgBARDc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Feb 2020 12:03:32 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 09:03:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="278352085"
Received: from mtaylo3-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.87.188])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2020 09:03:30 -0800
Date:   Sat, 1 Feb 2020 19:03:29 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/2] tpm: tpm2_bios_measurements_next should increase
 position index
Message-ID: <20200201170329.GA14875@linux.intel.com>
References: <e72b6fda6c4ff0d54af37d064d66b883d7ea48e7.camel@linux.intel.com>
 <16bde2d6-4208-e478-0ac3-163b5c3a1eaa@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16bde2d6-4208-e478-0ac3-163b5c3a1eaa@virtuozzo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 30, 2020 at 01:23:21PM +0300, Vasily Averin wrote:
> If seq_file .next function does not change position index,
> read after non-zero lseek can generate unexpected output.

Is it unwanted or unexpected? Unexpected would be mean random
output. I don't think that is the case. Please describe more
throughly.

> For /sys/kernel/security/tpm0/binary_bios_measurements:
> 1) read after lseek beyond end of file generates whole last line.
> 2) read after lseek to middle of last line generates
> expected end of last line and unexpected whole last line once again.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
> 
No empty line here.

> https://bugzilla.kernel.org/show_bug.cgi?id=206283

"Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283"

/Jarkko
