Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97582ECF92
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 13:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbhAGMZy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 07:25:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728026AbhAGMZy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 07:25:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 107C75tf175079;
        Thu, 7 Jan 2021 07:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3ULZz9USICj750998pXtKu2WUgvIrjOpcGli/deE++0=;
 b=nhsuMs+IkITf9GH9mJhWbzm5iE/TuiCmoFblhVcxD8Zl3H8a/Y6FZ5DaYOLIvEqQ+YmV
 An5LrfCGvuUILJVpppqYIhJNMhGS+M6qPv/E+jqEUWfZJBaIHhu2NzEwtMDGyhbbRnG+
 RtD1M1UWp19h0SeY33EROlPv18tC/lyDT8m4olF1V89xbAPcXlB+QmEn4/YLV7NVDNS5
 ZjA8Qu+KxWQuRurzTwQflAg5Kf3SYg3KXSu+K1YZdtI07HEBJvi80ooYEduc9AVz1ymM
 BoVPjiVrGME/GzSeHvsqXZjqDthHiAld1TvPehlACVmamC4mIX7lDYD/UDzHYnOwkddW CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35x1r7gyxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 07:25:09 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 107C7AoG175283;
        Thu, 7 Jan 2021 07:25:09 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35x1r7gywv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 07:25:09 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 107CAdej015320;
        Thu, 7 Jan 2021 12:25:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 35tgf7thk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 12:25:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 107CP1IJ33227222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jan 2021 12:25:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 345ADA405D;
        Thu,  7 Jan 2021 12:25:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 276B2A4040;
        Thu,  7 Jan 2021 12:25:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.37.241])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jan 2021 12:25:03 +0000 (GMT)
Message-ID: <021868cb0faadd4a61440974808880ff520f9bd6.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] Add test for using sign_hash API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Patrick Uiterwijk <patrick@puiterwijk.org>,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@redhat.com, Vitaly Chikunov <vt@altlinux.org>
Date:   Thu, 07 Jan 2021 07:25:03 -0500
In-Reply-To: <20210106094335.3178261-3-patrick@puiterwijk.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
         <20210106094335.3178261-3-patrick@puiterwijk.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_05:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070071
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Patrick,

On Wed, 2021-01-06 at 10:43 +0100, Patrick Uiterwijk wrote:
> This adds a test with a small program that calls the sign_hash API, to
> ensure that that codepath works.
> 
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>

Thank you for the regression test.  Other than the couple of comments
below,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---

> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index ff928e1..74f6125 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -10,3 +10,8 @@ distclean: distclean-keys
>  .PHONY: distclean-keys
>  distclean-keys:
>  	./gen-keys.sh clean
> +
> +AUTOMAKE_OPTIONS = subdir-objects
> +bin_PROGRAMS = sign_verify_apitest
> +sign_verify_apitest_SOURCES = sign_verify.apitest.c ../src/utils.c
> +sign_verify_apitest_LDFLAGS = -limaevm -L../src/.libs
> diff --git a/tests/sign_verify.apitest.c b/tests/sign_verify.apitest.c
> new file mode 100644
> index 0000000..20e2160
> --- /dev/null
> +++ b/tests/sign_verify.apitest.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * sign_verify.apitest: Test program for verifying sign_hash
> + *
> + * Copyright (C) 2020 Patrick Uiterwijk <patrick@puiterwijk.org>
> + * Copyright (C) 2013,2014 Samsung Electronics
> + * Copyright (C) 2011,2012,2013 Intel Corporation
> + * Copyright (C) 2011 Nokia Corporation
> + * Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
> + */

Looking at the history, Dmitry Kasatkin must have been involved.  From
which software package is this from?

> +
> +#include <assert.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <attr/xattr.h>

This include fails on a couple of distros (e.g. alpine, tumbleweed, and
RHEL 8.3).  src/evmctl.c is using sys/xattr.h.

Mimi

> +
> +#include "../src/imaevm.h"
> +#include "../src/utils.h"

