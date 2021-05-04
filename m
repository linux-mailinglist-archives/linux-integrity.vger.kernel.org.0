Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423E3372AA0
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhEDNFr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 09:05:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64598 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230403AbhEDNFq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 09:05:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144D4QSD176956;
        Tue, 4 May 2021 09:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vPMat20zOJxP9NnpSo3zdZdgqfv2y3qWrRNEmeNqnIA=;
 b=jbAjQZ+r+VJtlV1l1QxBACp5R6KVQEQRaenG/4YWk8su2QdbBACkdaL6b7U8pnnlzC2F
 NQgcUJniZWBleZ+B/klrRgEBUZlUHEcZkrMewboQvv6gYQvuteNueBkVWdF3S/ElAKVw
 JpbBkwZStJtV6bLPCVfJMEexs+Mav+SDplTdRP/ug6VNVhkxvThaqQ47WpMkVcOdj4TS
 5P3wZtp75YxG9W9piWOeW6l2PWejg1I+DfEwODsOqPR+lCOPIOVSzQ9hdxQGR1UIiYff
 edtNqpobeJFhpOkJZnUA2vFDyjcSnueO/mX8THeNv9Gda2k67c17pwF9djPrTsux005D kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38b5qftcp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:04:48 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 144D4axR177407;
        Tue, 4 May 2021 09:04:47 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38b5qftcnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:04:47 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144D2RNM022443;
        Tue, 4 May 2021 13:04:46 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 388xm95egq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 13:04:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144D4jmc36962590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 13:04:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20F2E112062;
        Tue,  4 May 2021 13:04:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12AA3112064;
        Tue,  4 May 2021 13:04:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 13:04:45 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter0@gmail.com>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-3-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <2702b9ca-d20a-8348-2fc5-4e36ec6b45bf@linux.ibm.com>
Date:   Tue, 4 May 2021 09:04:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504043357.4093409-3-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u_tSfpKweR-lle2TimNkl1mXGWzR-N1t
X-Proofpoint-ORIG-GUID: sanO6pnfqsNIS9zLv7iwE_Sk11FzkteA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_07:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/4/21 12:33 AM, Vitaly Chikunov wrote:
> Allow user to specify `--keyid @/path/to/cert.pem' to extract keyid from
> SKID of the certificate file. PEM or DER format is auto-detected.
>
> `--keyid' option is reused instead of adding a new option (like possible
> `--cert') to signify to the user it's only keyid extraction and nothing
> more.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   README                 |  1 +
>   src/evmctl.c           | 82 +++++++++++++++++++++++++++++++++++++++++++++++---
>   tests/sign_verify.test |  1 +
>   3 files changed, 79 insertions(+), 5 deletions(-)
>
> diff --git a/README b/README
> index 8cd66e0..0e1f6ba 100644
> --- a/README
> +++ b/README
> @@ -49,6 +49,7 @@ OPTIONS
>         --rsa          use RSA key type and signing scheme v1
>     -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
>         --keyid val    overwrite signature keyid with a value (for signing)
> +                     val is a x509 cert file if prefixed with '@'
>     -o, --portable     generate portable EVM signatures
>     -p, --pass         password for encrypted signing key
>     -r, --recursive    recurse into directories (sign)
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7983299..fdb0fb3 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -42,6 +42,7 @@
>   #include <sys/param.h>
>   #include <sys/stat.h>
>   #include <sys/ioctl.h>
> +#include <arpa/inet.h>
>   #include <fcntl.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> @@ -57,12 +58,14 @@
>   #include <termios.h>
>   #include <assert.h>
>   
> +#include <openssl/asn1.h>
>   #include <openssl/sha.h>
>   #include <openssl/pem.h>
>   #include <openssl/hmac.h>
>   #include <openssl/err.h>
>   #include <openssl/rsa.h>
>   #include <openssl/engine.h>
> +#include <openssl/x509v3.h>
>   #include "hash_info.h"
>   #include "pcr.h"
>   #include "utils.h"
> @@ -2447,6 +2450,7 @@ static void usage(void)
>   		"      --rsa          use RSA key type and signing scheme v1\n"
>   		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
>   		"      --keyid val    overwrite signature keyid with a value (for signing)\n"
> +		"                     val is a x509 cert file if prefixed with '@'\n"
>   		"  -o, --portable     generate portable EVM signatures\n"
>   		"  -p, --pass         password for encrypted signing key\n"
>   		"  -r, --recursive    recurse into directories (sign)\n"
> @@ -2567,12 +2571,71 @@ static char *get_password(void)
>   	return pwd;
>   }
>   
> +/* Return true if FILE is possibly PEM encoded (otherwise DER). */
> +static int is_encoding_pem(FILE *in)
> +{
> +	char buf[6]; /* Room for the 5 minus signs and '\0'. */
> +	int pem = 0;
> +
> +	if (fgets(buf, sizeof(buf), in) &&
> +	    strspn(buf, "-") == sizeof(buf) - 1)
> +		pem = 1;
> +	rewind(in);
> +	return pem;
> +}
> +
> +/* Extract keyid from SKID of the cert. No return on error. */
> +static unsigned long int extract_keyid(const char *certfile)
> +{
> +	uint32_t keyid_raw;
> +	const ASN1_OCTET_STRING *skid;
> +	int skid_len;
> +	X509 *x = NULL;
> +	int pem;
> +	FILE *in;
> +
> +	if (!(in = fopen(certfile, "r"))) {
> +		log_err("Cannot open cert file %s: %s\n", certfile,
> +			strerror(errno));
> +		exit(1);
> +	}
> +	if ((pem = is_encoding_pem(in)))


I think you should not try to detect PEM by '-----' at the beginning 
since it typically allows other text at the beginning of the file as 
well, such as a text dump of the cert. Instead search for '-----BEGIN 
CERTIFICATE-----' in the whole file or just try to read it as PEM first 
and then fall back to DER decoding if PEM failed.



> +		x = PEM_read_X509(in, &x, NULL, NULL);
> +	else
> +		x = d2i_X509_fp(in, &x);
> +	if (!x) {
> +		ERR_print_errors_fp(stderr);
> +		log_err("Cannot read x509 cert from %s file %s\n",
> +			pem? "PEM" : "DER", certfile);
> +		fclose(in);
> +		exit(1);
> +	}
> +	fclose(in);
> +
> +	if (!(skid = X509_get0_subject_key_id(x))) {
> +		log_err("%s: SKID not found\n", certfile);
> +		goto err_free;
> +	}
> +	skid_len = ASN1_STRING_length(skid);
> +	if (skid_len < sizeof(keyid_raw)) {
> +		log_err("%s: SKID too short (len %d)\n", certfile, skid_len);
> +		goto err_free;
> +	}
> +	memcpy(&keyid_raw, ASN1_STRING_get0_data(skid) + skid_len
> +	       - sizeof(keyid_raw), sizeof(keyid_raw));
> +	log_info("keyid %04x (from %s)\n", ntohl(keyid_raw), certfile);
> +	return ntohl(keyid_raw);
> +
> +err_free:
> +	X509_free(x);
> +	exit(1);
> +}
> +
>   int main(int argc, char *argv[])
>   {
>   	int err = 0, c, lind;
>   	ENGINE *eng = NULL;
>   	unsigned long int keyid;
> -	char *eptr;
>   
>   #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>   	OPENSSL_init_crypto(
> @@ -2718,10 +2781,19 @@ int main(int argc, char *argv[])
>   			pcrfile[npcrfile++] = optarg;
>   			break;
>   		case 143:
> -			errno = 0;
> -			keyid = strtoul(optarg, &eptr, 16);
> -			if (errno || eptr - optarg != strlen(optarg) ||
> -			    keyid > UINT_MAX || keyid == 0) {
> +			if (optarg[0] == '@') {
> +				keyid = extract_keyid(optarg + 1);
> +			} else {
> +				char *eptr;
> +
> +				errno = 0;
> +				keyid = strtoul(optarg, &eptr, 16);
> +				if (eptr - optarg != strlen(optarg) || errno) {
> +					log_err("Invalid keyid value.\n");
> +					exit(1);
> +				}
> +			}
> +			if (keyid > UINT_MAX || keyid == 0) {
>   				log_err("Invalid keyid value.\n");
>   				exit(1);
>   			}
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 2c21812..52ea33a 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -360,6 +360,7 @@ sign_verify  rsa1024  md5     0x030201:K:0080
>   sign_verify  rsa1024  sha1    0x030202:K:0080
>   sign_verify  rsa1024  sha224  0x030207:K:0080
>   expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
> +expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204:K:0080 OPTS=--keyid=@test-rsa1024.cer
>   sign_verify  rsa1024  sha256  0x030204:K:0080
>     try_different_keys
>     try_different_sigs
