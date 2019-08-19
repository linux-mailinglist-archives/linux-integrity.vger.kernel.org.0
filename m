Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37B694B21
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfHSRAX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 13:00:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:11836 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfHSRAX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 13:00:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 09:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="207060383"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2019 09:44:57 -0700
Date:   Mon, 19 Aug 2019 19:44:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, mark.rutland@arm.com, robh+dt@kernel.org,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: trivial checkpatch fixes
Message-ID: <20190819164457.extm4j4akx4mu6nl@linux.intel.com>
References: <20190813130559.16936-1-sashal@kernel.org>
 <20190815210201.yhc7dosvnafcayfu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815210201.yhc7dosvnafcayfu@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 16, 2019 at 12:02:01AM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 13, 2019 at 09:05:59AM -0400, Sasha Levin wrote:
> > Fixes a few checkpatch warnings (and ignores some), mostly around
> > spaces/tabs and documentation.
> > 
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Thank you!
> 
> I'll squash these to the existing patches.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Oops, replied this twice, sorry :-)

Anyway, I pushed the patch. I think I just keep it as separate
after all.

/Jarkko
