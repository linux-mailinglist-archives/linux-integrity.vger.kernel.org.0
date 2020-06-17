Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340181FC347
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 03:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFQBRZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 21:17:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:51471 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgFQBRZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 21:17:25 -0400
IronPort-SDR: lQA4CE45FwCgGFlXMPjoCh4cP20QHxy8Wamgs1HQ6XPURdKy4aX6f6m4G3OrkVwoAp7tejs0x9
 nL9w0EyARBaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 18:17:24 -0700
IronPort-SDR: bQFvK4v3jSvMKYV7mYxujZB44pNzl4SipeNCURWEO3iw9k19ivotm3Eag1MGkRXpuCP1vf7yEs
 IPZQ389lRZ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="450055304"
Received: from carusoal-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.130])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2020 18:17:14 -0700
Date:   Wed, 17 Jun 2020 04:17:13 +0300
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
Subject: Re: [PATCH v10 3/8] tpm: tpm_tis: Add retry in case of protocol
 failure or data integrity (on I2C only) failure.
Message-ID: <20200617011713.GC5100@linux.intel.com>
References: <20200604134713.157951-1-amirmizi6@gmail.com>
 <20200604134713.157951-4-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134713.157951-4-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 04:47:08PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> The FIFO protocol described in the TCG PC Client Device Driver Design
> Principles for TPM 2.0 advises retrying sending a command or receiving
> a response using the FIFO protocol in case of any error in the protocol.
> 
> Add a retry mechanism on any protocol error. In addition, in case of a data
> integrity issue in the I2C bus protocol, check after sending a command
> completion or receiving a response from the TPM.

The first sentence of this paragraph means absolutely nothing but
nonsense. Please describe the implementation broadly instead.

Also the code is organized badly and makes the current code base a mess.
You should derive __tpm_tis_recv() from the "old" tpm_tis_recv(), and
introduce a "new" tpm_tis_recv() that calls __tpm_tis_recv() a number of
times.

/Jarkko
