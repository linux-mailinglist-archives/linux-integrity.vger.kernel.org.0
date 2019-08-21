Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5279998428
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Aug 2019 21:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfHUTPj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Aug 2019 15:15:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:63593 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfHUTPi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Aug 2019 15:15:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 12:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="178597049"
Received: from kumarsh1-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.104])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2019 12:15:35 -0700
Date:   Wed, 21 Aug 2019 22:15:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH] tpm_tis: Fix interrupt probing
Message-ID: <20190821191534.m57vx4awlzlxxza2@linux.intel.com>
References: <20190820122517.2086223-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820122517.2086223-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 20, 2019 at 08:25:17AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> The interrupt probing of the TPM TIS was broken since we are trying to
> run it without an active locality and without the TPM_CHIP_FLAG_IRQ set.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Should have a fixes tag. I can add it. Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
