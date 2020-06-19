Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDEC200982
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgFSNE4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 09:04:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10526 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbgFSNEu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 09:04:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JD4Sqx095097;
        Fri, 19 Jun 2020 09:04:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rmmeyufn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 09:04:40 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05JD4ebk095672;
        Fri, 19 Jun 2020 09:04:40 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rmmeytbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 09:04:40 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JD0qF1011063;
        Fri, 19 Jun 2020 13:01:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 31r0u9h20v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 13:01:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05JD1rfk63373344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 13:01:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3FEA4040;
        Fri, 19 Jun 2020 13:01:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B990A4057;
        Fri, 19 Jun 2020 13:01:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.188.214])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jun 2020 13:01:52 +0000 (GMT)
Message-ID: <1592571711.17802.21.camel@linux.ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Bruno Meneguele <bmeneg@redhat.com>, ltp@lists.linux.it,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Date:   Fri, 19 Jun 2020 09:01:51 -0400
In-Reply-To: <20200619100737.GB18704@dell5510>
References: <20200527071434.28574-1-pvorel@suse.cz>
         <1590601280.16219.1.camel@linux.ibm.com> <20200528140747.GA8401@dell5510>
         <1590679145.4457.39.camel@linux.ibm.com> <20200528160527.GA27243@dell5510>
         <20200615194134.GF129694@glitch> <1592252491.11061.181.camel@linux.ibm.com>
         <20200619100737.GB18704@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_11:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 cotscore=-2147483648
 impostorscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190092
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-19 at 12:07 +0200, Petr Vorel wrote:
> Hi all,
> 
> > On Mon, 2020-06-15 at 16:41 -0300, Bruno Meneguele wrote:
> > > On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
> > > > Hi Mimi,
> ...
> > > > To sum that: my patch is required for any system without physical TPM with with
> > > > kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless kernel
> > > > version), because TPM 1.2 supports sha1 only boot aggregate.
> 
> > > > But testing on kernel with b59fda449cf0 with TPM 2.0 is not only broken with
> > > > this patch, but also on current version in master, right? As you have
> > > > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5 anyway.
> > > > So this patch would help at least testing on VM without vTPM.
> 
> 
> > > If we consider to delay this change until we have the ima-evm-utils
> > > released with the ima_boot_aggregate + make this test dependent on
> > > both ima-evm-utils and tsspcrread, would it be worth to SKIP the test in
> > > case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
> > > have the test fixed for TPM1.2 && no-TPM cases until we get the full
> > > support for multiple banks?
> +1
> 
> > As long as we're dealing with the "boot_aggregate", Maurizio just
> > posted a kernel patch for including PCR 8 & 9 in the boot_aggregate.
> >  The existing IMA LTP "boot_aggregate" test is going to need to
> > support this change.
> I'm not sure if I did something wrong, but it looks to me that 'evmctl
> ima_boot_aggregate' does not provide backward compatibility with TPM 1.2.
> Or am I wrong?

Calculating the "boot_aggregate" - "evmctl ima_boot_aggregate" - for
TPM 1.2 should work.  Reading the code, it looks like it assumes that
the crypto library supports SHA1 and SHA256.  That assumption needs to
be addressed.

The tests/boot_aggregate.test logs are TPM 2.0.  The test is failing
on systems with a TPM 1.2.  I'm working on a fix for this.

Mimi
