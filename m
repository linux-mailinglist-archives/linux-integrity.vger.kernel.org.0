Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8F1B310B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 22:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUUUB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 16:20:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:27933 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUUUB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 16:20:01 -0400
IronPort-SDR: rnGD2QRBb4e9b0/TkV31MWiXcjnm/0nSFKsMehLEAW+KwAy7lLP7+S8rb07VI8kUF+A6cPrMcX
 /sbw+8rXhTWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 13:20:00 -0700
IronPort-SDR: zF83PQMB5Bu/G1Q5Smya91Ut3aq7rWwKdjy6MzKVxvaWgQaz4eH/A0NjJof8igOwu0tlf6cPqp
 3avSBwWxz0eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="290594508"
Received: from mnchalux-mobl2.gar.corp.intel.com (HELO localhost) ([10.252.44.234])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2020 13:19:56 -0700
Date:   Tue, 21 Apr 2020 23:19:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Amir Mizinski <amirmizi6@gmail.com>
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Christophe Ricard <christophe-h.ricard@st.com>
Subject: Re: [PATCH v6 2/7] tpm: tpm_tis: Add check_data handle to
 tpm_tis_phy_ops
Message-ID: <20200421201955.GB46589@linux.intel.com>
References: <20200407162044.168890-1-amirmizi6@gmail.com>
 <20200407162044.168890-3-amirmizi6@gmail.com>
 <20200408183324.GB33486@linux.intel.com>
 <0cfa0486-8ccb-d7d1-acf2-ca103f723b3a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cfa0486-8ccb-d7d1-acf2-ca103f723b3a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 21, 2020 at 01:34:44PM +0000, Amir Mizinski wrote:
> 
> Hello jarkko,
> I reconfigure my email client by the instructions you've sent, and
> re-responsing as you requested.
> please tell me if there are still any issues. thank you.

This is great, thanks a lot!

Easy enough to check too:

https://lore.kernel.org/linux-integrity/0cfa0486-8ccb-d7d1-acf2-ca103f723b3a@gmail.com/

It wouldn't end up to the ML if your config wasn't correct.

/Jarkko
