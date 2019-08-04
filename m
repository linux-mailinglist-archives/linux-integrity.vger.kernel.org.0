Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2886080CD6
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2019 23:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHDVpA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Aug 2019 17:45:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:4039 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfHDVo7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Aug 2019 17:44:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2019 14:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,347,1559545200"; 
   d="scan'208";a="173712234"
Received: from chenghao-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.36.2])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2019 14:44:28 -0700
Date:   Mon, 5 Aug 2019 00:44:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190804214218.vdv2sn4oc4cityy2@linux.intel.com>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711200858.xydm3wujikufxjcw@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 11:08:58PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jul 05, 2019 at 04:47:44PM -0400, Sasha Levin wrote:
> > Changes from v7:
> > 
> >  - Address Jarkko's comments.
> > 
> > Sasha Levin (2):
> >   fTPM: firmware TPM running in TEE
> >   fTPM: add documentation for ftpm driver
> > 
> >  Documentation/security/tpm/index.rst        |   1 +
> >  Documentation/security/tpm/tpm_ftpm_tee.rst |  27 ++
> >  drivers/char/tpm/Kconfig                    |   5 +
> >  drivers/char/tpm/Makefile                   |   1 +
> >  drivers/char/tpm/tpm_ftpm_tee.c             | 350 ++++++++++++++++++++
> >  drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
> >  6 files changed, 424 insertions(+)
> >  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
> >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
> >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
> > 
> > -- 
> > 2.20.1
> > 
> 
> I applied the patches now. Appreciate a lot the patience with these.
> Thank you.

Hi, can you possibly fix these:

005-tpm-tpm_ftpm_tee-A-driver-for-firmware-TPM-running-i.patch
---------------------------------------------------------------
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#10:
https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/ .

WARNING: Non-standard signature: Co-authored-by:
#18:
Co-authored-by: Sasha Levin <sashal@kernel.org>

WARNING: prefer 'help' over '---help---' for new help texts
#39: FILE: drivers/char/tpm/Kconfig:167:
+config TCG_FTPM_TEE

WARNING: please write a paragraph that describes the config symbol fully
#39: FILE: drivers/char/tpm/Kconfig:167:
+config TCG_FTPM_TEE

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#57:
new file mode 100644

WARNING: please, no space before tabs
#102: FILE: drivers/char/tpm/tpm_ftpm_tee.c:41:
+ * ^IIn case of success the number of bytes received.$

WARNING: please, no space before tabs
#131: FILE: drivers/char/tpm/tpm_ftpm_tee.c:70:
+ * ^IIn case of success, returns 0.$

WARNING: please, no space before tabs
#276: FILE: drivers/char/tpm/tpm_ftpm_tee.c:215:
+ * ^IOn success, 0. On failure, -errno.$

WARNING: please, no space before tabs
#366: FILE: drivers/char/tpm/tpm_ftpm_tee.c:305:
+ * ^I0 always.$

ERROR: code indent should use tabs where possible
#387: FILE: drivers/char/tpm/tpm_ftpm_tee.c:326:
+        /* memory allocated with devm_kzalloc() is freed automatically */$

WARNING: DT compatible string "microsoft,ftpm" appears un-documented -- check ./Documentation/devicetree/bindings/
#393: FILE: drivers/char/tpm/tpm_ftpm_tee.c:332:
+	{ .compatible = "microsoft,ftpm" },

WARNING: DT compatible string vendor "microsoft" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#393: FILE: drivers/char/tpm/tpm_ftpm_tee.c:332:
+	{ .compatible = "microsoft,ftpm" },

total: 1 errors, 11 warnings, 405 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

I temporarily dropped the patches but can apply them once the issues
are fixed.

/Jarkko
