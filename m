Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892E1D60D3
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2020 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEPMdd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 16 May 2020 08:33:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:33972 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgEPMdc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 16 May 2020 08:33:32 -0400
IronPort-SDR: mUqFaj6YxFdLzdig8qLDPsS2LUAlsxe+nMho56TIq0PHsDV1DKP7zLj2/O3U3n7chf36rcXTZa
 3Bsct9cENkSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 05:33:32 -0700
IronPort-SDR: mcSXwHlWA3pXNUL5dfpg1hBlN39nYtjOFCNXmy5IuCWMKKWtGaM2fG13DMao5752b5FWGfXx6y
 e59RoNv2NFAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="410754136"
Received: from ebutchex-mobl1.ger.corp.intel.com ([10.249.40.79])
  by orsmga004.jf.intel.com with ESMTP; 16 May 2020 05:33:28 -0700
Message-ID: <4d2ff03c7869b5f5ba5c84da6720078628040980.camel@linux.intel.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
In-Reply-To: <20200515191758.ieojyk5xhsx2hzzd@cantor>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Sat, 16 May 2020 15:33:22 +0300
User-Agent: Evolution 3.36.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 12:17 -0700, Jerry Snitselaar wrote:
> > > > sudo ./keyctl-smoke.sh
> > > > 566201053 (0x80000000)
> > > > keyctl_read_alloc: Permission denied
> 
> I get keyctl_read_alloc -EPERM when I 'sudo su' and try to play with keyctl print.
> If I 'sudo su -' and then try it works as expected. Also works for normal user.

Can confirm these results with NUC7PJYH (Gemini Lake).

/Jarkko

