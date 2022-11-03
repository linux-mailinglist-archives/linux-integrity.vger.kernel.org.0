Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41821618B18
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 23:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKCWEa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 18:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKCWE3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 18:04:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0850DBE3C
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 15:04:27 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3L7B40017923;
        Thu, 3 Nov 2022 22:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GxQPzTdtadycYyo2d7Ixj24mwiawVVqvW6X2D+4AifI=;
 b=tX7qoRAcTW/E3Hia8c8WPKgRKBakfNu+TdauCw3ZAssshgyiNIdlYOQoIo9wCzM0seAj
 jQRO/FX7nCtAxJHEH27naSSy09I2352cDxiMcxQ9bhr0XbGDt+mK5xjO+Yf6kBhA3PYf
 pczcdnWnMYcHq1GAU4axAIq4hl+2NmUmfHEE+idwafVhHoHHQceUYGQyMnJrhaR4U/T1
 29HM+FTd9hPraLuvCSH71VDqMIzlnqfesHB70qN/2CRcQbo0m6c4KZSJQwms1Y1QN7PC
 85sxFjFCXF4cwP6NldrJvyo4us/B4hYIvTh4dl3KUp0CS479X9Ekt8VTuGxodnr7ZQBi mA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmgtsucyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 22:04:23 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3LpiT7002004;
        Thu, 3 Nov 2022 22:04:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 3kgutb58x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 22:04:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3M4PdG9831106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 22:04:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 389615805D;
        Thu,  3 Nov 2022 22:04:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF67C58058;
        Thu,  3 Nov 2022 22:04:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 22:04:20 +0000 (GMT)
Message-ID: <a5b21c9b-1c4c-36c1-450d-55631e841987@linux.ibm.com>
Date:   Thu, 3 Nov 2022 18:04:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v5 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-2-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221103183904.103562-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ES2JfwixURi4et5IkOlKV2QnBAwATjYp
X-Proofpoint-GUID: ES2JfwixURi4et5IkOlKV2QnBAwATjYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/3/22 14:38, Mimi Zohar wrote:
> This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/evmctl.c    | 18 ++----------------
>   src/libimaevm.c |  4 ----
>   2 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 76e2561798fa..0412bc0ac2b0 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -182,7 +182,6 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
>   	fp = fopen(name, "w");
>   	if (!fp) {
>   		log_err("Failed to open: %s\n", name);
> -		errno = 0;
>   		return -1;
>   	}
>   	err = fwrite(data, len, 1, fp);
> @@ -208,7 +207,6 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
>   	fp = fopen(name, "r");
>   	if (!fp) {
>   		log_err("Failed to open: %s\n", name);
> -		errno = 0;
>   		return NULL;
>   	}
>   	if (fstat(fileno(fp), &stats) == -1) {
> @@ -315,10 +313,8 @@ static int get_uuid(struct stat *st, char *uuid)
>   	sprintf(path, "blkid -s UUID -o value /dev/block/%u:%u", major, minor);
>   
>   	fp = popen(path, "r");
> -	if (!fp) {
> -		errno = 0;
> +	if (!fp)
>   		goto err;
> -	}
>   
>   	len = fread(_uuid, 1, sizeof(_uuid), fp);
>   	pclose(fp);
> @@ -375,7 +371,6 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   
>   			if (fd < 0) {
>   				log_err("Failed to open: %s\n", file);
> -				errno = 0;
>   				return -1;
>   			}
>   			if (ioctl(fd, FS_IOC_GETVERSION, &generation)) {
> @@ -1201,7 +1196,6 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
>   
>   		if (fd < 0) {
>   			log_err("Failed to open %s\n", file);
> -			errno = 0;
>   			goto out;
>   		}
>   		if (ioctl(fd, FS_IOC_GETVERSION, &generation)) {
> @@ -1392,7 +1386,6 @@ static int ima_fix(const char *path)
>   	fd = open(path, O_RDONLY);
>   	if (fd < 0) {
>   		log_errno("Failed to open file: %s", path);
> -		errno = 0;
>   		return -1;
>   	}
>   
> @@ -1916,10 +1909,8 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
>   	int i, result;
>   
>   	fp = fopen(pcrs, "r");
> -	if (!fp) {
> +	if (!fp)
>   		fp = fopen(misc_pcrs, "r");
> -		errno = 0;
> -	}
>   	if (!fp)
>   		return -1;
>   
> @@ -1982,7 +1973,6 @@ static int read_file_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
>   		fp = fopen(path, "r");
>   		if (!fp) {
>   			log_err("Could not open '%s'\n", path);
> -			errno = 0;
>   			return -1;
>   		}
>   
> @@ -2075,7 +2065,6 @@ static int ima_measurement(const char *file)
>   	fp = fopen(file, "rb");
>   	if (!fp) {
>   		log_err("Failed to open measurement file: %s\n", file);
> -		errno = 0;
>   		return -1;
>   	}
>   
> @@ -2321,7 +2310,6 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
>   	fp = fopen(file, "r");
>   	if (!fp) {
>   		log_errno("Failed to open TPM 1.2 event log.\n");
> -		errno = 0;
>   		return 1;
>   	}
>   
> @@ -2758,8 +2746,6 @@ int main(int argc, char *argv[])
>   	unsigned long keyid;
>   	char *eptr;
>   
> -	errno = 0;	/* initialize errno */
> -
>   #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>   	OPENSSL_init_crypto(
>   #ifndef DISABLE_OPENSSL_CONF
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index e4b62b4989b2..611631c57f14 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -144,7 +144,6 @@ static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
>   	fp = fopen(file, "r");
>   	if (!fp) {
>   		log_err("Failed to open: %s\n", file);
> -		errno = 0;
>   		return -1;
>   	}
>   
> @@ -259,7 +258,6 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
>   	if (!fp) {
>   		if (imaevm_params.verbose > LOG_INFO)
>   			log_info("Failed to open keyfile: %s\n", keyfile);
> -		errno = 0;
>   		return NULL;
>   	}
>   
> @@ -878,7 +876,6 @@ static int read_keyid_from_cert(uint32_t *keyid_be, const char *certfile, int tr
>   
>   	if (!(fp = fopen(certfile, "r"))) {
>   		log_err("Cannot open %s: %s\n", certfile, strerror(errno));
> -		errno = 0;
>   		return -1;
>   	}
>   	if (!PEM_read_X509(fp, &x, NULL, NULL)) {
> @@ -970,7 +967,6 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>   		fp = fopen(keyfile, "r");
>   		if (!fp) {
>   			log_err("Failed to open keyfile: %s\n", keyfile);
> -			errno = 0;
>   			return NULL;
>   		}
>   		pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
