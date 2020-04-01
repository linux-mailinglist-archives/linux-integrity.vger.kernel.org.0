Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956C919A718
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2020 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgDAIUa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Apr 2020 04:20:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:36715 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDAIUa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Apr 2020 04:20:30 -0400
IronPort-SDR: UIN3sk57ourU3eRBAkihcrtyZhMJ77gKNNrXX+398kTeF/Xtv5Qn1SyjZmxm/RM0yW+kwNDQrV
 Fc5vrreDRoFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 01:20:30 -0700
IronPort-SDR: gcLKdk5leewbXh2NZqZHf8qkafOI+oTgdm3xH4UEYLpxs9isubzIwwu4awu9+iJuhnz77lD0/8
 tXpKeFVPV4tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="242160906"
Received: from vikasjox-mobl.amr.corp.intel.com (HELO localhost) ([10.249.39.53])
  by fmsmga008.fm.intel.com with ESMTP; 01 Apr 2020 01:20:21 -0700
Date:   Wed, 1 Apr 2020 11:20:19 +0300
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
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Christophe Richard <hristophe-h.ricard@st.com>
Subject: Re: [PATCH v4 2/7] tpm: tpm_tis: Add check_data handle to
 tpm_tis_phy_ops in order to check data integrity
Message-ID: <20200401082019.GB17325@linux.intel.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-3-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331113207.107080-3-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 02:32:02PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> In order to compute the crc over the data sent in lower layer
>  (I2C for instance), tpm_tis_check_data() calls an operation (if available)
>  to check data integrity. If data integrity cannot be verified, a retry
>  attempt to save the sent/received data is implemented.
> 
> The current steps are done when sending a command:
>     1. Host writes to TPM_STS.commandReady.
>     2. Host writes command.
>     3. Host checks that TPM received data is valid.
>     4. If data is currupted go to step 1.
> 
> When receiving data:
>     1. Host checks that TPM_STS.dataAvail is set.
>     2. Host saves received data.
>     3. Host checks that received data is correct.
>     4. If data is currupted Host writes to TPM_STS.responseRetry and go to
>         step 1.
> 
> Co-developed-by: Christophe Richard <hristophe-h.ricard@st.com>
> Signed-off-by: Christophe Richard <hristophe-h.ricard@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

The email is malformed.

So.. How did Christophe participate on writing this patch? I haven't
seen him shouting anything about the subject and still his SOB is
there.

/Jarkko
