Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C895A339B6
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jun 2019 22:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfFCU2b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jun 2019 16:28:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:56757 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfFCU2a (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jun 2019 16:28:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 13:28:29 -0700
X-ExtLoop1: 1
Received: from jgaire-mobl.ger.corp.intel.com (HELO localhost) ([10.252.20.169])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2019 13:28:22 -0700
Date:   Mon, 3 Jun 2019 23:28:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190603202815.GA4894@linux.intel.com>
References: <20190530152758.16628-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530152758.16628-1-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 30, 2019 at 11:27:56AM -0400, Sasha Levin wrote:
> Changes since v3:
> 
>  - Address comments by Jarkko Sakkinen
>  - Address comments by Igor Opaniuk
> 
> Sasha Levin (2):
>   fTPM: firmware TPM running in TEE
>   fTPM: add documentation for ftpm driver

I think patches start to look proper but I wonder can anyone test
these? I don't think before that I can merge these.

/Jarkko
