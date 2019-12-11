Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E886711BADB
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 18:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfLKR7S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 12:59:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:29267 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbfLKR7S (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 12:59:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 09:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="220507178"
Received: from cmclough-mobl.ger.corp.intel.com (HELO localhost) ([10.251.85.152])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2019 09:59:15 -0800
Date:   Wed, 11 Dec 2019 19:59:14 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Fix TPM 2.0 trusted keys
Message-ID: <20191211175914.GM4516@linux.intel.com>
References: <1575936272.31378.50.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575936272.31378.50.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 09, 2019 at 04:04:32PM -0800, James Bottomley wrote:
> This fixes a wide array of problems with the current TPM 2.0
> implementation of trusted keys.  Since policy based trusted keys never
> worked in the current implementation, I've rewritten the policy
> implementation to make it easier to use and so the trusted key handler
> can understand what elements of a policy are failing and why.
> 
> Apart from fixing bugs like volatile object leakage, I've changed the
> output format to use the standardised ASN.1 coding for TPM2 keys,
> meaning they should interoperate with userspace TPM2 key
> implementations.  Apart from interoperability, another advantage of the
> existing key format is that it carries all parameters like parent and
> hash with it and it is capable of carrying policy directives in a way
> that mean they're tied permanently to the key (no having to try to
> remember what the policy was and reconstruct it from userspace).  This
> actually allows us to support the TPM 1.2 commands like pcrinfo easily
> in 2.0.
> 
> The big problem with this patch is still that we can't yet combine
> policy with authorization because that requires proper session
> handling, but at least with this rewrite it becomes possible (whereas
> it was never possible with the old external policy session code). 
> Thus, when we have the TPM 2.0 security patch upstream, we'll be able
> to use the session logic from that patch to imlement authorizations.

Testing as soon as we have more urgent issues out of the table.

/Jarkko
