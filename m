Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC30119CAE5
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Apr 2020 22:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgDBURM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 16:17:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:49357 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgDBURL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 16:17:11 -0400
IronPort-SDR: WoYS+8qKLMwoo753TKle50uWzAFDjZqrP49PNx7bb+UZ3U567sOcmRJbVDfz1Ebig3/9I1Z8Sr
 LEm+lb5SLvWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 13:17:11 -0700
IronPort-SDR: qibqd9S+az7ejxncAI8raSBbcCfwBpEuhv/Nu2BRMba++Z5SMzGaVWLlfTyJ5hOgqWZKvZdGfQ
 llSq6jQtbMQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="238650846"
Received: from hbriegel-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.39.101])
  by orsmga007.jf.intel.com with ESMTP; 02 Apr 2020 13:17:01 -0700
Date:   Thu, 2 Apr 2020 23:17:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Amir Mizinski <amirmizi6@gmail.com>
Cc:     Eyal.Cohen@nuvoton.com, Oshri Alkobi <oshrialkoby85@gmail.com>,
        Alexander Steffen <alexander.steffen@infineon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>,
        Tomer Maimon <tmaimon77@gmail.com>, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, IS30 Dan Morav <Dan.Morav@nuvoton.com>,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com,
        Christophe Richard <hristophe-h.ricard@st.com>
Subject: Re: [PATCH v4 2/7] tpm: tpm_tis: Add check_data handle to
 tpm_tis_phy_ops in order to check data integrity
Message-ID: <20200402201700.GG10314@linux.intel.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-3-amirmizi6@gmail.com>
 <20200401082019.GB17325@linux.intel.com>
 <CAMHTsUUvStPHNL-W7vtjGrtehQx22jUZbN8kLib4h+JWH3p7_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMHTsUUvStPHNL-W7vtjGrtehQx22jUZbN8kLib4h+JWH3p7_w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 01, 2020 at 12:19:39PM +0300, Amir Mizinski wrote:
>    this commit is based on Christophe work and was submitted in 2016:
>    https://patchwork.kernel.org/patch/8628661/
>    I followed you comments from the previous version on commit 1/7:
>    https://lore.kernel.org/patchwork/patch/1192101/
>    and fixed it in this one too. should i write it differently?
>    thank you,
>    Amir Mizinski

No then it's correct thanks. Just wanted to verify.

Please configure your email client:

https://www.kernel.org/doc/html/v4.10/process/email-clients.html

/Jarkko
