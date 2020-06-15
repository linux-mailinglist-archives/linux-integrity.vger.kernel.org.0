Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED8B1F9CAB
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgFOQKe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 12:10:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728585AbgFOQKd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 12:10:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FG3jdq097237;
        Mon, 15 Jun 2020 12:10:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31mtxf3krh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 12:10:28 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FG45MO099034;
        Mon, 15 Jun 2020 12:10:27 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31mtxf3kpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 12:10:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FG14Ek001730;
        Mon, 15 Jun 2020 16:10:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 31mpe81jcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 16:10:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05FGAMPT3080502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 16:10:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6687311C054;
        Mon, 15 Jun 2020 16:10:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54C5311C069;
        Mon, 15 Jun 2020 16:10:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.11])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jun 2020 16:10:21 +0000 (GMT)
Message-ID: <1592237420.11061.144.camel@linux.ibm.com>
Subject: Re: [PATCH 5/5] LSM: Define workqueue for measuring security module
 state
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Jun 2020 12:10:20 -0400
In-Reply-To: <CAEjxPJ61dup9HDQny_TAb7we-vcN-sM17y4x0Pos3d7ERaab9g@mail.gmail.com>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
         <20200613024130.3356-6-nramas@linux.microsoft.com>
         <CAEjxPJ7v5Lu-vzqg0ZVh8zJ9uZ=odN3jt_5+9d9x+RydsNWK0g@mail.gmail.com>
         <1592233145.11061.129.camel@linux.ibm.com>
         <CAEjxPJ61dup9HDQny_TAb7we-vcN-sM17y4x0Pos3d7ERaab9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_03:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 bulkscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-15 at 11:47 -0400, Stephen Smalley wrote:
> On Mon, Jun 15, 2020 at 10:59 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Mon, 2020-06-15 at 09:33 -0400, Stephen Smalley wrote:
> > > On Fri, Jun 12, 2020 at 10:42 PM Lakshmi Ramasubramanian
> > > <nramas@linux.microsoft.com> wrote:
> > > >
> > > > The data maintained by the security modules could be tampered with by
> > > > malware. The LSM needs to periodically query the state of
> > > > the security modules and measure the data when the state is changed.
> > > >
> > > > Define a workqueue for handling this periodic query and measurement.
> > >
> > > Won't this make it difficult/impossible to predict the IMA PCR value?
> > > Unless I missed it, you are going to end up measuring every N minutes
> > > even if there was no change and therefore constantly be extending the
> > > PCR.  That will break attestation or sealing against the IMA PCR.
> >
> > Even if it attempts to add the same measurement to the list multiple
> > times, unless something changed, there should only be one measurement
> > in the list.
> 
> Is the PCR only extended once?

Yes, otherwise you wouldn't be able to verify a quote.
 ima_lookup_digest_entry() first verifies the hash isn't in the cache,
before adding it to the measurement list and then extending the TPM.

Mimi
