Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFEDBD4EF
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2019 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391727AbfIXWbc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Sep 2019 18:31:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47472 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389629AbfIXWbb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 18:31:31 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 37B0C2010688;
        Tue, 24 Sep 2019 15:31:27 -0700 (PDT)
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: ima_tpm_chip is queried and saved only at IMA init, but never later
Message-ID: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
Date:   Tue, 24 Sep 2019 15:31:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When IMA is initialized the default TPM is queried and saved.
If at this point a TPM wasn't available, but is detected and surfaced 
later by the system, IMA doesn't update the TPM information.

security/integrity/ima/ima_init.c
int __init ima_init(void)
{
	int rc;

	ima_tpm_chip = tpm_default_chip();
	if (!ima_tpm_chip)
		pr_info("No TPM chip found, activating TPM-bypass!\n");
	...
}

TPM PCR update function in IMA is essentially a NOP if TPM wasn't 
detected during IMA init.

security/integrity/ima/ima_queue.c
static int ima_pcr_extend(const u8 *hash, int pcr)
{
	int result = 0;

	if (!ima_tpm_chip)
		return result;
	...
}

In one configuration I am testing, I see the TPM appear post IMA Init. 
Likely this is rare, but I was wondering if there was a reason why TPM 
information is only queried during IMA init, but never updated at a 
later point.

Thanks,
  -lakshmi
