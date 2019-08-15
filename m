Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374018EBBD
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Aug 2019 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfHOMmP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Aug 2019 08:42:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:13220 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfHOMmP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Aug 2019 08:42:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 05:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="260806924"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.163])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2019 05:42:12 -0700
Date:   Thu, 15 Aug 2019 15:42:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix fTPM on AMD Zen+ CPUs
Message-ID: <20190815124211.4gxroofqqysh2mjo@linux.intel.com>
References: <20190811174505.27019-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811174505.27019-1-ivan.lazeev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Aug 11, 2019 at 08:45:05PM +0300, ivan.lazeev@gmail.com wrote:
> From: Vanya Lazeev <ivan.lazeev@gmail.com>

You should have the "tpm:" tag in the beginning of short summary.

> The patch is an attempt to make fTPM on AMD Zen CPUs work.
> Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> 
> The problem seems to be that tpm_crb driver doesn't expect tpm command
> and response memory regions to belong to different ACPI resources.

Should be "TPM command", not "tpm command". Please be more strict
with the spelling.

> Tested on Asrock ITX motherboard with Ryzen 2600X CPU.

EOF the long description.

> However, I don't have any other hardware to test the changes on and no
> expertise to be sure that other TPMs won't break as a result.
> Hopefully, the patch will be useful.

This should not be part of the commit message but instead should be
placed just before diffstat (below two dashes in the patch) so that
it doesn't get included into commit log.

> Signed-off-by: Vanya Lazeev <ivan.lazeev@gmail.com>

You should take time and write what the commit does and why it
does what it does. That is the meat of the commit message and
your commit is completely lacking it.

I'll look at the code change once it is described appropriately.

For more information how to do commit properly I would advice
to go through the material in

https://kernelnewbies.org/FirstKernelPatch

/Jarkko
