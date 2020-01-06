Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6D131AB0
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 22:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFVsL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 16:48:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:22927 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAFVsL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 16:48:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 13:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="215324277"
Received: from ryanchev-mobl.ger.corp.intel.com ([10.252.23.147])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2020 13:48:08 -0800
Message-ID: <b17b2aca2a56be2aace6479e40b763e4ec176d3d.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/9] security: keys: trusted fix tpm2 authorizations
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 06 Jan 2020 23:48:07 +0200
In-Reply-To: <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-4-James.Bottomley@HansenPartnership.com>
         <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-06 at 23:45 +0200, Jarkko Sakkinen wrote:
> On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:
> > In TPM 1.2 an authorization was a 20 byte number.  The spec actually
> > recommended you to hash variable length passwords and use the sha1
> > hash as the authorization.  Because the spec doesn't require this
> > hashing, the current authorization for trusted keys is a 40 digit hex
> > number.  For TPM 2.0 the spec allows the passing in of variable length
> > passwords and passphrases directly, so we should allow that in trusted
> > keys for ease of use.  Update the 'blobauth' parameter to take this
> > into account, so we can now use plain text passwords for the keys.
> > 
> > so before
> > 
> > keyctl add trusted kmk "new 32 blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> > 
> > after:
> > 
> > keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> > 
> > Note this is both and enhancement and a potential bug fix.  The TPM
> > 2.0 spec requires us to strip leading zeros, meaning empyty
> > authorization is a zero length HMAC whereas we're currently passing in
> > 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> > Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
> > makes the Microsoft TPM emulator work with trusted keys.
> 
> Even if for good reasons, you should be explicit when you make an API
> change that is not backwards compatible.

Also you have illformed abbrevation in your short summary. Should
be TPM2, not tpm2.

/Jarkko

