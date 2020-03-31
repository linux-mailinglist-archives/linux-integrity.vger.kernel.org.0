Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3919960F
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgCaMOB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 08:14:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:17802 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgCaMOB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 08:14:01 -0400
IronPort-SDR: fxhVUpyXLaInrVgCZ4w3bkV8UuWJhd0IsTStZPb/dFtg18vY4/pKHqBR7Vj75kZIeOfAK2TpRs
 aYJeO3Fr5o1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 05:14:00 -0700
IronPort-SDR: Mk1XT5CSaErxYENmospOKj3NEgn1A3405UpKRkKu6W69I4rTAjGOOU+0gIVxfq2MFUyyfz3r+w
 xkzJ8ykAG8mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="294911570"
Received: from tking1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.59.94])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2020 05:13:53 -0700
Date:   Tue, 31 Mar 2020 15:13:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v4 3/7] tpm: tpm_tis: rewrite "tpm_tis_req_canceled()"
Message-ID: <20200331121352.GA9284@linux.intel.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-4-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331113207.107080-4-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 02:32:03PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Using this function while read/write data resulted in aborted operation.
> After investigating according to TCG TPM Profile (PTP) Specifications,
> i found cancel should happen only if TPM_STS.commandReady bit is lit and
> couldn't find a case when the current condition is valid.
> Also only cmdReady bit need to be compared instead of the full lower status
> register byte.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

We don't care about spec's. We care about hardware and not all hardware
follows specifications.

Please fix the exact thing you want to fix (and please provide a fixes
tag).

/Jarkko
