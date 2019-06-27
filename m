Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90FB57556
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 02:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfF0AUF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jun 2019 20:20:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:9750 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF0AUF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jun 2019 20:20:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 17:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="156052147"
Received: from mwsinger-mobl3.ger.corp.intel.com ([10.252.48.211])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2019 17:19:58 -0700
Message-ID: <1b3c1718d46c20d2b4c7d8fd4fc08482dd4b0c95.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/2] char: tpm: add new driver for tpm i2c ptp
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Oshri Alkoby <oshrialkoby85@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        tomer.maimon@nuvoton.com
Date:   Thu, 27 Jun 2019 03:20:10 +0300
In-Reply-To: <20190625223503.367710-1-oshrialkoby85@gmail.com>
References: <20190625223503.367710-1-oshrialkoby85@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-26 at 01:35 +0300, Oshri Alkoby wrote:
> This patch set adds support for TPM devices that implement the I2C
> interface defined by TCG PTP specification.
> 
> The driver was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.

Where is the link to teh spec?

/Jarkko

