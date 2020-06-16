Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D836C1FBDB4
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgFPSLa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 14:11:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbgFPSLa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 14:11:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GI268R115534;
        Tue, 16 Jun 2020 14:11:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31pwcvvfe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 14:11:15 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05GI2kaO119330;
        Tue, 16 Jun 2020 14:11:15 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31pwcvvfdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 14:11:15 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GIB9rV030256;
        Tue, 16 Jun 2020 18:11:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 31mpe82b0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 18:11:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GIBAsM61735064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 18:11:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8243042042;
        Tue, 16 Jun 2020 18:11:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64C494204D;
        Tue, 16 Jun 2020 18:11:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.198])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jun 2020 18:11:09 +0000 (GMT)
Message-ID: <1592331068.11061.218.camel@linux.ibm.com>
Subject: Re: [PATCH] extend IMA boot_aggregate with kernel measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Tue, 16 Jun 2020 14:11:08 -0400
In-Reply-To: <8c44ed75fb884cad9f33c86c2d4e8a27@huawei.com>
References: <1591921795.11061.12.camel@linux.ibm.com>
         <20200612143812.1609-1-maurizio.drocco@ibm.com>
         <380af929b2d2440a9dc35ba0b374247d@huawei.com>
         <1591982059.7235.29.camel@linux.ibm.com>
         <8c44ed75fb884cad9f33c86c2d4e8a27@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_10:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 cotscore=-2147483648 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-06-16 at 17:29 +0000, Roberto Sassu wrote:
> > From: James Bottomley [mailto:jejb@linux.ibm.com]
> > Sent: Friday, June 12, 2020 7:14 PM
> > On Fri, 2020-06-12 at 15:11 +0000, Roberto Sassu wrote:
> > > with recent patches, boot_aggregate can be calculated from non-SHA1
> > > PCR banks. I would replace with:
> > >
> > > Extend cumulative digest over ...
> > >
> > > Given that with this patch boot_aggregate is calculated differently,
> > > shouldn't we call it boot_aggregate_v2 and enable it with a new
> > > option?
> > 
> > So here's the problem: if your current grub doesn't do any TPM
> > extensions (as most don't), then the two boot aggregates are the same
> > because PCRs 8 and 9 are zero and there's a test that doesn't add them
> > to the aggregate if they are zero.  For these people its a nop so we
> > shouldn't force them to choose a different version of the same thing.
> > 
> > If, however, you're on a distribution where grub is automatically
> > measuring the kernel and command line into PCRs 8 and 9 (I think Fedora
> > 32 does this), your boot aggregate will change.  It strikes me in that
> > case we can call this a bug fix, since the boot aggregate isn't
> > properly binding to the previous measurements without PCRs 8 and 9.  In
> > this case, do we want to allow people to select an option which doesn't
> > properly bind the IMA log to the boot measurements?  That sounds like a
> > security hole to me.
> > 
> > However, since it causes a user visible difference in the grub already
> > measures case, do you have a current use case that would be affected?
> > As in are lots of people already running a distro with the TPM grub
> > updates and relying on the old boot aggregate?
> 
> I don't know how many people would be affected. However, if an
> attestation tool processes both measurement lists from unpatched kernels
> and patched kernels, keeping the same name would be a problem as it
> cannot be determined from the measurement list how boot_aggregate
> was calculated.
> 
> Anyway, I agree this should be fixed. At least, I suggest to add a Fixes tag,
> to ensure that this patch is applied to all stable kernels.

The boot aggregate on existing systems would be sha1.  Does it make
sense to limit this change to larger digests?  Anyone backporting
support for larger digests would also need to backport this change as
well.

Mimi
