Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2797214C796
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2020 09:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgA2IjL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jan 2020 03:39:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:44528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgA2IjL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jan 2020 03:39:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 05C5AAFB7;
        Wed, 29 Jan 2020 08:39:08 +0000 (UTC)
Date:   Wed, 29 Jan 2020 09:39:05 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        james.bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to
 HASH_ALGO__LAST
Message-ID: <20200129083905.GB387@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
 <20200127170443.21538-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127170443.21538-2-roberto.sassu@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

> chip->allocated_banks contains the list of TPM algorithm IDs of allocated
> PCR banks. It also contains the corresponding ID of the crypto subsystem,
> so that users of the TPM driver can calculate a digest for a PCR extend
> operation.

> However, if there is no mapping between TPM algorithm ID and crypto ID, the
> crypto_id field in chip->allocated_banks remains set to zero (the array is
> allocated and initialized with kcalloc() in tpm2_get_pcr_allocation()).
> Zero should not be used as value for unknown mappings, as it is a valid
> crypto ID (HASH_ALGO_MD4).

> This patch initializes crypto_id to HASH_ALGO__LAST.

Make sense.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
