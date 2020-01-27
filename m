Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99CA514A85B
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgA0Qwq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 11:52:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgA0Qwq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 11:52:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RGeC8o038410
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 11:52:44 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrjr4fsxx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 11:52:44 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 27 Jan 2020 16:52:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 16:52:40 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RGqec937290152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 16:52:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BF3B4C04E;
        Mon, 27 Jan 2020 16:52:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FE704C046;
        Mon, 27 Jan 2020 16:52:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.238])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 16:52:39 +0000 (GMT)
Subject: Re: [PATCH] Add support for TSS2 for PCR reading
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Patrick Uiterwijk <patrick@puiterwijk.org>,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@redhat.com, Vitaly Chikunov <vt@altlinux.org>
Date:   Mon, 27 Jan 2020 11:52:38 -0500
In-Reply-To: <CAJweMdarWZ7j5XrHbPqcp3ZV-XfzVBfeva5tMiuHMkd4M5HxMg@mail.gmail.com>
References: <CAJweMdarWZ7j5XrHbPqcp3ZV-XfzVBfeva5tMiuHMkd4M5HxMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012716-0008-0000-0000-0000034D2997
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012716-0009-0000-0000-00004A6D9FE9
Message-Id: <1580143958.5088.22.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_05:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=2 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Patrick,

On Sat, 2020-01-25 at 02:15 -0800, Patrick Uiterwijk wrote:
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>

Sorry for the long delay in reviewing the posted ima-evm-utils
patches, including yours.  I'm hoping to get back to working on ima-
evm-utils soon.

Mimi
 
> ---
>  configure.ac |   5 +++
>  src/evmctl.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 118 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index eedf90e..58a7fee 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -35,6 +35,9 @@ if test "x$TSSPCRREAD" = "xyes"; then
>  	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread
> binary installed])],
>  fi
> 
> +AC_CHECK_LIB([tss2-esys], [Esys_PCR_Read])
> +AC_CHECK_LIB([tss2-rc], [Tss2_RC_Decode])
> +
>  AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not
> found. You need the c-library development package.])])
>  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not
> found. You need the libkeyutils development package.])])
> 
> @@ -78,4 +81,6 @@ echo	"Configuration:"
>  echo	"          debug: $pkg_cv_enable_debug"
>  echo	"   openssl-conf: $enable_openssl_conf"
>  echo	"     tsspcrread: $TSSPCRREAD"
> +echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_PCR_Read"
> +echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
>  echo
> diff --git a/src/evmctl.c b/src/evmctl.c
> index b02be8b..5bc6773 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -69,6 +69,15 @@
>  #define XATTR_NAME_APPARMOR XATTR_SECURITY_PREFIX XATTR_APPARMOR_SUFFIX
>  #endif
> 
> +#ifdef HAVE_LIBTSS2_ESYS
> +#include <tss2/tss2_esys.h>
> +
> +#ifdef HAVE_LIBTSS2_RC
> +#include <tss2/tss2_rc.h>
> +#endif
> +#endif
> +
> +
>  #define USE_FPRINTF
> 
>  #include "imaevm.h"
> @@ -1407,9 +1416,110 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
>  	return result;
>  }
> 
> -#ifdef HAVE_TSSPCRREAD
> +#ifdef HAVE_LIBTSS2_ESYS
> +static int pcr_selections_match(TPML_PCR_SELECTION *a, TPML_PCR_SELECTION *b)
> +{
> +	if (a->count != b->count)
> +		return 0;
> +	for (int i = 0; i < a->count; i++) {
> +		if (a->pcrSelections[i].hash != b->pcrSelections[i].hash)
> +			return 0;
> +		if (a->pcrSelections[i].sizeofSelect != b->pcrSelections[i].sizeofSelect)
> +			return 0;
> +		for (int j = 0; j < a->pcrSelections[i].sizeofSelect; j++) {
> +			if (a->pcrSelections[i].pcrSelect[j] != b->pcrSelections[i].pcrSelect[j])
> +				return 0;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
> +static inline int tpm2_set_errmsg(char **errmsg, const char *message,
> TSS2_RC ret)
> +{
> +#ifdef HAVE_LIBTSS2_RC
> +		ret = asprintf(errmsg, "%s: %s", message, Tss2_RC_Decode(ret));
> +#else
> +		ret = asprintf(errmsg, "%s: #%d", message, ret);
> +#endif
> +}
> +#endif
> +
>  static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
>  {
> +#if defined(HAVE_LIBTSS2_ESYS)
> +	TSS2_ABI_VERSION abi_version = {
> +		.tssCreator = 1,
> +		.tssFamily = 2,
> +		.tssLevel = 1,
> +		.tssVersion = 108,
> +	};
> +	ESYS_CONTEXT *ctx = NULL;
> +	TSS2_RC ret = 0;
> +	TPML_PCR_SELECTION pcr_select_in = {
> +		.count = 1,
> +		.pcrSelections = {
> +			{
> +				.hash = TPM2_ALG_SHA1,
> +				.sizeofSelect = 3,
> +				.pcrSelect = { 0x00, 0x00, 0x00 },
> +			}
> +		}
> +	};
> +	TPML_PCR_SELECTION *pcr_select_out;
> +	TPML_DIGEST *pcr_digests;
> +	UINT32 pcr_update_counter;
> +
> +	pcr_select_in.pcrSelections[0].pcrSelect[idx / 8] = (1 << (idx % 8));
> +
> +	ret = Esys_Initialize(&ctx, NULL, &abi_version);
> +	if (ret != 0) {
> +		ret = tpm2_set_errmsg(errmsg, "esys initialize failed", ret);
> +		if (ret == -1)	/* the contents of errmsg are undefined */
> +			*errmsg = NULL;
> +		return -1;
> +	}
> +
> +	ret = Esys_PCR_Read(ctx,
> +			    ESYS_TR_NONE,
> +			    ESYS_TR_NONE,
> +			    ESYS_TR_NONE,
> +			    &pcr_select_in,
> +			    &pcr_update_counter,
> +			    &pcr_select_out,
> +			    &pcr_digests);
> +	Esys_Finalize(&ctx);
> +	if (ret != 0) {
> +		ret = tpm2_set_errmsg(errmsg, "esys PCR reading failed", ret);
> +		if (ret == -1)	/* the contents of errmsg is undefined */
> +			*errmsg = NULL;
> +		return -1;
> +	}
> +
> +	if (!pcr_selections_match(&pcr_select_in, pcr_select_out)) {
> +		Esys_Free(pcr_select_out);
> +		Esys_Free(pcr_digests);
> +
> +		ret = asprintf(errmsg, "TPM returned incorrect PCRs");
> +		if (ret == -1)	/* the contents of errmsg are undefined */
> +			*errmsg = NULL;
> +		return -1;
> +	}
> +	Esys_Free(pcr_select_out);
> +
> +	if (pcr_digests->count != 1 || pcr_digests->digests[0].size !=
> SHA_DIGEST_LENGTH) {
> +		Esys_Free(pcr_digests);
> +		ret = asprintf(errmsg, "TPM returned incorrect digests");
> +		if (ret == -1)	/* the contents of errmsg is undefined */
> +			*errmsg = NULL;
> +		return -1;
> +	}
> +
> +	memcpy(hwpcr, pcr_digests->digests[0].buffer, len);
> +	Esys_Free(pcr_digests);
> +	return 0;
> +
> +#elif defined(HAVE_TSSPCRREAD)
>  	FILE *fp;
>  	char pcr[100];	/* may contain an error */
>  	char cmd[50];
> @@ -1441,8 +1551,8 @@ static int tpm2_pcr_read(int idx, uint8_t
> *hwpcr, int len, char **errmsg)
>  		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */
> 
>  	return ret;
> -}
>  #endif
> +}
> 
>  #define TCG_EVENT_NAME_LEN_MAX	255
> 
> @@ -1701,7 +1811,7 @@ static int ima_measurement(const char *file)
>  		log_dump(pcr[i], SHA_DIGEST_LENGTH);
> 
>  		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
> -#ifdef HAVE_TSSPCRREAD
> +#if defined(HAVE_TSSPCRREAD) || defined(HAVE_LIBTSS2_ESYS)
>  			char *errmsg = NULL;
> 
>  			err = tpm2_pcr_read(i, hwpcr, sizeof(hwpcr), &errmsg);

