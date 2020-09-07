Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9437925FB7F
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgIGNbq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 09:31:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:29596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbgIGNX2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 09:23:28 -0400
IronPort-SDR: lWdFpcNghMtYvWjr2HuomqevqQO0DP81y4XhFbe/hrKy92lnpGDxPJviMxmcUydDtRcrvU6VWS
 x6lQv/zrN4Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="158020682"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="158020682"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 06:23:21 -0700
IronPort-SDR: cOISopWAAgc8mM4/izFtOJUF5FBgohD1aY5j7PblMc/wYADS2EQKd+OJNg8Y/WJx3609meJtlY
 nrrPP3aO3qqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="299443791"
Received: from noezdal-mobl5.ger.corp.intel.com (HELO localhost) ([10.252.57.15])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2020 06:23:20 -0700
Date:   Mon, 7 Sep 2020 16:23:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <20200907132322.GB106839@linux.intel.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200907053824.GA279469@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907053824.GA279469@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 07, 2020 at 07:38:24AM +0200, Greg KH wrote:
> Please just use a binary blob format.  Binary sysfs files are exactly
> what this is for, you are just passing the data through the kernel from
> the hardware to userspace.
> 
> You can have 24 binary files if that makes it easier, but the existing
> format really is an abuse of sysfs.
> 
> Or use securityfs, that's fine too, but as you say, you have to write
> more code for that.
> 
> thanks,
> 
> greg k-h

I suggested this in previous round: to have a single 'pcrs' binary file
with <TPM Alg ID, blob> pairs contained.

/Jarkko
