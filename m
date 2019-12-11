Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BEA11BACC
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 18:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfLKR6K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 12:58:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:46936 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbfLKR6K (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 12:58:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 09:58:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="225618649"
Received: from cmclough-mobl.ger.corp.intel.com (HELO localhost) ([10.251.85.152])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2019 09:58:07 -0800
Date:   Wed, 11 Dec 2019 19:58:05 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: selftests: cleanup after unseal with wrong policy
 test
Message-ID: <20191211175805.GL4516@linux.intel.com>
References: <157601492070.15343.464606544465753590.stgit@tstruk-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157601492070.15343.464606544465753590.stgit@tstruk-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 10, 2019 at 01:55:20PM -0800, Tadeusz Struk wrote:
> Unseal with wrong policy tests affects DA lockout and eventually
> causes to fail with:
> "ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921",
> when the test runs multiple times. Send tpm clear command
> after the test to reset the DA counters.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

You could pick this also to the same patch set.

/Jarkko
