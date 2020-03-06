Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6449417C689
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2020 20:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFTwu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Mar 2020 14:52:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:5212 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgCFTwu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Mar 2020 14:52:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 11:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="288059538"
Received: from sineadfi-mobl.ger.corp.intel.com (HELO localhost) ([10.252.15.28])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Mar 2020 11:52:48 -0800
Date:   Fri, 6 Mar 2020 21:52:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v7 3/6] security: keys: trusted: fix TPM2 authorizations
Message-ID: <20200306195247.GA11362@linux.intel.com>
References: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
 <20200305022744.12492-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305022744.12492-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 04, 2020 at 06:27:41PM -0800, James Bottomley wrote:
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

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
