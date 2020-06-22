Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E185E2042F7
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2020 23:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgFVVtf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 17:49:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:14723 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbgFVVtf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 17:49:35 -0400
IronPort-SDR: JTFxKTYojH5mEBs6RM7CZrfhkJB2rsHfbUOFIJm1KhcIFlFvstOHR+KS/SBsP9Is9Hd+ZIacWU
 LekfCDhbqnMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142147317"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="142147317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 14:49:33 -0700
IronPort-SDR: l3+aCNn5cePJQnTRUQM4M2UMmP5EjvVZ6GmDgHmqx1h3pHz2i1GNcq7Fihp7D5jhue8nvCH4Aq
 4ZBVhrF46cBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="263119058"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2020 14:49:24 -0700
Date:   Tue, 23 Jun 2020 00:49:22 +0300
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
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v11 0/8] Add tpm i2c ptp driver
Message-ID: <20200622214922.GC22727@linux.intel.com>
References: <20200618134344.243537-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618134344.243537-1-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 04:43:35PM +0300, amirmizi6@gmail.com wrote:
>  - Jarkko Sakkinen:
>         https://lore.kernel.org/patchwork/patch/1252428/
>         https://lore.kernel.org/patchwork/patch/1252422/
>         https://lore.kernel.org/patchwork/patch/1252424/

Thanks for linking these, very helpful.

/Jarkko
