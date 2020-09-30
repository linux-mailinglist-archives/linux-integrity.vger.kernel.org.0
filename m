Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5D27E796
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI3LYt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 07:24:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:34414 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3LYt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 07:24:49 -0400
IronPort-SDR: DUX6MuxePhqayVLFxLV0IiKB/R5QDGGaLF4vnFlIhwggu8geEZfIR+v9FSnjkGTLjObL74xZEq
 H/dVJN+KQAAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="247152243"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="247152243"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 04:24:48 -0700
IronPort-SDR: kJD3HtYmUgsrsqkx4RpK+1IrJVQraGCs8QdKc+Ka7jwri+kDt7A0MhpvOeiy5QBRJI5Kt13mh6
 g4THvChePu2g==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="497076174"
Received: from lbentzio-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.88])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 04:24:46 -0700
Date:   Wed, 30 Sep 2020 14:24:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v13 5/5] security: keys: trusted: Make sealed key
 properly interoperable
Message-ID: <20200930112444.GC5145@linux.intel.com>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
 <20200922022809.7105-6-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922022809.7105-6-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 21, 2020 at 07:28:09PM -0700, James Bottomley wrote:
> The current implementation appends a migratable flag to the end of a
> key, meaning the format isn't exactly interoperable because the using
> party needs to know to strip this extra byte.  However, all other
> consumers of TPM sealed blobs expect the unseal to return exactly the
> key.  Since TPM2 keys have a key property flag that corresponds to
> migratable, use that flag instead and make the actual key the only
> sealed quantity.  This is secure because the key properties are bound
> to a hash in the private part, so if they're altered the key won't
> load.
> 
> Backwards compatibility is implemented by detecting whether we're
> loading a new format key or not and correctly setting migratable from
> the last byte of old format keys.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

➜  tpm2-scripts (master) ✗ sudo keyctl add trusted kmk2 "new 32 blobauth=world keyhandle=80000000 migratable=1" @u
add_key: Invalid argument
➜  tpm2-scripts (master) ✗ sudo keyctl add trusted kmk2 "new 32 blobauth=world keyhandle=80000000 migratable=0" @u
608433517

Showed the -EINVAL example just to point out this:

	case Opt_migratable:
		if (*args[0].from == '0')
			pay->migratable = 0;
		else
			return -EINVAL;
		break;

I think it should just set migratable in both cases even if no-op,
given that it takes the value and also the documentation says that
"migratable=1" is legit:

"migratable=   0|1 indicating permission to reseal to new PCR values,
                default 1 (resealing allowed)"

Obviously not a concern of this patch but this is still IMHO a bug.
Would be nce if you could drop a prepending patch to fix this, when you
rebase the series, with this fixes tag:

Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")

BTW, please check my fixes so that I can push them ASAP and you get to
rebase this and we can land it. Now everything is properly tested.

/Jarkko
