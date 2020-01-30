Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1714D7EA
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgA3Iru (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 03:47:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:25438 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgA3Iru (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 03:47:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 00:47:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,381,1574150400"; 
   d="scan'208";a="232840310"
Received: from kvehmane-mobl.ger.corp.intel.com (HELO jsakkine-mobl1) ([10.237.50.119])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2020 00:47:45 -0800
Message-ID: <50afe1f50297b02af52621b6738ffff0c24f1bdf.camel@linux.intel.com>
Subject: Re: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to
 HASH_ALGO__LAST
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        james.bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 30 Jan 2020 10:47:44 +0200
In-Reply-To: <20200127170443.21538-2-roberto.sassu@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-2-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-27 at 18:04 +0100, Roberto Sassu wrote:
> chip->allocated_banks contains the list of TPM algorithm IDs of allocated
> PCR banks. It also contains the corresponding ID of the crypto subsystem,
> so that users of the TPM driver can calculate a digest for a PCR extend
> operation.
> 
> However, if there is no mapping between TPM algorithm ID and crypto ID, the
> crypto_id field in chip->allocated_banks remains set to zero (the array is
> allocated and initialized with kcalloc() in tpm2_get_pcr_allocation()).
> Zero should not be used as value for unknown mappings, as it is a valid
> crypto ID (HASH_ALGO_MD4).
> 
> This patch initializes crypto_id to HASH_ALGO__LAST.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>---

Remarks:

* After the subsystem tag, short summary starts with a capital lettter.
* Missing fixes tag and cc tag to stable.
* A struct called allocated_banks does not exist.
* Please prefer using an imperative sentence when describing the action
  to take e.g. "Thus, initialize crypto_id to HASH_ALGO__LAST".

/Jarkko

