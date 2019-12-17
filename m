Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18C122903
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 11:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfLQKh1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 05:37:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:34647 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfLQKh0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 05:37:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 02:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="247393564"
Received: from pbroex-mobl1.ger.corp.intel.com ([10.251.85.107])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2019 02:37:22 -0800
Message-ID: <8b18bea7dc0021c618ce405f9ec4eb87b24d6db7.camel@linux.intel.com>
Subject: Re: [PATCH =v2 3/3] tpm: selftest: cleanup after unseal with wrong
 auth/policy test
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        mingo@redhat.com, jeffrin@rajagiritech.edu.in,
        linux-integrity@vger.kernel.org, will@kernel.org, peterhuewe@gmx.de
In-Reply-To: <c3bffb8c-d454-1f53-7f7e-8b65884ffaf6@intel.com>
References: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
         <157617293957.8172.1404790695313599409.stgit@tstruk-mobl1>
         <1576180263.10287.4.camel@HansenPartnership.com>
         <c3bffb8c-d454-1f53-7f7e-8b65884ffaf6@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 17 Dec 2019 12:37:18 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 12:49 -0800, Tadeusz Struk wrote:
> I can change tpm2_clear to tpm2_dictionarylockout -c if we want to make
> it foolproof. In this case we can assume that the lockout auth is empty.

Check that your fix applies cleanly to for-linus-v5.5-rc3 before you
send it [*]. I'll amend it then to the appropriate commit.

[*] git://git.infradead.org/users/jjs/linux-tpmdd.git

/Jarkko

