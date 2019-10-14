Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D850D69AA
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 20:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfJNSpv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 14:45:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:47464 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbfJNSpv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 14:45:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 11:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="278953063"
Received: from kridax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.7.178])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2019 11:45:44 -0700
Date:   Mon, 14 Oct 2019 21:45:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     ivan.lazeev@gmail.com, kbuild-all@lists.01.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191014184543.GA13238@linux.intel.com>
References: <20191002201212.32395-1-ivan.lazeev@gmail.com>
 <201910141623.SRwaPnfk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910141623.SRwaPnfk%lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 14, 2019 at 04:32:20PM +0800, kbuild test robot wrote:
> Hi,
> 
> Thank you for the patch! Perhaps something to improve:

Please fix this and send v8 (with full change log).

/Jarkko
