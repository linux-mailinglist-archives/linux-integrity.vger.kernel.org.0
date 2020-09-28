Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7566027AFCF
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgI1OQR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 10:16:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:54532 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1OQQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 10:16:16 -0400
IronPort-SDR: rjUu92lA+djZnfzEAs01y5BaCGaCYBTPB7B9sCzpV3vyUbbd/nsIzeKZkuzSTRN95Br/6pfQhW
 9FPI4EaWXY3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="246740439"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="246740439"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 07:16:16 -0700
IronPort-SDR: Y1N4FP+h9NfmFZLps4jLAQPrnr9h6SrT7eQcEYcOxqlRlOFq/MNOy4nUBwbyfAvF3u67uT4Td+
 GmahZ5rKr2eQ==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488597261"
Received: from schuethe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.34.214])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 07:16:12 -0700
Date:   Mon, 28 Sep 2020 17:16:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20200928141613.GB70098@linux.intel.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <20200928010835.GD6704@linux.intel.com>
 <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 27, 2020 at 11:03:47PM -0700, Hao Wu wrote:
> Hi Jarkko,
> 
> Just to be clear it is not caused by that single commit, but a few accumulated commits
> https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3
> https://github.com/torvalds/linux/commit/cf151a9a44d52a63332e8e926234574fe5a5d784
> https://github.com/torvalds/linux/commit/59f5a6b07f6434efac0057dc2f303a96b871811b
> https://github.com/torvalds/linux/commit/424eaf910c329ab06ad03a527ef45dcf6a328f00
> 
> The easy way is probably just apply the patch I provided, and then revisit the value
> for TPM_TIMEOUT_WAIT_STAT  

When you response, please quote properly, and do not top post.  The
discussion is impossible to follow this way.

I'm not sure if I buy that. Which one is the first failing commit?

/Jarkko
