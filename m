Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B5826A1B6
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Sep 2020 11:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIOJJ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Sep 2020 05:09:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:37789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOJJ6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Sep 2020 05:09:58 -0400
IronPort-SDR: 1HvWKyEPmSJ40zRoYeycI+Zj7SqsCt8sdQZskuizJhK9tP+rtf1SozpS2sw6iga3b2KtZ9f81q
 JBvwI7yA56Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146967076"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="146967076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 02:09:56 -0700
IronPort-SDR: wppjluMxy0S5Wx5Ey4/7QgSn3ZnEEcFahxfF0jvcDA+rGIJaC5PWOQAvJz+wqU85rpiXBSkqR+
 WPfndzIvt1eA==
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="451228991"
Received: from blank-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.208])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 02:09:52 -0700
Date:   Tue, 15 Sep 2020 12:09:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v11 3/5] security: keys: trusted: fix TPM2 authorizations
Message-ID: <20200915090950.GB3612@linux.intel.com>
References: <20200912172643.9063-1-James.Bottomley@HansenPartnership.com>
 <20200912172643.9063-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912172643.9063-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Sep 12, 2020 at 10:26:41AM -0700, James Bottomley wrote:
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
> keyctl add trusted kmk "new 32 blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> 
> after we will accept both the old hex sha1 form as well as a new
> directly supplied password:
> 
> keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> 
> Since a sha1 hex code must be exactly 40 bytes long and a direct
> password must be 20 or less, we use the length as the discriminator
> for which form is input.
> 
> Note this is both and enhancement and a potential bug fix.  The TPM
> 2.0 spec requires us to strip leading zeros, meaning empyty
> authorization is a zero length HMAC whereas we're currently passing in
> 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
> makes the Microsoft TPM emulator work with trusted keys.
> 
> Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0 chips")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I created a key:

$ sudo ./tpm2-root-key
0x80000000
$ sudo ./tpm2-list-handles
0x80000000
$ keyctl add trusted kmk "new 32 blobauth=hello keyhandle=0x80000000"
<keyctl usage>
$ lsmod
Module                  Size  Used by
sha1_generic           16384  2
trusted                32768  0
asn1_encoder           16384  1 trusted
x86_pkg_temp_thermal    20480  0
iwlmvm                356352  0
iwlwifi               315392  1 iwlmvm
tpm_crb                16384  0
tpm_tis                16384  0
tpm_tis_core           24576  1 tpm_tis
tpm                    61440  4 tpm_tis,trusted,tpm_crb,tpm_tis_core
efivarfs               16384  1

What could be wrong? Have the full seris applied on a test kernel.

The root key creation is contained in create_root_key():

https://github.com/jsakkine-intel/tpm2-scripts/blob/master/tpm2.py

/Jarkko
