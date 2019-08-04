Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22F80CA4
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2019 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfHDUpZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Aug 2019 16:45:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:3654 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfHDUpZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Aug 2019 16:45:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2019 13:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,347,1559545200"; 
   d="scan'208";a="175408009"
Received: from rmohamed-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.37.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2019 13:44:57 -0700
Date:   Sun, 4 Aug 2019 23:44:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Zach Kubinski <zkubinski@xes-inc.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: A Request for your Expertise: tpm_crb: probe of MSFT0101:00
 failed with error -16
Message-ID: <20190804204400.kr4zhqalik7u64u6@linux.intel.com>
References: <504710714.386603.1564694480182.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504710714.386603.1564694480182.JavaMail.zimbra@xes-inc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

On Thu, Aug 01, 2019 at 04:21:20PM -0500, Zach Kubinski wrote:
>    Hi Jarkko,
>        I'm working on what I believe is a bug with our BIOS here at X-ES
>    which gives the following error in dmesg:
>        tpm_crb MSFT0101:00: can't request region for resource [mem
>        0x7be54000-0x7be5402f]
>        tpm_crb: probe of MSFT0101:00 failed with error -16
>        I've seen your name in many forums spanning the last couple years on
>    this
>        issue and related issues but I can't seem to find a thread that
>    accurately
>        describes and fixes the issue.
>        I wanted to reach out to see if you would be willing to help clarify a
>        thread or point me to one that could assist me in fixing this issue.
>        Currently, I believe that
>        this issue stems from the TPM attempting to allocate the Control
>        Area(CONA) in the ACPI_NVS region, shown in the e820 table, which
>    returns
>        the Linux error code -16 "EBUSY".
>        From what I read, the entire ACPI_NVS region has this flag which leads
>    me
>        to believe that there should be somewhere else to allocate the Control
>        Area.
>        I am using Linux Kernel 4-19-34 and my BIOS is UEFI Grangeville. If
>    you
>        would like any further information please let me know, I hope this
>    message
>        reaches you and I'm looking forward to hearing from you.
>        Best,
>        Zach Kubinski

I would ask you to read

https://www.kernel.org/doc/html/latest/process/email-clients.html

and then configure your email client accordingly.

Also go through this with time https://kernelnewbies.org/PatchCulture.
Especially I would suggest to read email etiquette part carefully.

Thank you.

/Jarkko
