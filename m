Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6715B5D0F
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Sep 2022 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiILPYQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Sep 2022 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiILPYP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Sep 2022 11:24:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A451F2C3
        for <linux-integrity@vger.kernel.org>; Mon, 12 Sep 2022 08:24:15 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CFBupu013371;
        Mon, 12 Sep 2022 15:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=O5gPyoa7ivd5eKdxlIa8dmsiiq3ukAmilCH9DQZF6Mo=;
 b=JPejWn5MEhhGOij3A9fTY/efLBwqzRTHOP7Ex8HMWrJoF0VmI/6xXzsWfl+++XPVUtVT
 v3WLD0TQBRTQqWNFARXjGrrYVi6e2fa6AwcAV7l7Dhxh2PW52OlUQ2MZho5SnJyKXsXz
 sIc++H+CdAuvzXJVvQHqtIsks0kQ6Fat/CckKZnobkvfguF+LGfBp7zaZ9KWqmZhA20A
 pRjh0cgJbbhKdwCZl3eMAueQ+mr3Tp3l839b0tij0IlwXVUojrJRusZmTi906A2Tbwpd
 aK+rwk2PHHPgzksno3iId/ioMEQixgOUjxoe3CZ8b9LozZeabJ5pqFBqG8lS52e4AnJO 4Q== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jj76ngfam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 15:24:09 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28CFKctG009475;
        Mon, 12 Sep 2022 15:24:08 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 3jgj79wx6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 15:24:08 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28CFO7Se2425356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 15:24:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31A2EBE04F;
        Mon, 12 Sep 2022 15:37:57 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BECF1BE051;
        Mon, 12 Sep 2022 15:37:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 12 Sep 2022 15:37:56 +0000 (GMT)
Message-ID: <0e2a3b78-f7c2-5b40-8700-a4e9623dcb3c@linux.ibm.com>
Date:   Mon, 12 Sep 2022 11:24:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v2] add support for reading per bank TPM 2.0
 PCRs via sysfs
Content-Language: en-US
To:     Tergel Myanganbayar <tergel@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Tergel Myanganbayar <tergel@u.northwestern.edu>,
        Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
References: <20220908002500.4710-1-tergel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220908002500.4710-1-tergel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GLVZ9v_GgaAitBFPRreMOmvlZlNO8JpL
X-Proofpoint-GUID: GLVZ9v_GgaAitBFPRreMOmvlZlNO8JpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_10,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120051
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/7/22 20:25, Tergel Myanganbayar wrote:
> Until Linux kernel version 5.11, a TSS was required to read TPM 2.0 PCR
> values. A feature which exposed the per bank TPM 2.0 PCRs directly via
> sysfs was upstreamed in newer Kernel versions.
> 
> Use this recent feature in IMA-EVM-UTILS to remove TSS dependency.
> 
> Signed-off-by: Tergel Myanganbayar <tergel@linux.ibm.com>
> ---
>   src/evmctl.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 46a34cc..07209b6 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1922,7 +1922,60 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
>   	for (i = 1; i < num_banks; i++)
>   		tpm_banks[i].supported = 0;
>   	return 0;
> +}
> +
> +static int read_tpm2_one_bank(struct tpm_bank_info *tpm_bank)
> +{
> +	FILE *fp;
> +	char digest[MAX_DIGEST_SIZE + 1];
> +	char file_name[NAME_MAX];
> +	char *p;
> +	int i;
> +
> +	for (i = 0; i < NUM_PCRS; i++) {
> +		sprintf(file_name, "/sys/class/tpm/tpm0/pcr-%s/%d",
> +			tpm_bank->algo_name, i);
> +		fp = fopen(file_name, "r");
> +		if (!fp)
> +			return -1;
>   
> +		p = fgets(digest, tpm_bank->digest_size * 2 + 1, fp);
> +		if (!p) {
> +			fclose(fp);
> +			return -1;
> +		}
> +
> +		hex2bin(tpm_bank->pcr[i], digest, tpm_bank->digest_size);
> +		fclose(fp);
> +	}
> +	return 0;
> +}
> +
> +static int read_sysfs_tpm2_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
> +{
> +	int tpm_enabled = 0;
> +	int rt, j;
> +
> +	if (imaevm_params.verbose > LOG_INFO)
> +		log_info("Trying to read PCRs via sysfs.\n");
> +
> +	for (j = 0; j < num_banks; j++) {
> +		rt = read_tpm2_one_bank(&tpm_banks[j]);
> +		if (rt < 0) {
> +			tpm_banks[j].supported = 0;
> +			continue;
> +		}
> +		tpm_enabled = 1;
> +	}
> +
> +	/* On failure to read any TPM bank PCRs, re-initialize the TPM banks*/
> +	if (tpm_enabled == 0) {
> +		for (j = 0; j < num_banks; j++)
> +			tpm_banks[j].supported = 1;
> +		return 1;
> +	}
> +
> +	return 0;
>   }
>   
>   /* Read PCRs from per-bank file(s) specified via --pcrs */
> @@ -2008,6 +2061,9 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
>   	if (read_sysfs_pcrs(num_banks, bank) == 0)
>   		return 0;
>   
> +	if (read_sysfs_tpm2_pcrs(num_banks, bank) == 0)
> +		return 0;
> +
>   	/* Any userspace applications available for reading TPM 2.0 PCRs? */
>   	if (!tpm2_pcr_supported()) {
>   		log_debug("Failed to read TPM 2.0 PCRs\n");


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
