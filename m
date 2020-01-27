Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3EF14A8ED
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 18:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgA0R3i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 12:29:38 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbgA0R3i (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:29:38 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id AE045A5854A2C70C7BF5;
        Mon, 27 Jan 2020 17:29:36 +0000 (GMT)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 27 Jan 2020 17:29:35 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 27 Jan 2020 18:29:35 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Mon, 27 Jan 2020 18:29:36 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 6/8] ima: calculate and extend PCR with digests in
 ima_template_entry
Thread-Topic: [PATCH 6/8] ima: calculate and extend PCR with digests in
 ima_template_entry
Thread-Index: AQHV1TQzib8f0iknEECfOoz/Jg91LKf+w3NA
Date:   Mon, 27 Jan 2020 17:29:35 +0000
Message-ID: <ef5e7e87ce7d4a9db18c270f99ff6ecc@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
 <20200127170443.21538-7-roberto.sassu@huawei.com>
In-Reply-To: <20200127170443.21538-7-roberto.sassu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: Roberto Sassu
> Sent: Monday, January 27, 2020 6:05 PM
> To: zohar@linux.ibm.com; jarkko.sakkinen@linux.intel.com;
> james.bottomley@hansenpartnership.com; linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org;
> Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>; Roberto Sassu
> <roberto.sassu@huawei.com>
> Subject: [PATCH 6/8] ima: calculate and extend PCR with digests in
> ima_template_entry
> 
> This patch modifies ima_calc_field_array_hash() to calculate a template
> digest for each allocated PCR bank and SHA1. It also passes the tpm_digest
> array of the template entry to ima_pcr_extend() or in case of a violation,
> the pre-initialized digests array filled with 0xff.
> 
> Padding with zeros is still done if the mapping between TPM algorithm ID
> and crypto ID is unknown.
> 
> This patch calculates again the template digest when a measurement list is
> restored. Copying only the SHA1 digest (due to the limitation of the
> current measurement list format) is not sufficient, as hash collision
> detection will be done on the digest calculated with the default IMA hash
> algorithm.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_crypto.c   | 26 ++++++++++++++++++++++-
>  security/integrity/ima/ima_queue.c    | 30 ++++++++++++++++-----------
>  security/integrity/ima/ima_template.c | 14 +++++++++++--
>  3 files changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_crypto.c
> b/security/integrity/ima/ima_crypto.c
> index 63fb4bdf80b0..786340feebbb 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -610,9 +610,33 @@ static int ima_calc_field_array_hash_tfm(struct
> ima_field_data *field_data,
>  int ima_calc_field_array_hash(struct ima_field_data *field_data,
>  			      struct ima_template_entry *entry)
>  {
> -	int rc;
> +	u16 alg_id;
> +	int rc, i;
> 
>  	rc = ima_calc_field_array_hash_tfm(field_data, entry,
> ima_sha1_idx);
> +	if (rc)
> +		return rc;
> +
> +	entry->digests[ima_sha1_idx].alg_id = TPM_ALG_SHA1;
> +
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 1; i++) {
> +		if (i == ima_sha1_idx)
> +			continue;
> +
> +		alg_id = ima_tpm_chip->allocated_banks[i].alg_id;

The line above should be executed for i < ima_tpm_chip->nr_allocated_banks.

I will fix in the next version of the patch set.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
