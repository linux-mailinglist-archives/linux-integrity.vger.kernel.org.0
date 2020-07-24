Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2234122CE83
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 21:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGXTNP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 15:13:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726416AbgGXTNP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 15:13:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OJDEeF043933
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 15:13:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32faj4muaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 15:13:14 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06OJDDhP043845
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 15:13:13 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32faj4mu6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 15:13:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OJ27H5008581;
        Fri, 24 Jul 2020 19:12:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 32brbh7fxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 19:12:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06OJCmFF34340970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 19:12:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A839BAE051;
        Fri, 24 Jul 2020 19:12:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20430AE053;
        Fri, 24 Jul 2020 19:12:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.236.7])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 19:12:48 +0000 (GMT)
Message-ID: <1595617967.5017.31.camel@linux.ibm.com>
Subject: Re: [PATCH v3 ima-evm-utils] extend ima_measurement --pcrs option
 to support per-bank pcr files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-integrity@vger.kernel.org, bill.c.roberts@gmail.com
Date:   Fri, 24 Jul 2020 15:12:47 -0400
In-Reply-To: <20200724145242.31178-1-stephen.smalley.work@gmail.com>
References: <20200724145242.31178-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_08:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-24 at 10:52 -0400, Stephen Smalley wrote:
> Extend the ima_measurement --pcrs option to support per-bank pcr files.
> The extended syntax is "--pcrs algorithm,pathname".  If no algorithm
> is specified, it defaults to sha1 as before.  Multiple --pcrs options
> are now supported, one per bank of PCRs. The file format remains
> unchanged.  If --pcrs is specified, only try to read PCRs from the
> specified file(s); do not fall back to trying to read from sysfs
> or the TPM itself in this case since the user requested use of
> the files.
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
> $ sudo evmctl ima_measurement --pcrs pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements
> 
> Pass only the sha1 PCRs to evmctl with explicit selection of sha1:
> $ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements
> 
> Pass both sha1 and sha256 PCRs to evmctl:
> $ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 --pcrs sha256,pcr-sha256 /sys/kernel/security/integrity/ima/binary_runtime_measurements
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I reviewed the patch and everything looks good, other than a few
comments below.  Weirdly the order in which the TPM bank files
containing the PCRs are supplied on the command line is affecting
being able to verify the measurement list - sha1, sha256 versus
sha256, sha1.  Perhaps during the time it takes to read the different
banks, the PCRs have changed?  Not quite sure what is happening.
 
> ---
> v3 splits reading the pcr files and the sysfs files into two separate functions
> each called from read_tpm_banks() with different error handling. Thus, if
> --pcrs is specified, then evmctl will only try to read from the specified
> file(s) and any errors will cause it to fail rather than trying to read
> directly from the TPM.  If --pcrs is not specified, then evmctl will try
> to read from the sysfs files and then fall back to reading directly
> from the TPM if that fails. v3 also reduces the limit on the number of
> PCRs read from the files to NUM_PCRS since otherwise it will overflow
> the pcrs[] array.  Further improvements to the file parser are deferred
> to future patches.
> 
> @@ -1829,20 +1783,108 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
>  #endif
>  }
>  
> -/* Read TPM 1.2 PCRs */
> -static int read_tpm_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
> +static int read_one_bank(struct tpm_bank_info *tpm_bank, FILE *fp)
>  {
> -	int i;
> +	char *p, pcr_str[8], buf[80];

As log as we're changing this from 70 to 80, might as well define it
as MAX_DITEST_SIZE * 2 + X.  I'm pretty sure support for additional,
larger digests will be added.  This can be deferred to the subsequent
patch. 

> +	int i = 0;
> +	int result = -1;
> +	for (;;) {
> +		p = fgets(buf, sizeof(buf), fp);
> +		if (!p || i >= NUM_PCRS)
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
> +/* Read one of the TPM 1.2 sysfs files if present */
> +static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
> +{
> +	FILE *fp;
> +	int i, result;
>  
> -	if (tpm_pcr_read(tpm_banks, SHA_DIGEST_LENGTH)) {
> -		log_debug("Failed to read TPM 1.2 PCRs.\n");
> +	fp = fopen(pcrs, "r");
> +	if (!fp)
> +		fp = fopen(misc_pcrs, "r");
> +	if (!fp)
>  		return -1;
> -	}
>  
> +	result = read_one_bank(&tpm_banks[0], fp);
> +	fclose(fp);
> +	if (result < 0)
> +		return result;
>  	tpm_banks[0].supported = 1;
>  	for (i = 1; i < num_banks; i++)
>  		tpm_banks[i].supported = 0;
>  	return 0;
> +
> +}
> +
> +/* Read PCRs from per-bank file(s) specified via --pcrs */
> +static int read_file_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
> +{
> +	struct stat s;
> +	FILE *fp;
> +	char *p;
> +	const char *alg, *path;
> +	int i, j, bank, result;
> +
> +	for (i = 0; i < num_banks; i++)
> +		tpm_banks[i].supported = 0;
> +
> +	for (i = 0; i < npcrfile; i++) {

Being able to provide more PCR files than banks is a bit strange.  I
guess the TPM could export additional banks, than what is currently
supported by ima-evm-utils, and programmatically supply them to ima-
evm-utils.

Mimi

> +		p = strchr(pcrfile[i], ',');
> +		if (p) {
> +			*p = 0;
> +			alg = pcrfile[i];
> +			path = ++p;
> +		} else {
> 
