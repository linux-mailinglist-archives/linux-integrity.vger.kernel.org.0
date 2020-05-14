Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEA1D2478
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 03:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgENBLr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 21:11:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:3479 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgENBLr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 21:11:47 -0400
IronPort-SDR: zVy8JUGXZYoiPcRIFbu8aRR8tBUy5E8srdppMWIrN9bn9U6ebbxL4AJjZv3pR+cZdufJk7QYzM
 Izg4BcMfq6GA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 18:11:46 -0700
IronPort-SDR: 2riP92HJXoTs4+2KeUluddBFfW61upoGPGWR2c4ITbdKxk75kqOiJ3x8aPmJfq455a6+2/3/8n
 x/LY9S2DSFHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="372079754"
Received: from gliber-mobl1.ger.corp.intel.com ([10.249.38.41])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2020 18:11:44 -0700
Message-ID: <00325dff8292a18212bbdaa3fd81cebee2a60bc2.camel@linux.intel.com>
Subject: Re: [PATCH v9 3/8] security: keys: trusted: fix TPM2 authorizations
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Thu, 14 May 2020 04:11:43 +0300
In-Reply-To: <20200507231147.27025-4-James.Bottomley@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <20200507231147.27025-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-07 at 16:11 -0700, James Bottomley wrote:
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

Have not checked yet the tail. Probably won't check before PR for v5.8
is out.

Just wondering would it hurt to merge everything up until this patch?


/Jarkko

