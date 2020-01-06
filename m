Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AF4131ADE
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 22:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgAFV6W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 16:58:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:47591 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAFV6V (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 16:58:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 13:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="422263230"
Received: from ryanchev-mobl.ger.corp.intel.com ([10.252.23.147])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2020 13:58:19 -0800
Message-ID: <482ad14deb25b1323c0079fb120fdf0ffd0724b3.camel@linux.intel.com>
Subject: Re: [PATCH v4 5/9] security: keys: trusted: Make sealed key
 properly interoperable
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 06 Jan 2020 23:58:18 +0200
In-Reply-To: <20191230173802.8731-6-James.Bottomley@HansenPartnership.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-6-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:
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

I'll stop review here as I'm now quite confident that in high-level
this going to right direction.

For remaining patches:

- Be more explict with the tools. That will also give a framework to
  easily test the patches.
- Same remarks for the code formatting as I gave to earlier.

/Jarkko

