Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE27204309
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2020 23:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgFVVzH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 17:55:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:23443 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgFVVzH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:07 -0400
IronPort-SDR: saSvpF9uemWYyMPhn0luvTSNJsWD9S7D7wR0CIfn+exv3MQp7VA8ykXYFLpP5nC+keZzOl04AD
 QINlGn+UeOHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131292443"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="131292443"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:55:04 -0700
IronPort-SDR: qJfWOOQSuH10rQ4L387fK4XAqza3y5fE0lxqXex6HgcraSRtXtIOTSXVZMcKMqjQIcT/s3HQfO
 tWzoLMcURrew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="478530110"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 14:54:56 -0700
Date:   Tue, 23 Jun 2020 00:54:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Benoit Houyere <benoit.houyere@st.com>
Subject: Re: [PATCH v11 2/8] tpm: tpm_tis: Fix expected bit handling and send
 all bytes in one shot without last byte in exception
Message-ID: <20200622215453.GD22727@linux.intel.com>
References: <20200618134344.243537-1-amirmizi6@gmail.com>
 <20200618134344.243537-3-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618134344.243537-3-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 04:43:37PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Detected the following incorrect implementation of the send command:
> polling on the TPM_STS.stsValid field followed by checking the
> TPM_STS.expect field only once. Since TPM_STS.stsValid represents the
> TPM_STS.expect validity, both fields should be polled at the same time.
> 
> This fix modifies the signature of wait_for_tpm_stat(), adding an
> additional "mask_result" parameter to its call. wait_for_tpm_stat() is now
> polling the TPM_STS with a mask and waits for the value in mask_result.
> The fix adds the ability to check if certain TPM_STS bits have been
> cleared.
> 
> This change is also aligned to verifying the CRC on I2C TPM. The CRC
> verification should be done after the TPM_STS.expect field is cleared
> (TPM received all expected command bytes and set the calculated CRC value
> in the register).
> 
> In addition, the send command was changed to comply with
> TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf as follows:
> - send all command bytes in one loop
> - remove special handling of the last byte
> 
> Suggested-by: Benoit Houyere <benoit.houyere@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

If this patch set needs a further update, you could rename the function
as 'tpm_tis_wait_for_stat()' (can be part of this patch). It's better
aligned with other naming and gives better picture of the scope of this
function.

/Jarkko
