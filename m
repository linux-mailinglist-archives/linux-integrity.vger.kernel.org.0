Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA927818A
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 09:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgIYH2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 03:28:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:12164 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYH2e (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 03:28:34 -0400
IronPort-SDR: MFgZD3nf7bbcN+n1X5MIEE06U+qBnpOa3WZ5Xs4wyttqQ5MyUrSVYiirjI/59193dcBlYynvkw
 MtFsaJ/lDA7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="225604546"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="225604546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 00:28:33 -0700
IronPort-SDR: I6pBUfQhZtJrH/ezp8atgpyz3LUTLntAd+FtNIS14S4J5gCLAh1sfVjQyEkuSxTilN7Qd01dhN
 623hYXFIxldQ==
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="487357963"
Received: from zzombora-mobl1.ti.intel.com (HELO localhost) ([10.249.32.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 00:28:32 -0700
Date:   Fri, 25 Sep 2020 10:28:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v13 3/5] security: keys: trusted: fix TPM2 authorizations
Message-ID: <20200925072829.GA170658@linux.intel.com>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
 <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 21, 2020 at 07:28:07PM -0700, James Bottomley wrote:
> In TPM 1.2 an authorization was a 20 byte number.  The spec actually
> recommended you to hash variable length passwords and use the sha1
> hash as the authorization.  Because the spec doesn't require this
> hashing, the current authorization for trusted keys is a 40 digit hex
> number.  For TPM 2.0 the spec allows the passing in of variable length
> passwords and passphrases directly, so we should allow that in trusted
> keys for ease of use.  Update the 'blobauth' parameter to take this
> into account, so we can now use plain text passwords for the keys.
> 
> so before
> 
> keyctl add trusted kmk "new 32 blobauth=f572d396fae9206628714fb2ce00f72e94f2258fkeyhandle=81000001" @u
> 
> after we will accept both the old hex sha1 form as well as a new
> directly supplied password:
> 
> keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001" @u

I'm still getting -EINVAL from both with a Geminilake NUC.

/Jarkko
