Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9C58F6B3
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Aug 2019 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfHOV5n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Aug 2019 17:57:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:51213 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730803AbfHOV5n (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Aug 2019 17:57:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 14:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="171234679"
Received: from schuberw-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.145])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 14:57:14 -0700
Date:   Fri, 16 Aug 2019 00:57:12 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-ID: <20190815215712.tho3fdfk43rs45ej@linux.intel.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
 <7152d1c2-14bc-87ae-618b-830a1fa008b0@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7152d1c2-14bc-87ae-618b-830a1fa008b0@linux.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 13, 2019 at 09:57:59AM +0300, Denis Efremov wrote:
> Hi All,
> 
> Initially, I've prepared a patch and only after found this discussion. So, please,
> look at this patch no more than just a simple reminder that get_maintainers.pl
> still emits this warning.

Can you resend this as a proper patch that can be applied. No other
complains.

/Jarkko
