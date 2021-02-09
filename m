Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883F315446
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 17:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhBIQrE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 11:47:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233169AbhBIQp3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 11:45:29 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119GXBPO089554
        for <linux-integrity@vger.kernel.org>; Tue, 9 Feb 2021 11:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T3gG3/TTe8Uskl0+tnRpFMCc4hUj0Ejg034cK3aZQTY=;
 b=G94o1Z4ANwcvU18nt06MstFWbhG1vDNiwJQ9/WOOF7lBwnnOUvV68fElkIdH3YlRcgap
 9KQrjubsopMnHZhnGR6+tvbaE233qv8nyYTW07KX9DGrciif1n//pCCCK44k0Vc7J89a
 Q97ehNimhwTKt5OpaICwb0C79nWHRgnddQueXTzmhwmAGD3Alow0i2+4zjknKh47mbeQ
 KnLbaTV7xSScvQyysBIsKfGafmiC/xyYezJ7J1USpUGrobsphAYs9heWnvxHAvTTO8i7
 DE4rzK+zID/225xVFVzL/fkmlExhW1TrD98Nrr2+1pf8EyQF4U9fRkIqzcoVCgE08xTp 8A== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kwqjruq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Feb 2021 11:44:47 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119Gafjq025077
        for <linux-integrity@vger.kernel.org>; Tue, 9 Feb 2021 16:44:45 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 36hjr9dtvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Feb 2021 16:44:45 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119GijkU16580968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 16:44:45 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B939124055;
        Tue,  9 Feb 2021 16:44:45 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D07F124053;
        Tue,  9 Feb 2021 16:44:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 16:44:44 +0000 (GMT)
Subject: Re: [ima-evm-utils][PATCH] Limit comparing the calculated PCR value
 to just a single bank
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20210209164116.152447-1-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <668a7a2e-5a3a-af8a-ea9e-f285fb13545e@linux.ibm.com>
Date:   Tue, 9 Feb 2021 11:44:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210209164116.152447-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/9/21 11:41 AM, Mimi Zohar wrote:
> TPM 2.0 banks may be extended either with a padded SHA1 hash or more
> recently with a per TPM bank calculated hash.  If the measurement list
> is carried across kexec, the original kernel might extend the TPM
> differently than the new kernel.
>
> Support for verifying a mixed IMA measurement list is not supported.  To
> permit verifying just the SHA1 bank, specify "--verify-bank=sha1" on the
> command line.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/src/evmctl.c b/src/evmctl.c
> index f7ffe388ef4f..051c218cc8b5 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -125,6 +125,7 @@ static char *caps_str;
>   static char *ima_str;
>   static char *selinux_str;
>   static char *search_type;
> +static char *verify_bank;
>   static int verify_list_sig;
>   static int recursive;
>   static int msize;
> @@ -2011,6 +2012,16 @@ static int ima_measurement(const char *file)
>   	pseudo_banks_mask = (1 << num_banks) - 1;
>   	pseudo_padded_banks_mask = pseudo_banks_mask;
>   
> +	/* Instead of verifying all the banks, only verify a single bank */
> +	for (c = 0; c < num_banks; c++) {
> +		if (verify_bank
> +		    && strcmp(pseudo_padded_banks[c].algo_name, verify_bank)) {
> +			pseudo_banks_mask ^= (1 << c);
> +			pseudo_padded_banks_mask ^= (1 << c);
> +			break;
> +		}
> +	}
> +
>   	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
>   		entry_num++;
>   		if (entry.header.name_len > TCG_EVENT_NAME_LEN_MAX) {
> @@ -2537,7 +2548,7 @@ struct command cmds[] = {
>   	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
>   	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
>   	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
> -	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
> +	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] [--verify-bank hash-algorithm] file", "Verify measurement list (experimental).\n"},
>   	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]", "Calculate per TPM bank boot_aggregate digests\n"},
>   	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
>   	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
> @@ -2578,6 +2589,7 @@ static struct option opts[] = {
>   	{"xattr-user", 0, 0, 140},
>   	{"ignore-violations", 0, 0, 141},
>   	{"pcrs", 1, 0, 142},
> +	{"verify-bank", 2, 0, 143},
>   	{}
>   
>   };
> @@ -2766,6 +2778,9 @@ int main(int argc, char *argv[])
>   			}
>   			pcrfile[npcrfile++] = optarg;
>   			break;
> +		case 143:
> +			verify_bank = optarg;
> +			break;
>   		case '?':
>   			exit(1);
>   			break;

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


