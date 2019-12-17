Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8B1221B7
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 02:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfLQBzc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 20:55:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:25607 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfLQBzc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 20:55:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 17:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="217360620"
Received: from chauvina-mobl1.ger.corp.intel.com ([10.251.85.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2019 17:55:26 -0800
Message-ID: <bba89735e69aec88889a95d759024bead69d7e5a.camel@linux.intel.com>
Subject: Re: [PATCH =v2 2/3] tpm: selftest: add test covering async mode
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        mingo@redhat.com, jeffrin@rajagiritech.edu.in,
        linux-integrity@vger.kernel.org, will@kernel.org, peterhuewe@gmx.de
Date:   Tue, 17 Dec 2019 03:55:25 +0200
In-Reply-To: <157617293389.8172.8156104731485294664.stgit@tstruk-mobl1>
References: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
         <157617293389.8172.8156104731485294664.stgit@tstruk-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 09:48 -0800, Tadeusz Struk wrote:
> Add a test that sends a tpm cmd in an async mode.
> Currently there is a gap in test coverage with regards
> to this functionality.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

LGTM, thank you.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

