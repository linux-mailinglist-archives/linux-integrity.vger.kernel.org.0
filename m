Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5131C1FC321
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 03:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgFQBBP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 21:01:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:27658 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgFQBBO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 21:01:14 -0400
IronPort-SDR: 7zCaFnrtO1zmJR5K9faS7qk/pUE0gHExivuPc+SsW5fnE6L6BcHjzvIOSxPDZ/n8/iVt3tdwD2
 ueJUAHK+7JLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 18:01:12 -0700
IronPort-SDR: tYvItSxVa5vDgDLWIUJSj5xJUFsh7xyAL+jXQk9M76uVpbPTgE7boUdpPWPRIEj6Ks1Oo/JLiG
 HoAumagWExOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="291253132"
Received: from carusoal-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.130])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2020 18:01:04 -0700
Date:   Wed, 17 Jun 2020 04:01:03 +0300
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
Subject: Re: [PATCH v10 2/8] tpm: tpm_tis: Fix expected bit handling and send
 all bytes in one shot without last byte in exception
Message-ID: <20200617010050.GA5100@linux.intel.com>
References: <20200604134713.157951-1-amirmizi6@gmail.com>
 <20200604134713.157951-3-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134713.157951-3-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 04:47:07PM +0300, amirmizi6@gmail.com wrote:
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

Just wondering how did you come up with that name since you are not
masking anything with 'mask_result'?

/Jarkko
