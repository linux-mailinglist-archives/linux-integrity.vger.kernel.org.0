Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4318C0E6
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 20:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgCST5L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 15:57:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:56698 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCST5L (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 15:57:11 -0400
IronPort-SDR: 70t+rRgQ0gRX8033IMgRnL7n/TrG5r9SqX4DQbPVAbailJtARnsfjsA6s07Z88yqgYzqudeq4I
 6Rbg5kwOhRiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 12:57:11 -0700
IronPort-SDR: /RO8zDtskTWdCQ5+WrYrGCM8WonO4Os2xkF5eC492U4btv5+VJWy+wvL96H2ug3FNEtQtK6EB5
 I9mFDlgdfCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="418468178"
Received: from oamor-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.182.181])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2020 12:57:07 -0700
Date:   Thu, 19 Mar 2020 21:57:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sachinp@linux.vnet.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2] qtpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm
 driver as module
Message-ID: <20200319195706.GD24804@linux.intel.com>
References: <20200319010017.738677-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319010017.738677-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 18, 2020 at 09:00:17PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This patch fixes the following problem when the ibmvtpm driver
> is built as a module:
> 
> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> make: *** [Makefile:1298: modules] Error 2
> 
> Fixes: 18b3670d79ae ("tpm: ibmvtpm: Add support for TPM2")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Should have "tpm:" tag in the short summary.

/Jarkko
