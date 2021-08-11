Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328303E8F2E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 12:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhHKK6Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 06:58:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231509AbhHKK6X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 06:58:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BAYbQR193662
        for <linux-integrity@vger.kernel.org>; Wed, 11 Aug 2021 06:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FIaPAznCNWmnFGEYvlik7fOnu3AW4CfkYoSzA7dmNTM=;
 b=NiLw6bXO1DRAvmbQKK2GfnXuHoOqJ+eOzISTSoFGVTet+LsjyBcDX33J+rUMP+78FIZX
 IvKrRFqkDLedpGB1puJHMigXySPSdm6WHOnVF24eOM/yQlOGnpVN4fYD14rEEyS//ZgM
 tUIfsOhyEJGHxCQzHOxOXr+oK9eXVVY2j6+0vyfkDWaldXMmRewAD0529g9GZL+X8xD8
 qLriLU9ricLGxif4+1JnkTcQ6j2hSK+XPEfknKbbhaQEmhNU8/2GRkgDyxLGYbB8Otge
 VlJscAOCWS36eggWPP/ZMO/kiZSEhWJ4cpW5ZmLrXPHG5stO5e5BO4tAhP95vfQSgVSp Dg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3abb7q1bv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Aug 2021 06:57:59 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17BArpVK030104
        for <linux-integrity@vger.kernel.org>; Wed, 11 Aug 2021 10:57:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3abujqsc72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Aug 2021 10:57:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17BAvra851315152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 10:57:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0DC4A4086;
        Wed, 11 Aug 2021 10:57:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA2E2A4094;
        Wed, 11 Aug 2021 10:57:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.84])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Aug 2021 10:57:52 +0000 (GMT)
Message-ID: <ed9ce2996682a1d2042a3f4afc9324a02e945344.camel@linux.ibm.com>
Subject: Re: [PATCH v5 ima-evm-utils 3/3] Create alternative tpm2_pcr_read()
 that uses IBM TSS
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgoldman@us.ibm.com>, linux-integrity@vger.kernel.org
Cc:     kgold@linux.ibm.com
Date:   Wed, 11 Aug 2021 06:57:51 -0400
In-Reply-To: <20210803204008.29612-4-kgoldman@us.ibm.com>
References: <20210803204008.29612-1-kgoldman@us.ibm.com>
         <20210803204008.29612-4-kgoldman@us.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: liErt3v8qpSD0G-fFr71u6rKzVX7NRyq
X-Proofpoint-GUID: liErt3v8qpSD0G-fFr71u6rKzVX7NRyq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_03:2021-08-10,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ken,

On Tue, 2021-08-03 at 16:40 -0400, Ken Goldman wrote:
> Use the IBM TSS to implement the functions as an alternative to the
> command line tools.
> 
> The algorithm_string_to_algid() function supports only the digest
> algorithms in use.  The table has place holders for other algorithms
> as they are needed and the C strings are defined.
> 
> The table can also be used for an algorithm ID to string function if
> it's ever needed.
> 
> When using the IBM TSS, link in its library.
> 
> Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
> 
> Please review the configure.ac change.

FYI, the above comment/note for the commit belongs after the three-dash 
line.  From the README for git format-patch:

--notes[=<ref>]
--no-notes
Append the notes (see git-notes[1]) for the commit after the three-dash 
line.

The expected use case of this is to write supporting explanation for
the commit that does not belong to the commit log message proper, and
include it with the patch submission. While one can simply write these
explanations after format-patch has run but before sending, keeping
them as Git notes allows them to be maintained between versions of the
patch series (but see the discussion of the notes.rewrite configuration
options in git-notes[1] to use this workflow).

The default is --no-notes, unless the format.notes configuration is
set.

> ---

Comments/notes go here.

>  configure.ac     |   8 ++
>  src/Makefile.am  |  15 +++-
>  src/pcr_ibmtss.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 213 insertions(+), 2 deletions(-)
>  create mode 100644 src/pcr_ibmtss.c
> 
> diff --git a/configure.ac b/configure.ac
> index e1ed100..4f6fe7c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -30,10 +30,17 @@ AC_SUBST(KERNEL_HEADERS)
>  AC_CHECK_HEADER(unistd.h)
>  AC_CHECK_HEADERS(openssl/conf.h)
>  
> +# Intel TSS
>  AC_CHECK_LIB([tss2-esys], [Esys_Free])
>  AC_CHECK_LIB([tss2-rc], [Tss2_RC_Decode])
>  AM_CONDITIONAL([USE_PCRTSS], [test "x$ac_cv_lib_tss2_esys_Esys_Free" = "xyes"])
>  
> +# IBM TSS include files
> +AC_CHECK_HEADER(ibmtss/tss.h, [have_ibmtss=true],
> +			      [have_ibmtss=false],
> +			      [[#define TPM_POSIX]])
> +AM_CONDITIONAL([USE_IBMTSS], $have_ibmtss)

There's no need to define "have_ibmtss".

+AC_CHECK_HEADER(ibmtss/tss.h, [], [], [[#define TPM_POSIX]])
+AM_CONDITIONAL([USE_IBMTSS], [test "x$ac_cv_header_ibmtss_tss_h" =
"xyes"])

> +
>  AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
>  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
>  
> @@ -79,5 +86,6 @@ echo	"          debug: $pkg_cv_enable_debug"
>  echo	"   openssl-conf: $enable_openssl_conf"
>  echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
>  echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
> +echo    "         ibmtss: $have_ibmtss"

This would be:
+echo    "         ibmtss: $ac_cv_header_ibmtss_tss_h"

>  echo	"            doc: $have_doc"
>  echo
> diff --git a/src/Makefile.am b/src/Makefile.am
> index d6c779f..f89d971 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -22,10 +22,21 @@ evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>  evmctl_LDFLAGS = $(LDFLAGS_READLINE)
>  evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
>  
> +# USE_PCRTSS uses the Intel TSS
>  if USE_PCRTSS
> -evmctl_SOURCES += pcr_tss.c
> + evmctl_SOURCES += pcr_tss.c
> +
> +# USE_IBMTSS uses the IBM TSS
> +else
> +if USE_IBMTSS
> + evmctl_SOURCES += pcr_ibmtss.c
> + evmctl_LDADD += -libmtss
> +
> +# uses the IBM TSS command line utilities
>  else
> -evmctl_SOURCES += pcr_tsspcrread.c
> + evmctl_SOURCES += pcr_tsspcrread.c
> +
> +endif
>  endif
>  
>  AM_CPPFLAGS = -I$(top_srcdir) -include config.h
> diff --git a/src/pcr_ibmtss.c b/src/pcr_ibmtss.c
> new file mode 100644
> index 0000000..551f9c4
> --- /dev/null
> +++ b/src/pcr_ibmtss.c
> @@ -0,0 +1,192 @@
> +/*
> + * ima-evm-utils - IMA/EVM support utilities
> + *
> + * Copyright (C) 2021 IBM
> + *
> + * Authors:
> + * Ken Goldman <kgoldman@us.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * As a special exception, the copyright holders give permission to link the
> + * code of portions of this program with the OpenSSL library under certain
> + * conditions as described in each individual source file and distribute
> + * linked combinations including the program with the OpenSSL library. You
> + * must comply with the GNU General Public License in all respects
> + * for all of the code used other than as permitted herein. If you modify
> + * file(s) with this exception, you may extend this exception to your
> + * version of the file(s), but you are not obligated to do so. If you do not
> + * wish to do so, delete this exception statement from your version. If you
> + * delete this exception statement from all source files in the program,
> + * then also delete it in the license file.
> + *
> + * File: pcr_tsspcrread.c
> + *	 PCR reading implementation based on IBM TSS2
> + */
> +

Newer files are just including "// SPDX-License-Identifier: GPL-2.0"
instead of the entire license.

> +#include <errno.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdint.h>
> +
> +#include <openssl/sha.h>
> +
> +#define USE_FPRINTF
> +#include "utils.h"
> +#include "imaevm.h"
> +
> +#define TPM_POSIX	/* use Posix, not Windows constructs in TSS */
> +#undef MAX_DIGEST_SIZE	/* imaevm uses a different value than the TSS */
> +#include <ibmtss/tss.h>
> +
> +#define CMD "tsspcrread"
> +
> +static char path[PATH_MAX];
> +
> +int tpm2_pcr_supported(void)
> +{
> +	if (imaevm_params.verbose > LOG_INFO)
> +		log_info("Using %s to read PCRs.\n", CMD);
> +
> +	if (get_cmd_path(CMD, path, sizeof(path))) {
> +		log_debug("Couldn't find '%s' in $PATH\n", CMD);
> +		return 0;
> +	}
> +
> +	log_debug("Found '%s' in $PATH\n", CMD);
> +	return 1;
> +}
> +
> +/* Table mapping C strings to TCG algorithm identifiers */
> +typedef struct tdAlgorithm_Map {
> +	const char *algorithm_string;
> +	TPMI_ALG_HASH algid;
> +} Algorithm_Map;
> +
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
> +/*
> + * algorithm_string_to_algid() converts a digest algorithm from a C string to a
> + * TCG algorithm identifier as defined in the TCG Algorithm Regisrty..
> + *
> + *  Returns TPM_ALG_ERROR if the string has an unsupported value.
> + */
> +static TPMI_ALG_HASH algorithm_string_to_algid(const char *algorithm_string)
> +{
> +	size_t 	i;
> +
> +	for (i=0 ; i < sizeof(algorithm_map)/sizeof(Algorithm_Map) ; i++) {
> +		if (strcmp(algorithm_string, algorithm_map[i].algorithm_string)
> +		    == 0) {
> +			return algorithm_map[i].algid; 		/* if match */
> +		}
> +	}
> +	return TPM_ALG_ERROR;
> +}
> +
> +/* tpm2_pcr_read() reads the PCR

The function name should be on a separate line.

> + *
> + * algo_name: PCR digest algorithm (the PCR bank) as a C string
> + * pcr_handle: PCR number to read
> + * hwpcr: buffer for the PCR output in binary
> + * len: allocated size of hwpcr and should match the digest algorithm
> + */
> +int tpm2_pcr_read(const char *algo_name, uint32_t pcr_handle, uint8_t *hwpcr,
> +		  int len, char **errmsg)
> +{
> +        int 			ret = 0;	/* function return code */
> +	TPM_RC			rc = 0;		/* TCG return code */
> +	TPM_RC 			rc1 = 0;	/* secondary return code */
> +	PCR_Read_In 		pcr_read_in;	/* command input */
> +	PCR_Read_Out 		pcr_read_out;	/* response output */
> +	TSS_CONTEXT		*tss_context = NULL;
> +	TPMI_ALG_HASH 		alg_id;		/* PCR algorithm */
> +
> +	alg_id = algorithm_string_to_algid(algo_name);
> +	if (alg_id == TPM_ALG_ERROR) {
> +		ret = asprintf(errmsg, "tpm2_pcr_read: unknown algorithm %s",
> +			       algo_name);
> +		if (ret == -1) 	/* the contents of errmsg is undefined */
> +			*errmsg = NULL;
> +		rc = 1;
> +		goto end;
> +	}
> +	rc = TSS_Create(&tss_context);
> +	if (rc != 0)
> +		goto end;
> +	/* call TSS to execute the command */
> +	pcr_read_in.pcrSelectionIn.count = 1;
> +	pcr_read_in.pcrSelectionIn.pcrSelections[0].hash = alg_id;
> +	pcr_read_in.pcrSelectionIn.pcrSelections[0].sizeofSelect = 3;
> +	pcr_read_in.pcrSelectionIn.pcrSelections[0].pcrSelect[0] = 0;
> +	pcr_read_in.pcrSelectionIn.pcrSelections[0].pcrSelect[1] = 0;
> +	pcr_read_in.pcrSelectionIn.pcrSelections[0].pcrSelect[2] = 0;
> +	pcr_read_in.pcrSelectionIn.pcrSelections[0].pcrSelect[pcr_handle / 8] =
> +		1 << (pcr_handle % 8);
> +	rc = TSS_Execute(tss_context,
> +			 (RESPONSE_PARAMETERS *)&pcr_read_out,
> +			 (COMMAND_PARAMETERS *)&pcr_read_in,
> +			 NULL,
> +			 TPM_CC_PCR_Read,
> +			 TPM_RH_NULL, NULL, 0);
> +	if (rc != 0)
> +		goto end;
> +	/* nothing read, bank missing */
> +	if (pcr_read_out.pcrValues.count == 0) {
> +		ret = asprintf(errmsg, "tpm2_pcr_read: returned count 0 for %s",
> +			       algo_name);
> +		if (ret == -1) /* the contents of errmsg is undefined */
> +			*errmsg = NULL;
> +		rc = 1;
> +		goto end;
> +	}
> +	/* len parameter did not match the digest algorithm */
> +	else if (pcr_read_out.pcrValues.digests[0].t.size != len) {
> +		ret = asprintf(errmsg,
> +			       "tpm2_pcr_read: "
> +			       "expected length %d actual %u for %s",
> +			       len, pcr_read_out.pcrValues.digests[0].t.size,
> +			       algo_name);
> +		if (ret == -1)	/* the contents of errmsg is undefined */
> +			*errmsg = NULL;
> +		rc = 1;
> +		goto end;
> +	}
> +	else {
> +		memcpy(hwpcr,
> +		       pcr_read_out.pcrValues.digests[0].t.buffer,
> +		       pcr_read_out.pcrValues.digests[0].t.size);
> +	}
> + end:
> +	rc1 = TSS_Delete(tss_context);
> +	if (rc == 0)
> +		rc = rc1;
> +	/* map TCG return code to function return code */
> +	if (rc == 0)
> +		return 0;
> +	else
> +		return -1;
> +}
> +

"git am" complains about the trailing blank line.

I'll make these changes.

thanks,

Mimi

