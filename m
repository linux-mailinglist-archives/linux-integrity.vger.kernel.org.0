Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD50671B3B
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 17:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGWPOz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 11:14:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390812AbfGWPOz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 11:14:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NFANwe114618
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 11:14:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tx4n507e8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 11:14:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 23 Jul 2019 16:14:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 16:14:49 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NFEm1Z31850556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 15:14:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8164E4204B;
        Tue, 23 Jul 2019 15:14:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B89D742047;
        Tue, 23 Jul 2019 15:14:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.145])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 15:14:47 +0000 (GMT)
Subject: Re: [PATCH v1] ima-evm-utils: use tsspcrread to read the TPM 2.0
 PCRs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Tue, 23 Jul 2019 11:14:36 -0400
In-Reply-To: <20190723071545.GA26973@x230>
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
         <20190723071545.GA26973@x230>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072315-0008-0000-0000-0000030017E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072315-0009-0000-0000-0000226DA580
Message-Id: <1563894876.14396.120.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-07-23 at 09:15 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> others commented C code, thus I'll comment autotools checks.

Perfect

> 
> > The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> > userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> > application is required to read PCRs.
> OT: anyone aware why TPM 2.0 does not expose PCR banks to userspace via sysfs?

TPM 2.0 support is slowly being upstreamed in stages.  Initially the
TPM 2.0 event log was not exported.  Assuming that support for
exposing the TPM 2.0 PCRs is upstreamed, it doesn't necessarily
guarantee that it will be backported to stable.

> > diff --git a/src/Makefile.am b/src/Makefile.am
> > index 9c037e21dc4f..f0990fb01210 100644
> > --- a/src/Makefile.am
> > +++ b/src/Makefile.am
> > @@ -21,6 +21,9 @@ evmctl_SOURCES = evmctl.c
> >  evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
> >  evmctl_LDFLAGS = $(LDFLAGS_READLINE)
> >  evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
> > +if CONFIG_IBMTSS
> > +evmctl_CFLAGS = -DIBMTSS
> > +endif
> You can also use definition from config.h instead of passing it.
> 
> AC_SEARCH_LIBS(TSS_Transmit, [ibmtss tss],
> 	[have_ibmtss=yes
> 	AC_DEFINE(HAVE_IBMTSS, 1, [Define to 1 if you have libibmtss installed])],
> 	[have_ibmtss=no])
> 
> Then you don't need to pass -DIBMTSS, use HAVE_IBMTSS from config.h instead.

Much better ...
> 
> >  AM_CPPFLAGS = -I$(top_srcdir) -include config.h
> 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 9e0926f10404..f726b2186678 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c

> > @@ -1402,6 +1400,32 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
> >  	return result;
> >  }
> 
> > +#ifdef IBMTSS
> > +static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errmsg)
> > +{
> > +	FILE *fp;
> > +	char pcr[100];	/* may contain an error */
> > +	char cmd[36];
> > +	int ret;
> > +
> > +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns", idx);
> 
> Did I get it right, that in the end we don't use libibmtss, but tsspcrread.
> So wouldn't be safer to detect it with AC_CHECK_PROGS macro?
> See proposed diff.

Yes, thank you!  I've included it in the next version.

thanks!

Mimi

