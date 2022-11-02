Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67C616F4F
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 22:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKBVCT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 17:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKBVCS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 17:02:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40DDF29
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 14:02:17 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2KqTj8002202;
        Wed, 2 Nov 2022 21:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ozBkaOasXK4kHkldivIL/iCn9O7lKRvQq/0wuIScR/o=;
 b=G7H2wC1VlzEuaPCO1/wuLMeZ9oBdTiwmB90ZnBroZWffaNtQZZvLaAZ2jme/KGL3n0Pk
 FslM1Y6SCbGkm+ln2o4XHdAOCEryizbBJMg6+kz9IwDbrfIx6zRfR5lu7AjHOgmPBt1r
 7IMMttlNXIcr4J/Wyh8rjREQvhWw2ilF1OD2n40Fv0NJnYv1tgkhYCnUS+OOUBzeFm+m
 11RYgqQle48R7/3UY/CD2cZsI6u44GEeCoMP+oHBVC7eXzdc70vCY2eRyItZsadjqUDb
 7kZU9ePkMBLZNTQCdWfHQJsQNKIq9iHjD8Ku21o6Y8yxWqsGsQ8Tcj0KMya9dQtowrXP rg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkyyjg7tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 21:02:11 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2KoJ3v013693;
        Wed, 2 Nov 2022 21:02:10 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3kgut9w42g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 21:02:10 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2L293r19530136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 21:02:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8A015803F;
        Wed,  2 Nov 2022 21:02:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4978E58066;
        Wed,  2 Nov 2022 21:02:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 21:02:08 +0000 (GMT)
Message-ID: <acaaf8eb-431e-fc73-78da-40507d56e6d8@linux.ibm.com>
Date:   Wed, 2 Nov 2022 17:02:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v4 02/17] log and reset 'errno' after
 failure to open non-critical files
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
 <20221101201803.372652-3-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221101201803.372652-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RpcXUmt-s27JPotZZUkeJvs53jztBIjX
X-Proofpoint-GUID: RpcXUmt-s27JPotZZUkeJvs53jztBIjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/1/22 16:17, Mimi Zohar wrote:
> Define a log_errno_reset macro to emit the errno string at or near the
> time of error, similar to the existing log_errno macro, but also reset
> errno to avoid dangling or duplicate errno messages on exit.
> 
> The initial usage is for non-critical file open failures.

After looking just at the fopen() in evmctl.c at the end of this series there are some that are left over that show no error message (read_binary_bios_measurements) others that still use log_err() then. Should they not all be converted/extended and use log_errno_reset()?


> 
> Suggested-by: Vitaly Chikunov <vt@altlinux.org>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 0412bc0ac2b0..54123bf20f03 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -166,6 +166,9 @@ struct tpm_bank_info {
>   static char *pcrfile[MAX_PCRFILE];
>   static unsigned npcrfile;
>   
> +#define log_errno_reset(level, fmt, args...) \
> +	{do_log(level, fmt " (errno: %s)\n", ##args, strerror(errno)); errno = 0; }
> +
>   static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
>   {
>   	FILE *fp;
> @@ -1911,8 +1914,10 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
>   	fp = fopen(pcrs, "r");
>   	if (!fp)
>   		fp = fopen(misc_pcrs, "r");
> -	if (!fp)
> +	if (!fp) {
> +		log_errno_reset(LOG_DEBUG, "Failed to read TPM 1.2 PCRs");
>   		return -1;
> +	}
>   
>   	result = read_one_bank(&tpm_banks[0], fp);
>   	fclose(fp);
> @@ -2055,7 +2060,6 @@ static int ima_measurement(const char *file)
>   	int err_padded = -1;
>   	int err = -1;
>   
> -	errno = 0;
>   	memset(zero, 0, MAX_DIGEST_SIZE);
>   
>   	pseudo_padded_banks = init_tpm_banks(&num_banks);
> @@ -2072,6 +2076,8 @@ static int ima_measurement(const char *file)
>   		init_public_keys(imaevm_params.keyfile);
>   	else				/* assume read pubkey from x509 cert */
>   		init_public_keys("/etc/keys/x509_evm.der");
> +	if (errno)
> +		log_errno_reset(LOG_DEBUG, "Failed to initialize public keys");
>   
>   	/*
>   	 * Reading the PCRs before walking the IMA measurement list
> @@ -2746,6 +2752,8 @@ int main(int argc, char *argv[])
>   	unsigned long keyid;
>   	char *eptr;
>   
> +	errno = 0;	/* initialize global errno */
> +
>   #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>   	OPENSSL_init_crypto(
>   #ifndef DISABLE_OPENSSL_CONF

