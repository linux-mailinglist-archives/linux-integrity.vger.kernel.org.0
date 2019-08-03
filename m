Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB6806C9
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2019 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfHCOop (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 3 Aug 2019 10:44:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:31834 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHCOop (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 3 Aug 2019 10:44:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2019 07:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,342,1559545200"; 
   d="scan'208";a="164212471"
Received: from xinpan-mobl1.ger.corp.intel.com ([10.249.33.239])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2019 07:44:39 -0700
Message-ID: <aff3502c598fb76a1517795edaacd8c8ea330051.camel@linux.intel.com>
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Date:   Sat, 03 Aug 2019 17:44:37 +0300
In-Reply-To: <20190802202343.GE26616@elm>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
         <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
         <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
         <20190801163215.mfkagoafkxscesne@linux.intel.com>
         <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
         <20190802142721.GA26616@elm>
         <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
         <20190802202343.GE26616@elm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-08-02 at 15:23 -0500, Tyler Hicks wrote:
> That wasn't the conclusion that I came to. I prefer Robert's proposed
> change to trusted.ko.
> 
> How do you propose that this be fixed in eCryptfs?
> 
> Removing encrypted_key support from eCryptfs is the only way that I can
> see to fix the bug in eCryptfs. That support has been there since 2011.
> I'm not sure of the number of users that would be broken by removing
> encrypted_key support. I don't think the number is high but I can't say
> that confidently.

Looking at the documentation [1] it is stated that

"Encrypted keys do not depend on a TPM, and are faster, as they use AES
for encryption/decryption."

Why would you need to remove support for encrypted keys? Isn't it a
regression in encrypted keys to hard depend on trusted keys given
what the documentation says?

> Roberto, what was your use case when you added encrypted_key support to
> eCryptfs back then? Are you aware of any users of eCryptfs +
> encrypted_keys?
> 
> Jarkko, removing a long-standing feature is potentially more disruptive
> to users than adding a workaround to trusted.ko which already requires a
> similar workaround. I don't think that I agree with you on the proper
> fix here.

There is nothing to disagree or agree. I just try to get the picture
since ecryptfs is relatively alien to me.

[1] https://www.kernel.org/doc/html/v4.13/security/keys/trusted-encrypted.html

/Jarkko

