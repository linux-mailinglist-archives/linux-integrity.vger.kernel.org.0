Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B34E7A89
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2019 21:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfJ1UxS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Oct 2019 16:53:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:43583 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJ1UxR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Oct 2019 16:53:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 13:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="205279169"
Received: from shrehore-mobl1.ti.intel.com (HELO localhost) ([10.251.82.5])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 13:53:14 -0700
Date:   Mon, 28 Oct 2019 22:53:13 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191028205313.GH8279@linux.intel.com>
References: <20191025193103.30226-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025193103.30226-1-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar wrote:
> +	return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
> +		       ? "2.0" : "1.2");

This is not right. Should be either "1" or "2".

/Jarkko
