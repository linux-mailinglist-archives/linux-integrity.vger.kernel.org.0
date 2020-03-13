Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817F5183E39
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 02:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCMBEh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Mar 2020 21:04:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:58736 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCMBEh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Mar 2020 21:04:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 18:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; 
   d="scan'208";a="243218144"
Received: from seyal2-mobl.ger.corp.intel.com (HELO localhost) ([10.254.147.27])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 18:04:27 -0700
Date:   Fri, 13 Mar 2020 03:04:25 +0200
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
Subject: Re: [PATCH v2 1/2] KEYS: Don't write out to userspace while holding
 key semaphore
Message-ID: <20200313010425.GA11360@linux.intel.com>
References: <20200308170410.14166-1-longman@redhat.com>
 <20200308170410.14166-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308170410.14166-2-longman@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Mar 08, 2020 at 01:04:09PM -0400, Waiman Long wrote:
> +		/*
> +		 * Read methods will just return the required length
> +		 * without any copying if the provided length isn't big
> +		 * enough.
> +		 */
> +		if ((ret > 0) && (ret <= buflen) && buffer &&
> +		    copy_to_user(buffer, tmpbuf, ret))
> +			ret = -EFAULT;

Please, reorg and remove redundant parentheses:

/*
 * Read methods will just return the required length
 * without any copying if the provided length isn't big
 * enough.
 */
if (ret > 0 && ret <= buflen) {
	if (buffer && copy_to_user(buffer, tmpbuf, ret))
		ret = -EFAULT;
}

Now the comment is attached to the exact right thing. The previous
organization is a pain to look at when backtracking commits for
whatever reason in the future.

I'm also wondering, would it be possible to rework the code in a way
that you don't have check whether buffer is valid on a constant basis?

/Jarkko
