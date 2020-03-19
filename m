Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1836C18C387
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2020 00:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCSXRF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 19:17:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727452AbgCSXRF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 19:17:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JN423h079616;
        Thu, 19 Mar 2020 19:15:59 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7ftjx6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 19:15:59 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02JN7DJq004569;
        Thu, 19 Mar 2020 23:15:58 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2yrpw6v020-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 23:15:58 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02JNFwn515008662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 23:15:58 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61715AC05E;
        Thu, 19 Mar 2020 23:15:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40401AC05B;
        Thu, 19 Mar 2020 23:15:58 +0000 (GMT)
Received: from t440p.yottatech.com (unknown [9.85.138.240])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Mar 2020 23:15:58 +0000 (GMT)
Received: (from gcwilson@localhost)
        by t440p.yottatech.com (8.15.2/8.15.2/Submit) id 02JNFq2I027749;
        Thu, 19 Mar 2020 18:15:52 -0500
X-Authentication-Warning: t440p.yottatech.com: gcwilson set sender to gcwilson@linux.ibm.com using -f
Date:   Thu, 19 Mar 2020 18:15:52 -0500
From:   George Wilson <gcwilson@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH v3] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200319231552.GA25351@us.ibm.com>
References: <20200318234927.206075-1-gcwilson@linux.ibm.com>
 <20200319195011.GB24804@linux.intel.com>
 <20200319195503.GC24804@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319195503.GC24804@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_09:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190091
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 19, 2020 at 09:55:03PM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 19, 2020 at 09:50:16PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 18, 2020 at 07:49:27PM -0400, George Wilson wrote:
> > > tpm_ibmvtpm_send() can fail during PowerVM Live Partition Mobility resume
> > > with an H_CLOSED return from ibmvtpm_send_crq().  The PAPR says, 'The
> > > “partner partition suspended” transport event disables the associated CRQ
> > > such that any H_SEND_CRQ hcall() to the associated CRQ returns H_Closed
> > > until the CRQ has been explicitly enabled using the H_ENABLE_CRQ hcall.'
> > > This patch adds a check in tpm_ibmvtpm_send() for an H_CLOSED return from
> > > ibmvtpm_send_crq() and in that case calls tpm_ibmvtpm_resume() and
> > > retries the ibmvtpm_send_crq() once.
> > > 
> > > Reported-by: Linh Pham <phaml@us.ibm.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
> > > Tested-by: Linh Pham <phaml@us.ibm.com>
> > > Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Unfortunately have to take that back because it has checkpatch
> errors:
> 
> $ scripts/checkpatch.pl 0001-tpm-ibmvtpm-retry-on-H_CLOSED-in-tpm_ibmvtpm_send.patch
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #11:
> “partner partition suspended” transport event disables the associated CRQ

I'd noticed that but it appears to be a spurious checkpatch warning.
The line is 73 chars long, the same as the first line of the commit
description.  Maybe the quotes throw it off?

> 
> WARNING: Prefer using '"%s...", __func__' to using 'ibmvtpm_crq_send_init', this function's name, in a string
> #61: FILE: drivers/char/tpm/tpm_ibmvtpm.c:152:
> +			"ibmvtpm_crq_send_init failed rc=%d\n", rc);

I didn't change that error string because it's in an unmodified existing
function that I moved above the caller so a declaration wasn't required.
All other examples in the file are the same.  I'm of course happy to
change it in this function if you think it's appropriate to do so.

> 
> Also the fixes tag is incorrect. Should be:
> 
> Fixes: 132f76294744 ("drivers/char/tpm: Add new device driver to support IBM vTPM")

I see it done different ways, mostly without the path, even for the TPM
drivers.  For example, there's no path in Stefan's "[PATCH v7 2/3] tpm:
ibmvtpm: Wait for buffer to be set before proceeding."  I'm certainly
happy to change it, however, and it's good to know that's the preferred
style going forward.

Separate topic:  Since this fixes a migration hang, do you think it
should also be cc'd to stable?

> 
> /Jarkko

-- 
George Wilson
IBM Linux Technology Center
Security Development
