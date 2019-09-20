Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F202B9181
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbfITOSa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Sep 2019 10:18:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:35096 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387773AbfITOSa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Sep 2019 10:18:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2019 07:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,528,1559545200"; 
   d="scan'208";a="194706214"
Received: from eergin-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.12])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2019 07:18:27 -0700
Date:   Fri, 20 Sep 2019 17:18:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 02/12] tpm-buf: add handling for TPM2B types
Message-ID: <20190920141826.GC9578@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
 <1568031515.6613.31.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568031515.6613.31.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 01:18:35PM +0100, James Bottomley wrote:
> Most complex TPM commands require appending TPM2B buffers to the
> command body.  Since TPM2B types are essentially variable size arrays,
> it makes it impossible to represent these complex command arguments as
> structures and we simply have to build them up using append primitives
> like these.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

I think a better idea would be to have headerless TPM buffers and also
it makes sense to have a separate length field in the struct to keep the
code sane given that sometimes the buffer does not store the length.

E.g.

enum tpm_buf_flags {
	TPM_BUF_OVERFLOW	= BIT(0),
	TPM_BUF_HEADERLESS	= BIT(1),
};

struct tpm_buf {
	unsigned int length;
	struct page *data_page;
	unsigned int flags;
	u8 *data;
};

/Jarkko
