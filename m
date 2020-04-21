Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF41B2852
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgDUNoi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 09:44:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55013 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728807AbgDUNoh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 09:44:37 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LDYj6O146012
        for <linux-integrity@vger.kernel.org>; Tue, 21 Apr 2020 09:44:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gcbfh7a6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 21 Apr 2020 09:44:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 21 Apr 2020 14:43:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 14:43:53 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03LDiRcQ55967962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 13:44:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F96FA4054;
        Tue, 21 Apr 2020 13:44:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A0AA4060;
        Tue, 21 Apr 2020 13:44:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.227.98])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 13:44:25 +0000 (GMT)
Subject: Re: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Omar Sandoval <osandov@osandov.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, kernel-team@fb.com
Date:   Tue, 21 Apr 2020 09:44:24 -0400
In-Reply-To: <20200416190249.GC701157@vader>
References: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
         <19d930ef-4090-3339-1088-c3579e8a080f@molgen.mpg.de>
         <20200416190249.GC701157@vader>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042113-0008-0000-0000-00000374C490
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042113-0009-0000-0000-00004A968A6B
Message-Id: <1587476664.5149.14.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_05:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Omar,

On Thu, 2020-04-16 at 12:02 -0700, Omar Sandoval wrote:
> On Thu, Apr 16, 2020 at 08:22:10AM +0200, Paul Menzel wrote:
> > Dear Omar,
> > 
> > 
> > Am 16.04.20 um 02:23 schrieb Omar Sandoval:
> > > From: Omar Sandoval <osandov@fb.com>
> > 
> > Thank you for the patch.
> > 
> > > We've encountered a particular model of STMicroelectronics TPM that
> > 
> > Please add models you are encountering this with to the commit message.
> > 
> > > transiently returns a bad value in the status register. This causes the
> > 
> > Have you contacted STMMicroelectronics?

Also how transient is it?  Is this something that only happens early,
for example before selftests finishes?  Could you get some statistics
here?

> > 
> > > kernel to believe that the TPM is ready to receive a command when it
> > > actually isn't, which in turn causes the send to time out in
> > > get_burstcount(). In testing, reading the status register one extra time
> > > convinces the TPM to return a valid value.

Is this only affecting get_burstcount()?

> > > 
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >   drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > index 27c6ca031e23..5a2f6acaf768 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -238,6 +238,25 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
> > >   	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> > >   	if (rc < 0)
> > >   		return 0;
> > > +	/*
> > > +	 * Some STMicroelectronics TPMs have a bug where the status register is
> > > +	 * sometimes bogus (all 1s) if read immediately after the access
> > > +	 * register is written to. Bits 0, 1, and 5 are always supposed to read
> > > +	 * as 0, so this is clearly invalid. Reading the register a second time
> > > +	 * returns a valid value.
> > > +	 */
> > > +	if (unlikely(status == 0xff)) {
> > 
> > I’d like to see a debug message here, saying the TPM is buggy. Maybe the
> > model can be printed to, and that the TPM manufacturer should be contacted.
> 
> How can I get the model information? (Sorry, I'm not very familiar with
> TPMs, I'm just the guy on the team that ended up tracking this down.)

Ken's post yesterday suggested using a userspace tool.

In general, Linux does support buggy HW, like the iTPM support.  As
Paul said, see if there is a vendor solution first.  Whatever fix is
upstreamed should be very specific with a clear explanation of the
problem.

thanks,

Mimi

