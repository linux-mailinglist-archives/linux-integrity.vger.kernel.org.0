Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF3C5F6C5
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 12:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGDKmd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 06:42:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:6534 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGDKmd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 06:42:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 03:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; 
   d="scan'208";a="363321423"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jul 2019 03:42:30 -0700
Message-ID: <4e3579a4d84aa7e2c80e5068eb1f7a30e17a655b.camel@linux.intel.com>
Subject: Re: Problem with the kernels trusted module on "inactive" TPM
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        CrazyT <crazyt2019+lml@gmail.com>, keyrings@vger.kernel.org
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        jejb@linux.ibm.com, zohar@linux.ibm.com
Date:   Thu, 04 Jul 2019 13:42:29 +0300
In-Reply-To: <f4b36912-0fb0-1e83-1ad2-fb1d2313c08e@huawei.com>
References: <CACnrVGfhkpsSWbCai4+5WEOhRukEr7JWDUnFdM-5D+FUyov+nQ@mail.gmail.com>
         <f4b36912-0fb0-1e83-1ad2-fb1d2313c08e@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-07-01 at 17:22 +0300, Roberto Sassu wrote:
> Adding to the discussion Jarkko (the maintainer of the trusted key) and
> the linux-integrity mailing list.

I'm a co-maintainer (added James and Mimi).

> > some people (including me) have problems with the "trusted" kernel module.
> > As a result to this also the ecryptfs-module won't load.
> > (https://bugs.archlinux.org/task/62678)
> > If you use an "inactive" TPM module, the "trusted" module won't load
> > anymore.
> > The command modprobe just responds with "Bad address".
> > The strace-command shows that init_module fails with EFAULT.
> > I believe the reason for this is that the trusted-module handles
> > inactive modules the same as active modules.
> > This results in an error.
> > 
> > For example:
> > 
https://github.com/torvalds/linux/commit/0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400#diff-c01228e6d386afb29df6aac17d9dd7abR1251
> > 
> > My guess is that init_digests(); returns EFAULT in that case.
> > The " if (!chip)" check above probably needs to check if the chip is
> > "inactive".
> > 
> > "inactive" = still visible to the system, but not functional.
> > It seems to be the default bios-setting for TPM on thinkpad.
> > (btw.: i have no clue why anybody would need something like that)
> > 
> > Sadly i have no idea how you would check for an inactive chip,else i
> > would have send a patch instead.
> > But I hope the info i wrote is enough to get it fixed by somebody.
> 
> Thanks for the report. If you see -EFAULT, tpm_get_random() is probably
> returning 0.
> 
> Jarkko, we could consider it as non-critical error, and handle it as if
> the TPM is not found. What do you think?

Not sure I get this. Wasn't the issue fixed in c78719203fc6 or is there
something missing?

/Jarkko

