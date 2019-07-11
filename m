Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719666605F
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfGKUFe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 16:05:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:54951 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbfGKUFe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 16:05:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 13:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="171340904"
Received: from mmoerth-mobl6.ger.corp.intel.com (HELO localhost) ([10.249.35.82])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2019 13:05:25 -0700
Date:   Thu, 11 Jul 2019 23:05:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 2/2] fTPM: add documentation for ftpm driver
Message-ID: <20190711200523.2y6hgsyxfuui4yao@linux.intel.com>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190705204746.27543-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705204746.27543-3-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 05, 2019 at 04:47:46PM -0400, Sasha Levin wrote:
> This patch adds basic documentation to describe the new fTPM driver.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
