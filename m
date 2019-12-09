Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB891177D0
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 21:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLIUxI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 15:53:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:10294 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfLIUxI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 15:53:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 12:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="215206749"
Received: from nshalmon-mobl.ger.corp.intel.com (HELO localhost) ([10.252.8.146])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2019 12:20:26 -0800
Date:   Mon, 9 Dec 2019 22:20:24 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 0/8] Fix TPM 2.0 trusted keys
Message-ID: <20191209202024.GJ19243@linux.intel.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575781600.14069.8.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 07, 2019 at 09:06:40PM -0800, James Bottomley wrote:
> The big problem with this patch is still that we can't yet combine
> policy with authorization because that requires proper session
> handling, but at least with this rewrite it becomes possible (whereas
> it was never possible with the old external policy session code). 
> Thus, when we have the TPM 2.0 security patch upstream, we'll be able
> to use the session logic from that patch to imlement authorizations.

This essentially means that this is an RFC, not something that can be
merged at this point before whatever you mean by proper has been landed.

/Jarkko
