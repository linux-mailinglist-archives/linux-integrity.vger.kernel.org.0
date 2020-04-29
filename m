Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3081BD407
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2020 07:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgD2FfC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Apr 2020 01:35:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:35181 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgD2FfC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Apr 2020 01:35:02 -0400
IronPort-SDR: kNeYML+CgPmBvsKrf/YqwwXOx4P0sxfx6coHVdw9bBC5CLhG5xB+giOa26F0rCsAO9kRTznB+c
 tt06wcG4FOOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 22:35:02 -0700
IronPort-SDR: s4NeAsRyeeP97mDZ/cj5n+fyYS8RyKuJv8U22zVY0vAzjI97LbdSn1TmcX06rXG7jPOXmHfYEA
 6FGq/3el5u7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="459064698"
Received: from ramibuso-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.170])
  by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2020 22:34:54 -0700
Date:   Wed, 29 Apr 2020 08:34:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        oshri.alkoby@nuvoton.com, tmaimon77@gmail.com, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com,
        Christophe Ricard <christophe-h.ricard@st.com>
Subject: Re: [PATCH v7 2/7] tpm: tpm_tis: Add verify_data_integrity handle
 toy tpm_tis_phy_ops
Message-ID: <20200429053456.GE8452@linux.intel.com>
References: <20200427124931.115697-1-amirmizi6@gmail.com>
 <20200427124931.115697-3-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427124931.115697-3-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 27, 2020 at 03:49:26PM +0300, amirmizi6@gmail.com wrote:
> +	bool (*verify_data_integrity)(struct tpm_tis_data *data, const u8 *buf,
> +				      size_t len);

Why can't the i2c driver verify this in the end of read_bytes()?

/Jarkko
