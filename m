Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9A6394D
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2019 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGIQZG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jul 2019 12:25:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:50005 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIQZG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jul 2019 12:25:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 09:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="364638749"
Received: from mmaitert-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.34.54])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2019 09:24:59 -0700
Date:   Tue, 9 Jul 2019 19:24:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        tyhicks@canonical.com, nayna@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190709162458.f4fjteokcmidv7w6@linux.intel.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <1562618099.20748.13.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562618099.20748.13.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 08, 2019 at 01:34:59PM -0700, James Bottomley wrote:
> Not a criticism of your patch, but can we please stop doing this. 
> Single random number sources are horrendously bad practice because it
> gives an attacker a single target to subvert.  We should ensure the TPM
> is plugged into the kernel RNG as a source and then take randomness
> from the mixed pool so it's harder for an attacker because they have to
> subvert all our sources to predict what came out.

It is and I agree.

/Jarkko
