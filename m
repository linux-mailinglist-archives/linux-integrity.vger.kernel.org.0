Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E229204322
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2020 23:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgFVV7e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 17:59:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:9787 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730765AbgFVV7e (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 17:59:34 -0400
IronPort-SDR: YNpJ5+bxd3wR5TagIo+MocH5MLJ33w30QuLwM5b3d+ENgpuIArwMY94DxJWs0uPpEsPBzgxI+S
 s5T2NqnVsbfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="161967180"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="161967180"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:59:33 -0700
IronPort-SDR: mRBtvo2zY+7y2bE8mNE0Cb73kyWqwyHB4DbRHe1Bz/S/GoLN87diVCPnqSis7qkGJ9CjHSEBN9
 fHonmyKnmF8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="263121248"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2020 14:59:23 -0700
Date:   Tue, 23 Jun 2020 00:59:22 +0300
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
        Christophe Ricard <christophe-h.ricard@st.com>
Subject: Re: [PATCH v11 3/8] tpm: tpm_tis: Add retry in case of protocol
 failure or data integrity (on I2C only) failure.
Message-ID: <20200622215922.GE22727@linux.intel.com>
References: <20200618134344.243537-1-amirmizi6@gmail.com>
 <20200618134344.243537-4-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618134344.243537-4-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 04:43:38PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a retry mechanism on any protocol error. In addition, a retry is
> added in case of a data integrity issue in the I2C bus protocol. The check
> is performed after sending a command to the TPM and after receiving a
> response from the TPM.

No chance to merge this without reasoning why on any protocol error we
should retry. It's not reasoned here. Unfotunately, with this premise I
cannot merge this.

/Jarkko
