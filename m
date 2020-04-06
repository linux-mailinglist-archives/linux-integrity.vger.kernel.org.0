Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9C19FD27
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2020 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgDFS3H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 14:29:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:60637 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgDFS3H (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 14:29:07 -0400
IronPort-SDR: zdY2ZwOyo9enom4KOHelaPIJyTNC1sTqT302hfq6AuZnJAUvtGO2pxmqMuozJBLEU4gMhDKEnw
 9M9yLFGf7KEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 11:29:05 -0700
IronPort-SDR: Xkt7Xtn/+sHG0FniHBkUYaEK4aGrUhaQuxkz8qhNnpo04b6z/seQo7xmHzFRH2j/1mbmy15gPb
 G3wEuwtNtIFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,352,1580803200"; 
   d="scan'208";a="452163192"
Received: from yweiss1-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.159])
  by fmsmga006.fm.intel.com with ESMTP; 06 Apr 2020 11:29:00 -0700
Date:   Mon, 6 Apr 2020 21:28:59 +0300
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
Subject: Re: [PATCH v5 2/7] tpm: tpm_tis: Add check_data handle to
 tpm_tis_phy_ops in order to check data integrity
Message-ID: <20200406182859.GC20105@linux.intel.com>
References: <20200405125352.183693-1-amirmizi6@gmail.com>
 <20200405125352.183693-3-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405125352.183693-3-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Short summary could just be:

"Add check_data handle() to struct tpm_tis_phy_ops"

and leave the reasoning to the long description.

On Sun, Apr 05, 2020 at 03:53:47PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> In order to compute the crc over the data sent in lower layer
> (I2C for instance), tpm_tis_check_data() calls an operation (if available)
> to check data integrity. If data integrity cannot be verified, a retry
> attempt to save the sent/received data is implemented.

It does not. The existing code does not do that.

Also it is not clear whether the steps are from existing code or
after this commit has been applied.

/Jarkko
