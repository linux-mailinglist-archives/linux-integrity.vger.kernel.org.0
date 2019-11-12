Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303B4F9A84
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLUXA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 15:23:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:23533 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfKLUXA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 15:23:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 12:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="194443228"
Received: from joshbuck-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.20.68])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2019 12:22:49 -0800
Date:   Tue, 12 Nov 2019 22:22:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com
Subject: Re: [PATCH v1 2/5] char: tpm: Add check_data handle to
 tpm_tis_phy_ops in order to check data integrity
Message-ID: <20191112202247.GA12877@linux.intel.com>
References: <20191110162137.230913-1-amirmizi6@gmail.com>
 <20191110162137.230913-3-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110162137.230913-3-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 10, 2019 at 06:21:34PM +0200, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> The current principles:
> - When sending command:
> 1. Host writes TPM_STS.commandReady
> 2. Host writes command
> 3. Host checks TPM received data correctly
> 4. if not go to step 1

You are probably talking about steps, right?

Please check the grammar and punctation e.g. "The current steps are
roughly done when sending a command".

> - When receiving data:
> 1. Host check TPM_STS.dataAvail is set
> 2. Host get data
> 3. Host check received data are correct.
> 4. if not Host write TPM_STS.responseRetry and go to step 1.
> 
> this commit is based on previous work by Christophe Richard

Sentences in English start with a capital letter and end with a full
stop.

This is completely lacking the description what the commit does.

/Jarkko
