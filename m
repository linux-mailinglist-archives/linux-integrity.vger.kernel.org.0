Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0075F8012B
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406192AbfHBTmc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 15:42:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:1619 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405999AbfHBTmc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 15:42:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 12:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="201767232"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2019 12:42:27 -0700
Date:   Fri, 2 Aug 2019 22:42:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
 <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
 <20190802142721.GA26616@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802142721.GA26616@elm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 02, 2019 at 09:27:22AM -0500, Tyler Hicks wrote:
> On 2019-08-02 10:21:16, Roberto Sassu wrote:
> > On 8/1/2019 6:32 PM, Jarkko Sakkinen wrote:
> > > On Mon, Jul 15, 2019 at 06:44:28PM +0200, Roberto Sassu wrote:
> > > > According to the bug report at https://bugs.archlinux.org/task/62678,
> > > > the trusted module is a dependency of the ecryptfs module. We should
> > > > load the trusted module even if the TPM is inactive or deactivated.
> > > > 
> > > > Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
> > > > "get random"") changes the return code of tpm_get_random(), the patch
> > > > should be modified to ignore the -EIO error. I will send a new version.
> > > 
> > > Do you have information where this dependency comes from?
> > 
> > ecryptfs retrieves the encryption key from encrypted keys (see
> > ecryptfs_get_encrypted_key()).
> 
> That has been there for many years with any problems. It was added
> in 2011:
> 
>  commit 1252cc3b232e582e887623dc5f70979418caaaa2
>  Author: Roberto Sassu <roberto.sassu@polito.it>
>  Date:   Mon Jun 27 13:45:45 2011 +0200
> 
>      eCryptfs: added support for the encrypted key type
> 
> What's recently changed the situation is this patch:
> 
>  commit 240730437deb213a58915830884e1a99045624dc
>  Author: Roberto Sassu <roberto.sassu@huawei.com>
>  Date:   Wed Feb 6 17:24:51 2019 +0100
> 
>      KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()
> 
> Now eCryptfs has a hard dependency on a TPM chip that's working
> as expected even if eCryptfs (or the rest of the system) isn't utilizing
> the TPM. If the TPM behaves unexpectedly, you can't access your files.
> We need to get this straightened out soon.

I agree with this conclusion that eCryptfs needs to be fixed, not
another workaround to trusted.ko.

/Jarkko
