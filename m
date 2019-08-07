Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB49684CD7
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2019 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfHGNV7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Aug 2019 09:21:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38033 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388059AbfHGNV6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Aug 2019 09:21:58 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost.localdomain)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1hvLsm-0002TB-34; Wed, 07 Aug 2019 15:21:36 +0200
Message-ID: <5707aee16681065a975ed42a06069674c3127edb.camel@pengutronix.de>
Subject: Re: [Tee-dev] [PATCH v8 0/2] fTPM: firmware TPM running in TEE
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        thiruan@microsoft.com, tee-dev@lists.linaro.org, jgg@ziepe.ca,
        ilias.apalodimas@linaro.org, rdunlap@infradead.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        bryankel@microsoft.com
Date:   Wed, 07 Aug 2019 15:21:33 +0200
In-Reply-To: <20190711200858.xydm3wujikufxjcw@linux.intel.com>
References: <20190705204746.27543-1-sashal@kernel.org>
         <20190711200858.xydm3wujikufxjcw@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I spent some time with the fTPM module and TA on a Nitrogen6X with the
latest OP-TEE master. After stumbling through the "tee_supplicant no
persistent storage" problem, my module now issues the following error
message on module load:

[   34.633252] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff0006
[   34.641035] tpm tpm0: tpm_try_transmit: send(): error -65530
[   34.647008] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff0006
[   34.654788] tpm tpm0: tpm_try_transmit: send(): error -65530
[   34.660480] ftpm-tee ftpm: ftpm_tee_probe: tpm_chip_register failed with rc=-65530
[   34.678087] ftpm-tee: probe of ftpm failed with error -65530

To me the TEE_ERROR_BAD_PARAMETERS indicates some ABI issue between the
TA and the kernel module. Note that I built the TA from 
https://github.com/microsoft/MSRSec.git with commit
6bb57db632c424f87cbaf7ec6f9c89be7682b3c0. Maybe this is not the correct
version, I had some problems building the module from the repository
mentioned in the Patches

Regards,
Rouven Czerwinski
-- 
Pengutronix e.K.                           |            		 |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

