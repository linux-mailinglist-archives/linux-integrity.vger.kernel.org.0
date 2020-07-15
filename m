Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C87220C1E
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgGOLr2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 07:47:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730066AbgGOLrY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 07:47:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FB3lJ8138149;
        Wed, 15 Jul 2020 07:47:21 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329uehb2f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 07:47:21 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FBjnd7018747;
        Wed, 15 Jul 2020 11:47:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 327527vfvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 11:47:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FBlFSR14418114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 11:47:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C89B142045;
        Wed, 15 Jul 2020 11:47:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FB7C4204B;
        Wed, 15 Jul 2020 11:47:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 11:47:15 +0000 (GMT)
Message-ID: <1594813634.12900.264.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Check for tsspcrread in runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Wed, 15 Jul 2020 07:47:14 -0400
In-Reply-To: <20200715062125.GA7493@dell5510>
References: <20200714154659.8080-1-pvorel@suse.cz>
         <1594757196.12900.191.camel@linux.ibm.com> <20200715062125.GA7493@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_10:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150093
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-15 at 08:21 +0200, Petr Vorel wrote:
> > On Tue, 2020-07-14 at 17:46 +0200, Petr Vorel wrote:
> > > instead of checking in build time as it's runtime dependency.
> > > Also log when tsspcrread not found to make debugging easier.
> 
> > > We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> > > thus pcr_none.c was dropped as unneeded.
> 
> > > file_exist(), file_exist() and MIN() taken from LTP project.
> 
> > One of these "file_exists" I assume is suppose to be "tst_get_path".
> Yes. I'm sorry, thanks for catching it.
> 
> 
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Hi Mimi,
> 
> > > small improvement based on the current next-testing branch
> > > (9638068aff2476b567185d7eb94126449ad89ca7).
> 
> > > I'm sorry I don't have the required setup, thus didn't test this patch.
> 
> > > Kind regards,
> > > Petr
> 
> > Nice!  It works.
> Thanks a lot for a testing?

Yes, reviewed/tested together.

diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
> > > @@ -47,8 +48,21 @@
> 
> > >  #include "utils.h"
> 
> > > -int tpm2_pcr_supported(void)
> > > +#define CMD "tsspcrread"
> > > +
> > > +static char path[PATH_MAX];
> > > +
> > > +int tpm2_pcr_supported(char **errmsg)
> > >  {
> > > +	int ret;
> > > +
> > > +	if (get_cmd_path(CMD, path, sizeof(path))) {
> > > +		ret = asprintf(errmsg, "Couldn't find '%s' in $PATH", CMD);
> > > +		if (ret == -1)	/* the contents of errmsg is undefined */
> > > +			*errmsg = NULL;
> > > +		return 0;
> > > +	}
> > > +
> 
> > Any chance you could also emit the pathname on success as well?
> 
> Do you mean to print it into stderr:
> 
> int tpm2_pcr_supported(char **errmsg)
> {
> 	int ret;
> 
> 	if (get_cmd_path(CMD, path, sizeof(path))) {
> 		ret = asprintf(errmsg, "Couldn't find '%s' in $PATH", CMD);
> 		if (ret == -1)	/* the contents of errmsg is undefined */
> 			*errmsg = NULL;
> 		return 0;
> 	}
> 
> 	ret = asprintf(errmsg, "Found '%s' in $PATH", CMD);
> 	if (ret == -1)	/* the contents of errmsg is undefined */
> 		*errmsg = NULL;
> 	return 1;
> }
> 

When running these tests remotely, it helps to know which method of
reading the PCRs is used.  How about adding something like this to
both instances of tpm2_pcr_supported()?

        if (imaevm_params.verbose > LOG_INFO)
                log_info("Using %s to read PCRs.\n", CMD);

> Shell I post v2 or you amend my patch?

Either way is fine. 

> BTW I was thinking to create custom function / macro for handling errmsg to
> reduce duplicity.

Sure, I assume that would be in addition to log_err() and log_errno().

> 
> + there is minor warning on newer gcc, I'm not sure how to fix that:
> 
> evmctl.c: In function ‘read_tpm_banks’:
> evmctl.c:1404:25: warning: ‘%2.2d’ directive writing between 2 and 10 bytes into a region of size 3 [-Wformat-overflow=]
>  1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
>       |                         ^~~~~
> evmctl.c:1404:20: note: directive argument in the range [0, 2147483647]
>  1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
>       |                    ^~~~~~~~~~~
> evmctl.c:1404:3: note: ‘sprintf’ output between 7 and 15 bytes into a destination of size 7
>  1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Interesting.  Checking that "i" isn't greater than 99 solves this
warning.  Changing pcr_str size from 7 to 8 solves the other warning.

Mimi


