Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3516C22B931
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 00:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgGWWL2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 18:11:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29602 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbgGWWL2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 18:11:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NM2Pqm120840
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jul 2020 18:11:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9beujp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jul 2020 18:11:26 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NMAcqb157997
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jul 2020 18:11:26 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9beujd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 18:11:26 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NMB8SF029755;
        Thu, 23 Jul 2020 22:11:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq86mku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 22:11:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NMBMfZ11207082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 22:11:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BA734C040;
        Thu, 23 Jul 2020 22:11:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 949C94C046;
        Thu, 23 Jul 2020 22:11:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.234])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 22:11:21 +0000 (GMT)
Message-ID: <1595542280.5211.220.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils] extend ima_measurement --pcrs option
 to support per-bank pcr files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-integrity@vger.kernel.org, bill.c.roberts@gmail.com
Date:   Thu, 23 Jul 2020 18:11:20 -0400
In-Reply-To: <20200723193329.24144-1-stephen.smalley.work@gmail.com>
References: <20200723193329.24144-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230151
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-23 at 15:33 -0400, Stephen Smalley wrote:
> Extend the ima_measurement --pcrs option to support per-bank pcr files.
> The extended syntax is "--pcrs algorithm,pathname".  If no algorithm
> is specified, it defaults to sha1 as before.  Multiple --pcrs options
> are now supported, one per bank of PCRs. The file format remains
> unchanged.
> 
> Create per-bank pcr files, depends on "tpm: add sysfs exports for all
> banks of PCR registers" kernel patch:
> $ cat tpm2pcrread.sh
> #!/bin/sh
> for alg in sha1 sha256
> do
>   rm -f pcr-$alg
>   pcr=0;
>   while [ $pcr -lt 24 ];
>   do
>     printf "PCR-%02d: " $pcr >> pcr-$alg;
>     cat /sys/class/tpm/tpm0/pcr-$alg/$pcr >> pcr-$alg;
>     pcr=$[$pcr+1];
>   done
> done
> $ sh ./tpm2pcrread.sh
> 
> Pass only the sha1 PCRs to evmctl defaulting to sha1:
> $ sudo evmctl ima_measurement --pcrs pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements --validate
> 
> Pass only the sha1 PCRs to evmctl with explicit selection of sha1:
> $ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements --validate
> 
> Pass both sha1 and sha2 PCRs to evmctl:
> $ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 --pcrs sha256,pcr-sha256 /sys/kernel/security/integrity/ima/binary_runtime_measurements --validate
> 
> NB The file parser could be improved to be more robust but I left the
> existing code unchanged from the code to read the TPM 1.2 sysfs file other
> than generalizing it to support loading other banks.

Agreed.  As a separate patch, please feel free to update the file
parser.

> 
> NB The error handling is IMHO wrong; if any error occurs during handling of
> the --pcrs option(s), evmctl will try to fall back to reading the PCRs in
> some other way.  I think these should be fatal errors but left it as it
> was for the TPM 1.2 sysfs file.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thank you.

<snip>

> @@ -1829,16 +1783,100 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
>  #endif
>  }
>  
> -/* Read TPM 1.2 PCRs */
> +static int read_one_bank(struct tpm_bank_info *tpm_bank, FILE *fp)
> +{
> +	char *p, pcr_str[8], buf[80];
> +	int i = 0;
> +	int result = -1;
> +	for (;;) {
> +		p = fgets(buf, sizeof(buf), fp);
> +		if (!p || i > 99)
> +			break;
> +		sprintf(pcr_str, "PCR-%2.2d", i);
> +		if (!strncmp(p, pcr_str, 6))
> +			hex2bin(tpm_bank->pcr[i++], p + 7, tpm_bank->digest_size);
> +		result = 0;
> +	}
> +	return result;
> +}
> +
> +static char *pcrs = "/sys/class/tpm/tpm0/device/pcrs";  /* Kernels >= 4.0 */
> +static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
> +
> +/* Read all of the TPM PCRs */
>  static int read_tpm_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
>  {
> -	int i;
> +	struct stat s;
> +	FILE *fp = NULL;
> +	char *p;
> +	const char *alg, *path;
> +	int i = 0, j;
> +	int bank, result;
> +
> +	/* Use the provided TPM bank pcr file(s) */
> +	if (npcrfile) {
> +		for (i = 0; i < num_banks; i++)
> +			tpm_banks[i].supported = 0;
> +		for (i = 0; i < npcrfile; i++) {
> +			p = strchr(pcrfile[i], ',');
> +			if (p) {
> +				*p = 0;
> +				alg = pcrfile[i];
> +				path = ++p;
> +			} else {
> +				alg = "sha1";
> +				path = pcrfile[i];
> +			}
>  
> -	if (tpm_pcr_read(tpm_banks, SHA_DIGEST_LENGTH)) {
> -		log_debug("Failed to read TPM 1.2 PCRs.\n");
> -		return -1;
> +			bank = -1;
> +			for (j = 0; j < num_banks; j++) {
> +				if (!strcmp(tpm_banks[j].algo_name, alg)) {
> +					bank = j;
> +					break;
> +				}
> +			}
> +			if (bank < 0) {
> +				log_err("Unknown algorithm '%s'\n", alg);
> +				return -1;
> +			}
> +
> +			if (stat(path, &s) == -1) {
> +				log_err("Could not stat '%s'\n", path);
> +				return -1;
> +			}
> +
> +			if (!S_ISREG(s.st_mode)) {
> +				log_err("TPM PCR file: not a regular file or link to regular file\n");
> +				return -1;
> +			}
> +
> +			fp = fopen(path, "r");
> +			if (!fp) {
> +				log_err("Could not open '%s'\n", path);
> +				return -1;
> +			}
> +
> +			result = read_one_bank(&tpm_banks[bank], fp);
> +			fclose(fp);
> +			if (result < 0)
> +				return result;
> +			tpm_banks[bank].supported = 1;
> +		}
> +
> +		return 0;
>  	}

Previously on failure to read the --pcrs TPM 1.2 file, it attempted to
then read the TPM 1.2 sysfs file.  Changing it like this is fine.  I
agree with NB 2 - either read the PCR files or the TPM PCRs directly,
not both.  Perhaps make that a separate patch either before or after
this one.

I appreciate your limiting the changes to simplify review.  With
reading either the PCR files or the sysfs files, can we get rid of the
npcrfile indentation above?

if (!npcrfile)
     read_sysfs_pcrs()

Mimi


> +	/* Read the TPM 1.2 sysfs file */
> +	fp = fopen(pcrs, "r");
> +	if (!fp)
> +		fp = fopen(misc_pcrs, "r");
> +	if (!fp)
> +		return -1;
> +
> +	result = read_one_bank(&tpm_banks[0], fp);
> +	fclose(fp);
> +	if (result < 0)
> +		return result;
>  	tpm_banks[0].supported = 1;
>  	for (i = 1; i < num_banks; i++)
>  		tpm_banks[i].supported = 0;

