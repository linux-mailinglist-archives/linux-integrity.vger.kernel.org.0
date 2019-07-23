Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47371F43
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391488AbfGWSZL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 14:25:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391475AbfGWSZL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 14:25:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NIMg2O119995
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 14:25:09 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60rkgjt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 14:25:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 23 Jul 2019 19:25:07 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 19:25:06 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NIP5ee30212494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 18:25:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 260D84C046;
        Tue, 23 Jul 2019 18:25:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BF274C040;
        Tue, 23 Jul 2019 18:25:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.145])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 18:25:04 +0000 (GMT)
Subject: Re: [PATCH v2] ima-evm-utils: use tsspcrread to read the TPM 2.0
 PCRs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Tue, 23 Jul 2019 14:24:53 -0400
In-Reply-To: <20190723164144.ewrcvrod7m6rahkg@altlinux.org>
References: <1563893743-4586-1-git-send-email-zohar@linux.ibm.com>
         <20190723154759.GB16649@glitch> <1563897190.14396.144.camel@linux.ibm.com>
         <20190723164144.ewrcvrod7m6rahkg@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072318-0012-0000-0000-0000033584A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072318-0013-0000-0000-0000216F1607
Message-Id: <1563906293.14396.163.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=852 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230184
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-07-23 at 19:41 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Jul 23, 2019 at 11:53:10AM -0400, Mimi Zohar wrote:
> > On Tue, 2019-07-23 at 12:47 -0300, Bruno E. O. Meneguele wrote:
> > 
> > > > @@ -1402,6 +1400,41 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
> > > >  	return result;
> > > >  }
> > > >  
> > > > +#ifdef HAVE_TSSPCRREAD
> > > > +static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
> > > > +{
> > > > +	FILE *fp;
> > > > +	char pcr[100];	/* may contain an error */
> > > > +	char cmd[50];
> > > > +	int ret;
> > > > +
> > > > +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns 2> /dev/null", idx);
> > > > +	fp = popen(cmd, "r");
> > > > +	if (!fp) {
> > > > +		snprintf(pcr, sizeof(pcr), "popen failed: %s", strerror(errno));
> > > > +		*errmsg = strdup("popen failed:");
> > > 
> > > Should it have been 
> > > 
> > > *errmsg = strdup(pcr);
> > > 
> > Yes, of course.
> 
> Or better to use asprintf(3).

That's even better, assuming that we want to include
AC_USE_SYSTEM_EXTENSIONS in configure.ac?

Did you want to make this change as a separate patch, or should I fold
it into this one?

Mimi

