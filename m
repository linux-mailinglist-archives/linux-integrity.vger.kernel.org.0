Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3377F8011F
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 21:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406035AbfHBTkV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 15:40:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:16762 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403792AbfHBTkV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 15:40:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 12:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="201765804"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2019 12:40:16 -0700
Date:   Fri, 2 Aug 2019 22:40:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        tyhicks@canonical.com, nayna@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190802194015.btthaf5ey4n64tzt@linux.intel.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
 <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 02, 2019 at 10:21:16AM +0200, Roberto Sassu wrote:
> On 8/1/2019 6:32 PM, Jarkko Sakkinen wrote:
> > On Mon, Jul 15, 2019 at 06:44:28PM +0200, Roberto Sassu wrote:
> > > According to the bug report at https://bugs.archlinux.org/task/62678,
> > > the trusted module is a dependency of the ecryptfs module. We should
> > > load the trusted module even if the TPM is inactive or deactivated.
> > > 
> > > Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
> > > "get random"") changes the return code of tpm_get_random(), the patch
> > > should be modified to ignore the -EIO error. I will send a new version.
> > 
> > Do you have information where this dependency comes from?
> 
> ecryptfs retrieves the encryption key from encrypted keys (see
> ecryptfs_get_encrypted_key()).

So... what is preventing removing this requirement "in the source"?

/Jarkko
