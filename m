Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1FA17832D
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 20:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgCCTdG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 14:33:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:57381 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgCCTdG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 14:33:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 11:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="229044654"
Received: from fkuchars-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.236])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2020 11:33:03 -0800
Date:   Tue, 3 Mar 2020 21:33:02 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v6 3/6] security: keys: trusted: fix TPM2 authorizations
Message-ID: <20200303193302.GC5775@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302122759.5204-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 02, 2020 at 07:27:56AM -0500, James Bottomley wrote:
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

The commit message does not mention it but there limitation that you
cannot have this as a *password*:

  f572d396fae9206628714fb2ce00f72e94f2258f

The commit message should explicitly state this.

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0 chips")

Fixes should be before SOB.

/Jarkko
