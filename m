Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA91FD9E5
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 01:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFQXoL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 19:44:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:39678 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFQXoH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 19:44:07 -0400
IronPort-SDR: AvTPPGByuqnA65am31NlFwtkwh0cx/gLga4P9bh8R7YMoQVtx/8U6/MqeWBYW1vv2sVhTPoQud
 ZJwVug+EPjBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:44:06 -0700
IronPort-SDR: 2x2iZFF+yjEvYM++mNHnNcCnNoPvKYiu2uwsw/UvcL2qvOY4PWoNaSFgzIMiZAABiWT3ZbHUNG
 fUzdQLHifuCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,524,1583222400"; 
   d="scan'208";a="317670794"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2020 16:44:04 -0700
Date:   Thu, 18 Jun 2020 02:44:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 6/8] security: keys: trusted: add PCR policy to TPM2
 keys
Message-ID: <20200617234403.GK62794@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-7-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616160229.8018-7-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 16, 2020 at 09:02:27AM -0700, James Bottomley wrote:
> This commit adds the ability to specify a PCR lock policy to TPM2
> keys.  There is a complexity in that the creator of the key must chose
> either to use a PCR lock policy or to use authentication.  At the
> current time they can't use both due to a complexity with the way
> authentication works when policy registers are in use.  The way to
> construct a pcrinfo statement for a key is simply to use the
> TPMS_PCR_SELECT structure to specify the PCRs and follow this by a
> hash of all their values in order of ascending PCR number.
> 
> For simplicity, we require the policy name hash and the hash used for
> the PCRs to be the same.  Thus to construct a policy around the value
> of the resettable PCR 16 using the sha1 bank, first reset the pcr to
> zero giving a hash of all zeros as:
> 
> 6768033e216468247bd031a0a2d9876d79818f8f
> 
> Then the TPMS_PCR_SELECT value for PCR 16 is
> 
> 03000001
> 
> So create a new 32 byte key with a policy policy locking the key to
> this value of PCR 16 with a parent key of 81000001 would be:
> 
> keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 pcrinfo=030000016768033e216468247bd031a0a2d9876d79818f8f" @u
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Policy stuff definitely should be a follow up and not part of the same
patch set. Too many decisions to make. 

/Jarkko
