Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702B82ADB38
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Nov 2020 17:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgKJQFG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Nov 2020 11:05:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730186AbgKJQFG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Nov 2020 11:05:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAG1wHt149724
        for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2020 11:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=Y+K07jIcAoHXIf3ojqVBT8f3DNxMwKuW82/lOQARSro=;
 b=T810hrWe91XtlK5aQS471LF0YYFPO8asby/edLeJZjfW0qMpW1g+xj4OcPrbFsdBsAND
 OTc4+l3NtQ/4TfpK9MYqbulc28ME3Q0/zexcJ8WYMj9RB0NvV2eIoppAyE1msBhZh2zR
 ipEDf2OvL12/DDcu25GqC/U2Np4pTQkuLyHle8SHZYSkg+aiaKKCC0oh7FEadIYXMR4d
 bVEWw8WeNE3Yf46vLxZRLmHe/m3OWsKGY8KSCxGcc1YZGc+ljRk9mRx3Of5dfagyd4fo
 DXePMTH/DnUb0J0AjYPniv0QqXyYXH6+jq7oLrbp/uWIidj6nwbrStO7O4lJreUudrN+ DQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qsbctc5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2020 11:05:04 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AAG31JH007486
        for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2020 16:05:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 34nk789pmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Nov 2020 16:05:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AAG503T1311280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 16:05:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 240E411C05B;
        Tue, 10 Nov 2020 16:05:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6955011C04A;
        Tue, 10 Nov 2020 16:04:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.83.27])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 16:04:59 +0000 (GMT)
Message-ID: <d19bc808b3eeb40f47e010e0b23c26d2c807c538.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/5] ima-evm-utils: Change tpm2_pcr_read() to use C
 code
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgoldman@us.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Date:   Tue, 10 Nov 2020 11:04:58 -0500
In-Reply-To: <20201012234416.20995-4-kgoldman@us.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
         <20201012234416.20995-4-kgoldman@us.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_06:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ken,

On Mon, 2020-10-12 at 19:44 -0400, Ken Goldman wrote:
> Replace the call out to the command line tools with C functions.
> 
> The algorithm_string_to_algid() function supports only the digest
> algorithms in use.  The table has place holders for other agorithms as
> they are needed and the C strings are defined.
> 
> The table can also be used for an algrithm ID to string function if
> it's ever needed.
> 
> When using the IBM TSS, link in its library.
> 
> Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>

The code seems to be working properly, but needs to be cleaned up. 
There are simple formatting changes and some style changes.

Simple formatting changes:
- Tabs should be 8 characters.
- Remove blank spaces before code.
- 80 characater maximum line length.
- Leave a blank line between variable definitions and code.
- Long comments should start with "/*" and end with "*/" on separate
lines:
/*
 * multiple line comments
 * continued
 */
- When defining function variables, please use the format:
term:
<definition>


Style changes:
- There are valid reasons for having a common function exit (e.g.
freeing memory), otherwise the function should exit early.  The "if (rc
== 0)" tests cause the code to unnecessarily be indented.  Instead the
test could be inverted "if (!rc)" followed by a "goto out".

- Please do not use camel or Hungarian variable naming conventions.  
The variable definition can reference the spec name.

thanks,

Mimi

> ---
>  src/Makefile.am      |   1 +
>  src/pcr_tsspcrread.c | 156 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 123 insertions(+), 34 deletions(-)
> 
> diff --git a/src/Makefile.am b/src/Makefile.am
> index d6c779f..bf18caf 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -26,6 +26,7 @@ if USE_PCRTSS
>  evmctl_SOURCES += pcr_tss.c
>  else
>  evmctl_SOURCES += pcr_tsspcrread.c
> +evmctl_LDADD += -libmtss
>  endif
>  
>  AM_CPPFLAGS = -I$(top_srcdir) -include config.h
> diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
> index 118c7d2..eae68b7 100644
> --- a/src/pcr_tsspcrread.c
> +++ b/src/pcr_tsspcrread.c
> @@ -50,6 +50,10 @@
>  #include "utils.h"
>  #include "imaevm.h"
>  
> +#define TPM_POSIX	/* use Posix, not Windows constructs in TSS */
> +#undef MAX_DIGEST_SIZE	/* imaevm uses a different value than the TSS */
> +#include <ibmtss/tss.h>
> +
>  #define CMD "tsspcrread"
>  
>  static char path[PATH_MAX];
> @@ -68,44 +72,128 @@ int tpm2_pcr_supported(void)
>  	return 1;
>  }
>  
> -int tpm2_pcr_read(const char *algo_name, uint32_t pcrHandle, uint8_t *hwpcr,
> -		 int len, char **errmsg)
> -{
> -	FILE *fp;
> -	char pcr[100];	/* may contain an error */
> -	char cmd[PATH_MAX + 50];
> -	int ret;
> -
> -	sprintf(cmd, "%s -halg %s -ha %d -ns 2> /dev/null",
> -		path, algo_name, pcrHandle);
> -	fp = popen(cmd, "r");
> -	if (!fp) {
> -		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
> -		if (ret == -1)	/* the contents of errmsg is undefined */
> -			*errmsg = NULL;
> -		return -1;
> -	}
> +/* Table mapping C strings to TCG algorithm identifiers */
> +
> +typedef struct tdAlgorithm_Map {
> +    const char *algorithm_string;
> +    TPMI_ALG_HASH algid;
> +} Algorithm_Map;
>  
> -	if (fgets(pcr, sizeof(pcr), fp) == NULL) {
> -		ret = asprintf(errmsg, "tsspcrread failed: %s",
> -			       strerror(errno));
> -		if (ret == -1)	/* the contents of errmsg is undefined */
> -			*errmsg = NULL;
> -		ret = pclose(fp);
> -		return -1;
> +Algorithm_Map algorithm_map[] = {
> +				 { "sha1", TPM_ALG_SHA1},
> +				 { "sha256", TPM_ALG_SHA256},
> +#if 0	/* uncomment as these digest algorithms are supported */
> +				 { "", TPM_ALG_SHA384},
> +				 { "", TPM_ALG_SHA512},
> +				 { "", TPM_ALG_SM3_256},
> +				 { "", TPM_ALG_SHA3_256},
> +				 { "", TPM_ALG_SHA3_384},
> +				 { "", TPM_ALG_SHA3_512},
> +#endif
> +};
> +
> +/* algorithm_string_to_algid() converts a digest algorithm from a C string to a TCG algorithm
> +   identifier as defined in the TCG Algorithm Regisrty..
> +
> +   Returns TPM_ALG_ERROR if the string has an unsupported value.
> +*/
> +
> +static TPMI_ALG_HASH algorithm_string_to_algid(const char *algorithm_string)
> +{
> +    size_t 	i;
> +    for (i=0 ; i < sizeof(algorithm_map)/sizeof(Algorithm_Map) ; i++) {
> +	if (strcmp(algorithm_string, algorithm_map[i].algorithm_string) == 0) {
> +	    return algorithm_map[i].algid; /* if match */
>  	}
> +    }
> +    return TPM_ALG_ERROR;
> +}
>  
> -	/* get the popen "cmd" return code */
> -	ret = pclose(fp);
> +/* tpm2_pcr_read() reads the PCR
>  
> -	/* Treat an unallocated bank as an error */
> -	if (!ret && (strlen(pcr) < SHA_DIGEST_LENGTH))
> -		ret = -1;
> +   algo_name is the PCR digest algorithm (the PCR bank) as a C string
> +   pcrHandle is the PCR number to read
> +   hwpcr is a buffer for the PCR output in binary
> +   len is the allocated size of hwpcr and should match the digest algorithm
> +*/
>  
> -	if (!ret)
> -		hex2bin(hwpcr, pcr, len);
> -	else
> -		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */
> +int tpm2_pcr_read(const char *algo_name, uint32_t pcrHandle, uint8_t *hwpcr,
> +		 int len, char **errmsg)
> +{
> +        int 			ret = 0;	/* function return code */
> +	TPM_RC			rc = 0;		/* TCG return code */
> +	PCR_Read_In 		pcrReadIn;	/* command input */
> +	PCR_Read_Out 		pcrReadOut;	/* response output */
> +	TSS_CONTEXT		*tssContext = NULL;
> +	TPMI_ALG_HASH 		alg_id;		/* PCR algorithm */
>  
> -	return ret;
> +	if (rc == 0) {		/* map algorithm string to TCG value */
> +	    alg_id = algorithm_string_to_algid(algo_name);
> +	    if (alg_id == TPM_ALG_ERROR) {
> +		ret = asprintf(errmsg, "tpm2_pcr_read: unknown algorithm %s", algo_name);
> +		if (ret == -1) {	/* the contents of errmsg is undefined */
> +		    *errmsg = NULL;
> +		}
> +		rc = 1;
> +	    }
> +	}
> +	if (rc == 0) {
> +	    rc = TSS_Create(&tssContext);
> +	}
> +	/* call TSS to execute the command */
> +	if (rc == 0) {
> +	    pcrReadIn.pcrSelectionIn.count = 1;
> +	    pcrReadIn.pcrSelectionIn.pcrSelections[0].hash = alg_id;
> +	    pcrReadIn.pcrSelectionIn.pcrSelections[0].sizeofSelect = 3;
> +	    pcrReadIn.pcrSelectionIn.pcrSelections[0].pcrSelect[0] = 0;
> +	    pcrReadIn.pcrSelectionIn.pcrSelections[0].pcrSelect[1] = 0;
> +	    pcrReadIn.pcrSelectionIn.pcrSelections[0].pcrSelect[2] = 0;
> +	    pcrReadIn.pcrSelectionIn.pcrSelections[0].pcrSelect[pcrHandle / 8] =
> +		1 << (pcrHandle % 8);
> +	    rc = TSS_Execute(tssContext,
> +			     (RESPONSE_PARAMETERS *)&pcrReadOut,
> +			     (COMMAND_PARAMETERS *)&pcrReadIn,
> +			     NULL,
> +			     TPM_CC_PCR_Read,
> +			     TPM_RH_NULL, NULL, 0);
> +	}
> +	if (rc == 0) {
> +	    /* nothing read, bank missing */
> +	    if (pcrReadOut.pcrValues.count == 0) {
> +		ret = asprintf(errmsg, "tpm2_pcr_read: returned count 0 for %s", algo_name);
> +		if (ret == -1) {	/* the contents of errmsg is undefined */
> +		    *errmsg = NULL;
> +		}
> +		rc = 1;
> +	    }
> +	    /* len parameter did not match the digest algorithm */
> +	    else if (pcrReadOut.pcrValues.digests[0].t.size != len) {
> +		ret = asprintf(errmsg,
> +			       "tpm2_pcr_read: expected length %d actual %u for %s",
> +			       len, pcrReadOut.pcrValues.digests[0].t.size, algo_name);
> +		if (ret == -1) {	/* the contents of errmsg is undefined */
> +		    *errmsg = NULL;
> +		}
> +		rc = 1;
> +	    }
> +	    else {
> +		memcpy(hwpcr,
> +		       pcrReadOut.pcrValues.digests[0].t.buffer,
> +		       pcrReadOut.pcrValues.digests[0].t.size);
> +	    }
> +	}
> +	{
> +	    TPM_RC rc1 = TSS_Delete(tssContext);
> +	    if (rc == 0) {
> +		rc = rc1;
> +	    }
> +	}
> +	/* map TCG return code to function return code */
> +	if (rc == 0) {
> +	    return 0;
> +	}
> +	else {
> +	    return -1;
> +	}
>  }
> +


