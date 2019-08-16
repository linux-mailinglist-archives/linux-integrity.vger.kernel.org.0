Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D54907FF
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2019 20:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfHPS63 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Aug 2019 14:58:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:47555 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfHPS63 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Aug 2019 14:58:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 11:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="179753626"
Received: from dpalikow-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.34.140])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2019 11:58:25 -0700
Date:   Fri, 16 Aug 2019 21:58:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        Denis Kenzior <denkenz@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RESEND PATCH] MAINTAINERS: keys: Update path to trusted.h
Message-ID: <20190816185823.kjuxqfegpsywulkn@linux.intel.com>
References: <20190815215712.tho3fdfk43rs45ej@linux.intel.com>
 <20190815221200.3465-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815221200.3465-1-efremov@linux.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 16, 2019 at 01:12:00AM +0300, Denis Efremov wrote:
> Update MAINTAINERS record to reflect that trusted.h
> was moved to a different directory in commit 22447981fc05
> ("KEYS: Move trusted.h to include/keys [ver #2]").
> 
> Cc: Denis Kenzior <denkenz@gmail.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
