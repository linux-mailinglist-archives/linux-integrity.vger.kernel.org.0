Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED4D18600F
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Mar 2020 22:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgCOVcz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Mar 2020 17:32:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:61462 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgCOVcz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Mar 2020 17:32:55 -0400
IronPort-SDR: B+34pgH3LFrNzyvCTPtmJ6rkhbIVmRUrwa6TIWv2OtT77T+MGQnk5jFbTnbsUfYr8GRQtjsuTH
 SOfzFKI9NYew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 14:32:54 -0700
IronPort-SDR: TrK/OBbbo2SS27DbEO5B+xBXL4aYlz0x6ARhVedaFludoKk+waMQQu51KAcrpTdC0fBhLL1Tf+
 rnsRmDviZR/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,557,1574150400"; 
   d="scan'208";a="443089525"
Received: from babayass-mobl.ger.corp.intel.com (HELO localhost) ([10.249.90.210])
  by fmsmga005.fm.intel.com with ESMTP; 15 Mar 2020 14:32:47 -0700
Date:   Sun, 15 Mar 2020 23:32:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v3 2/3] KEYS: Avoid false positive ENOMEM error on key
 read
Message-ID: <20200315213245.GF224162@linux.intel.com>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313152102.1707-3-longman@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 13, 2020 at 11:21:01AM -0400, Waiman Long wrote:
> -		 * Read methods will just return the required length
> -		 * without any copying if the provided length isn't big
> -		 * enough.
> +		 * We don't want an erronous -ENOMEM error due to an
> +		 * arbitrary large user-supplied buflen. So if buflen
> +		 * exceeds a threshold (1024 bytes in this case), we call
> +		 * the read method twice. The first time to get the buffer
> +		 * length and the second time to read out the key data.
> +		 *
> +		 * N.B. All the read methods will return the required
> +		 *      buffer length with a NULL input buffer or when
> +		 *      the input buffer length isn't large enough.
>  		 */
> +		if (buflen <= 0x400) {

1. The overwhelmingly long comment. Will be destined to rotten.
2. Magic number.
3. The cap must be updated both in comment and code, and not only
   that, but the numbers use a different base (dec and hex).

/Jarkko
