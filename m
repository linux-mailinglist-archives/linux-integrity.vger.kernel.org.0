Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C108D5F4B9
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGDIoB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 04:44:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:45920 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfGDIoB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 04:44:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 01:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; 
   d="scan'208";a="191313110"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2019 01:43:57 -0700
Message-ID: <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Oshri Alkoby <oshrialkoby85@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        dan.morav@nuvoton.com, tomer.maimon@nuvoton.com
Date:   Thu, 04 Jul 2019 11:43:55 +0300
In-Reply-To: <20190628151327.206818-1-oshrialkoby85@gmail.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-28 at 18:13 +0300, Oshri Alkoby wrote:

The long descriptions are still missing. Please take the time and write
a proper commit messages that clearly tell what the patch does.

Check out tpm_tis_core.c and tpm_tis_spi.c. TPM TIS driver implements
that spec so you should only implement a new physical layer.

/Jarkko

