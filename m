Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E955ABC2C
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Sep 2022 03:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiICByU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 21:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiICByT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 21:54:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B7DC08B
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 18:54:18 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2831ktxN025922;
        Sat, 3 Sep 2022 01:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=I4vOnywEZVuQugrw6tCUtwxamP8SgI3qQGMyve9OOww=;
 b=QJzC3cccGeds5lFBitTaqvqDV7k5r3r3FPrVojWsJICbi4gi0mOvTSm2tLnCqwgijMka
 ypQL6LAPrp2tH9fidPJ86Vwqv4s0u/XK4R9X7O5mIWRFwjYG2xh08TQhtlmI8bqvmIC+
 4sj6zpCCKa1V4VRpD50+YHQYxhZ/7dsKDXnNWal4kCIHs+O/mmUiSDURJ7LpKxJX8E/A
 5/D0N9MLRsBnxmd90NeCjdgSdO94ZJHNIetDshhBO4wxYasCRFYzZZazyCB/rjFIxm5Z
 THwsYtjMg0fWZJbm/LcWmOFMl03CYZacOh3afbIW8fVCOELtuzeQ6XOzHZ54uEj9Lc4k Fg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbwjj83m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Sep 2022 01:54:14 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2831pRge027323;
        Sat, 3 Sep 2022 01:54:13 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3j7awap6v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Sep 2022 01:54:13 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2831sCcw60817812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 3 Sep 2022 01:54:12 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1076D2805A;
        Sat,  3 Sep 2022 01:54:12 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA7C928059;
        Sat,  3 Sep 2022 01:54:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  3 Sep 2022 01:54:11 +0000 (GMT)
Message-ID: <57e1b104-e1bf-de17-3567-6bb148047403@linux.ibm.com>
Date:   Fri, 2 Sep 2022 21:54:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils] add support for reading per bank TPM 2.0
 PCRs via sysfs
Content-Language: en-US
To:     Tergel Myanganbayar <tergel@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Tergel Myanganbayar <tergel@u.northwestern.edu>
References: <20220902230815.35448-1-tergel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220902230815.35448-1-tergel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tRnyIB76NaByo_6CL_um7Pi1_2iOEXxq
X-Proofpoint-GUID: tRnyIB76NaByo_6CL_um7Pi1_2iOEXxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209030006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/2/22 19:08, Tergel Myanganbayar wrote:
> Until Linux kernel version 5.11, a TSS was required to read TPM 2.0 PCR
> values. A feature which exposed the per bank TPM 2.0 PCRs directly via
> sysfs was upstreamed in newer Kernel versions.

>> Use this recent feature in IMA-EVM-UTILS to remove TSS dependency.
> 
> Signed-off-by: Tergel Myanganbayar <tergel@linux.ibm.com>
> ---
>   src/evmctl.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 46a34cc..d5fe988 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1899,6 +1899,7 @@ static int read_one_bank(struct tpm_bank_info *tpm_bank, FILE *fp)
>   
>   static char *pcrs = "/sys/class/tpm/tpm0/device/pcrs";  /* Kernels >= 4.0 */
>   static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
> +static char tpm2_pcr_path[28] = "/sys/class/tpm/tpm0/pcr-sha";

I don't think this 'constant' is necessary since it's only used once 
though the same may be true for the other two. If you want to keep it it 
should probably be written like this

static const char *tpm2_pcr_path = "/sys/class/tpm/tpm0/pcr-sha";

The others should also have a 'const'.
>   
>   /* Read one of the TPM 1.2 sysfs files if present */
>   static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
> @@ -1922,7 +1923,55 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
>   	for (i = 1; i < num_banks; i++)
>   		tpm_banks[i].supported = 0;
>   	return 0;
> +}
> +
> +static int read_tpm2_one_bank(struct tpm_bank_info *tpm_bank, int bank)
> +{
> +	FILE *fp;
> +	char file_name[NAME_MAX];
> +	char digest[MAX_DIGEST_SIZE + 1];
> +	char *p;
> +	int i;
> +
> +	for (i = 0; i < NUM_PCRS; i++) {
> +		sprintf(file_name, "%s%d/%d", tpm2_pcr_path, bank, i);

... and just write "/sys/class/tpm/tpm0/pcr-sha%d/%d" here ?

> +		fp = fopen(file_name, "r");
> +		if (!fp)
> +			return -1;
> +
> +		p = fgets(digest, (tpm_bank->digest_size * 2 + 1), fp);

no need for parenthesis

> +		if (!p)
> +			return -1;

fclose(fp) before the return

> +
> +		hex2bin(tpm_bank->pcr[i], digest, tpm_bank->digest_size);
> +		fclose(fp);
> +	}
> +	return 0;
> +}
> +
> +static int read_sysfs_tpm2_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
> +{
> +	int banks[2] = {1, 256};
> +	int rt, j;
> +	int tpm_enabled = 0;
>   
> +	if (imaevm_params.verbose > LOG_INFO)
> +		log_info("Trying to read TPM 2.0 PCRs via sysfs.\n");
> +
> +	for (j = 0; j < num_banks; j++) {
> +		rt = read_tpm2_one_bank(&tpm_banks[j], banks[j]);
> +		tpm_banks[j].supported = 0;
> +
> +		if (rt < 0)
> +			continue;
> +
> +		tpm_enabled = 1;
> +		tpm_banks[j].supported = 1;
> +	}
> +
> +	if (tpm_enabled == 0)
> +		return -1;
> +	return 0;


You could have just copied and pasted from read_tpm_banks():

return tpm_enabled ? 0 : 1;
>   }
>   
>   /* Read PCRs from per-bank file(s) specified via --pcrs */
> @@ -2008,6 +2057,9 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
>   	if (read_sysfs_pcrs(num_banks, bank) == 0)
>   		return 0;
>   
> +	if (read_sysfs_tpm2_pcrs(num_banks, bank) == 0)
> +		return 0;
> +
>   	/* Any userspace applications available for reading TPM 2.0 PCRs? */
>   	if (!tpm2_pcr_supported()) {
>   		log_debug("Failed to read TPM 2.0 PCRs\n");
> @@ -2024,6 +2076,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
>   					    bank[i].pcr[pcr_handle],
>   					    bank[i].digest_size,
>   					    &errmsg);
> +			bank[i].supported = 1;

Is this a bugfix?

>   			if (err) {
>   				log_debug("Failed to read %s PCRs: (%s)\n",
>   					  bank[i].algo_name, errmsg);
