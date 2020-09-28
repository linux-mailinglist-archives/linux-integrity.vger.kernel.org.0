Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4543027A511
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 03:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI1BIi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 21:08:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:22624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgI1BIi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 21:08:38 -0400
IronPort-SDR: GcTR+sW+pxuABLkl0shx+uaqUjVpwWvrUDvucwCB1ycTzUnN7LtwygbxfNDPzuNj8Cd/6wEdrb
 eNN2Cw0Tk/dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="226072036"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="226072036"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:08:37 -0700
IronPort-SDR: phkIfXwF+q7AxoOv7Bo+mL7Se/Nz8tsqPkmHIteD+GJJXtMc+TbxqM5gGgImWwfc91UpP8KW6M
 nMeI/UC2fFCQ==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488357231"
Received: from memara-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:08:33 -0700
Date:   Mon, 28 Sep 2020 04:08:35 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc:     Hao Wu <hao.wu@rubrik.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20200928010835.GD6704@linux.intel.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 27, 2020 at 11:25:39AM -0700, James Bottomley wrote:
> On Sat, 2020-09-26 at 16:10 -0700, Hao Wu wrote:
> > Resending following email in plaintext.
> > 
> > ----
> > 
> > Hi James,
> > 
> > Thanks for following up.
> > 
> > We have actually tried change 
> > TPM_TIMEOUT_USECS_MIN / TPM_TIMEOUT_USECS_MAX 
> > according to https://patchwork.kernel.org/patch/10520247/
> > It does not solve the problem for ATMEL chip. The chips facing crash
> > is 
> > not experimental, but happens commonly in 
> > the production systems we and our customers are using.
> > It is widely found in Cisco 220 / 240 systems which are using
> > Ateml chips.
> 
> Well, I came up with the values in that patch by trial and error ....
> all I know is they work for my nuvoton. If they're not right for you,
> see if you can find what values actually do work for your TPM.  The
> difference between msleep and usleep_range is that the former can have
> an indefinitely long timeout and the latter has a range bounded one. 
> If you think msleep works for you, the chances are it doesn't and
> you're relying on the large upper bound to make the bug infrequent
> enough for you not to see it.  Playing with the values in usleep range
> will help you find what the actual timeout is and eliminate the problem
> for good.
> 
> James

I think I should revert 424eaf910c329, up until more legit values are found.

/Jarkko
