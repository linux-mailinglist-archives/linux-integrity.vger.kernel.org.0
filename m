Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C5222A5F7
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgGWDV1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 23:21:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:61274 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbgGWDV1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 23:21:27 -0400
IronPort-SDR: KNPwFgVwMdWfYqjmi5j4SZJOEMWu0dKN9etoa/muOinlJqFn6i/8MrmFPOOG7RakkwaNExfUJL
 XG1iyHNIZF4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="147953081"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="147953081"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 20:21:26 -0700
IronPort-SDR: /j3Fng3LEN5jzFpRmBckB9MOxaMUa5hg49SeyscAvDr8n0Cgw12TkZpwfW7jmAG4LOIYosgQUV
 wAB/a3hPcMEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="320502858"
Received: from aghafar1-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.58.209])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jul 2020 20:21:22 -0700
Date:   Thu, 23 Jul 2020 06:21:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/3] tpm: Put the TCPA table buf after using it
Message-ID: <20200723031900.GA47866@linux.intel.com>
References: <1594986348-52258-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594986348-52258-1-git-send-email-guohanjun@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 17, 2020 at 07:45:46PM +0800, Hanjun Guo wrote:
> The acpi_get_table() should be coupled with acpi_put_table() if
> the mapped table is not used for runtime to release the table
> mapping, put the TCPA table buf after using it.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

In a commit message you should first describe the action taken and
then the rationale of doing that e.g. "Couple acpi_get_table() with
acpi_put_table() in order to prevent a memory leak."

In addition, please put a fixes tag.

Please read the section two from the submitting patches guide:

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

Thank you.

/Jarkko
